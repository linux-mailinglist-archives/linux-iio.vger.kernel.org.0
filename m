Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A123FB656
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhH3MrK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhH3MrK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:47:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E959C6054F;
        Mon, 30 Aug 2021 12:46:10 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:49:21 +0100
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
Subject: Re: [PATCH 09/40] mfd: ti_am335x_tscadc: Fix style
Message-ID: <20210830134921.7886a982@jic23-huawei>
In-Reply-To: <20210825152518.379386-10-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-10-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:47 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> These are mostly deffects reported by checkpatch.pl.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

look sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 45262ca7734a..540c6dcef541 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -140,15 +140,17 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		adc_channels++;
>  		if (val > 7) {
>  			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
> -					val);
> +				val);
>  			return -EINVAL;
>  		}
>  	}
> +
>  	total_channels = tsc_wires + adc_channels;
>  	if (total_channels > 8) {
>  		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
>  		return -EINVAL;
>  	}
> +
>  	if (total_channels == 0) {
>  		dev_err(&pdev->dev, "Need atleast one channel.\n");
>  		return -EINVAL;
> @@ -170,8 +172,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "no irq ID is specified.\n");
>  		goto ret;
> -	} else
> +	} else {
>  		tscadc->irq = err;
> +	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
> @@ -180,7 +183,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  
>  	tscadc->tscadc_phys_base = res->start;
>  	tscadc->regmap = devm_regmap_init_mmio(&pdev->dev,
> -			tscadc->tscadc_base, &tscadc_regmap_config);
> +					       tscadc->tscadc_base,
> +					       &tscadc_regmap_config);
>  	if (IS_ERR(tscadc->regmap)) {
>  		dev_err(&pdev->dev, "regmap init failed\n");
>  		err = PTR_ERR(tscadc->regmap);

