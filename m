Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1D5BBE62
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIROaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIROaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 10:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6BFFD0C;
        Sun, 18 Sep 2022 07:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6414AB81022;
        Sun, 18 Sep 2022 14:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34ABC433C1;
        Sun, 18 Sep 2022 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663511417;
        bh=XRuarmPYFtugEr38caK7dyUbAPLqBhROnmK/NnYB3sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrKl0gzv06ZFQ6unzCAtEcP/WVFcXeJ7HKEaDQvQsyKOm+O/gqcXLJQQfLxznTqOM
         AbyhSF2/3rdDySbKNBcxzHgKqV7+LY3FlT5VDqidTX4aOsDALVjKy8hG5cPROHYgx5
         J44g+U/JH8mg9OrIjH9aqDrZuNsDG5Rz1IvSEW1vgDIGjE401R7hRCzUtnEaiyyupg
         jitCpHxj1pQYijKc8iQp1LhluREFkD/SbSGF5sG044kQ8UfaDqf+cuDcarckQfuYdH
         dq37oVhoTIyR2b60d8JcGsQok+OPjBlTZIJkR2r9xztFfy0odmV69gSgnpAPF/WxOw
         wV+RkFkiRZ6jA==
Date:   Sun, 18 Sep 2022 15:30:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <20220918153021.791166a2@jic23-huawei>
In-Reply-To: <20220916140922.2506248-5-ciprian.regus@analog.com>
References: <20220916140922.2506248-1-ciprian.regus@analog.com>
        <20220916140922.2506248-5-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Sep 2022 17:09:21 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The LTC2499 is a 16-channel (eight differential), 24-bit,
> ADC with Easy Drive technology and a 2-wire, I2C interface.
> 
> Implement support for the LTC2499 ADC by extending the LTC2497
> driver. A new chip_info struct is added to differentiate between
> chip types and resolutions when reading data from the device.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
I'm not certain why (as I have the prerequisit on the tree) but this
didn't apply cleanly.  Please give the result of my manual intervention a
quick sanity check.

Thanks,

Jonathan

> ---
>  changes in v3:
>   - set the correct chip info indexes for i2c_device_id entries.
>   - added the asm/unaligned.h header.
>   - removed TYPE_LTC2496.
>   - moved the ltc2497_chip_type enum to ltc2497.c file.
>   - removed the name setting.
>  drivers/iio/adc/ltc2496.c      |  8 ++++-
>  drivers/iio/adc/ltc2497-core.c |  2 +-
>  drivers/iio/adc/ltc2497.c      | 61 +++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ltc2497.h      |  5 +++
>  4 files changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index dfb3bb5997e5..bf89d5ae19af 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -15,6 +15,7 @@
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  
>  #include "ltc2497.h"
>  
> @@ -74,6 +75,7 @@ static int ltc2496_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
> +	st->common_ddata.chip_info = device_get_match_data(dev);
>  
>  	return ltc2497core_probe(dev, indio_dev);
>  }
> @@ -85,8 +87,12 @@ static void ltc2496_remove(struct spi_device *spi)
>  	ltc2497core_remove(indio_dev);
>  }
>  
> +static const struct ltc2497_chip_info ltc2496_info = {
> +	.resolution = 16,
> +};
> +
>  static const struct of_device_id ltc2496_of_match[] = {
> -	{ .compatible = "lltc,ltc2496", },
> +	{ .compatible = "lltc,ltc2496", .data = &ltc2496_info, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltc2496_of_match);
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 2a485c8a1940..b2752399402c 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -95,7 +95,7 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		*val = ret / 1000;
> -		*val2 = 17;
> +		*val2 = ddata->chip_info->resolution + 1;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index f7c786f37ceb..36248423a7a6 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -12,18 +12,31 @@
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +
> +#include <asm/unaligned.h>
>  
>  #include "ltc2497.h"
>  
> +enum ltc2497_chip_type {
> +	TYPE_LTC2497,
> +	TYPE_LTC2499,
> +};
> +
>  struct ltc2497_driverdata {
>  	/* this must be the first member */
>  	struct ltc2497core_driverdata common_ddata;
>  	struct i2c_client *client;
> +	u32 recv_size;
> +	u32 sub_lsb;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be32 buf __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		__be32 d32;
> +		u8 d8[3];
> +	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
> @@ -34,13 +47,29 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  	int ret;
>  
>  	if (val) {
> -		ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
> +		if (st->recv_size == 3)
> +			ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
> +		else
> +			ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
> +
>  		if (ret < 0) {
>  			dev_err(&st->client->dev, "i2c_master_recv failed\n");
>  			return ret;
>  		}
>  
> -		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +		/*
> +		 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
> +		 * resolution + 1 position, which is set for positive values only. Given this
> +		 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
> +		 * equivalent to a sign extension.
> +		 */
> +		if (st->recv_size == 3) {
> +			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
> +				- BIT(ddata->chip_info->resolution + 1);
> +		} else {
> +			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
> +				- BIT(ddata->chip_info->resolution + 1);
> +		}
>  	}
>  
>  	ret = i2c_smbus_write_byte(st->client,
> @@ -54,9 +83,11 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  static int ltc2497_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> +	const struct ltc2497_chip_info *chip_info;
>  	struct iio_dev *indio_dev;
>  	struct ltc2497_driverdata *st;
>  	struct device *dev = &client->dev;
> +	u32 resolution;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>  				     I2C_FUNC_SMBUS_WRITE_BYTE))
> @@ -71,6 +102,15 @@ static int ltc2497_probe(struct i2c_client *client,
>  	st->client = client;
>  	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
>  
> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		chip_info = (const struct ltc2497_chip_info *)id->driver_data;
> +	st->common_ddata.chip_info = chip_info;
> +
> +	resolution = chip_info->resolution;
> +	st->sub_lsb = 31 - (resolution + 1);
> +	st->recv_size = BITS_TO_BYTES(resolution) + 1;
> +
>  	return ltc2497core_probe(dev, indio_dev);
>  }
>  
> @@ -83,14 +123,25 @@ static int ltc2497_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct ltc2497_chip_info ltc2497_info[] = {
> +	[TYPE_LTC2497] = {
> +		.resolution = 16,
> +	},
> +	[TYPE_LTC2499] = {
> +		.resolution = 24,
> +	},
> +};
> +
>  static const struct i2c_device_id ltc2497_id[] = {
> -	{ "ltc2497", 0 },
> +	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
> +	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
>  
>  static const struct of_device_id ltc2497_of_match[] = {
> -	{ .compatible = "lltc,ltc2497", },
> +	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
> +	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltc2497_of_match);
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index d0b42dd6b8ad..71957fc7e1ba 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -4,9 +4,14 @@
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
>  
> +struct ltc2497_chip_info {
> +	u32 resolution;
> +};
> +
>  struct ltc2497core_driverdata {
>  	struct regulator *ref;
>  	ktime_t	time_prev;
> +	const struct ltc2497_chip_info	*chip_info;
>  	u8 addr_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
>  				  u8 address, int *val);

