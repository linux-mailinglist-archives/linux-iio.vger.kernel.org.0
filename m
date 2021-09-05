Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB5400F7B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhIEMGz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:06:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC22360249;
        Sun,  5 Sep 2021 12:05:44 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:09:07 +0100
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
Subject: Re: [PATCH v2 16/46] mfd: ti_am335x_tscadc: Move the driver
 structure allocation earlier
Message-ID: <20210905130907.69565df5@jic23-huawei>
In-Reply-To: <20210902215144.507243-17-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-17-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:14 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Allocating the driver structure should be done earlier in the probe so
> that we can used its members from the beginning.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index fca58e78abb2..ea52d8523524 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -125,6 +125,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	int tsc_wires = 0, adc_channels = 0, total_channels;
>  	int readouts = 0;
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
> @@ -164,13 +171,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

