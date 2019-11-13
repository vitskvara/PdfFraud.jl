# syntax: proto3
using ProtoBuf
import ProtoBuf.meta
import ProtoBuf.google.protobuf

mutable struct PdfSampleRaw_SampleId <: ProtoType
    customer_id::AbstractString
    batch_id::AbstractString
    timestamp::Float32
    uuid::AbstractString
    PdfSampleRaw_SampleId(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_SampleId

mutable struct PdfSampleRaw_BoundingBox <: ProtoType
    x::Float32
    y::Float32
    width::Float32
    height::Float32
    PdfSampleRaw_BoundingBox(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_BoundingBox

mutable struct PdfSampleRaw_MultiObj_MultiObjOcc_AttributesEntry <: ProtoType
    key::AbstractString
    value::AbstractString
    PdfSampleRaw_MultiObj_MultiObjOcc_AttributesEntry(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_MultiObj_MultiObjOcc_AttributesEntry (mapentry)

mutable struct PdfSampleRaw_MultiObj_MultiObjOcc <: ProtoType
    gen_id::UInt32
    byte_position::UInt64
    attributes::Base.Dict{AbstractString,AbstractString} # map entry
    PdfSampleRaw_MultiObj_MultiObjOcc(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_MultiObj_MultiObjOcc

mutable struct PdfSampleRaw_MultiObj <: ProtoType
    obj_id::UInt32
    occurrences::Base.Vector{PdfSampleRaw_MultiObj_MultiObjOcc}
    occ_differs::Bool
    PdfSampleRaw_MultiObj(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_MultiObj

mutable struct PdfSampleRaw_Page_Overlap <: ProtoType
    page::UInt32
    hidden_text::AbstractString
    bbox::PdfSampleRaw_BoundingBox
    replacement_text::AbstractString
    PdfSampleRaw_Page_Overlap(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Overlap

mutable struct PdfSampleRaw_Page_TextAppend_WordBoundingBox <: ProtoType
    word::AbstractString
    bbox::PdfSampleRaw_BoundingBox
    PdfSampleRaw_Page_TextAppend_WordBoundingBox(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_TextAppend_WordBoundingBox

mutable struct PdfSampleRaw_Page_TextAppend <: ProtoType
    page::UInt32
    sentence::AbstractString
    seq_dist::UInt32
    distance_from_bottom::Float32
    blue_words::Base.Vector{PdfSampleRaw_Page_TextAppend_WordBoundingBox}
    red_words::Base.Vector{PdfSampleRaw_Page_TextAppend_WordBoundingBox}
    PdfSampleRaw_Page_TextAppend(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_TextAppend

mutable struct PdfSampleRaw_Page_Image <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    name::AbstractString
    src_width::UInt32
    src_height::UInt32
    image_mask::ProtoBuf.google.protobuf.BoolValue
    bits::UInt32
    color_space::Base.Vector{AbstractString}
    matrix::Base.Vector{Float32}
    stream_length::Int64
    stream_obj_id::UInt32
    PdfSampleRaw_Page_Image(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Image
const __pack_PdfSampleRaw_Page_Image = Symbol[:matrix]
const __wtype_PdfSampleRaw_Page_Image = Dict(:stream_length => :sint64)
meta(t::Type{PdfSampleRaw_Page_Image}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, __pack_PdfSampleRaw_Page_Image, __wtype_PdfSampleRaw_Page_Image, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

struct __enum_PdfSampleRaw_Page_Curve_CurveType <: ProtoEnum
    CURVE::Int32
    LINE::Int32
    RECTANGLE::Int32
    __enum_PdfSampleRaw_Page_Curve_CurveType() = new(0,1,2)
end #struct __enum_PdfSampleRaw_Page_Curve_CurveType
const PdfSampleRaw_Page_Curve_CurveType = __enum_PdfSampleRaw_Page_Curve_CurveType()

mutable struct PdfSampleRaw_Page_Curve_Point <: ProtoType
    x::Float32
    y::Float32
    PdfSampleRaw_Page_Curve_Point(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Curve_Point

struct __enum_PdfSampleRaw_Page_Curve_Color_ColorType <: ProtoEnum
    FLOAT::Int32
    STRING::Int32
    __enum_PdfSampleRaw_Page_Curve_Color_ColorType() = new(0,1)
end #struct __enum_PdfSampleRaw_Page_Curve_Color_ColorType
const PdfSampleRaw_Page_Curve_Color_ColorType = __enum_PdfSampleRaw_Page_Curve_Color_ColorType()

mutable struct PdfSampleRaw_Page_Curve_Color <: ProtoType
    _type::Int32
    value::AbstractString
    PdfSampleRaw_Page_Curve_Color(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Curve_Color

mutable struct PdfSampleRaw_Page_Curve <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    curve_type::Int32
    even_odd::Bool
    fill::Bool
    line_width::Float32
    stroke::Bool
    non_stroking_color::Base.Vector{PdfSampleRaw_Page_Curve_Color}
    stroking_color::Base.Vector{PdfSampleRaw_Page_Curve_Color}
    points::Base.Vector{PdfSampleRaw_Page_Curve_Point}
    PdfSampleRaw_Page_Curve(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Curve

mutable struct PdfSampleRaw_Page_Char <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    char::AbstractString
    adv::Float32
    matrix::Base.Vector{Float32}
    PdfSampleRaw_Page_Char(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Char
const __pack_PdfSampleRaw_Page_Char = Symbol[:matrix]
meta(t::Type{PdfSampleRaw_Page_Char}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, __pack_PdfSampleRaw_Page_Char, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct PdfSampleRaw_Page_Text <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    text::AbstractString
    font_name::AbstractString
    render_style::UInt32
    upright::Bool
    cs_name::ProtoBuf.google.protobuf.StringValue
    cs_components::ProtoBuf.google.protobuf.UInt32Value
    chars::Base.Vector{PdfSampleRaw_Page_Char}
    PdfSampleRaw_Page_Text(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Text

struct __enum_PdfSampleRaw_Page_MarkedContent_Type <: ProtoEnum
    POINT::Int32
    SEQUENCE::Int32
    __enum_PdfSampleRaw_Page_MarkedContent_Type() = new(0,1)
end #struct __enum_PdfSampleRaw_Page_MarkedContent_Type
const PdfSampleRaw_Page_MarkedContent_Type = __enum_PdfSampleRaw_Page_MarkedContent_Type()

mutable struct PdfSampleRaw_Page_MarkedContent_PropertiesEntry <: ProtoType
    key::AbstractString
    value::AbstractString
    PdfSampleRaw_Page_MarkedContent_PropertiesEntry(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_MarkedContent_PropertiesEntry (mapentry)

mutable struct PdfSampleRaw_Page_MarkedContent <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    name::AbstractString
    _type::Int32
    properties::Base.Dict{AbstractString,AbstractString} # map entry
    tagged_text::Base.Vector{PdfSampleRaw_Page_Text}
    PdfSampleRaw_Page_MarkedContent(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_MarkedContent

mutable struct PdfSampleRaw_Page_Annotation <: ProtoType
    page::UInt32
    seq_id::UInt32
    bbox::PdfSampleRaw_BoundingBox
    subtype::ProtoBuf.google.protobuf.StringValue
    text::ProtoBuf.google.protobuf.StringValue
    PdfSampleRaw_Page_Annotation(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_Annotation

mutable struct PdfSampleRaw_Page_VatNumber <: ProtoType
    page::UInt32
    text::AbstractString
    bbox::PdfSampleRaw_BoundingBox
    validated::Bool
    PdfSampleRaw_Page_VatNumber(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_VatNumber

mutable struct PdfSampleRaw_Page_VisualRepresentation <: ProtoType
    letter_representation::Base.Vector{Float32}
    PdfSampleRaw_Page_VisualRepresentation(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_VisualRepresentation
const __pack_PdfSampleRaw_Page_VisualRepresentation = Symbol[:letter_representation]
meta(t::Type{PdfSampleRaw_Page_VisualRepresentation}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, __pack_PdfSampleRaw_Page_VisualRepresentation, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

struct __enum_PdfSampleRaw_Page_AccountNumber_AccountType <: ProtoEnum
    IBAN::Int32
    CZECH_NATIONAL::Int32
    __enum_PdfSampleRaw_Page_AccountNumber_AccountType() = new(0,1)
end #struct __enum_PdfSampleRaw_Page_AccountNumber_AccountType
const PdfSampleRaw_Page_AccountNumber_AccountType = __enum_PdfSampleRaw_Page_AccountNumber_AccountType()

mutable struct PdfSampleRaw_Page_AccountNumber <: ProtoType
    page::UInt32
    text::AbstractString
    bbox::PdfSampleRaw_BoundingBox
    validated::Bool
    _type::Int32
    PdfSampleRaw_Page_AccountNumber(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_AccountNumber

mutable struct PdfSampleRaw_Page_CharHistEntry <: ProtoType
    key::AbstractString
    value::UInt32
    PdfSampleRaw_Page_CharHistEntry(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page_CharHistEntry (mapentry)

mutable struct PdfSampleRaw_Page <: ProtoType
    page_id::UInt32
    obj_id::UInt32
    layout_bbox::PdfSampleRaw_BoundingBox
    is_scanned::Bool
    is_scanned_with_ocr::Bool
    annotations::Base.Vector{PdfSampleRaw_Page_Annotation}
    images::Base.Vector{PdfSampleRaw_Page_Image}
    curves::Base.Vector{PdfSampleRaw_Page_Curve}
    lines::Base.Vector{PdfSampleRaw_Page_Curve}
    rectangles::Base.Vector{PdfSampleRaw_Page_Curve}
    texts::Base.Vector{PdfSampleRaw_Page_Text}
    marked_contents::Base.Vector{PdfSampleRaw_Page_MarkedContent}
    word_appends::Base.Vector{PdfSampleRaw_Page_TextAppend}
    word_overlaps::Base.Vector{PdfSampleRaw_Page_Overlap}
    char_hist::Base.Dict{AbstractString,UInt32} # map entry
    vat_numbers::Base.Vector{PdfSampleRaw_Page_VatNumber}
    visual_representation::PdfSampleRaw_Page_VisualRepresentation
    account_numbers::Base.Vector{PdfSampleRaw_Page_AccountNumber}
    visual_class::ProtoBuf.google.protobuf.StringValue
    attribution_key::ProtoBuf.google.protobuf.StringValue
    recognized_account_number::PdfSampleRaw_Page_AccountNumber
    PdfSampleRaw_Page(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_Page

mutable struct PdfSampleRaw_StreamOperations_StreamOperation_StreamOperand <: ProtoType
    _type::AbstractString
    value::AbstractString
    PdfSampleRaw_StreamOperations_StreamOperation_StreamOperand(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_StreamOperations_StreamOperation_StreamOperand

mutable struct PdfSampleRaw_StreamOperations_StreamOperation <: ProtoType
    operator::AbstractString
    operands::Base.Vector{PdfSampleRaw_StreamOperations_StreamOperation_StreamOperand}
    PdfSampleRaw_StreamOperations_StreamOperation(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_StreamOperations_StreamOperation

mutable struct PdfSampleRaw_StreamOperations <: ProtoType
    obj_id::UInt32
    operations::Base.Vector{PdfSampleRaw_StreamOperations_StreamOperation}
    PdfSampleRaw_StreamOperations(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_StreamOperations

mutable struct PdfSampleRaw_StreamWhitespaces <: ProtoType
    obj_id::UInt32
    whitespaces::Base.Vector{AbstractString}
    PdfSampleRaw_StreamWhitespaces(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_StreamWhitespaces

mutable struct PdfSampleRaw_ObjPos <: ProtoType
    byte_pos::UInt32
    obj_id::UInt32
    gen_no::UInt32
    PdfSampleRaw_ObjPos(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_ObjPos

mutable struct PdfSampleRaw_PdfCatalog_Xrefs_Xref <: ProtoType
    obj_id::UInt32
    gen::UInt32
    pos::UInt32
    stream_id::ProtoBuf.google.protobuf.UInt32Value
    PdfSampleRaw_PdfCatalog_Xrefs_Xref(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_PdfCatalog_Xrefs_Xref

mutable struct PdfSampleRaw_PdfCatalog_Xrefs <: ProtoType
    pdf_miner_type::AbstractString
    xrefs::Base.Vector{PdfSampleRaw_PdfCatalog_Xrefs_Xref}
    json_trailer::AbstractString
    PdfSampleRaw_PdfCatalog_Xrefs(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_PdfCatalog_Xrefs

mutable struct PdfSampleRaw_PdfCatalog_JsonCatalogEntry <: ProtoType
    key::UInt32
    value::AbstractString
    PdfSampleRaw_PdfCatalog_JsonCatalogEntry(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_PdfCatalog_JsonCatalogEntry (mapentry)

mutable struct PdfSampleRaw_PdfCatalog <: ProtoType
    json_catalog::Base.Dict{UInt32,AbstractString} # map entry
    xrefs::Base.Vector{PdfSampleRaw_PdfCatalog_Xrefs}
    PdfSampleRaw_PdfCatalog(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_PdfCatalog

mutable struct PdfSampleRaw_SignedBytesDigestsEntry <: ProtoType
    key::AbstractString
    value::Array{UInt8,1}
    PdfSampleRaw_SignedBytesDigestsEntry(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw_SignedBytesDigestsEntry (mapentry)

mutable struct PdfSampleRaw <: ProtoType
    sample_id::PdfSampleRaw_SampleId
    sha256::AbstractString
    file_length::UInt64
    is_edi::Bool
    is_generated_with_preview::Bool
    is_generated_with_preview_print_to_pdf::Bool
    pdf_comment_lines::Base.Vector{Array{UInt8,1}}
    pages::Base.Vector{PdfSampleRaw_Page}
    stream_operations::Base.Vector{PdfSampleRaw_StreamOperations}
    stream_whitespaces::Base.Vector{PdfSampleRaw_StreamWhitespaces}
    obj_positions::Base.Vector{PdfSampleRaw_ObjPos}
    multi_objs::Base.Vector{PdfSampleRaw_MultiObj}
    pdf_catalog::PdfSampleRaw_PdfCatalog
    signed_bytes_digests::Base.Dict{AbstractString,Array{UInt8,1}} # map entry
    PdfSampleRaw(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PdfSampleRaw

export PdfSampleRaw_SampleId, PdfSampleRaw_BoundingBox, PdfSampleRaw_MultiObj_MultiObjOcc_AttributesEntry, PdfSampleRaw_MultiObj_MultiObjOcc, PdfSampleRaw_MultiObj, PdfSampleRaw_Page_Overlap, PdfSampleRaw_Page_TextAppend_WordBoundingBox, PdfSampleRaw_Page_TextAppend, PdfSampleRaw_Page_Image, PdfSampleRaw_Page_Curve_CurveType, PdfSampleRaw_Page_Curve_Point, PdfSampleRaw_Page_Curve_Color_ColorType, PdfSampleRaw_Page_Curve_Color, PdfSampleRaw_Page_Curve, PdfSampleRaw_Page_Char, PdfSampleRaw_Page_Text, PdfSampleRaw_Page_MarkedContent_Type, PdfSampleRaw_Page_MarkedContent_PropertiesEntry, PdfSampleRaw_Page_MarkedContent, PdfSampleRaw_Page_Annotation, PdfSampleRaw_Page_VatNumber, PdfSampleRaw_Page_VisualRepresentation, PdfSampleRaw_Page_AccountNumber_AccountType, PdfSampleRaw_Page_AccountNumber, PdfSampleRaw_Page_CharHistEntry, PdfSampleRaw_Page, PdfSampleRaw_StreamOperations_StreamOperation_StreamOperand, PdfSampleRaw_StreamOperations_StreamOperation, PdfSampleRaw_StreamOperations, PdfSampleRaw_StreamWhitespaces, PdfSampleRaw_ObjPos, PdfSampleRaw_PdfCatalog_Xrefs_Xref, PdfSampleRaw_PdfCatalog_Xrefs, PdfSampleRaw_PdfCatalog_JsonCatalogEntry, PdfSampleRaw_PdfCatalog, PdfSampleRaw_SignedBytesDigestsEntry, PdfSampleRaw
# mapentries: "PdfSampleRaw_Page_CharHistEntry" => ("AbstractString", "UInt32"), "PdfSampleRaw_Page_MarkedContent_PropertiesEntry" => ("AbstractString", "AbstractString"), "PdfSampleRaw_PdfCatalog_JsonCatalogEntry" => ("UInt32", "AbstractString"), "PdfSampleRaw_SignedBytesDigestsEntry" => ("AbstractString", "Array{UInt8,1}"), "PdfSampleRaw_MultiObj_MultiObjOcc_AttributesEntry" => ("AbstractString", "AbstractString")
