# GIFKeeper
 
# Договоренности по проекту 

## CodeStyle

###  Если аргументов больше одного - переносим после скобки (,{ , скобку потом тоже переносим

### Если в guard две проверки - перенос
    guard
        let
        let
    else {}
### Если аргумент один в кложуре - пишем в одну строку

### В кложурах аргументы очевидные писать $0 (напр. make в SnapKit)
    Неочевидные - польностью

## Constants
    - Выносятся Magic числа 
    - Все значения строк и цифр ЕСЛИ повторяются 

## Naming

### Переменные коллекций
    - Не должны содержать название самой коллекции
    Не правильно: UsersArray
    Правильно: Users, UserList

### Custom UI Classes:
    Как надо именовать CustomButton
    Как не надо CustomButtonDetailViewController


## Шаблон ViewController-а

    final class ViewController: UIViewController {
        
        // MARK: UIElements
        
        // MARK: View controller lifecycle methods
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureNavigationBar()
            setupHierarchy()
            setupLayout()
            configureView()
        }
    }

    // MARK: - Configure Navigation bar

    extension ViewController {
        private func configureNavigationBar() {
            navigationItem.title = Constants.navigationTitle
            navigationItem.searchController = searchController
        }
    }

    // MARK: - Setup hierarchy

    private extension ViewController {
        func setupHierarchy() {
            view.addSubview(allGroupsCollection)
        }
    }

    // MARK: - Setup layouts for UIElements

    private extension ViewController {
        func setupLayout() {
            collection.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) 
            }
        }
    }

    // MARK: - Configure view property

    private extension ViewController {
        func configureView() {
            view.backgroundColor = .white
        }
    }

    // MARK: - CollectionViewDataSource

    extension ViewController: UICollectionViewDataSource {}

    // MARK: - CollectionViewDelegate

    extension ViewController: UICollectionViewDelegate {}

    // MARK: - Constants

    private enum Constants {
        static let navigationTitle = ""
        static let spacingItemsInCollection: CGFloat = 5
    }

