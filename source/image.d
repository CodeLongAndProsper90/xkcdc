import std.process: execute;
import std.stdio: writefln, File;
import requests;

int kitty_disp_image(string image)
{
  auto kitty = execute(["kitty", "+kitten", "icat", image]);
  if (kitty.status != 0)
  {
    writefln("Error. %s %s exited with status %d", "kitty +kitten icat", "image", kitty.status);
  }
  return 0;
}

int download_img(string url)
{
  auto content = getContent(url);
  auto img = File("/tmp/xkcd.png", "wb");
  img.write(content);
  img.close();
  return 0;
}

void disp(string url)
{
  download_img(url);
  kitty_disp_image("/tmp/xkcd.png");
}
