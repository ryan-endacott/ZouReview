# Factory to represent crawled and parsed data from grade distribution site
# Default should be equal to factory outputs for course, section, department, and instructor

FactoryGirl.define do
  factory :crawled_data, class:Hash do
    course_dept 'HP'
    course_title 'PHYSICAL AGENTS'
    course_number '214'
    section_number '1'
    term 'WS2001'
    course_au 'HP'
    instructor 'ABBOTT'
    count_a 12
    count_b 22
    count_c 0
    count_d 0
    count_f 0
    avg_gpa 3.353

    initialize_with { attributes }
  end
end