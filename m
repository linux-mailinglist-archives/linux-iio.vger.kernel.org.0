Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5F3FB70C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhH3Nhl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhH3Nhk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:37:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C488606A5;
        Mon, 30 Aug 2021 13:36:40 +0000 (UTC)
Date:   Mon, 30 Aug 2021 14:39:52 +0100
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
Subject: Re: [PATCH 11/40] mfd: ti_am335x_tscadc: Get rid of useless gotos
Message-ID: <20210830143952.1c9c5db3@jic23-huawei>
In-Reply-To: <20210825152518.379386-12-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-12-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:49 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Gotos jumping to a return statement are not really useful, drop them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As a side note, I'm not seeing the expected calls to of_put_node() for
the child nodes.  So we are leaking some stuff on those calls.

Fixing that might make this patch no longer correct.

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index f0824732badf..8e86b766b619 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -169,7 +169,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	err = platform_get_irq(pdev, 0);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "no irq ID is specified.\n");
> -		goto ret;
> +		return err;
>  	} else {
>  		tscadc->irq = err;
>  	}
> @@ -185,8 +185,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  					       &tscadc_regmap_config);
>  	if (IS_ERR(tscadc->regmap)) {
>  		dev_err(&pdev->dev, "regmap init failed\n");
> -		err = PTR_ERR(tscadc->regmap);
> -		goto ret;
> +		return PTR_ERR(tscadc->regmap);
>  	}
>  
>  	spin_lock_init(&tscadc->reg_lock);
> @@ -270,7 +269,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  err_disable_clk:
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -ret:
> +
>  	return err;
>  }
>  

