Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C729E43E2BA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhJ1N5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhJ1N5B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:57:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F396960527;
        Thu, 28 Oct 2021 13:54:32 +0000 (UTC)
Date:   Thu, 28 Oct 2021 14:58:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maslov Dmitry <maslovdmitry@seeed.cc>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, north_sea@qq.com, baozhu.zuo@seeed.cc,
        jian.xiong@seeed.cc
Subject: Re: [PATCH] iio: light: ltr501: Added ltr303 driver support
Message-ID: <20211028145859.3ea79669@jic23-huawei>
In-Reply-To: <20211025213023.7309-1-maslovdmitry@seeed.cc>
References: <20211025213023.7309-1-maslovdmitry@seeed.cc>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Oct 2021 23:30:23 +0200
Maslov Dmitry <maslovdmitry@seeed.cc> wrote:

> Previously ltr501 driver supported a number of light and,
> proximity sensors including ltr501, ltr559 and ltr301.
> This adds support for another light sensor ltr303
> used in Seeed Studio reTerminal, a carrier board
> for Raspberry Pi 4 CM.
> 
> It is a fix of previous commit, that simplified ltr303 support
> and removed a lot of unnecessary code. Filename has also been removed
> from the file.
> 
> Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>

I missed that email should have had the subject

[PATCH v2] iio: light: ltr501: Add ltr303 support

> ---
>  drivers/iio/light/ltr501.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7e51aaac0bf..d92d324d5e3 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
> + * Support for Lite-On LTR501, LTR509, LTR301, LTR303 ambient light
> + * and proximity sensors (only LTR5xx)
>   *
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -98,6 +99,9 @@ enum {
>  	ltr501 = 0,
>  	ltr559,
>  	ltr301,
> +	ltr303,
> +
> +	ltr_max
>  };
>  
>  struct ltr501_gain {
> @@ -1231,6 +1235,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
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
> @@ -1597,6 +1613,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
>  	{"LTER0501", ltr501},
>  	{"LTER0559", ltr559},
>  	{"LTER0301", ltr301},
> +	{"LTER0303", ltr303},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
> @@ -1605,6 +1622,7 @@ static const struct i2c_device_id ltr501_id[] = {
>  	{ "ltr501", ltr501},
>  	{ "ltr559", ltr559},
>  	{ "ltr301", ltr301},
> +	{ "ltr303", ltr303},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> @@ -1613,6 +1631,7 @@ static const struct of_device_id ltr501_of_match[] = {
>  	{ .compatible = "liteon,ltr501", },
>  	{ .compatible = "liteon,ltr559", },
>  	{ .compatible = "liteon,ltr301", },
> +	{ .compatible = "liteon,ltr303", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ltr501_of_match);

