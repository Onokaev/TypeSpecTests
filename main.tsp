import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-m365-copilot";

using TypeSpec.Http;
using TypeSpec.M365.Copilot.Agents;

alias sunoSkill = {
  nameForHuman: "Suno";
  descriptionForModel: "Suno is a tool that can generate songs based on a description. The user provides a description of the song they want to create, and Suno generates the song lyrics. Suno is a fun and creative way to create songs for any occasion.";
  contactEmail: "ionutro@microsoft.com";
  logoUrl: "https://th.bing.com/th?id=OSK.935650835684F7E18AC3F31034DE6DF3";
  privacyPolicyUrl: "https://app.suno.ai/privacy";
  legalInfoUrl: "https://app.suno.ai/legal";
};


@agent(
  "agent title",
 "agent description",
 )
 @service(#{
   title: "Suno"
 })
 @actions(#{
   nameForHuman: "SomeCharName more names than 20 chars make sure it is actually long",
   descriptionForModel: "Suno is a song tool",
   privacyPolicyUrl: "https://app.suno.ai/privacy",
   legalInfoUrl: "https://app.suno.ai/legal",
   contactEmail: "ionutro@microsoft.com",
   logoUrl: "https://th.bing.com/th?id=OSK.935650835684F7E18AC3F31034DE6DF3",
   descriptionForHuman: "Suno is a tool that can generate songs based on a description."
 })
 @route("/createSong")
 namespace Suno {
  op embedded is AgentCapabilities.EmbeddedKnowledge<TFiles = [
    "file1.docx", "file2.csv"
  ]>;
   /** Create a song given the user preferences */
   @get op createSong(
     @query topic: string): string;
 }