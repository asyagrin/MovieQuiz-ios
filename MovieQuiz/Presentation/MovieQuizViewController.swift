import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    //Связи для картинки, текста и счетчика
    
   
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!
    
    //outlet for yesButton
    
    @IBOutlet var yesButtonImage: UIButton!
    //outlet for noButton
    
    @IBOutlet var noButtonImage: UIButton!
    
    // Переменная, которая отвечает за индекс текущего вопроса
    private var currentQuestionIndex: Int = 0
    
    //При ответе на вопрос мы будем увеличивать этот счётчик и использовать его для получения правильной модели из массива questions
    private var currentQuestion: QuizQuestion {
        questions[currentQuestionIndex]
    }
    
    //переменная количества правильных ответов
    private var correctAnswers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Функция для кнопки Да
    
    @IBAction func yesButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    //Функция для кнопки Нет
    
    
    @IBAction func noButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    //enable&disable for yes&no buttons
    private func buttonsEnabled(is state: Bool) {
        if state {
            self.yesButtonImage.isEnabled = true
            self.noButtonImage.isEnabled = true
        } else {
            self.yesButtonImage.isEnabled = false
            self.noButtonImage.isEnabled = false
        }
    }
    
    
    //mock-данные описаны такой структурой
    struct QuizQuestion {
      let image: String
      let text: String
      let correctAnswer: Bool
    }

    //Модель для состояния "Вопрос задан"
    struct QuizStepViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }

    //Модель для состояния "Результат квиза"
    struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }

    
   
    
//Все 10 вопросов нашего квиза могут быть представлены в виде массива вот таких структур: let questions: [QuizQuestion]
   
//Массив как переменная, заполненная тестовыми данными:
    private let questions: [QuizQuestion] = [
    QuizQuestion (
        image: "The Godfather",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion (
        image: "The Dark Knight",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Kill Bill",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "The Avengers",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Deadpool",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "The Green Knight",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: true),
                QuizQuestion(
                    image: "Old",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "The Ice Age Adventures of Buck Wild",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "Tesla",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false),
                QuizQuestion(
                    image: "Vivarium",
                    text: "Рейтинг этого фильма больше чем 6?",
                    correctAnswer: false)
            ]
    
    //Показать вопрос на экране (функция, которая будет показывать View-модель на экране)
    private func show(quiz step: QuizStepViewModel) {
        // здесь мы заполняем нашу картинку, текст и счётчик данными
        imageView.image = step.image
        counterLabel.text = step.questionNumber
        textLabel.text = step.question
    }
    
    //показать следующий шаг - состояние, где показывается вопрос, или в состояние, где показаны результаты всего квиза
    private func showNextQuestionOrResults() {
        //если индекс текущего вопроса указывает на последний вопрос в массиве вопросов, то надо показывать результат. Если нет — надо взять следующий вопрос в массиве и показать его
        if currentQuestionIndex == questions.count - 1 {
            // показать результат квиза
            let text = "Ваш результат: \(correctAnswers) из 10"
            let viewModel = QuizResultsViewModel (title: "Этот раунд закончен!",
                                                  text: text,
                                                  buttonText: "Сыграть еще раз")
            show(quiz: viewModel)
            
        } else {
            //увеличиваем индекс текущего урока на 1; таким образом мы сможем получить следующий урок
            currentQuestionIndex += 1
            // показать следующий вопрос - взять вопрос по текущему индексу currentQuestionIndex, превратить его во View-модель, используя функцию конвертации, и вызвать показ этой View-модели

            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
        }
    }
    
    //После нажатия на кнопки «Да» и «Нет» экран переходит в другое состояние — состояние показа результата ответа. Функция, чтобы показать его:
        private func showAnswerResult(isCorrect: Bool) {
            
            //если ответ верен, увеличиваем переменную correctAnswers
            if isCorrect {
                correctAnswers += 1
            }
            
            // даём разрешение на рисование рамки
            imageView.layer.masksToBounds = true
            // толщина рамки
            imageView.layer.borderWidth = 8
            //Отображение красной или зеленой рамки (цвета), исходя из правильности ответа, то есть переменной `isCorrect` (если isCorrect, то зеленая, иначе красная)
            imageView.layer.borderColor = isCorrect ? UIColor.ypGreen?.cgColor : UIColor.ypRed?.cgColor
            //to disable yes & no buttons
            buttonsEnabled(is: false)
            // запускаем задачу через 1 секунду
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // код, который надо вызвать через 1 секунду
                self.showNextQuestionOrResults()
                self.imageView.layer.borderColor = UIColor.clear.cgColor
                //to enable yes & no buttons back
                self.buttonsEnabled(is: true)
            }
            
        }
    
    //Функция конвертации из QuizQuestion в QuizStepViewModel (преобразуем данные, которые есть в модели вопроса, в те данные, которые необходимо показать на этапе квиза)
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            // распаковываем картинку
            image: UIImage(named: model.image) ?? UIImage(),
            // берём текст вопроса
            question: model.text,
            // высчитываем номер вопроса
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
    
    //(функция, которая будут показывать View-модель на экране)
    private func show(quiz result: QuizResultsViewModel) {
        // здесь мы показываем результат прохождения квиза
        // создаём объекты всплывающего окна
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        // создаём для него кнопки с действиями
        let action = UIAlertAction(title: result.buttonText, style: .default) {_ in
            self.currentQuestionIndex = 0
            // скидываем счётчик правильных ответов
            self.correctAnswers = 0
            // заново показываем первый вопрос
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)}
        
        // добавляем в алерт кнопки
        alert.addAction(action)
        // показываем всплывающее окно
        self.present(alert, animated: true, completion: nil)
            

    }
    
    
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
