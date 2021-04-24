Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4536A110
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhDXMLN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhDXMLL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 08:11:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A938861422;
        Sat, 24 Apr 2021 12:10:30 +0000 (UTC)
Date:   Sat, 24 Apr 2021 13:11:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: iio: cdc: ad7746: use dt for capacitive
 channel setup.
Message-ID: <20210424131110.640cc152@jic23-huawei>
In-Reply-To: <b0132613b82b17d63c8a91556c2c424015f202db.1618785336.git.lucas.p.stankus@gmail.com>
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
        <b0132613b82b17d63c8a91556c2c424015f202db.1618785336.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Apr 2021 19:50:10 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> Ditch platform_data fields in favor of device tree properties for
> configuring EXCA and EXCB output pins and setting the capacitive channel
> excitation level.
> 
> As this covers all current use cases for the platform_data struct, remove
> ad7746.h header file since it's no longer needed.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
Hi Lucas,

Just one comment which is that the permille to register value
is a bit opaque so I think I'd prefer a simple lookup table even though it
is a bit more code.

Otherwise looks good to me.

Thanks,

Jonathan
> ---
> 
> Changes in v2:
> Previously this change set was composed of two patches, but it lead to
> regressions between the two. Merging them avoids the unwanted behaviour
> without having to deal with the special cases.
> 
>  drivers/staging/iio/cdc/ad7746.c | 42 +++++++++++++++-----------------
>  drivers/staging/iio/cdc/ad7746.h | 28 ---------------------
>  2 files changed, 19 insertions(+), 51 deletions(-)
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.h
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index dfd71e99e872..c0e84c1cf4f1 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -18,8 +18,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include "ad7746.h"
> -
>  /*
>   * AD7746 Register Definition
>   */
> @@ -66,7 +64,7 @@
>  #define AD7746_EXCSETUP_NEXCB		BIT(4)
>  #define AD7746_EXCSETUP_EXCA		BIT(3)
>  #define AD7746_EXCSETUP_NEXCA		BIT(2)
> -#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
> +#define AD7746_EXCSETUP_EXCLVL(x)	(((x) >> 7) & 0x3)

I'd like a comment on this maths, or just use a lookup table instead so
we don't have to think about it and also enforce exact matches.
The rounding this results in is a bit odd

>  
>  /* Config Register Bit Designations (AD7746_REG_CFG) */
>  #define AD7746_CONF_VTFS_SHIFT		6
> @@ -676,10 +674,11 @@ static const struct iio_info ad7746_info = {
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	struct ad7746_platform_data *pdata = client->dev.platform_data;
> +	struct device *dev = &client->dev;
>  	struct ad7746_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned char regval = 0;
> +	unsigned int vdd_permille;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> @@ -703,28 +702,25 @@ static int ad7746_probe(struct i2c_client *client,
>  	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (pdata) {
> -		if (pdata->exca_en) {
> -			if (pdata->exca_inv_en)
> -				regval |= AD7746_EXCSETUP_NEXCA;
> -			else
> -				regval |= AD7746_EXCSETUP_EXCA;
> -		}
> -
> -		if (pdata->excb_en) {
> -			if (pdata->excb_inv_en)
> -				regval |= AD7746_EXCSETUP_NEXCB;
> -			else
> -				regval |= AD7746_EXCSETUP_EXCB;
> -		}
> +	if (device_property_read_bool(dev, "adi,exca-output-en")) {
> +		if (device_property_read_bool(dev, "adi,exca-output-invert"))
> +			regval |= AD7746_EXCSETUP_NEXCA;
> +		else
> +			regval |= AD7746_EXCSETUP_EXCA;
> +	}
>  
> -		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> -	} else {
> -		dev_warn(&client->dev, "No platform data? using default\n");
> -		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> -			AD7746_EXCSETUP_EXCLVL(3);
> +	if (device_property_read_bool(dev, "adi,excb-output-en")) {
> +		if (device_property_read_bool(dev, "adi,excb-output-invert"))
> +			regval |= AD7746_EXCSETUP_NEXCB;
> +		else
> +			regval |= AD7746_EXCSETUP_EXCB;
>  	}
>  
> +	ret = device_property_read_u32(dev, "adi,excitation-vdd-permille",
> +				       &vdd_permille);
> +	if (!ret)
> +		regval |= AD7746_EXCSETUP_EXCLVL(vdd_permille);
> +
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					AD7746_REG_EXC_SETUP, regval);
>  	if (ret < 0)
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> deleted file mode 100644
> index 8bdbd732dbbd..000000000000
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -
> -#ifndef IIO_CDC_AD7746_H_
> -#define IIO_CDC_AD7746_H_
> -
> -/*
> - * TODO: struct ad7746_platform_data needs to go into include/linux/iio
> - */
> -
> -#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
> -#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
> -#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
> -#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
> -
> -struct ad7746_platform_data {
> -	unsigned char exclvl;	/*Excitation Voltage Level */
> -	bool exca_en;		/* enables EXCA pin as the excitation output */
> -	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
> -	bool excb_en;		/* enables EXCB pin as the excitation output */
> -	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
> -};
> -
> -#endif /* IIO_CDC_AD7746_H_ */

