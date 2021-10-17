Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC9430849
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhJQLSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237065AbhJQLSl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:18:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8484360F46;
        Sun, 17 Oct 2021 11:16:30 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:20:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
Message-ID: <20211017122043.731858d3@jic23-huawei>
In-Reply-To: <20211017013343.3385923-4-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-4-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:38 -0500
David Lechner <david@lechnology.com> wrote:

> This adds support to the TI eQEP counter driver for the Unit Timer.
> The Unit Timer is a device-level extension that provides a timer to be
> used for speed calculations. The sysfs interface for the Unit Timer is
> new and will be documented in a later commit. It contains a R/W time
> attribute for the current time, a R/W period attribute for the timeout
> period and a R/W enable attribute to start/stop the timer. It also
> implements a timeout event on the chrdev interface that is triggered
> each time the period timeout is reached.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

No comments on the interface in here as leaving that for William / later.

A few minor comments on the implementation.

Thanks,

Jonathan

> ---
>  drivers/counter/ti-eqep.c    | 132 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/counter.h |   2 +
>  2 files changed, 133 insertions(+), 1 deletion(-)

...

> +static int ti_eqep_unit_timer_time_write(struct counter_device *counter,
> +					u64 value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qutmr;
> +
> +	/* convert nanoseconds to timer ticks */
> +	qutmr = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);

Hmm. This pattern strikes me as 'too clever' and also likely to trip up static
checkers who will moan about the truncation if they don't understand this trick.

I think I'd prefer you just put the answer in an u64 and then do a simple bounds
check before casting down.

> +	if (qutmr != value)
> +		return -ERANGE;
> +
> +	regmap_write(priv->regmap32, QUTMR, qutmr);
> +
> +	return 0;
> +}
> +

...

>  static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
>  {
>  	struct ti_eqep_cnt *priv = dev_id;
> @@ -474,6 +580,8 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
>  	if (qflg & QFLG_QDC)
>  		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
>  
> +	if (qflg & QFLG_UTO)
> +		counter_push_event(counter, COUNTER_EVENT_TIMEOUT, 0);
>  
>  	regmap_set_bits(priv->regmap16, QCLR, ~0);
>  
> @@ -500,6 +608,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ti_eqep_cnt *priv;
> +	struct clk *clk;
>  	void __iomem *base;
>  	int err;
>  	int irq;
> @@ -508,6 +617,24 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	clk = devm_clk_get(dev, "sysclkout");
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get sysclkout");

dev_err_probe() which both removes most of this boilerplate
and stashes the reason for the deferred probe such that it can be checked when
debugging.

> +		return PTR_ERR(clk);
> +	}

No need to enable the clock?

> +
> +	priv->sysclkout_rate = clk_get_rate(clk);
> +	if (priv->sysclkout_rate == 0) {
> +		dev_err(dev, "failed to get sysclkout rate");
> +		/* prevent divide by zero */
> +		priv->sysclkout_rate = 1;
> +		/*
> +		 * This error is not expected and the driver is mostly usable
> +		 * without clock rate anyway, so don't exit here.
> +		 */
> +	}
> +
>  
>  /**

