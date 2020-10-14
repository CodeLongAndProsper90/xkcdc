import std.stdio;
import requests;
import std.conv;
import std.json;
import std.getopt;
import std.string;

int main(string[] args)
{
  bool export_json;
  auto help = getopt(
                     args,
                     "export-json", &export_json
  );
  if (help.helpWanted)
    {
      defaultGetoptPrinter("Help for xkcdc:", help.options);
    }
  string current = to!string(getContent("https://xkcd.com/info.0.json"));
  auto comic = parseJSON(current);
  if (args.length > 1)
    {
      int num = to!int(args[1]); // convert the first argument
      int exists = cast(int) comic["num"].integer;
      if (num > exists)
        // Comic out of range
        {
          writeln("xkcdc: Comic in future. Missing TARDIS");
          return 1;
        }
      string url = format("https://xkcd.com/%d/info.0.json", num);
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
                            "Title: %s\nImage: %s\nTranscript: %s\nAlt: %s",
                            text(comic["title"]),
                            replace(text(comic["img"]), "\\/", "/"),
                            text(comic["transcript"]),
                            text(comic["alt"]),
                            );
      
      //      string output = format("Title: %s", text(comic["alt"]));
      writeln(output);
    }

  return 0;
  
}
