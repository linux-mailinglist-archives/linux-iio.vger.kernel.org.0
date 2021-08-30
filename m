Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110A3FB784
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhH3OJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236803AbhH3OJM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:09:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E6B60F42;
        Mon, 30 Aug 2021 14:08:12 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:11:27 +0100
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
Subject: Re: [PATCH 29/40] mfd: ti_am335x_tscadc: Support the correctly
 spelled DT property
Message-ID: <20210830151127.3b314155@jic23-huawei>
In-Reply-To: <20210825152518.379386-30-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-30-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:07 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> There was in the past a typo in the coordinate readouts property. The
> bindings have been updated, the touchscreen driver as well and now
> supports both. However, the MFD driver that is in charge of verifying
> the validity of the property only checks the bogus one. Add support for
> the correctly spelled DT property.
> 
> Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Ouch.

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index f4f6b9db4d2a..0bd260edc9ad 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -143,7 +143,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (tscadc->data->has_tsc) {
>  		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>  		of_property_read_u32(node, "ti,wires", &tscmag_wires);
> -		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> +		err = of_property_read_u32(node, "ti,coordinate-readouts",
> +					   &readouts);
> +		if (err < 0) {
> +			err = of_property_read_u32(node, "ti,coordiante-readouts",
> +						   &readouts);

I'm going to guess this will trigger not used warnings for err.  

> +		}
> +
>  		if (tscmag_wires)
>  			use_tsc = true;
>  	} else {

