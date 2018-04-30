#' Levers
#' @export
.levers <-
  purrr::set_names(
    c(
      "Institutional Initiatives",
      "Assessment of Teaching",
      "Implementing Effective Teaching",
      "Infrastructure Supporting Teaching",
      "Broad Engagement Around Teaching",
      "Recognizing Effective Teaching"
    ),
    c(
      "instinit",
      "assessteach",
      "impteach",
      "infrastruct",
      "brengage",
      "teachrec"
    )
  )

.lever_alias <-
  purrr::set_names(
    c(
      "instinit",
      "assessteach",
      "impteach",
      "infrastruct",
      "brengage",
      "teachrec"
    ),
    c(
      "Lever1",
      "Lever2",
      "Lever3",
      "Lever4",
      "Lever5",
      "Lever6"
    )

  )

.tcps_levers <-
  tibble::tibble(
    survey = rep(c("Faculty", "Staff", "Student"), each = 6),
    lever = rep(
      c(
        "instinit",
        "assessteach",
        "impteach",
        "infrastruct",
        "brengage",
        "teachrec"
      ),
      3
    ),
    questions = list(
      sprintf("Q%s", 7:12),
      sprintf("Q%s", 13:18),
      sprintf("Q%s", 19:25),
      sprintf("Q%s", 26:30),
      sprintf("Q%s", 31:37),
      sprintf("Q%s", 38:43),
      sprintf("Q%s", 6:11),
      sprintf("Q%s", 12:15),
      sprintf("Q%s", 16:21),
      sprintf("Q%s", 22:27),
      sprintf("Q%s", 28:33),
      sprintf("Q%s", 34:38),
      sprintf("Q%s", 8:12),
      sprintf("Q%s", 13:17),
      sprintf("Q%s", 18:23),
      sprintf("Q%s", 24:28),
      sprintf("Q%s", 29:34),
      sprintf("Q%s", 35:38)
    )
  )

.questions <- tibble::tibble(
  survey = c(rep("Faculty", 43-7+1),rep("Staff",38-6+1),rep("Students",38-8+1)),
  question = c(sprintf("Q%s", 7:43),sprintf("Q%s", 6:38), sprintf("Q%s",8:38)),
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
        "staff who support teaching are regarded as an 1 2 3 4 5 DK PNA important resource for instructors and
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
pal_one <- c("#F6D600","#11CD86")

#' Ridgeline palette two
#' @export
pal_two <- c("#ffdf50","#00a7f5")

#' Ridgeline palette three
#' @export
pal_three <- c("#091971","#80eb84")
