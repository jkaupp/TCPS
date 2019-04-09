#' Levers
#' @export
.levers <-
  purrr::set_names(
    c(
      "Lever 1: Institutional, strategic initiatives & practices prioritize effective teaching",
      "Lever 2: Assessment of teaching is constructive & flexible",
      "Lever 3: Implementing effective teaching",
      "Lever 4: Infrastructure exists to support teaching",
      "Lever 5: Broad engagement around teaching",
      "Lever 6: Effective teaching is recognized and rewarded"
    ),
    c(
      "lever1",
      "lever2",
      "lever3",
      "lever4",
      "lever5",
      "lever6"
    )
  )


.tcps <- tibble::tibble(
  survey = c(rep("Faculty", 6+6+7+5+7+6),rep("Staff",6+4+6+6+6+5),rep("Student",5+5+6+5+6+4)),
  lever =  c(purrr::flatten_chr(purrr::map2(sprintf("lever%s", 1:6), c(6,6,7,5,7,6), ~rep(.x, each = .y))),
             purrr::flatten_chr(purrr::map2(sprintf("lever%s", 1:6), c(6,4,6,6,6,5), ~rep(.x, each = .y))),
             purrr::flatten_chr(purrr::map2(sprintf("lever%s", 1:6), c(5,5,6,5,6,4), ~rep(.x, each = .y)))),
  title = c(purrr::flatten_chr(purrr::map2(c("instinit", "assessteach", "impteach", "infrastruct", "brengage", "teachrec"), c(6,6,7,5,7,6), ~rep(.x, each = .y))),
            purrr::flatten_chr(purrr::map2(c("instinit", "assessteach", "impteach", "infrastruct", "brengage", "teachrec"), c(6,4,6,6,6,5), ~rep(.x, each = .y))),
            purrr::flatten_chr(purrr::map2(c("instinit", "assessteach", "impteach", "infrastruct", "brengage", "teachrec"), c(5,5,6,5,6,4), ~rep(.x, each = .y)))),
  question = c(
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:7),
    sprintf("q%s", 1:5),
    sprintf("q%s", 1:7),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:4),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:5),
    sprintf("q%s", 1:5),
    sprintf("q%s", 1:5),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:5),
    sprintf("q%s", 1:6),
    sprintf("q%s", 1:4)
  ),
  prompt = c(
    c(
      "teaching is considered a priority in the primary institutional strategic plan",
      "effective teaching is clearly defined in institution-wide documents",
      "senior administrators convey that effective teaching is an institutional priority",
      "institution-wide initiatives promote innovative teaching practices",
      "most instructors consider good teaching to be a priority",
      "institutional policies recognize effective teaching in evaluation of instructor job performance",
      "students are invited to provide feedback to their instructors in addition to end of course evaluations",
      "student evaluations of teaching are taken into consideration in hiring, promotion and tenure practices",
      "teaching is formally assessed in multiple ways",
      "course design is considered in the assessment of teaching",
      "student learning outcomes are considered in program evaluation",
      "instructors have some influence over how their teaching is assessed",
      "instructors adopt a variety of approaches to teaching and learning",
      "instructors tell their students how they use student feedback to improve teaching",
      "instructors have developed teaching and assessment methods that align with the learning outcomes of their course",
      "instructors tell their students how their course fits into the curriculum toward a degree",
      "instructors access the services and resources provided to support their development as teachers",
      "instructors are encouraged to spend time developing their teaching",
      "instructors are encouraged to use evidence about teaching to inform their teaching practices",
      "learning spaces such as classrooms, labs and/or studios are designed to support learning",
      "instructors have access to adequate materials/supplies to provide a good learning environment",
      "instructors have access to resources to help them facilitate technology-enabled learning",
      "instructors have access to resources and support to improve their teaching",
      "instructors can get financial support to develop their teaching",
      "students are involved in activities that foster effective teaching across the institution",
      "external stakeholders are involved in initiatives that foster effective teaching across the institution",
      "staff who support teaching are involved in initiatives that foster effective teaching",
      "teaching assistants provide effective support for student learning",
      "collaborative approaches to teaching are valued",
      "teaching practices are discussed across the institution through a range of mechanisms",
      "opportunities exist for instructors to lead initiatives that enhance teaching beyond their own classroom",
      "evidence of effective teaching is recognized in the evaluation of instructor job performance",
      "there are institutional rewards for effective teaching",
      "teaching accomplishments, contributions, and/or awards are publicized and/or celebrated",
      "teaching is valued in instructor hiring processes",
      "unit level administrators reward effective teaching as a priority",
      "research on teaching is recognized in the evaluation of instructor job performance"),
      c(
        "teaching is considered a priority in the primary institutional strategic plan",
        "effective teaching is clearly defined in institution-wide documents",
        "senior administrators convey that effective teaching is an institutional priority",
        "institution-wide initiatives promote innovative teaching practices",
        "most instructors consider good teaching to be a priority",
        "staff who support teaching are regarded as an important resource for instructors and
educational administrators",
        "student evaluations of teaching are taken into consideration in hiring, promotion and tenure practices",
        "teaching is formally assessed in multiple ways",
        "the results of teaching evaluations are accessible to students",
        "staff who support teaching are invited to provide feedback on course design",
        "instructors adopt a variety of approaches to teaching and learning",
        "instructors have developed teaching and assessment methods that align with the learning outcomes of their course",
        "instructors tell their students how their course fits into the curriculum toward a degree",
        "instructors access the services and resources provided to support their development as teachers",
        "instructors are encouraged to spend time developing their teaching",
        "staff who support teaching contribute to the development and implementation of effective
teaching",
        "learning spaces such as classrooms, labs and/or studios are designed to support learning",
        "instructors have access to adequate materials/supplies to provide a good learning environment",
        "instructors have access to resources to help them facilitate technology-enabled learning",
        "instructors have access to resources and support to improve their teaching",
        "staff who support teaching are encouraged to develop their expertise in their role",
        "staff who support teaching can get financial support to develop their expertise in their role",
        "students are involved in activities that foster effective teaching across the institution",
        "external stakeholders such as alumni, employers and/or community members are involved in initiatives that foster effective teaching across the institution",
        "staff who support teaching are involved in initiatives that foster effective teaching",
        "teaching assistants provide effective support for student learning",
        "collaborative approaches to teaching are valued",
        "teaching practices are discussed across the institution through a range of mechanisms",
        "evidence of effective teaching is recognized in the evaluation of instructor job performance",
        "there are institutional rewards for effective teaching",
        "teaching accomplishments, contributions, and/or awards are publicized and/or celebrated",
        "teaching is valued in instructor hiring processes",
        "there is institutional recognition for staff who support teaching"),
    c(
      "teaching is considered a priority in the primary institutional strategic plan",
      "effective teaching is clearly defined in institution-wide documents",
      "senior administrators convey that effective teaching is an institutional priority",
      "institution-wide initiatives promote innovative teaching practices",
      "most instructors consider good teaching to be a priority",
      "students are invited to provide feedback to their instructors in addition to end of course evaluations",
      "student evaluations of teaching are taken into consideration in hiring, promotion and tenure practices",
      "the results of teaching evaluations are accessible to students",
      "students are invited to provide feedback on course design",
      "student evaluations of teaching are taken into consideration to improve teaching",
      "instructors adopt a variety of approaches to teaching and learning",
      "instructors think of creative or unique ways to engage students in the course material",
      "instructors tell their students how they use student feedback to improve teaching",
      "instructors communicate how course content is relevant to the workplace and future careers",
      "instructors tell their students how teaching methods and assignments align with learning outcomes",
      "instructors tell their students how their course fits into the curriculum toward a degree",
      "learning spaces such as classrooms, labs and/or studios are designed to support learning",
      "instructors have access to adequate materials/supplies to provide a good learning environment",
      "instructors have access to resources and support to improve their teaching",
      "instructors use technology effectively to support student learning",
      "instructors use technology in new and innovative ways to facilitate student learning",
      "students are involved in activities that foster effective teaching across the institution",
      "external stakeholders such as alumni, employers and/or community members are involved in initiatives that foster effective teaching across the institution",
      "staff who support teaching (from units such as the library, the teaching centre, and student success) are involved in initiatives that foster effective teaching",
      "teaching assistants provide effective support for student learning",
      "collaborative approaches to teaching are valued",
      "instructors discuss ways to improve the student learning experience with their colleagues",
      "evidence of effective teaching is recognized in the evaluation of instructor job performance",
      "there are institutional rewards for effective teaching",
      "teaching accomplishments, contributions, and/or awards are publicized and/or celebrated",
      "teaching is valued in instructor hiring processes")
      )
  )


#' Ridgeline palette one
#' @export
pal_one <- c("#0051b3", "#a70076")

#' Ridgeline palette two
#' @export
pal_two <- c("#98ce49",
             "#00298d")

#' Ridgeline palette three
#' @export
pal_three <- c("#026ec0",
               "#dd3a48")
