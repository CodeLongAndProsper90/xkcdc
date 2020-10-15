import std.stdio;
import requests;
import std.conv;
import std.json;
import std.getopt;
import std.string;

int main(string[] args)
{
  bool export_json;
  bool verbose;
  auto help = getopt(
                     args,
                     "export-json", &export_json, // Does the user want JSON?
                     "verbose", &verbose, // Does the user want verbosity?
  );

  if (help.helpWanted) // -h flag invoked
    {
      defaultGetoptPrinter("Help for xkcdc:", help.options);
    }
  
  void log(string info)
  {
    if (verbose)
      writeln(info);
  }
  
  log("Downloading current comic"); // Give some info

  // This is so we can tell if the comic exists or not
  string current = to!string(getContent("https://xkcd.com/info.0.json"));
  auto comic = parseJSON(current); // Turn the downloaded string into JSON

  if (args.length > 1)
    {
      int num = to!int(args[1]); // convert the first argument
      int exists = cast(int) comic["num"].integer;
      log(format("Latest comic is %d, current comic is %d", exists, num));
      if (num > exists)
        // Comic out of range
        {
          writeln("xkcdc: Comic in future. Missing TARDIS");
          return 1;
        }
      string url = format("https://xkcd.com/%d/info.0.json", num);
      log(format("Downloading JSON at %s", url));
      string req = to!string(getContent(url));
      comic = parseJSON(req);
    }
  if (export_json)
    {
      writeln(comic);
    }
  else
    {
      
      string output = format(
                            "Title: %s\nImage: %s\n\nTranscript:\n===\n%s\n===\nAlt: %s",
                            text(comic["title"]),
                            replace(text(comic["img"]), "\\/", "/"),
                            replace(text(comic["transcript"]), "\\n", "\n"),
                            text(comic["alt"]),
                            );
      
      //      string output = format("Title: %s", text(comic["alt"]));
      writeln(output);
    }

  return 0;
  
}
