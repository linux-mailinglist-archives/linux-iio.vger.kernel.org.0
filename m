Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC43FB72A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhH3Nph (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhH3Npg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:45:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45988604D7;
        Mon, 30 Aug 2021 13:44:36 +0000 (UTC)
Date:   Mon, 30 Aug 2021 14:47:47 +0100
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
Subject: Re: [PATCH 15/40] mfd: ti_am335x_tscadc: Simplify divisor
 calculation
Message-ID: <20210830144747.4ec5d23f@jic23-huawei>
In-Reply-To: <20210825152518.379386-16-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-16-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:53 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Let's rewrite this on a single line, it does not hurt the readability
> and saves a useless temporary variable.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index d27f8917272d..3231ccbbad02 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	u32 val;
>  	int tsc_wires = 0, adc_channels = 0, readouts = 0;
> -	int total_channels, clock_rate, ctrl, err;
> +	int total_channels, ctrl, err;
>  
>  	/* Allocate memory for device */
>  	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> @@ -208,11 +208,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		err = PTR_ERR(clk);
>  		goto err_disable_clk;
>  	}
> -	clock_rate = clk_get_rate(clk);
> -	tscadc->clk_div = clock_rate / ADC_CLK;
>  
> -	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
> -	tscadc->clk_div--;
> +	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
>  	/* Set the control register bits */

