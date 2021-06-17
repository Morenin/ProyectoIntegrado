//
//  ChangePasswordViewController.m
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 23/4/21.
//

#import "ChangePasswordViewController.h"
#import "ProyectoFormacionPractica-Swift.h"

@interface ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *ChangeButtonOutlet;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self style];
}


- (IBAction)buttonChange:(id)sender {
    NSString *password = _passwordNewTextField.text;
    NSString *confirmpassword = _repeatNewPasswordTextField.text;
    if ([password length] == 0) {
        [self alertTitle: @"Error" alerText: @"Por favor introduce una nueva contraseña" actionTitle: @"Aceptar"];
    } else {
        if ([password isEqualToString: confirmpassword]) {
            [self alertTitle: @"Aceptar" alerText: @"Contraseña cambiada correctamente" actionTitle: @"Aceptar"];
        } else {
            [self alertTitle: @"Error" alerText: @"Las contraseña deben coincidir" actionTitle: @"Aceptar"];
        }
    }
}

-(void) style {
    //Colo de la pantalla
    [self.view loadStylerColorFoundGris];
    //Label titulo
    self.titleLabel.text = @"Lorem ipsum dolor sit amet, feugiat faucibu lectur, eu semper erat porta vitae: Morbi eestas risus vitae tincidunt maatis";
    [self.titleLabel loadStyleLabelFontOpenSasNormalSmall];
    //Navigation bar
    [self.navigationController.navigationBar loadStyleNavigationBarForgotPassword];
    self.navigationItem.title = @"Cambiar contraseña";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //Boton cambiar
    [self.ChangeButtonOutlet setTitle: @"CAMBIAR" forState:UIControlStateNormal];
    [self.ChangeButtonOutlet loadStyleButtonColorDark];
    [self.ChangeButtonOutlet.titleLabel loadStyleLabelFontOpenSasBoldBig];
    //Text Field contraseña atual
    [self modifyTextField: self.passwordTextField texto:@"Contraseña actual"];
    //Text Field contraseña nueva
    [self modifyTextField: self.passwordNewTextField texto:@"Contraseña nueva"];
    //Text Field repetir contraseña nueva
    [self modifyTextField: self.repeatNewPasswordTextField texto: @"Repetir contraseña nueva"];
}

-(void) modifyTextField: (UITextField *) name texto:(NSString *) text {
    [name setSecureTextEntry: YES];
    [name loadStyleTextFiledColorWhite];
    name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [UIColor black60]}];
    //Padding del texto
    UIView *padding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    name.leftView = padding;
    name.leftViewMode = UITextFieldViewModeAlways;
    //Sombreado
    name.layer.shadowColor = [UIColor blackColor].CGColor;
    name.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    name.layer.shadowOpacity = 0.1;
}

-(void) alertTitle: (NSString *) titleAlert alerText: (NSString *) textAlert actionTitle: (NSString *) titleAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: titleAlert message: textAlert preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle: titleAction style:UIAlertActionStyleDefault handler: ^(UIAlertAction * action) {}];
    [alert addAction: action];
    [self presentViewController: alert animated: YES completion: nil];
}
@end
        
