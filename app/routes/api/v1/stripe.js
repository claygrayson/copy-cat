var express = require('express');
var router = express.Router();

module.exports = function() {


/**
 *	/api/v1/stripe
 */
router.route('/')
	.post(function (req, resp, next) {
		var event = req.body;

		// Parse Event Type: https://stripe.com/docs/api#event_types
		switch(event.type) {
			case 'account.updated':
				break;
			case 'account.application.deauthorized':
				break;
			case 'account.external_account.created':
				break;
			case 'account.external_account.deleted':
				break;
			case 'account.external_account.updated':
				break;
			case 'application_fee.created':
				break;
			case 'application_fee.refunded':
				break;
			case 'application_fee.refund.updated':
				break;
			case 'balance.available':
				break;
			case 'bitcoin.receiver.created':
				break;
			case 'bitcoin.receiver.filled':
				break;
			case 'bitcoin.receiver.updated':
				break;
			case 'bitcoin.receiver.transaction.created':
				break;
			case 'charge.captured':
				break;
			case 'charge.failed':
				break;
			case 'charge.refunded':
				break;
			case 'charge.succeeded':
				break;
			case 'charge.updated':
				break;
			case 'charge.dispute.closed':
				break;
			case 'charge.dispute.created':
				break;
			case 'charge.dispute.funds_reinstated':
				break;
			case 'charge.dispute.funds_withdrawn':
				break;
			case 'charge.dispute.updated':
				break;
			case 'coupon.created':
				break;
			case 'coupon.deleted':
				break;
			case 'coupon.updated':
				break;
			case 'customer.created':
				break;
			case 'customer.deleted':
				break;
			case 'customer.updated':
				break;
			case 'customer.discount.created':
				break;
			case 'customer.discount.deleted':
				break;
			case 'customer.discount.updated':
				break;
			case 'customer.source.created':
				break;
			case 'customer.source.deleted':
				break;
			case 'customer.source.updated':
				break;
			case 'customer.subscription.created':
				break;
			case 'customer.subscription.deleted':
				break;
			case 'customer.subscription.trial_will_end':
				break;
			case 'customer.subscription.updated':
				break;
			case 'invoice.created':
				break;
			case 'invoice.payment_failed':
				break;
			case 'invoice.payment_succeeded':
				break;
			case 'invoice.updated':
				break;
			case 'invoiceitem.created':
				break;
			case 'invoiceitem.deleted':
				break;
			case 'invoiceitem.updated':
				break;
			case 'order.created':
				break;
			case 'order.payment_failed':
				break;
			case 'order.payment_succeeded':
				break;
			case 'order.updated':
				break;
			case 'plan.created':
				break;
			case 'plan.deleted':
				break;
			case 'plan.updated':
				break;
			case 'product.created':
				break;
			case 'product.updated':
				break;
			case 'recipient.created':
				break;
			case 'recipient.deleted':
				break;
			case 'recipient.updated':
				break;
			case 'sku.created':
				break;
			case 'sku.updated':
				break;
			case 'transfer.created':
				break;
			case 'transfer.failed':
				break;
			case 'transfer.paid':
				break;
			case 'transfer.reversed':
				break;
			case 'transfer.updated':
				break;
			case 'ping':
				break;
			default:
				break;
		}

		resp.json({success:true, msg:'Successfully Received Stripe WebHook Event: ' + event.type});
	});

	return router;
}
