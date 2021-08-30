Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B172E3FB777
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhH3OBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhH3OBG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:01:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8895860ED4;
        Mon, 30 Aug 2021 14:00:06 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:03:17 +0100
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
Subject: Re: [PATCH 27/40] mfd: ti_am335x_tscadc: Move control register
 configuration
Message-ID: <20210830150317.18330c09@jic23-huawei>
In-Reply-To: <20210825152518.379386-28-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-28-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:05 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The datasheet states that most of the configuration should be set in the
> control register in the first place, before actually enabling the
> hardware.

Reference always good. 

> So far only half of the configuration was made in the first
> step, which does not make really sense and would complicating the code
> when introducing support for the am437x hardware.
> 
> Let's move that register write a bit below to enclose more configuration.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Looks fine to me otherwise.

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index a40091830cea..1a30610dc65f 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -224,7 +224,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	tscadc->ctrl = CNTRLREG_STEPID;
>  	if (tscadc->data->has_tsc) {
>  		tscadc->ctrl |= CNTRLREG_TSC_STEPCONFIGWRT;
> -		regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  		if (use_tsc) {
>  			tscadc->ctrl |= CNTRLREG_TSC_ENB;
>  			if (tscmag_wires == 5)
> @@ -235,6 +234,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  
>  	}
>  
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> +
>  	tscadc_idle_config(tscadc);
>  
>  	/* Enable the TSC module enable bit */

