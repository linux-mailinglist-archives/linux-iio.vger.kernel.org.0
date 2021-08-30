Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6F3FB719
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhH3NlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhH3NlK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:41:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC8260E98;
        Mon, 30 Aug 2021 13:40:10 +0000 (UTC)
Date:   Mon, 30 Aug 2021 14:43:21 +0100
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
Subject: Re: [PATCH 13/40] mfd: ti_am335x_tscadc: Reword the comment
 explaining the dividers
Message-ID: <20210830144321.77b21d40@jic23-huawei>
In-Reply-To: <20210825152518.379386-14-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-14-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:51 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The comment misses the main information which is that we assume that a
> sample takes 15 ADC clock cycles to be generated. Let's take the
> occasion to rework a little bit this comment.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Fair enough. It does seem a little clearer to me after your rewording.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 0fef35e1e64b..3afe22680973 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -195,12 +195,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	/*
> -	 * The TSC_ADC_Subsystem has 2 clock domains
> -	 * OCP_CLK and ADC_CLK.
> -	 * The ADC clock is expected to run at target of 3MHz,
> -	 * and expected to capture 12-bit data at a rate of 200 KSPS.
> -	 * The TSC_ADC_SS controller design assumes the OCP clock is
> -	 * at least 6x faster than the ADC clock.
> +	 * The TSC_ADC_Subsystem has 2 clock domains: OCP_CLK and ADC_CLK.
> +	 * ADCs produce a 12-bit sample every 15 ADC_CLK cycles.
> +	 * am33xx ADCs expect to capture 200ksps.
> +	 * We need the ADC clocks to run at 3MHz.
> +	 * This frequency is valid since TSC_ADC_SS controller design
> +	 * assumes the OCP clock is at least 6x faster than the ADC clock.
>  	 */
>  	clk = devm_clk_get(&pdev->dev, "adc_tsc_fck");
>  	if (IS_ERR(clk)) {

