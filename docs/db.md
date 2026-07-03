model content {
    id             uuid pk
    type           ContentType
    title          text
    description     text
    cover_image     text
    published       boolean
    locked          boolean
    unlock_code      text 
    created_at       timestamptz
    updated_at       timestamptz
    payload         jsonb
}

enum ContentType {
    quiz
}