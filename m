Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F3430834
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhJQLIB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235960AbhJQLIB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:08:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ECD61244;
        Sun, 17 Oct 2021 11:05:50 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:10:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] counter/ti-eqep: implement over/underflow events
Message-ID: <20211017121004.3933b636@jic23-huawei>
In-Reply-To: <20211017013343.3385923-2-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-2-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:36 -0500
David Lechner <david@lechnology.com> wrote:

> This adds support to the TI eQEP counter driver for subscribing to
> overflow and underflow events using the counter chrdev interface.
> 
> Since this is the first event added, this involved adding an irq
> handler. Also, additional range checks had to be added to the ceiling
> attribute to avoid infinite interrupts.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Hi David,

A few minor things inline. I've not commented on the new counter interface
stuff though as it's still a bit vague in my head, so over to William for that :)

Jonathan

> ---
>  drivers/counter/ti-eqep.c | 119 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 09817c953f9a..b7c79435e127 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/counter.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -67,6 +68,44 @@
>  #define QEPCTL_UTE		BIT(1)
>  #define QEPCTL_WDE		BIT(0)
>  
> +#define QEINT_UTO		BIT(11)
> +#define QEINT_IEL		BIT(10)
> +#define QEINT_SEL		BIT(9)
> +#define QEINT_PCM		BIT(8)
> +#define QEINT_PCR		BIT(7)
> +#define QEINT_PCO		BIT(6)
> +#define QEINT_PCU		BIT(5)
> +#define QEINT_WTO		BIT(4)
> +#define QEINT_QDC		BIT(3)
> +#define QEINT_PHE		BIT(2)
> +#define QEINT_PCE		BIT(1)
> +
> +#define QFLG_UTO		BIT(11)
> +#define QFLG_IEL		BIT(10)
> +#define QFLG_SEL		BIT(9)
> +#define QFLG_PCM		BIT(8)
> +#define QFLG_PCR		BIT(7)
> +#define QFLG_PCO		BIT(6)
> +#define QFLG_PCU		BIT(5)
> +#define QFLG_WTO		BIT(4)
> +#define QFLG_QDC		BIT(3)
> +#define QFLG_PHE		BIT(2)
> +#define QFLG_PCE		BIT(1)
> +#define QFLG_INT		BIT(0)
> +
> +#define QCLR_UTO		BIT(11)
> +#define QCLR_IEL		BIT(10)
> +#define QCLR_SEL		BIT(9)
> +#define QCLR_PCM		BIT(8)
> +#define QCLR_PCR		BIT(7)
> +#define QCLR_PCO		BIT(6)
> +#define QCLR_PCU		BIT(5)
> +#define QCLR_WTO		BIT(4)
> +#define QCLR_QDC		BIT(3)
> +#define QCLR_PHE		BIT(2)
> +#define QCLR_PCE		BIT(1)
> +#define QCLR_INT		BIT(0)
> +
>  /* EQEP Inputs */
>  enum {
>  	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> @@ -233,12 +272,46 @@ static int ti_eqep_action_read(struct counter_device *counter,
>  	}
>  }
>  
> +static int ti_eqep_events_configure(struct counter_device *counter)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	struct counter_event_node *event_node;
> +	u32 qeint = 0;
> +
> +	list_for_each_entry(event_node, &counter->events_list, l) {
> +		switch (event_node->event) {
> +		case COUNTER_EVENT_OVERFLOW:
> +			qeint |= QEINT_PCO;
> +			break;
> +		case COUNTER_EVENT_UNDERFLOW:
> +			qeint |= QEINT_PCU;
> +			break;
> +		}
> +	}
> +
> +	return regmap_write_bits(priv->regmap16, QEINT, ~0, qeint);

regmap_write() given mask is all bits.


> +}
> +
> +static int ti_eqep_watch_validate(struct counter_device *counter,
> +				  const struct counter_watch *watch)
> +{
> +	switch (watch->event) {
> +	case COUNTER_EVENT_OVERFLOW:
> +	case COUNTER_EVENT_UNDERFLOW:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct counter_ops ti_eqep_counter_ops = {
>  	.count_read	= ti_eqep_count_read,
>  	.count_write	= ti_eqep_count_write,
>  	.function_read	= ti_eqep_function_read,
>  	.function_write	= ti_eqep_function_write,
>  	.action_read	= ti_eqep_action_read,
> +	.events_configure = ti_eqep_events_configure,
> +	.watch_validate	= ti_eqep_watch_validate,
>  };
>  
>  static int ti_eqep_position_ceiling_read(struct counter_device *counter,
> @@ -260,11 +333,17 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
>  					  u64 ceiling)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qposmax = ceiling;
>  
> -	if (ceiling != (u32)ceiling)
> +	/* ensure that value fits in 32-bit register */
> +	if (qposmax != ceiling)
>  		return -ERANGE;
>  
> -	regmap_write(priv->regmap32, QPOSMAX, ceiling);
> +	/* protect against infinite overflow interrupts */
> +	if (qposmax == 0)
> +		return -EINVAL;
> +
> +	regmap_write(priv->regmap32, QPOSMAX, qposmax);
>  
>  	return 0;
>  }
> @@ -349,6 +428,25 @@ static struct counter_count ti_eqep_counts[] = {
>  	},
>  };
>  
> +static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
> +{
> +	struct ti_eqep_cnt *priv = dev_id;
> +	struct counter_device *counter = &priv->counter;
> +	u32 qflg;
> +
> +	regmap_read(priv->regmap16, QFLG, &qflg);
> +
> +	if (qflg & QFLG_PCO)
> +		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
> +
> +	if (qflg & QFLG_PCU)
> +		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
> +
> +	regmap_set_bits(priv->regmap16, QCLR, ~0);
Generally avoid clearing bits reflecting interrupt events you haven't handled.
I'm guessing there is a potential race in here where we read qflg and additional
events then occur before we clear.  Those events we never see because they
are unconditionally cleared by this write.

We are better off interrupting again if that race happens.

> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct regmap_config ti_eqep_regmap32_config = {
>  	.name = "32-bit",
>  	.reg_bits = 32,
> @@ -371,6 +469,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	struct ti_eqep_cnt *priv;
>  	void __iomem *base;
>  	int err;
> +	int irq;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -390,6 +489,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap16))
>  		return PTR_ERR(priv->regmap16);
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	err = devm_request_threaded_irq(dev, irq, NULL, ti_eqep_irq_handler,
> +					IRQF_ONESHOT, dev_name(dev), priv);
> +	if (err < 0)
> +		return err;
> +
>  	priv->counter.name = dev_name(dev);
>  	priv->counter.parent = dev;
>  	priv->counter.ops = &ti_eqep_counter_ops;
> @@ -409,6 +517,13 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> +	/*
> +	 * We can end up with an interupt infinite loop (interrupts triggered
> +	 * as soon as they are cleared) if we leave this at the default value
> +	 * of 0 and events are enabled.
> +	 */
> +	regmap_write(priv->regmap32, QPOSMAX, UINT_MAX);
> +
>  	err = counter_register(&priv->counter);
>  	if (err < 0) {
>  		pm_runtime_put_sync(dev);

