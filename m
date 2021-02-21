Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920FD320B82
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBUPmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 10:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhBUPmS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:42:18 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8196564DA8;
        Sun, 21 Feb 2021 15:41:35 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:41:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <20210221154132.037100ff@archlinux>
In-Reply-To: <20210216081356.3577-3-o.rempel@pengutronix.de>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
        <20210216081356.3577-3-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 09:13:56 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add simple IRQ or GPIO base event counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
> 
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
A FYI note inline.

Driver looks good to me.

Jonathan

> ---
>  MAINTAINERS                     |   7 +
>  drivers/counter/Kconfig         |  10 ++
>  drivers/counter/Makefile        |   1 +
>  drivers/counter/interrupt-cnt.c | 249 ++++++++++++++++++++++++++++++++
>  4 files changed, 267 insertions(+)
>  create mode 100644 drivers/counter/interrupt-cnt.c
> 
...

> +static int interrupt_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct interrupt_cnt_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->irq = platform_get_irq_optional(pdev,  0);
> +	if (priv->irq == -ENXIO)
> +		priv->irq = 0;
> +	else if (priv->irq < 0)
> +		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
> +
> +	priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(priv->gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get GPIO\n");
> +
> +	if (!priv->irq && !priv->gpio) {
> +		dev_err(dev, "IRQ and GPIO are not found. At least one source should be provided\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!priv->irq) {
> +		int irq = gpiod_to_irq(priv->gpio);
> +
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "failed to get IRQ from GPIO\n");
> +
> +		priv->irq = irq;
> +	}
> +
> +	priv->counter.priv = priv;
> +	priv->counter.name = dev_name(dev);
> +	priv->counter.parent = dev;
> +	priv->counter.ops = &interrupt_cnt_ops;
> +	priv->counter.counts = interrupt_cnts;
> +	priv->counter.num_counts = ARRAY_SIZE(interrupt_cnts);
> +	priv->counter.signals = interrupt_cnt_signals;
> +	priv->counter.num_signals = priv->gpio ?
> +				    ARRAY_SIZE(interrupt_cnt_signals) : 0;
> +
> +	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);

Just as a side note, there is a series that cleans up this case, though no
idea if it will make the merge window or not.

https://lore.kernel.org/linux-input/aefbe49321b845c98e505518314a93cc@hisilicon.com/

If it does we can tidy this up then.

> +	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> +			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +			       INTERRUPT_CNT_NAME, priv);
> +	if (ret)
> +		return ret;
> +
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
...
