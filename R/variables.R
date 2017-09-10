.levers <-
  stats::setNames(
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

.faculty_levers <-
  tibble::tibble(
    survey = rep(c("Faculty", "Staff", "Students"), each = 6),
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
      sprintf("Q%s", 6:11),
      sprintf("Q%s", 12:17),
      sprintf("Q%s", 18:24),
      sprintf("Q%s", 25:29),
      sprintf("Q%s", 30:36),
      sprintf("Q%s", 37:42),
      sprintf("Q%s", 7:12),
      sprintf("Q%s", 13:16),
      sprintf("Q%s", 17:22),
      sprintf("Q%s", 23:28),
      sprintf("Q%s", 29:34),
      sprintf("Q%s", 35:39),
      sprintf("Q%s", 8:12),
      sprintf("Q%s", 13:17),
      sprintf("Q%s", 18:23),
      sprintf("Q%s", 24:28),
      sprintf("Q%s", 29:34),
      sprintf("Q%s", 35:38)
    )
  )

.questions <- tibble::tibble(
    question = c(
      "Q6",
      "Q7",
      "Q8",
      "Q9",
      "Q10",
      "Q11",
      "Q12",
      "Q13",
      "Q14",
      "Q15",
      "Q16",
      "Q17",
      "Q18",
      "Q19",
      "Q20",
      "Q21",
      "Q22",
      "Q23",
      "Q24",
      "Q25",
      "Q26",
      "Q27",
      "Q28",
      "Q29",
      "Q30",
      "Q31",
      "Q32",
      "Q33",
      "Q34",
      "Q35",
      "Q36",
      "Q37",
      "Q38",
      "Q39",
      "Q40",
      "Q41",
      "Q42"
    ),
    prompt = c(
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
      "research on teaching is recognized in the evaluation of instructor job performance"
    )
  )
