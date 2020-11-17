if (Rails.env.development?)
  table_name = "projects"
  ActiveRecord::Base.connection.execute("Delete from #{table_name}")
  ActiveRecord::Base.connection.execute("DELETE FROM SQLITE_SEQUENCE WHERE name='#{table_name}'")
else
  Project.destroy_all
end

puts "Seeing Projects"
Project.create([
  {
    title: "Blue Hawaiian",
    description: "Professional: I, along with one other person, put together this masterpiece in about 5 months.",
    image_address: "bluehawaiian.jpg",
    image_alt: "alex younger blue hawaiian helicopters website project",
    project_link: "https://www.bluehawaiian.com/",
    framework: "PHP Laravel",
    color: "text-blue",
    bg_color: "bg-blue-lightest",
  },
  {
    title: "Sundance Helicopters",
    description: "Professional: I have been responsible for the ongoing maintenance and occasional redesigns of this site for nearly two years.",
    image_address: "sundance.jpg",
    image_alt: "alex younger sundance helicopters website project",
    project_link: "https://www.sundancehelicopters.com/",
    framework: "Ruby on Rails",
    color: "text-orange",
    bg_color: "bg-orange-lightest",
  },
  {
    title: "Izoox",
    description: "Professional: Site co-creator and ongoing maintenance.",
    image_address: "izoox.jpg",
    image_alt: "alex younger blue hawaiian helicopters website project",
    project_link: "https://www.izoox.com/",
    framework: "PHP Laravel",
    color: "text-blue",
    bg_color: "bg-blue-lightest",
  },
  {
    title: "The Arkenstone",
    description: "Professional: Ongoing Maintenance",
    image_address: "irocks.jpg",
    image_alt: "alex younger blue hawaiian helicopters website project and management",
    project_link: "https://www.irocks.com/",
    framework: "PHP Laravel",
    color: "text-purple",
    bg_color: "bg-purple-lightest",
  },
  {
    title: "Contemplative Outreach",
    description: "Professional: Site co-creator and ongoing maintenance.",
    image_address: "co.jpg",
    image_alt: "alex younger contemplative outreach website management",
    project_link: "https://www.contemplativeoutreach.org/",
    framework: "Wordpress",
    color: "text-yellow-darker",
    bg_color: "bg-yellow-lightest",
  },
  {
    title: "Hazlitt Data",
    description: "Product of my company, Hazlitt Tech LLC, a data terminal for financial markets. In production.",
    image_address: "hazlitt-data.jpg",
    image_alt: "alex younger hazlitt data website project",
    project_link: "https://github.com/AlextheYounga/hazlitt-data",
    framework: "PHP Laravel",
    color: "text-black",
    bg_color: "bg-grey-lighter",
  },
  {
    title: "Fractal Geometry Calculator",
    description: "Personal: A Python program for determining Hurst exponents and rescale ranges",
    image_address: "mandelbrot.jpg",
    image_alt: "alex younger fractal geometry calculator",
    project_link: "https://github.com/AlextheYounga/fractalGeometryCalculator",
    framework: "Python",
    color: "text-black",
    bg_color: "bg-grey-lighter",
  },
  {
    title: "Word Frequency Calculator",
    description: "Personal: A Python program for calculating word frequency in a book, the average syllable count, and graphing word occurrence over time.",
    image_address: "wordfrequency.jpg",
    image_alt: "alex younger fractal geometry calculator",
    project_link: "https://github.com/AlextheYounga/word-frequency-calculator",
    framework: "Python",
    color: "text-black",
    bg_color: "bg-grey-lighter",
  },
  {
    title: "Plunge Alert Telegram Bot",
    description: "Personal: A telegram bot that alerts you via telegram if the market has crashed",
    image_address: "plungealertbot.jpg",
    image_alt: "alex younger plunge alert telegram bot",
    project_link: "https://github.com/AlextheYounga/plungeAlertBot",
    framework: "Python",
    color: "text-blue",
    bg_color: "bg-blue-lightest",
  },
  {
    title: "Deep Work Planner",
    description: "Personal: A Daily Planner inspired by the book Deep Work",
    image_address: "deep-work-planner.jpg",
    image_alt: "alex younger deep work planner website project and management",
    project_link: "https://github.com/AlextheYounga/deep-work-planner",
    framework: "Ruby on Rails",
    color: "text-black",
    bg_color: "bg-grey-lighter",
  },
# {
#     title: "Economic Indicators Scraped from 200 Countries",
#     description: "Perso",
#     image_address: "world-map.jpg",
#     image_alt: "alex younger leading economic indicators from 200 countries project",
#     project_link: "https://keepingstock.net/i-built-a-web-scraper-to-analyze-the-economic-soundness-of-200-countries-heres-what-i-found-d3ec4fa8116b",
#     framework: "Ruby on Rails",
#     color: "text-orange-darker",
#     bg_color: "bg-orange-lightest"
# },
# {
#     title: "Healing Natural Oils",
#     description: "",
#     image_address: "amoils.jpg",
#     image_alt: "alex younger blue hawaiian helicopters website management",
#     project_link: "https://www.amoils.com/",
#     framework: "Wordpress",
#     color: "text-green",
#     bg_color: "bg-green-lightest"
# },
# {
#     title: "Parallel Path",
#     description: "",
#     image_address: "pp.jpg",
#     image_alt: "alex younger blue hawaiian helicopters website management",
#     project_link: "https://parallelpath.com/",
#     framework: "PHP Laravel with Wordpress",
#     color: "text-grey-dark",
#     bg_color: "bg-grey-lightest"
# },

])
