import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-copilot-skills";

using TypeSpec.Http;
using TypespecCopilotSkills;
using TypespecCopilotSkills.Agents;

@agent(
  "Repairs and Posts agent",
  "An agent for managing repair information and blog posts"
)
@instructions("""
  You are a repairs and blog posts expert agent.
""")
@conversationStarter(#{
  title: "List repairs",
  text: "List all repairs"
})
@conversationStarter(#{
  title: "List blog posts",
  text: "List all blog posts"
})
namespace TypeSpecAdaptiveCards {
  @service
  @actions(#{
    nameForHuman: "Repairs Hub",
    descriptionForHuman: "Manage your repairs and maintenance tasks.",
    descriptionForModel: "Plugin to add, update, remove, and view repair objects.",
  })
  @server("https://repairshub.azurewebsites.net", "Repairs Hub API")
  namespace RepairsHub {
    /**
     * List all repairs.
     */
    @route("/repairs")
    @get
    //@card(#{ dataPath: "$", file: "./appPackage/adaptiveCards/listRepairs.json", title: "$.title", url: "$.image" })
    op listRepairs(): Repair[];
    
    /**
     * A model representing a repair.
     */
    model Repair {
      /**
       * The unique identifier for the repair.
       */
      id?: string;

      /**
       * The short summary or title of the repair.
       */
      title: string;

      /**
       * The detailed description of the repair.
       */
      description?: string;

      /**
       * The user who is assigned to the repair.
       */
      assignedTo?: string;

      /**
       * The optional date and time when the repair is scheduled or completed.
       */
      @format("date-time")
      date?: string;

      /**
       * The URL of the image associated with the repair.
       */
      @format("uri")
      image?: string;
    }
  }

  @service
  @actions(#{
    nameForHuman: "Blog Posts",
    descriptionForHuman: "Manage your blog posts.",
    descriptionForModel: "Plugin to view posts objects.",
  })
  @server("https://jsonplaceholder.typicode.com", "Posts API")
  namespace Posts {
    /**
     * List all posts.
     */
    @route("/posts")
    @get
    op listPosts(): Post[];
    
    model Post {
      /**
       * The unique identifier for the post.
       */
      id?: string;

      /**
       * The user who created the post.
       */
      userId?: string;

      /**
       * The short summary or title of the post.
       */
      title: string;

      /**
       * The detailed description of the post.
       */
      body?: string;
    }
  }
}
