Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E85196745
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgC1QUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgC1QUv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 12:20:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE2F20716;
        Sat, 28 Mar 2020 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585412449;
        bh=X3pXjmYLi4bBeFRbSjGMWSGh145Uly6D7FDS9jUFKtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CSuuH0ktIW0FX3xb6zCP69uQEtgdDW003Z+65Wskmk8fGna++e/tqA2OX0xtIaXDi
         ol/JbKD1gVCT7h1btCix22D6VSo2CGhDKaW24MlOk1lePqpunCoFWWdmldWYz791rd
         P2VMGJsedOsIOIa+I4uRvWdmGL5EaDDOKJZtUyLk=
Date:   Sat, 28 Mar 2020 16:20:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v5 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20200328162044.7b9992c3@archlinux>
In-Reply-To: <20200324080309.12171-2-mike.looijmans@topic.nl>
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
        <20200324080309.12171-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 09:03:08 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Hi Mike, 

A few tiny things from me.

For the sampling frequency, I wonder if we are better off going back
to the list of values, but then also using the read_avail infrastructure
to avoid having to carry them as a string as well?

Thanks,

Jonathan

> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..7ed9c82b731b 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config BMI088_ACCEL
> +	tristate "Bosch BMI088 Accelerometer Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select BMI088_ACCEL_SPI
> +	help
> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
> +
> +	  This is a combo module with both accelerometer and gyroscope.
> +	  This driver is only implementing accelerometer part, which has
> +	  its own address and register map.
> +
> +config BMI088_ACCEL_SPI
> +	tristate
> +	select REGMAP_SPI
> +

Hmm. So we list this driver even if SPI is disabled.  Generally we try
not to do that, as it makes for lots of things to pick on devices that
don't actually have an SPI bus.

Hence, please add a depends to the first Kconfig symbol so it's hidden
if no SPI.  When I2C is added it can become at least one of the two.

...

> +
> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
> +					int *val, int *val2)
> +{
> +	unsigned int value;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +			  &value);
> +	if (ret)
> +		return ret;
> +
> +	value &= BMI088_ACCEL_MODE_ODR_MASK;
> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
> +		*val = 12;
> +		*val2 = 500000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +	} else {
> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
> +		*val2 = 0;
> +		ret = IIO_VAL_INT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
> +{
> +	unsigned int value;
> +
> +	if (val < 12 || val > 1600)
> +		return -EINVAL;
> +
> +	value = fls(val) + 1;

This leads to some 'novel' rounding to my mind.

(12,16] = 12.5
(16,32] = 25
(32,64] = 50
(64,128] = 100

Generally we want to go faster if anything when talking about sampling frequencies,
so I'd either like to see round up or precise value matching only.

> +
> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +				  BMI088_ACCEL_MODE_ODR_MASK, value);
> +}
> +

...

> +
> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bmi088_accel_get_temp(data, val);
> +		case IIO_ACCEL:
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			ret = bmi088_accel_get_axis(data, chan, val);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* Offset applies before scale */
> +			*val = BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;

Why?  In error paths it's not used, and it's set in the other two paths.

> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* 0.125 degrees per LSB */
> +			*val = BMI088_ACCEL_TEMP_UNIT;
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			ret = regmap_read(data->regmap,
> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
> +			if (ret)
> +				return ret;
> +
> +			*val2 = 15 - (*val & 0x3);
> +			*val = 3 * 980;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_get_sample_freq(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
...
