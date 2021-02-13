# 🗣 LocoBuddy

**LocoBuddy** is a Swift command-line tool that makes it easier to use and search Apple's `AppleGlot` [translation glossaries](https://developer.apple.com/download/more/), which are exports of translations used in Apple's system apps, such as Maps and Home, for all system languages.

However, these translation glossaries are provided in `lg` file formats, and separated per each system app. LocoBuddy handles parsing these glossaries to search for specific terms and translate a found term into any number of given languages. 

This package is heavily inspired by and uses code adapted from [Douglas' in depth blog post on parsing these glossaries](https://douglashill.co/localisation-using-apples-glossaries/).

<br>

## Requirements

**LocoBuddy** requires **macOS 11+** and is used directly on the command-line (Terminal). The command-line interface is created through Apple's [Swift Argument Parser](https://github.com/apple/swift-argument-parser) library, which is added through Swift Package Manager. 

<br>

## Installation

You can download the latest build of **LocoBuddy**, or build it from the source in this repository. 

### Prebuilt Install

Download the `LocoBuddy` binary in the [latest release](releases), then run it from Terminal.

### Manual Build

Clone this repository, then run `swift build` in the source folder using Terminal, and find the binary in the `.build/debug` or `.build/release` folder.

<br>

## Usage

This tool requires Apple's translation glossaries to be downloaded and mounted; a valid Apple Developer account is required to download the glossaries. [Download](https://developer.apple.com/download/more/) the glossary languages you want from Apple's website by searching for glossaries, then mount the `dmg` disk images by double-clicking on each one.

After mounting the disk images, search for terms in the glossaries you downloaded. For example, to search for "Book" in the Simplified Chinese glossary:

```bash
LocoBuddy search --language "Simplified Chinese" --match contains "Book"
```
```
􀅴   Found 12 strings matching or containing `Cancel Ride`!

􀅶   Add to Bookmarks
􀰑   加入書籤
􀟕   URL_ACTION_BOOKMARK
􀎫   ContactsUI.lg
...
```

You can then translate a specific key (e.g. `URL_ACTION_BOOKMARK`) into one or more languages, using the initials or full names of the glossaries, at the same time:

(SC is Simplified Chinese, TC is Traditional Chinese)

```bash
LocoBuddy translate --key "URL_ACTION_BOOKMARK" "SC" "TC" 
```

```
􀰑   加入書籤
􀎫   ContactsUI.lg
􀆪   Traditional Chinese

􀰑   添加到书签
􀎫   ContactsUI.lg
􀆪   Simplified Chinese
```

<br>

## Contributing

Contributions and pull requests are welcomed by anyone! If you find an issue with **LocoBuddy**, file a Github Issue, or, if you know how to fix it, submit a pull request. 

Please review our [Code of Conduct](CODE_OF_CONDUCT.md) and [Contribution Guidelines](CONTRIBUTING.md) before making a contribution.

<br>

## Credit

**LocoBuddy** was created by [Julian Schiavo](https://twitter.com/julianschiavo), and published available under the [MIT License](LICENSE). The original code is adapted from [Douglas Hill's post *Localisation using Apple’s glossaries*](https://douglashill.co/localisation-using-apples-glossaries/) under the MIT License.

<br>

## License

Available under the MIT License. See the [License](LICENSE) for more info.
