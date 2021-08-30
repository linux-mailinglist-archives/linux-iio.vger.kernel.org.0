Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD03FB875
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhH3OrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhH3OrN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:47:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A91B660249;
        Mon, 30 Aug 2021 14:46:14 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:49:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 19/40] mfd: ti_am335x_tscadc: Always provide an idle
 configuration
Message-ID: <20210830154925.4fa89e44@jic23-huawei>
In-Reply-To: <20210825152518.379386-20-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-20-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:57 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The idle register is valid no matter if the touchscreen is used or not,
> let's always configure it.
Probably want a statement in here about the reordering that occurred in resume.

J

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 258199be4c6a..7071344ad18e 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -218,16 +218,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
> @@ -318,12 +318,12 @@ static int __maybe_unused tscadc_resume(struct device *dev)
>  			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
>  		else
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -		tscadc_idle_config(tscadc);
>  	}
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> +	tscadc_idle_config(tscadc);
>  
>  	return 0;
>  }

