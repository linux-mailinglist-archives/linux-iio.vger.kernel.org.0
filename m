Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE59A3FB661
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhH3MuC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236684AbhH3MuB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:50:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AF260524;
        Mon, 30 Aug 2021 12:49:02 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:52:13 +0100
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
Subject: Re: [PATCH 10/40] mfd: ti_am335x_tscadc: Drop extra spacing when
 declaring stack variables
Message-ID: <20210830135213.3eeb93f8@jic23-huawei>
In-Reply-To: <20210825152518.379386-11-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-11-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:48 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Many variables will be updated (renamed, dropped, added) in the upcoming
> changes, so let's simplify the style to avoid messing with spaces over
> and over again.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
I agree with dropping the spaces, but not so much with reordering the elements.
Whilst it obviously doesn't make any difference to padding etc, it does
require more thought that I'd want to expend reviewing a patch like this
to establish whether there was a semantic meaning to the original order that
we are disrupting.

Jonathan


> ---
>  drivers/mfd/ti_am335x_tscadc.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 540c6dcef541..f0824732badf 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -113,18 +113,16 @@ static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
>  
>  static	int ti_tscadc_probe(struct platform_device *pdev)
>  {
> -	struct ti_tscadc_dev	*tscadc;
> -	struct resource		*res;
> -	struct clk		*clk;
> -	struct device_node	*node;
> -	struct mfd_cell		*cell;
> -	struct property         *prop;
> -	const __be32            *cur;
> -	u32			val;
> -	int			err, ctrl;
> -	int			clock_rate;
> -	int			tsc_wires = 0, adc_channels = 0, total_channels;
> -	int			readouts = 0;
> +	struct ti_tscadc_dev *tscadc;
> +	struct device_node *node;
> +	struct property *prop;
> +	struct mfd_cell *cell;
> +	struct resource *res;
> +	const __be32 *cur;
> +	struct clk *clk;
> +	u32 val;
> +	int tsc_wires = 0, adc_channels = 0, readouts = 0;
> +	int total_channels, clock_rate, ctrl, err;
>  
>  	if (!pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
> @@ -278,7 +276,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  
>  static int ti_tscadc_remove(struct platform_device *pdev)
>  {
> -	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
> +	struct ti_tscadc_dev *tscadc = platform_get_drvdata(pdev);
>  
>  	regmap_write(tscadc->regmap, REG_SE, 0x00);
>  
> @@ -297,7 +295,7 @@ static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
>  
>  static int __maybe_unused tscadc_suspend(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
> +	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
>  
>  	regmap_write(tscadc->regmap, REG_SE, 0x00);
>  	if (device_for_each_child(dev, NULL, ti_tscadc_can_wakeup)) {
> @@ -315,7 +313,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
>  
>  static int __maybe_unused tscadc_resume(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
> +	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
>  	u32 ctrl;
>  
>  	pm_runtime_get_sync(dev);

