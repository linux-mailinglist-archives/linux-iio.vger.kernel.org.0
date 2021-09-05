Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26043400FED
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhIENWG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 09:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231754AbhIENWF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:22:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB8E60F45;
        Sun,  5 Sep 2021 13:20:55 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:24:19 +0100
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
Subject: Re: [PATCH v2 35/46] mfd: ti_am335x_tscadc: Support the correctly
 spelled DT property
Message-ID: <20210905142419.67b7f48f@jic23-huawei>
In-Reply-To: <20210902215144.507243-36-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-36-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:33 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> There was in the past a typo in the coordinate readouts property. The
> bindings have been updated, the touchscreen driver as well and now
> supports both. However, the MFD driver that is in charge of verifying
> the validity of the property only checks the bogus one. Add support for
> the correctly spelled DT property.
> 
> Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Looks good now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index a3347f9fc388..4c2fe9910400 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -144,8 +144,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (tscadc->data->has_tsc) {
>  		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>  		of_property_read_u32(node, "ti,wires", &tscmag_wires);
> -		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> +		err = of_property_read_u32(node, "ti,coordinate-readouts",
> +					   &readouts);
> +		if (err < 0)
> +			of_property_read_u32(node, "ti,coordiante-readouts",
> +					     &readouts);
> +
>  		of_node_put(node);
> +
>  		if (tscmag_wires)
>  			use_tsc = true;
>  	} else {

