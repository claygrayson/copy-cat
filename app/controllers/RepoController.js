var User				= require('../models/copycat/User');

var EmailController		= require('./EmailController');

function RepoController() {

};

RepoController.sendEmail = function(copyright, monitoring_users, cb) {
						var msg = 
'							<tr>' +
'								<td valign="top" id="templateHeader" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #ffffff;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 0;"></td>' +
'							</tr>' +
'							<tr>' +
'								<td valign="top" id="templateBody" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;border-top: 0;border-bottom: 2px solid #EAEAEA;padding-top: 0;padding-bottom: 9px;"><table class="mcnTextBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" border="0" cellpadding="0" cellspacing="0" width="100%">' +
'	<tbody class="mcnTextBlockOuter">' +
'		<tr>' +
'			<td class="mcnTextBlockInner" valign="top" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
'				<table style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnTextContentContainer" align="left" border="0" cellpadding="0" cellspacing="0" width="100%">' +
'					<tbody><tr>' +
'						<td class="mcnTextContent" style="padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #202020;font-family: Helvetica;font-size: 16px;line-height: 150%;text-align: left;" valign="top">' +
'							<h1 style="display: block;margin: 0;padding: 0;color: #202020;font-family: Helvetica;font-size: 16px;font-style: normal;font-weight: light;line-height: 125%;letter-spacing: normal;text-align: left;">Hi,</h1>' +
'<div style="text-align: justify;">A Copyright request was received by CopyCat, please process payment by clicking the link below:<br></div><br>' +
'						</td>' +
'					</tr>' +
'				</tbody></table>' +
'			</td>' +
'		</tr>' +
'	</tbody>' +
'</table><table class="mcnButtonBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" border="0" cellpadding="0" cellspacing="0" width="100%">' +
'	<tbody class="mcnButtonBlockOuter">' +
'		<tr>' +
'			<td style="padding-top: 0;padding-right: 18px;padding-bottom: 18px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnButtonBlockInner" align="center" valign="top">' +
'				<table class="mcnButtonContentContainer" style="border-collapse: separate ! important;border-radius: 3px;background-color: #2BAADF;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" border="0" cellpadding="0" cellspacing="0">' +
'					<tbody>' +
'						<tr>' +
'							<td style="font-family: Arial;font-size: 16px;padding: 15px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnButtonContent" align="center" valign="middle">' +
'								<a class="mcnButton " title="Validate Account" href="' + process.env.HOST + '/copyright/' + copyright.getId().toString() + '/" target="_blank" style="font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;display: block;">Copyright My Code!</a>' +
'							</td>' +
'						</tr>' +
'					</tbody>' +
'				</table>' +
'			</td>' +
'		</tr>' +
'	</tbody>' +
'</table></td>' +
'							</tr>';
	var user = new User();
	user.instantiate(monitoring_users[0]);
	EmailController.send(user, 'Copyright Request', msg, function(err, info) {
		cb(err);
	});
};

module.exports = RepoController;
