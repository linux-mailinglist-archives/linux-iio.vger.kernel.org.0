Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F33FB769
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhH3N5s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236846AbhH3N5r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:57:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3311D604D7;
        Mon, 30 Aug 2021 13:56:47 +0000 (UTC)
Date:   Mon, 30 Aug 2021 14:59:59 +0100
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
Subject: Re: [PATCH 25/40] mfd: ti_am335x_tscadc: Add a boolean to clarify
 the presence of a touchscreen
Message-ID: <20210830145959.03bed30a@jic23-huawei>
In-Reply-To: <20210825152518.379386-26-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-26-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:03 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Just checking the number of wires will soon not be enough, add a boolean
> to indicated the actual use or not of the touchscreen.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 2f934fd2154a..30f53cdb41f8 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -121,6 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	const __be32 *cur;
>  	struct clk *clk;
>  	u32 val;
> +	bool use_tsc = false;
>  	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
>  	int total_channels, err;
>  
> @@ -141,6 +142,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>  	of_property_read_u32(node, "ti,wires", &tscmag_wires);
>  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> +	if (tscmag_wires)
> +		use_tsc = true;
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
>  	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
> @@ -163,7 +166,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	if (readouts * 2 + 2 + adc_channels > 16) {
> +	if (use_tsc && (readouts * 2 + 2 + adc_channels > 16)) {

This one is adding a check that wasn't there before.  The description should
mention why it will now be necessary and isn't a bug...

>  		dev_err(&pdev->dev, "Too many step configurations requested\n");
>  		return -EINVAL;
>  	}
> @@ -218,7 +221,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  
> -	if (tscmag_wires > 0) {
> +	if (use_tsc) {
>  		tscadc->ctrl |= CNTRLREG_TSC_ENB;
>  		if (tscmag_wires == 5)
>  			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;

