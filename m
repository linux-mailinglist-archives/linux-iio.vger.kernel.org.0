Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043E4400F83
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhIEMLA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMLA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:11:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30CD60E97;
        Sun,  5 Sep 2021 12:09:50 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:13:13 +0100
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
Subject: Re: [PATCH v2 20/46] mfd: ti_am335x_tscadc: Always provide an idle
 configuration
Message-ID: <20210905131313.76d04009@jic23-huawei>
In-Reply-To: <20210902215144.507243-21-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-21-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:18 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The idle register is valid no matter if the touchscreen is used or not,
> let's always configure it.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
With the earlier reorganization this now obviously only doing what you say.
Thanks for tidying that up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 4a24fc1141cf..5f189da99468 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -223,16 +223,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  
> -	/* Set register bits for Idle Config Mode */
>  	if (tsc_wires > 0) {
>  		tscadc->tsc_wires = tsc_wires;
>  		if (tsc_wires == 5)
>  			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
>  		else
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -		tscadc_idle_config(tscadc);
>  	}
>  
> +	tscadc_idle_config(tscadc);
> +
>  	/* Enable the TSC module enable bit */
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> @@ -323,8 +323,10 @@ static int __maybe_unused tscadc_resume(struct device *dev)
>  			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
>  		else
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -		tscadc_idle_config(tscadc);
>  	}
> +
> +	tscadc_idle_config(tscadc);
> +
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  

