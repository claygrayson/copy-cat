var nodemailer = require('nodemailer');
var EmailTemplate = require('email-templates').EmailTemplate;
var path = require('path');
var User = require('../models/copycat/User');

var templatesDir = path.resolve(__dirname, '..', 'emailTemplates');

var transporter = null;
if(process.env.GMAIL_PASSWORD !== 'undefined') {
	transporter = nodemailer.createTransport({
		service: 'Gmail',
		auth: {
			user: 'support@copy-cat.io',
			pass: process.env.GMAIL_PASSWORD
		}
	});
}

function EmailController() {

}

EmailController.send = function(user, subject, msg, cb) {
	var up = user.getOwnedUserProfile();
	if(typeof(up) !== 'undefined' && typeof(up.getEmail()) !== 'undefined' && up.getEmail() !== null && up.getEmail() !== '') {
		if(transporter !== null) {
			var owning_name = '';

			transporter.sendMail({
					from: 'CopyCat <support@copy-cat.io>', // sender address
					to: owning_name + '<' + up.getEmail() + '>', // list of receivers
					sender: 'support@copy-cat.io',
					replyTo: 'support@copy-cat.io',
					subject: subject, // Subject line
					html:
				'<!doctype html>' +
				'<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">' +
				' <head>' +
				'  <!-- NAME: 1 COLUMN -->' +
				'  <!--[if gte mso 15]>' +
				'  <xml>' +
				'   <o:OfficeDocumentSettings>' +
				'   <o:AllowPNG/>' +
				'   <o:PixelsPerInch>96</o:PixelsPerInch>' +
				'   </o:OfficeDocumentSettings>' +
				'  </xml>' +
				'  <![endif]-->' +
				'  <meta charset="UTF-8">' +
				'        <meta http-equiv="X-UA-Compatible" content="IE=edge">' +
				'        <meta name="viewport" content="width=device-width, initial-scale=1">' +
				'  <title>Welcome to Copy-Cat.io!</title>' +

				'    <style type="text/css">' +
				'  p{' +
				'   margin:10px 0;' +
				'   padding:0;' +
				'  }' +
				'  table{' +
				'   border-collapse:collapse;' +
				'  }' +
				'  h1,h2,h3,h4,h5,h6{' +
				'   display:block;' +
				'   margin:0;' +
				'   padding:0;' +
				'  }' +
				'  img,a img{' +
				'   border:0;' +
				'   height:auto;' +
				'   outline:none;' +
				'   text-decoration:none;' +
				'  }' +
				'  body,#bodyTable,#bodyCell{' +
				'   height:100%;' +
				'   margin:0;' +
				'   padding:0;' +
				'   width:100%;' +
				'  }' +
				'  #outlook a{' +
				'   padding:0;' +
				'  }' +
				'  img{' +
				'   -ms-interpolation-mode:bicubic;' +
				'  }' +
				'  table{' +
				'   mso-table-lspace:0pt;' +
				'   mso-table-rspace:0pt;' +
				'  }' +
				'  .ReadMsgBody{' +
				'   width:100%;' +
				'  }' +
				'  .ExternalClass{' +
				'   width:100%;' +
				'  }' +
				'  p,a,li,td,blockquote{' +
				'   mso-line-height-rule:exactly;' +
				'  }' +
				'  a[href^=tel],a[href^=sms]{' +
				'   color:inherit;' +
				'   cursor:default;' +
				'   text-decoration:none;' +
				'  }' +
				'  p,a,li,td,body,table,blockquote{' +
				'   -ms-text-size-adjust:100%;' +
				'   -webkit-text-size-adjust:100%;' +
				'  }' +
				'  .ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{' +
				'   line-height:100%;' +
				'  }' +
				'  a[x-apple-data-detectors]{' +
				'   color:inherit !important;' +
				'   text-decoration:none !important;' +
				'   font-size:inherit !important;' +
				'   font-family:inherit !important;' +
				'   font-weight:inherit !important;' +
				'   line-height:inherit !important;' +
				'  }' +
				'  #bodyCell{' +
				'   padding:10px;' +
				'  }' +
				'  .templateContainer{' +
				'   max-width:600px !important;' +
				'  }' +
				'  a.mcnButton{' +
				'   display:block;' +
				'  }' +
				'  .mcnImage{' +
				'   vertical-align:bottom;' +
				'  }' +
				'  .mcnTextContent{' +
				'   word-break:break-word;' +
				'  }' +
				'  .mcnTextContent img{' +
				'   height:auto !important;' +
				'  }' +
				'  .mcnDividerBlock{' +
				'   table-layout:fixed !important;' +
				'  }' +
				'  body,#bodyTable{' +
				'   background-color:#ffffff;' +
				'  }' +
				'  #bodyCell{' +
				'   border-top:0;' +
				'  }' +
				'  .templateContainer{' +
				'   border:0;' +
				'  }' +
				'  h1{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:26px;' +
				'   font-style:normal;' +
				'   font-weight:bold;' +
				'   line-height:125%;' +
				'   letter-spacing:normal;' +
				'   text-align:left;' +
				'  }' +
				'  h2{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:22px;' +
				'   font-style:normal;' +
				'   font-weight:bold;' +
				'   line-height:125%;' +
				'   letter-spacing:normal;' +
				'   text-align:left;' +
				'  }' +
				'  h3{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:20px;' +
				'   font-style:normal;' +
				'   font-weight:bold;' +
				'   line-height:125%;' +
				'   letter-spacing:normal;' +
				'   text-align:left;' +
				'  }' +
				'  h4{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:18px;' +
				'   font-style:normal;' +
				'   font-weight:bold;' +
				'   line-height:125%;' +
				'   letter-spacing:normal;' +
				'   text-align:left;' +
				'  }' +
				'  #templatePreheader{' +
				'   background-color:#ffffff;' +
				'   border-top:0;' +
				'   border-bottom:0;' +
				'   padding-top:9px;' +
				'   padding-bottom:9px;' +
				'  }' +
				'  #templatePreheader .mcnTextContent,#templatePreheader .mcnTextContent p{' +
				'   color:#656565;' +
				'   font-family:Helvetica;' +
				'   font-size:12px;' +
				'   line-height:150%;' +
				'   text-align:left;' +
				'  }' +
				'  #templatePreheader .mcnTextContent a,#templatePreheader .mcnTextContent p a{' +
				'   color:#656565;' +
				'   font-weight:normal;' +
				'   text-decoration:underline;' +
				'  }' +
				'  #templateHeader{' +
				'   background-color:#ffffff;' +
				'   border-top:0;' +
				'   border-bottom:0;' +
				'   padding-top:9px;' +
				'   padding-bottom:0;' +
				'  }' +
				'  #templateHeader .mcnTextContent,#templateHeader .mcnTextContent p{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:16px;' +
				'   line-height:150%;' +
				'   text-align:left;' +
				'  }' +
				'  #templateHeader .mcnTextContent a,#templateHeader .mcnTextContent p a{' +
				'   color:#2BAADF;' +
				'   font-weight:normal;' +
				'   text-decoration:underline;' +
				'  }' +
				'  #templateBody{' +
				'   background-color:#FFFFFF;' +
				'   border-top:0;' +
				'   border-bottom:2px solid #EAEAEA;' +
				'   padding-top:0;' +
				'   padding-bottom:9px;' +
				'  }' +
				'  #templateBody .mcnTextContent,#templateBody .mcnTextContent p{' +
				'   color:#202020;' +
				'   font-family:Helvetica;' +
				'   font-size:16px;' +
				'   line-height:150%;' +
				'   text-align:left;' +
				'  }' +
				'  #templateBody .mcnTextContent a,#templateBody .mcnTextContent p a{' +
				'   color:#2BAADF;' +
				'   font-weight:normal;' +
				'   text-decoration:underline;' +
				'  }' +
				'  #templateFooter{' +
				'   background-color:#ffffff;' +
				'   border-top:0;' +
				'   border-bottom:0;' +
				'   padding-top:9px;' +
				'   padding-bottom:9px;' +
				'  }' +
				'  #templateFooter .mcnTextContent,#templateFooter .mcnTextContent p{' +
				'   color:#656565;' +
				'   font-family:Helvetica;' +
				'   font-size:12px;' +
				'   line-height:150%;' +
				'   text-align:center;' +
				'  }' +
				'  #templateFooter .mcnTextContent a,#templateFooter .mcnTextContent p a{' +
				'   color:#656565;' +
				'   font-weight:normal;' +
				'   text-decoration:underline;' +
				'  }' +
				' @media only screen and (min-width:768px){' +
				'  .templateContainer{' +
				'   width:600px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  body,table,td,p,a,li,blockquote{' +
				'   -webkit-text-size-adjust:none !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  body{' +
				'   width:100% !important;' +
				'   min-width:100% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #bodyCell{' +
				'   padding-top:10px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImage{' +
				'   width:100% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnCaptionTopContent,.mcnCaptionBottomContent,.mcnTextContentContainer,.mcnBoxedTextContentContainer,.mcnImageGroupContentContainer,.mcnCaptionLeftTextContentContainer,.mcnCaptionRightTextContentContainer,.mcnCaptionLeftImageContentContainer,.mcnCaptionRightImageContentContainer,.mcnImageCardLeftTextContentContainer,.mcnImageCardRightTextContentContainer{' +
				'   max-width:100% !important;' +
				'   width:100% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnBoxedTextContentContainer{' +
				'   min-width:100% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageGroupContent{' +
				'   padding:9px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnCaptionLeftContentOuter .mcnTextContent,.mcnCaptionRightContentOuter .mcnTextContent{' +
				'   padding-top:9px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageCardTopImageContent,.mcnCaptionBlockInner .mcnCaptionTopContent:last-child .mcnTextContent{' +
				'   padding-top:18px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageCardBottomImageContent{' +
				'   padding-bottom:9px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageGroupBlockInner{' +
				'   padding-top:0 !important;' +
				'   padding-bottom:0 !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageGroupBlockOuter{' +
				'   padding-top:9px !important;' +
				'   padding-bottom:9px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnTextContent,.mcnBoxedTextContentColumn{' +
				'   padding-right:18px !important;' +
				'   padding-left:18px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnImageCardLeftImageContent,.mcnImageCardRightImageContent{' +
				'   padding-right:18px !important;' +
				'   padding-bottom:0 !important;' +
				'   padding-left:18px !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcpreview-image-uploader{' +
				'   display:none !important;' +
				'   width:100% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  h1{' +
				'   font-size:22px !important;' +
				'   line-height:125% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  h2{' +
				'   font-size:20px !important;' +
				'   line-height:125% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  h3{' +
				'   font-size:18px !important;' +
				'   line-height:125% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  h4{' +
				'   font-size:16px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  .mcnBoxedTextContentContainer .mcnTextContent,.mcnBoxedTextContentContainer .mcnTextContent p{' +
				'   font-size:14px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #templatePreheader{' +
				'   display:block !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #templatePreheader .mcnTextContent,#templatePreheader .mcnTextContent p{' +
				'   font-size:14px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #templateHeader .mcnTextContent,#templateHeader .mcnTextContent p{' +
				'   font-size:16px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #templateBody .mcnTextContent,#templateBody .mcnTextContent p{' +
				'   font-size:16px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'} @media only screen and (max-width: 480px){' +
				'  #templateFooter .mcnTextContent,#templateFooter .mcnTextContent p{' +
				'   font-size:14px !important;' +
				'   line-height:150% !important;' +
				'  }' +
				'}</style></head>' +
				'    <body style="height: 100%;margin: 0;padding: 0;width: 100%;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #ffffff;">' +
				'        <center>' +
				'            <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;height: 100%;margin: 0;padding: 0;width: 100%;background-color: #ffffff;">' +
				'                <tr>' +
				'                    <td align="center" valign="top" id="bodyCell" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;height: 100%;margin: 0;padding: 10px;width: 100%;border-top: 0;">' +
				'                        <!-- BEGIN TEMPLATE // -->' +
				'      <!--[if gte mso 9]>' +
				'      <table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;">' +
				'      <tr>' +
				'      <td align="center" valign="top" width="600" style="width:600px;">' +
				'      <![endif]-->' +
				'                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;border: 0;max-width: 600px !important;">' +
				'                            <tr>' +
				'                                <td valign="top" id="templatePreheader" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #ffffff;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 9px;"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnImageBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'    <tbody class="mcnImageBlockOuter">' +
				'            <tr>' +
				'                <td valign="top" style="padding: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnImageBlockInner">' +
				'                    <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" class="mcnImageContentContainer" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                        <tbody><tr>' +
				'                            <td class="mcnImageContent" valign="top" style="padding-right: 9px;padding-left: 9px;padding-top: 0;padding-bottom: 0;text-align: center;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                        <img align="center" alt="" src="https://rapid.io/img/rapid-cover.png" width="564" style="max-width: 1024px;padding-bottom: 0;display: inline !important;vertical-align: bottom;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" class="mcnImage">' +
				'                            </td>' +
				'                        </tr>' +
				'                    </tbody></table>' +
				'                </td>' +
				'            </tr>' +
				'    </tbody>' +
				'</table></td>' +
				'                            </tr>' +
				msg +
				'                            <tr>' +
				'                                <td valign="top" id="templateFooter" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #ffffff;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 9px;"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'    <tbody class="mcnFollowBlockOuter">' +
				'        <tr>' +
				'            <td align="center" valign="top" style="padding: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowBlockInner">' +
				'                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentContainer" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'    <tbody><tr>' +
				'        <td align="center" style="padding-left: 9px;padding-right: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContent">' +
				'                <tbody><tr>' +
				'                    <td align="center" valign="top" style="padding-top: 9px;padding-right: 9px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                        <table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                            <tbody><tr>' +
				'                                <td align="center" valign="top" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                    <!--[if mso]>' +
				'                                    <table align="center" border="0" cellspacing="0" cellpadding="0">' +
				'                                    <tr>' +
				'                                    <![endif]-->' +
				'                                        <!--[if mso]>' +
				'                                        <td align="center" valign="top">' +
				'                                        <![endif]-->' +
				'                                            <table align="left" border="0" cellpadding="0" cellspacing="0" style="display: inline;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                <tbody><tr>' +
				'                                                    <td valign="top" style="padding-right: 10px;padding-bottom: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContentItemContainer">' +
				'                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                            <tbody><tr>' +
				'                                                                <td align="left" valign="middle" style="padding-top: 5px;padding-right: 10px;padding-bottom: 5px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                    <table align="left" border="0" cellpadding="0" cellspacing="0" width="" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                        <tbody><tr>' +
				'                                                                                <td align="center" valign="middle" width="24" class="mcnFollowIconContent" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                                    <a href="http://www.twitter.com/rapid_io" target="_blank" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/color-twitter-48.png" style="display: block;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" height="24" width="24" class=""></a>' +
				'                                                                                </td>' +
				'                                                                        </tr>' +
				'                                                                    </tbody></table>' +
				'                                                                </td>' +
				'                                                            </tr>' +
				'                                                        </tbody></table>' +
				'                                                    </td>' +
				'                                                </tr>' +
				'                                            </tbody></table>' +
				'                                        <!--[if mso]>' +
				'                                        </td>' +
				'                                        <![endif]-->' +
				'                                        <!--[if mso]>' +
				'                                        <td align="center" valign="top">' +
				'                                        <![endif]-->' +
				'                                            <table align="left" border="0" cellpadding="0" cellspacing="0" style="display: inline;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                <tbody><tr>' +
				'                                                    <td valign="top" style="padding-right: 10px;padding-bottom: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContentItemContainer">' +
				'                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                            <tbody><tr>' +
				'                                                                <td align="left" valign="middle" style="padding-top: 5px;padding-right: 10px;padding-bottom: 5px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                    <table align="left" border="0" cellpadding="0" cellspacing="0" width="" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                        <tbody><tr>' +
				'                                                                                <td align="center" valign="middle" width="24" class="mcnFollowIconContent" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                                    <a href="http://www.facebook.com/RapidAppDev" target="_blank" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/color-facebook-48.png" style="display: block;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" height="24" width="24" class=""></a>' +
				'                                                                                </td>' +
				'                                                                        </tr>' +
				'                                                                    </tbody></table>' +
				'                                                                </td>' +
				'                                                            </tr>' +
				'                                                        </tbody></table>' +
				'                                                    </td>' +
				'                                                </tr>' +
				'                                            </tbody></table>' +
				'                                        <!--[if mso]>' +
				'                                        </td>' +
				'                                        <![endif]-->' +
				'                                        <!--[if mso]>' +
				'                                        <td align="center" valign="top">' +
				'                                        <![endif]-->' +
				'                                            <table align="left" border="0" cellpadding="0" cellspacing="0" style="display: inline;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                <tbody><tr>' +
				'                                                    <td valign="top" style="padding-right: 10px;padding-bottom: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContentItemContainer">' +
				'                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                            <tbody><tr>' +
				'                                                                <td align="left" valign="middle" style="padding-top: 5px;padding-right: 10px;padding-bottom: 5px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                    <table align="left" border="0" cellpadding="0" cellspacing="0" width="" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                        <tbody><tr>' +
				'                                                                                <td align="center" valign="middle" width="24" class="mcnFollowIconContent" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                                    <a href="http://rapid.io" target="_blank" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/color-link-48.png" style="display: block;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" height="24" width="24" class=""></a>' +
				'                                                                                </td>' +
				'                                                                        </tr>' +
				'                                                                    </tbody></table>' +
				'                                                                </td>' +
				'                                                            </tr>' +
				'                                                        </tbody></table>' +
				'                                                    </td>' +
				'                                                </tr>' +
				'                                            </tbody></table>' +
				'                                        <!--[if mso]>' +
				'                                        </td>' +
				'                                        <![endif]-->' +
				'                                        <!--[if mso]>' +
				'                                        <td align="center" valign="top">' +
				'                                        <![endif]-->' +
				'                                            <table align="left" border="0" cellpadding="0" cellspacing="0" style="display: inline;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                <tbody><tr>' +
				'                                                    <td valign="top" style="padding-right: 10px;padding-bottom: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContentItemContainer">' +
				'                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                            <tbody><tr>' +
				'                                                                <td align="left" valign="middle" style="padding-top: 5px;padding-right: 10px;padding-bottom: 5px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                    <table align="left" border="0" cellpadding="0" cellspacing="0" width="" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                        <tbody><tr>' +
				'                                                                                <td align="center" valign="middle" width="24" class="mcnFollowIconContent" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                                    <a href="http://www.linkedin.com" target="_blank" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/color-linkedin-48.png" style="display: block;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" height="24" width="24" class=""></a>' +
				'                                                                                </td>' +
				'                                                                        </tr>' +
				'                                                                    </tbody></table>' +
				'                                                                </td>' +
				'                                                            </tr>' +
				'                                                        </tbody></table>' +
				'                                                    </td>' +
				'                                                </tr>' +
				'                                            </tbody></table>' +
				'                                        <!--[if mso]>' +
				'                                        </td>' +
				'                                        <![endif]-->' +
				'                                        <!--[if mso]>' +
				'                                        <td align="center" valign="top">' +
				'                                        <![endif]-->' +
				'                                            <table align="left" border="0" cellpadding="0" cellspacing="0" style="display: inline;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                <tbody><tr>' +
				'                                                    <td valign="top" style="padding-right: 0;padding-bottom: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnFollowContentItemContainer">' +
				'                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                            <tbody><tr>' +
				'                                                                <td align="left" valign="middle" style="padding-top: 5px;padding-right: 10px;padding-bottom: 5px;padding-left: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                    <table align="left" border="0" cellpadding="0" cellspacing="0" width="" style="border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                        <tbody><tr>' +
				'                                                                                <td align="center" valign="middle" width="24" class="mcnFollowIconContent" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                                                                                    <a href="mailto:support@rapid.io" target="_blank" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/color-forwardtofriend-48.png" style="display: block;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;" height="24" width="24" class=""></a>' +
				'                                                                                </td>' +
				'                                                                        </tr>' +
				'                                                                    </tbody></table>' +
				'                                                                </td>' +
				'                                                            </tr>' +
				'                                                        </tbody></table>' +
				'                                                    </td>' +
				'                                                </tr>' +
				'                                            </tbody></table>' +
				'                                        <!--[if mso]>' +
				'                                        </td>' +
				'                                        <![endif]-->' +
				'                                    <!--[if mso]>' +
				'                                    </tr>' +
				'                                    </table>' +
				'                                    <![endif]-->' +
				'                                </td>' +
				'                            </tr>' +
				'                        </tbody></table>' +
				'                    </td>' +
				'                </tr>' +
				'            </tbody></table>' +
				'        </td>' +
				'    </tr>' +
				'</tbody></table>' +
				'            </td>' +
				'        </tr>' +
				'    </tbody>' +
				'</table><table class="mcnDividerBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;table-layout: fixed !important;" border="0" cellpadding="0" cellspacing="0" width="100%">' +
				'    <tbody class="mcnDividerBlockOuter">' +
				'        <tr>' +
				'            <td class="mcnDividerBlockInner" style="min-width: 100%;padding: 10px 18px 25px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                <table class="mcnDividerContent" style="min-width: 100%;border-top: 2px solid #EEEEEE;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" border="0" cellpadding="0" cellspacing="0" width="100%">' +
				'                    <tbody><tr>' +
				'                        <td style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                            <span></span>' +
				'                        </td>' +
				'                    </tr>' +
				'                </tbody></table>' +
				'<!--' +
				'                <td class="mcnDividerBlockInner" style="padding: 18px;">' +
				'                <hr class="mcnDividerContent" style="border-bottom-color:none; border-left-color:none; border-right-color:none; border-bottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; margin-right:0; margin-bottom:0; margin-left:0;" />' +
				'-->' +
				'            </td>' +
				'        </tr>' +
				'    </tbody>' +
				'</table><table class="mcnTextBlock" style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" border="0" cellpadding="0" cellspacing="0" width="100%">' +
				'    <tbody class="mcnTextBlockOuter">' +
				'        <tr>' +
				'            <td class="mcnTextBlockInner" valign="top" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">' +
				'                <table style="min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;" class="mcnTextContentContainer" align="left" border="0" cellpadding="0" cellspacing="0" width="100%">' +
				'                    <tbody><tr>' +
				'                        <td class="mcnTextContent" style="padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #656565;font-family: Helvetica;font-size: 12px;line-height: 150%;text-align: center;" valign="top">' +
				'                            <em>Copyright &copy; 2016 RAPiD.io, All rights reserved.</em><br>' +
				' You are receiving this email because you signed up on RAPiD.io<br>' +
				'<br>' +
				'<strong>Our mailing address is:</strong><br>' +
				'<div class="vcard"><span class="org fn">RAPiD.io</span><div class="adr"><div class="street-address">475-A East Bay St.</div><span class="locality">Charleston</span>, <span class="region">SC</span>  <span class="postal-code">29403</span></div><br><a href="http://ossys.us11.list-manage.com/vcard?u=c18b0495c3c50b992c29d3b22&id=7fb77851fe" class="hcard-download">Add us to your address book</a></div>' +
				'<br>' +
				'<br>' +
				'Want to change how you receive these emails?<br>' +
				'You can <a href="' + process.env.HOST + '/dashboard/#/account" style="mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;color: #656565;font-weight: normal;text-decoration: underline;">update your preferences</a><br>' +
				'<br>' +
				'                        </td>' +
				'                    </tr>' +
				'                </tbody></table>' +
				'            </td>' +
				'        </tr>' +
				'    </tbody>' +
				'</table></td>' +
				'                            </tr>' +
				'                        </table>' +
				'      <!--[if gte mso 9]>' +
				'      </td>' +
				'      </tr>' +
				'      </table>' +
				'      <![endif]-->' +
				'                        <!-- // END TEMPLATE -->' +
				'                    </td>' +
				'                </tr>' +
				'            </table>' +
				'        </center>' +
				'    </body>' +
				'</html>'
			}, function(err, info){
				cb(err, info);
			});
		} else {
			cb(null, {message: 'E-Mail not sent, E-Mail transporter object null'});
		}
	}
};


EmailController.notify = function(user_id, message, cb) {
   var template = new EmailTemplate(path.join(templatesDir, 'notify'));
   var user = new User(user_id, null, function(err){
      if(!err) {
         var data = {
            email: user.getEmail(),
            name: user.getFullName(),
            message: message
         };

         template.render(data, function (err, results) {
           if (err) {
             return cb(console.error(err));
           }

           transporter.sendMail({
             from: 'CopyCat <support@copy-cat.io>',
             to: data.email,
             subject: 'Notification from CopyCat',
             html: results.html,
             text: results.text
           }, function (err, responseStatus) {
             if (err) {
               return cb(console.error(err));
             }
             console.log(responseStatus.message);
             return cb(null, responseStatus.message);
          });
        });
      } else {
         return cb(err, null);
      }
   });
};

module.exports = EmailController;
