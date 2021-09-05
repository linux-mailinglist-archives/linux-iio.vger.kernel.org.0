Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651D400F8D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhIEMQd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMQd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:16:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C678F606A5;
        Sun,  5 Sep 2021 12:15:23 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:18:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 21/46] mfd: ti_am335x_tscadc: Reorder the
 initialization steps
Message-ID: <20210905131847.03f5091b@jic23-huawei>
In-Reply-To: <20210902215144.507243-22-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-22-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:19 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> TI AM335X TRM [1] states that most of the configuration should be set in
> the control register in the first place, before actually enabling the
> hardware with the subsystem enable bit.
> 
> So far only half of the configuration was made in the first step (before
> enabling the "subsystem"), which does not make really sense. Also, the
> probe and the resume patch were acting differently. Let's harmonize all
> this by following these steps:
> 1/ Configure the CLKDIV register
> 2/ Configure the CTRL register
> 3/ Configure the idle configuration
> 4/ Really enable the device by rewriting the CTRL register with the
>    subsystem enable bit set.
> 
> [1] https://www.ti.com/lit/pdf/spruh73
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
This tidies up the other patches which is good. Now I haven't checked the new
order against the datasheet but it now does things as you describe so I'm assuming
that's fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 5f189da99468..61f878c7593b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -221,8 +221,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  
>  	/* Set the control register bits */
>  	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> -
>  	if (tsc_wires > 0) {
>  		tscadc->tsc_wires = tsc_wires;
>  		if (tsc_wires == 5)
> @@ -230,6 +228,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		else
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
>  	}
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  
>  	tscadc_idle_config(tscadc);
>  
> @@ -315,9 +314,9 @@ static int __maybe_unused tscadc_resume(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  
>  	/* context restore */
> -	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
> +	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
>  	if (tscadc->tsc_wires > 0) {
>  		if (tscadc->tsc_wires == 5)
>  			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> @@ -325,13 +324,13 @@ static int __maybe_unused tscadc_resume(struct device *dev)
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
>  	}
>  
> +	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> +
>  	tscadc_idle_config(tscadc);
>  
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  
> -	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> -
>  	return 0;
>  }
>  

