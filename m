Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7D18BBF6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCSQLH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 12:11:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35273 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgCSQLG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 12:11:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so2991641wmi.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2020 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sWuJdiN77I0SRgdziu/ANQCfcDyI2dyQpD0oHzx05RE=;
        b=NRa2TH1KNI20HKrUdaB3mq5Pgdr1fkTVBjHkK/j6Qbqy8i//ZRT2cAze9k5sXg0Zvy
         eLOhkWXlswuuJ0k0yrX7QAekZqGfRoUNh2t3ivM7JMntHXaj+GSk6Wqh1f8mLrEJX2Rp
         8QBQkqWD4HnIkigqg+eHV3l87n8x29UMh95ytehJ/c+BJq2YaHf8LONa/5gcM325uWTk
         MRqJgDV6n+mZfEVeNmeq0nzd+QCfmn4C0rudw87mHF8HlL+lDqjdcQYIFsSixSU6DsMq
         3ouPozXhOEHsKRIBd6sbq6qV7bly3FFsohcvjPWp637TEUerlgV3/7R1l8pbZH3d/ZkE
         vVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sWuJdiN77I0SRgdziu/ANQCfcDyI2dyQpD0oHzx05RE=;
        b=AFVs500/7dY0KHgHBQMhrMemoKwN50NIAY1Rs0kCy99UR5nPAQazyeCofLYUnJ6Nzy
         xz3HeJEOickQYBuSz9kZQae7SWcJPWi4+4N90wWFcfCZSy4Kx7+aPzG2ObN9VOGUdZzz
         mZ9Jl0gThMN6h40BL0nQk9v23P8mTGhRrNY8cJyaj1030D9S7KH/VUnIkEQeQMn45Vf9
         9KivwBkIl/zPEXUrlYr/sxQLO2MrgXExbw5OD9prbvHrFhz8E0Xu/13aHmmHDOVESbiv
         vSV9D8Gj5OdUnAm1+GTlsvTj6XN338+FJ+XpNZi4ZfKhOv11BmKIjZxLyUGuS7aRxUuP
         asqQ==
X-Gm-Message-State: ANhLgQ0c20HTjqhT/83XPZO2hfyp7vpS1PwDngnATtpA6HeR7M3SuDi3
        K4bz5BK9VNtgEz6KZgfYU0ufzQ==
X-Google-Smtp-Source: ADFU+vtOE3VlyG9v+RM4DJhmHiqbPcL3RRCD1IQqEyTkro7G/tSGEAywOgeiEyqGnDiLbv1bZbTwsg==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr4309223wmh.143.1584634263756;
        Thu, 19 Mar 2020 09:11:03 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id l13sm4046033wrm.57.2020.03.19.09.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:11:03 -0700 (PDT)
Date:   Thu, 19 Mar 2020 16:11:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH RESEND v6 2/7] mfd: rn5t618: add IRQ support
Message-ID: <20200319161149.GB5477@dell>
References: <20200313064535.31503-1-andreas@kemnade.info>
 <20200313064535.31503-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200313064535.31503-3-andreas@kemnade.info>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020, Andreas Kemnade wrote:

> This adds support for IRQ handling in the RC5T619 which is required
> for properly implementing subdevices like RTC.
> For now only definitions for the variant RC5T619 are included.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v5:
> rn5t618_irq_init static
> 
> Changes in v4:
> merge rn5t618-irq.c into rn5t618.c
> use macros for IRQ table
> 
> Changes in v3:
> alignment cleanup
> 
> Changes in v2:
> - no dead code, did some more testing and thinking for that
> - remove extra empty lines
>  drivers/mfd/Kconfig         |  1 +
>  drivers/mfd/rn5t618.c       | 88 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rn5t618.h | 15 +++++++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2b203290e7b9..a7067888a41e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1058,6 +1058,7 @@ config MFD_RN5T618
>  	depends on OF
>  	select MFD_CORE
>  	select REGMAP_I2C
> +	select REGMAP_IRQ
>  	help
>  	  Say yes here to add support for the Ricoh RN5T567,
>  	  RN5T618, RC5T619 PMIC.
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index ead2e79036a9..849a33d64860 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/rn5t618.h>
>  #include <linux/module.h>
> @@ -46,9 +48,63 @@ static const struct regmap_config rn5t618_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static const struct regmap_irq rc5t619_irqs[] = {
> +	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_RTC, 0, BIT(2)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_ADC, 0, BIT(3)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_GPIO, 0, BIT(4)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_CHG, 0, BIT(6)),
> +};
> +
> +static const struct regmap_irq_chip rc5t619_irq_chip = {
> +	.name = "rc5t619",
> +	.irqs = rc5t619_irqs,
> +	.num_irqs = ARRAY_SIZE(rc5t619_irqs),
> +	.num_regs = 1,
> +	.status_base = RN5T618_INTMON,
> +	.mask_base = RN5T618_INTEN,
> +	.mask_invert = true,
> +};
> +
>  static struct rn5t618 *rn5t618_pm_power_off;
>  static struct notifier_block rn5t618_restart_handler;
>  
> +static int rn5t618_irq_init(struct rn5t618 *rn5t618)
> +{
> +	const struct regmap_irq_chip *irq_chip;
> +	int ret;
> +
> +	if (!rn5t618->irq)
> +		return 0;
> +
> +	switch (rn5t618->variant) {
> +	case RC5T619:
> +		irq_chip = &rc5t619_irq_chip;
> +		break;
> +	default:
> +		irq_chip = NULL;

If you initialised this at the top, you can rid this line.

Don't you want to put a message in here about an unsupported device?

> +		break;
> +	}
> +
> +	if (!irq_chip) {
> +		dev_err(rn5t618->dev, "Currently no IRQ support for variant %d\n",
> +			(int)rn5t618->variant);
> +		return -ENOENT;
> +	}

Ah yes.  Put this in 'default' instead.

> +	ret = devm_regmap_add_irq_chip(rn5t618->dev, rn5t618->regmap,
> +				       rn5t618->irq,
> +				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				       0, irq_chip, &rn5t618->irq_data);
> +	if (ret) {
> +		dev_err(rn5t618->dev, "Failed to register IRQ chip\n");
> +		return ret;

Make this a one line if.

> +	}
> +
> +	return 0;

... and return ret.

> +}
> +
>  static void rn5t618_trigger_poweroff_sequence(bool repower)
>  {
>  	/* disable automatic repower-on */
> @@ -106,6 +162,8 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>  
>  	i2c_set_clientdata(i2c, priv);
>  	priv->variant = (long)of_id->data;
> +	priv->irq = i2c->irq;
> +	priv->dev = &i2c->dev;
>  
>  	priv->regmap = devm_regmap_init_i2c(i2c, &rn5t618_regmap_config);
>  	if (IS_ERR(priv->regmap)) {
> @@ -138,6 +196,11 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	if (priv->irq > 0) {

There are already have checks in rn5t618_irq_init().

Just call it regardless.

> +		if (rn5t618_irq_init(priv))

If this returns an error, you should return that error from .probe().

> +			priv->irq = 0;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -155,15 +218,40 @@ static int rn5t618_i2c_remove(struct i2c_client *i2c)
>  	return 0;
>  }
>  
> +static int __maybe_unused rn5t618_i2c_suspend(struct device *dev)
> +{
> +	struct rn5t618 *priv = dev_get_drvdata(dev);
> +
> +	if (priv->irq)
> +		disable_irq(priv->irq);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
> +{
> +	struct rn5t618 *priv = dev_get_drvdata(dev);
> +
> +	if (priv->irq)
> +		enable_irq(priv->irq);
> +
> +	return 0;
> +}
> +
>  static const struct i2c_device_id rn5t618_i2c_id[] = {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
>  
> +static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
> +			rn5t618_i2c_suspend,
> +			rn5t618_i2c_resume);
> +
>  static struct i2c_driver rn5t618_i2c_driver = {
>  	.driver = {
>  		.name = "rn5t618",
>  		.of_match_table = of_match_ptr(rn5t618_of_match),
> +		.pm = &rn5t618_i2c_dev_pm_ops,
>  	},
>  	.probe = rn5t618_i2c_probe,
>  	.remove = rn5t618_i2c_remove,
> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
> index d62ef48060b5..739571656f2b 100644
> --- a/include/linux/mfd/rn5t618.h
> +++ b/include/linux/mfd/rn5t618.h
> @@ -242,9 +242,24 @@ enum {
>  	RC5T619,
>  };
>  
> +/* RN5T618 IRQ definitions */
> +enum {
> +	RN5T618_IRQ_SYS = 0,
> +	RN5T618_IRQ_DCDC,
> +	RN5T618_IRQ_RTC,
> +	RN5T618_IRQ_ADC,
> +	RN5T618_IRQ_GPIO,
> +	RN5T618_IRQ_CHG,
> +	RN5T618_NR_IRQS,
> +};
> +
>  struct rn5t618 {
>  	struct regmap *regmap;
> +	struct device *dev;
>  	long variant;
> +
> +	int irq;
> +	struct regmap_irq_chip_data *irq_data;
>  };
>  
>  #endif /* __LINUX_MFD_RN5T618_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
