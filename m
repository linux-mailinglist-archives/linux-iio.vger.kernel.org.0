Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B86129943
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfLWRWe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfLWRWe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:22:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1121206CB;
        Mon, 23 Dec 2019 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577121754;
        bh=5dzUhxJVXJE4MT7lORO4U7iPxMS9do0mraNiK2OkjC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C6CfQUJ18M7EzXAm+bR2kZtTbx6REvWNo5oaHA15YZ2O3v5wQircE7kS4QohrKnHg
         gZpp6kiMvdYftdP34MzScYSkWxYyNhduscrOWUzZ8vLDcv4YBNddABoZGj0s/5wrfR
         0EF7cCyhNMurlZugtz8iBxy3uVOkhcGYttMRgT5g=
Date:   Mon, 23 Dec 2019 17:22:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 3/4] iio: accel: bma180: Use explicit member assignment
Message-ID: <20191223172228.0457ec7a@archlinux>
In-Reply-To: <20191211213819.14024-3-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
        <20191211213819.14024-3-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 22:38:18 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This uses the C99 explicit .member assignment for the
> variant data in struct bma180_part_info. This makes it
> easier to understand and add new variants.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This I like.  Sensible improvement to readability.
Not sure why I let it through in the form it was in originally.
oh well.

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 68 ++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 4a619b5a544a..f583f10ccbb9 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -632,32 +632,52 @@ static const struct iio_chan_spec bma250_channels[] = {
>  
>  static const struct bma180_part_info bma180_part_info[] = {
>  	[BMA180] = {
> -		bma180_channels, ARRAY_SIZE(bma180_channels),
> -		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
> -		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
> -		BMA180_CTRL_REG0, BMA180_RESET_INT,
> -		BMA180_CTRL_REG0, BMA180_SLEEP,
> -		BMA180_BW_TCS, BMA180_BW,
> -		BMA180_OFFSET_LSB1, BMA180_RANGE,
> -		BMA180_TCO_Z, BMA180_MODE_CONFIG, BMA180_LOW_POWER,
> -		BMA180_CTRL_REG3, BMA180_NEW_DATA_INT,
> -		BMA180_RESET,
> -		bma180_chip_config,
> -		bma180_chip_disable,
> +		.channels = bma180_channels,
> +		.num_channels = ARRAY_SIZE(bma180_channels),
> +		.scale_table = bma180_scale_table,
> +		.num_scales = ARRAY_SIZE(bma180_scale_table),
> +		.bw_table = bma180_bw_table,
> +		.num_bw = ARRAY_SIZE(bma180_bw_table),
> +		.int_reset_reg = BMA180_CTRL_REG0,
> +		.int_reset_mask = BMA180_RESET_INT,
> +		.sleep_reg = BMA180_CTRL_REG0,
> +		.sleep_mask = BMA180_SLEEP,
> +		.bw_reg = BMA180_BW_TCS,
> +		.bw_mask = BMA180_BW,
> +		.scale_reg = BMA180_OFFSET_LSB1,
> +		.scale_mask = BMA180_RANGE,
> +		.power_reg = BMA180_TCO_Z,
> +		.power_mask = BMA180_MODE_CONFIG,
> +		.lowpower_val = BMA180_LOW_POWER,
> +		.int_enable_reg = BMA180_CTRL_REG3,
> +		.int_enable_mask = BMA180_NEW_DATA_INT,
> +		.softreset_reg = BMA180_RESET,
> +		.chip_config = bma180_chip_config,
> +		.chip_disable = bma180_chip_disable,
>  	},
>  	[BMA250] = {
> -		bma250_channels, ARRAY_SIZE(bma250_channels),
> -		bma250_scale_table, ARRAY_SIZE(bma250_scale_table),
> -		bma250_bw_table, ARRAY_SIZE(bma250_bw_table),
> -		BMA250_INT_RESET_REG, BMA250_INT_RESET_MASK,
> -		BMA250_POWER_REG, BMA250_SUSPEND_MASK,
> -		BMA250_BW_REG, BMA250_BW_MASK,
> -		BMA250_RANGE_REG, BMA250_RANGE_MASK,
> -		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
> -		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
> -		BMA250_RESET_REG,
> -		bma250_chip_config,
> -		bma250_chip_disable,
> +		.channels = bma250_channels,
> +		.num_channels = ARRAY_SIZE(bma250_channels),
> +		.scale_table = bma250_scale_table,
> +		.num_scales = ARRAY_SIZE(bma250_scale_table),
> +		.bw_table = bma250_bw_table,
> +		.num_bw = ARRAY_SIZE(bma250_bw_table),
> +		.int_reset_reg = BMA250_INT_RESET_REG,
> +		.int_reset_mask = BMA250_INT_RESET_MASK,
> +		.sleep_reg = BMA250_POWER_REG,
> +		.sleep_mask = BMA250_SUSPEND_MASK,
> +		.bw_reg = BMA250_BW_REG,
> +		.bw_mask = BMA250_BW_MASK,
> +		.scale_reg = BMA250_RANGE_REG,
> +		.scale_mask = BMA250_RANGE_MASK,
> +		.power_reg = BMA250_POWER_REG,
> +		.power_mask = BMA250_LOWPOWER_MASK,
> +		.lowpower_val = 1,
> +		.int_enable_reg = BMA250_INT_ENABLE_REG,
> +		.int_enable_mask = BMA250_DATA_INTEN_MASK,
> +		.softreset_reg = BMA250_RESET_REG,
> +		.chip_config = bma250_chip_config,
> +		.chip_disable = bma250_chip_disable,
>  	},
>  };
>  

