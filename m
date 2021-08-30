Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6813FB7F7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhH3OW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237173AbhH3OWz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:22:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC2260F25;
        Mon, 30 Aug 2021 14:21:55 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:25:06 +0100
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
Subject: Re: [PATCH 12/40] mfd: ti_am335x_tscadc: Move the driver structure
 allocation earlier
Message-ID: <20210830152506.6215c0e8@jic23-huawei>
In-Reply-To: <20210825152518.379386-13-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-13-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:50 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Allocating the driver structure should be done earlier in the probe so
> that we can used its members from the beginning.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
No problem with this, but I would expect either this patch or the one
immediately after it to actually take advantage of this being
available earlier in probe().
As things stand it's not clear to a reviewer that this is actually
a useful bit of refactoring.

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 8e86b766b619..0fef35e1e64b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -124,6 +124,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	int tsc_wires = 0, adc_channels = 0, readouts = 0;
>  	int total_channels, clock_rate, ctrl, err;
>  
> +	/* Allocate memory for device */
> +	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> +	if (!tscadc)
> +		return -ENOMEM;
> +
> +	tscadc->dev = &pdev->dev;
> +
>  	if (!pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
>  		return -EINVAL;
> @@ -159,13 +166,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Allocate memory for device */
> -	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> -	if (!tscadc)
> -		return -ENOMEM;
> -
> -	tscadc->dev = &pdev->dev;
> -
>  	err = platform_get_irq(pdev, 0);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "no irq ID is specified.\n");

