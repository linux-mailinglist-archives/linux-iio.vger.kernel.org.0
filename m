Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157D544F47B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhKMSSC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 13:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKMSSB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 13:18:01 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E116460F46;
        Sat, 13 Nov 2021 18:15:07 +0000 (UTC)
Date:   Sat, 13 Nov 2021 18:19:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maslov Dmitry <maslovdmitry@seeed.cc>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, north_sea@qq.com, baozhu.zuo@seeed.cc,
        jian.xiong@seeed.cc
Subject: Re: [PATCH v4] iio: light: ltr501: Added ltr303 driver support
Message-ID: <20211113181954.7b714942@jic23-huawei>
In-Reply-To: <20211106174137.6783-1-maslovdmitry@seeed.cc>
References: <20211106174137.6783-1-maslovdmitry@seeed.cc>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  6 Nov 2021 18:41:37 +0100
Maslov Dmitry <maslovdmitry@seeed.cc> wrote:

> Previously ltr501 driver supported a number of light and,
> proximity sensors including ltr501, ltr559 and ltr301.
> This adds support for another light sensor ltr303
> used in Seeed Studio reTerminal, a carrier board
> for Raspberry Pi 4 CM.
> 
> Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>

Applied to the togreg branch of iio.git and pushed out as testing to see if 0-day
can find anything we missed.   I'll rebase the tree after rc1 and soon after that
it should be visible in linux-next.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> It is a fix of previous commits, that simplified ltr303 support
> and removed a lot of unnecessary code. Filename has also been removed
> from the file.
> Additionally, in v3 of the patch, unused ltr_max was removed
> and description of the driver was changed to more general, i.e.
> "LTR501 and similar ambient light and proximity sensors."
> In v4 of the patch, ltr303 entry was removed from ACPI match table,
> since ACPI ID is not present in acpi id list.
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7e51aaac0bf..bab5b78f2e3 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
> + * Support for Lite-On LTR501 and similar ambient light and proximity sensors.
>   *
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -98,6 +98,7 @@ enum {
>  	ltr501 = 0,
>  	ltr559,
>  	ltr301,
> +	ltr303,
>  };
>  
>  struct ltr501_gain {
> @@ -1231,6 +1232,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>  		.channels = ltr301_channels,
>  		.no_channels = ARRAY_SIZE(ltr301_channels),
>  	},
> +	[ltr303] = {
> +		.partid = 0x0A,
> +		.als_gain = ltr559_als_gain_tbl,
> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +		.als_mode_active = BIT(0),
> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> +		.als_gain_shift = 2,
> +		.info = &ltr301_info,
> +		.info_no_irq = &ltr301_info_no_irq,
> +		.channels = ltr301_channels,
> +		.no_channels = ARRAY_SIZE(ltr301_channels),
> +	},
>  };
>  
>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1605,6 +1618,7 @@ static const struct i2c_device_id ltr501_id[] = {
>  	{ "ltr501", ltr501},
>  	{ "ltr559", ltr559},
>  	{ "ltr301", ltr301},
> +	{ "ltr303", ltr303},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> @@ -1613,6 +1627,7 @@ static const struct of_device_id ltr501_of_match[] = {
>  	{ .compatible = "liteon,ltr501", },
>  	{ .compatible = "liteon,ltr559", },
>  	{ .compatible = "liteon,ltr301", },
> +	{ .compatible = "liteon,ltr303", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ltr501_of_match);

