
# This entity is an Event with multiple Files e.g. Video and Audio recordings, as well as PDFs e.g. the lecture slides
# alternate Name: Lecture, Talk?
module Types
  class LectureType < Types::BaseObject
    description "This entity is an Event with multiple Files e.g. Video and Audio recordings, as well as PDFs e.g. the lecture slides"
    field :guid, ID, null: false 
    field :localId, Integer, null: false
    #field :conference, Types::ConferenceType, "The conference this event belongs to", null: false

    field :title, String,  "The title of this event", null: false
    field :subtitle, String,  "The event's subtitle that may be displayed below the title", null: true
    field :description, String, "The event's description", null: true

    field :slug, String, "The URL slug of this event", null: false
    field :originalLanguage, String, "The event's original language, encoded as ISO 639-2", null: true
    #field :duration, Types::Duration, "The lecture's duration in seconds", null: true

    field :persons, [String], "Names of persons that held the event", null: true
    field :promoted, Boolean, "Whether the event is promoted right now", null: true
    field :tags, [String], "Tags/keywords describing the event", null: true
    field :posterUrl, String, "A URL pointing to a preview/poster image of the event", null: true
    field :thumbUrl, String, "A URL pointing to a thumbnail describing the event", null: true

    field :date, GraphQL::Types::ISO8601DateTime, "Identifies the date and time when the event took place", null: true
    field :releaseDate, GraphQL::Types::ISO8601DateTime, "Identifies the date when the event got released", null: true
    field :updatedAt, GraphQL::Types::ISO8601DateTime, "Identifies the date and time when the object was last updated", null: true
    field :viewCount, Int, "The amount of views of this event", null: true
    field :link, String, "A URL pointing to the event's website", null: true

    field :videoPreferred, Types::AssetType, null: false
    field :videoFiles, [Types::AssetType], null: false
    field :audioFiles, [Types::AssetType], null: true
    field :slidesFiles, [Types::AssetType], null: true
    field :files, [Types::AssetType], null: false

    #field :thumbnail, Types::ImageType, null: true

    '''
    recordings(, 
      # Skip the first _n_ edges
      offset: Int

      # Limit the amount of returned edges
      limit: Int
    ): RecordingConnection! "A list of recordings at this event"

    # A list of related events, ordered by decreasing relevance.
    relatedEvents(
      # Skip the first _n_ related events.
      offset: Int

      # Limit the amount of returned related events.
      limit: Int
    ): EventConnection!
    '''

    def local_id
      object.id
    end

    def files
      object.recordings
    end

    def video_files
      object.videos_sorted_by_language
    end

    def video_preferred
      object.preferred_recording
    end

    def audio_files
      object.recordings.audio
    end

    def audio_preferred
      object.audio_recording
    end


  end
end