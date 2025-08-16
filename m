Return-Path: <linux-iio+bounces-22792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E889B28D0B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5ACB0575C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53B23BCEF;
	Sat, 16 Aug 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WadRKRCX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246B156C79;
	Sat, 16 Aug 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341375; cv=none; b=oh2sz8crVOieBXkSt9jjGOL2V76ZJDFPL+ERf43Oo8XyYvxiJjMoCyQWu2Kz79Ua6UW2dLpr5x5u22Yoa+VeGAW27U98dhRQmtjsHLgepvLnggv+iIwXHPDwN9mB5ft8Isqexxsms4OzLUQzEgT7Okqpg65pyI8G5u2io8d8klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341375; c=relaxed/simple;
	bh=QjzhGSjZPNRLCzH5ie+MpMUmCnZul+cxysrq0tU5Ufs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxYLzeP7YUDZCC+feKW8dbbz47QIIjcb9mPHsLtP7hReLjtXRm/qgCPNLVZ0wx9Weq+j7dU4A2FGju8Vykx9IdoI/Ix9yuyp+uoH6wFlw7CZaO1jJT+rhcu+H8zbWoyvGtD1xLzXzzdco+sVrZCTLgmhKcNttZ3/CqB5SKlC2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WadRKRCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA9C4CEEF;
	Sat, 16 Aug 2025 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755341374;
	bh=QjzhGSjZPNRLCzH5ie+MpMUmCnZul+cxysrq0tU5Ufs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WadRKRCXZiHD4L0a8kIf/DwD3BbBN4P7V0SqLNWldpK7EYhJy6beRhlnN1mXe+6wu
	 rzIuUF7k49FkkcUMNejMspu17HvuhE7YjvaC417qQ+/SnOWkC4jZzzTcU1fYH7dgRd
	 qyql3dKEirH2IEXNF54hQCwyaTdbZ7I6nfQLkNtMGFypLqkOmMipTghHZCstJ3jv5S
	 1sHRkoHANln74EgEB8GsOUwx69M9wQR92Zeo1Cl0rgs2jQmGbYTY+PwkvilXOLcVgR
	 KN3kXNCLThCT0uKuHB6K54v+97F6RYlLhKRNQ4s1C1bXotvx/sZEHor5sZrLSHaPIm
	 uoBZ+Ssu50zmA==
Date: Sat, 16 Aug 2025 11:49:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: ltc2497: add support for LTC2495
Message-ID: <20250816114924.7335948c@jic23-huawei>
In-Reply-To: <20250815-ltc2495-v4-2-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
	<20250815-ltc2495-v4-2-2d04e6005468@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:02:03 +0200
Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:

> Update the LTC2497 driver to also support the LTC2495.
> 
> Support for reading the internal temperature sensor on LTC2495 and
> LTC2499 via a standard IIO temperature channel.
> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>

Hi Alper,

Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ltc2497-core.c | 132 ++++++++++++++++++++++++++++-------------
>  drivers/iio/adc/ltc2497.c      |  39 +++++++++++-
>  drivers/iio/adc/ltc2497.h      |  11 ++++
>  3 files changed, 140 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..9f3509c5974dd7a0489145c591630e1ff9dc333e 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/units.h>
I'm not seeing this used in this patch.  If it is used in driver already and the include
was missing, add it as a separate patch.

> @@ -95,10 +99,37 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret / 1000;
> -		*val2 = ddata->chip_info->resolution + 1;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = ret / 1000;
> +			*val2 = ddata->chip_info->resolution + 1;
>  
> -		return IIO_VAL_FRACTIONAL_LOG2;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		case IIO_TEMP:
> +			if (!ddata->chip_info->has_temp_channel)
> +				return -EINVAL;
> +
> +			*val = ret;
> +			*val2 = ddata->chip_info->temp_scale_mV;

Uou are outputting via _RAW but doing part of the scaling in here.
Why not figure out the full scale with the vref part and output
that as _scale? It's linear so that should be easy to do.

> +
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;
> +
> +		ret = regulator_get_voltage(ddata->ref);

Reference regulators very rarely change in practice (once enabled) so it's
common option to just read them in probe as then can use the devm_ calls that
exist to turn them on and read the voltage and only keep a visible copy of
the voltage.

It might be worth a precursor patch to do that for existing scaling measurement.
 
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = kelvin_to_celsius(0) * ddata->chip_info->temp_scale_mV;
> +		*val2 = ret / 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
>  
>  	default:
>  		return -EINVAL;
> @@ -126,39 +157,54 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  	.differential = 1, \
>  }

>  static const struct iio_info ltc2497core_info = {
> @@ -182,8 +228,14 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  
>  	indio_dev->info = &ltc2497core_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ltc2497core_channel;
> -	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
> +
> +	if (ddata->chip_info->has_temp_channel) {
> +		indio_dev->channels = ltc2497core_channel_with_temperature;
> +		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel_with_temperature);
> +	} else {
> +		indio_dev->channels = ltc2497core_channel;
> +		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
> +	}
>  
>  	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
>  	if (ret < 0)
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index eb9d521e86e54def0493ea0e81f63b37900c56a5..cd3d00a8ffcb44107c9ad948913c97db9412b5f5 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -18,7 +18,12 @@
>  
>  #include "ltc2497.h"
>  
> +/* Optional second byte fields for LTC2495 and LTC2499 */
> +#define LTC2497_EN2	BIT(7)
If they only exist on parts other than LTC2497, name the define

after one of those rather than the general driver prefix.
LTC2499_EN2 probably

> +#define LTC2497_IM	BIT(6)
> +
>  enum ltc2497_chip_type {
> +	TYPE_LTC2495,
>  	TYPE_LTC2497,
>  	TYPE_LTC2499,
>  };
> @@ -85,8 +90,28 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  			return 0;
>  	}
>  
> -	ret = i2c_smbus_write_byte(st->client,
> -				   LTC2497_ENABLE | address);
> +	/*
> +	 * Chips with temperature sensor support (e.g., LTC2495/LTC2499)
Given one of these parts was supported prior to this patch I would suggest some reorganization.

Patch 1.  Add this temperature channel support for the LTC2499
Patch 2.  Binding for the LTC2495
Patch 3.  Device support for the LTC2945 (which should just be a few lines).

Alternative would be

Patch 1. Binding with fallback compatible so it 'works'.
Patch 2. Basic matching support for new part.
Patch 3. Temperature support for 9 and 5 parts.

but to me that is a little less elegant.


> +	 * require a two-byte command format to select any channel.
> +	 *
> +	 * To read the internal temperature, LTC2497_EN2 and LTC2497_IM
> +	 * are sent as the second byte. To read a voltage channel, LTC2497_EN2
> +	 * is sent, which sets the default configuration: simultaneous 50/60Hz
> +	 * rejection, 1x speed, and gain=1.
> +	 *
> +	 * Chips without this feature use a standard single-byte command.
> +	 */
> +	if (ddata->chip_info->has_temp_channel) {

Given your description there is other stuff in byte 2.
Maybe better to gate this on something called has_byte_2

If there are devices with byte 2 and no temp sensor, then two flags probably needed.

> +		if (ddata->chan_type_prev == IIO_TEMP)
> +			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE,
> +							LTC2497_EN2 | LTC2497_IM);
> +		else
> +			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE | address,
> +							LTC2497_EN2);
> +	} else {
> +		ret = i2c_smbus_write_byte(st->client, LTC2497_ENABLE | address);
> +	}
> +
>  	if (ret)
>  		dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
>  			ERR_PTR(ret));

> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 64e81c95a3dd05911b6717c09ac0560c9f47f304..dfe2d5c30017adeb3f17e57fc5bf1e0e792ff30f 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -7,6 +7,16 @@
>  struct ltc2497_chip_info {
>  	u32 resolution;
>  	const char *name;
> +	/*
> +	 * Represents the datasheet constant from the temperature formula:
> +	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
> +	 *
> +	 * To allow the driver to use Vref in millivolts for the calculation
> +	 * and also to avoid floating points, this stored value represents the
> +	 * datasheet constant scaled by 1000.
> +	 */
> +	u32 temp_scale_mV;
You've lost me on the untis here. If this temp_scale in the formula then a
bit of dimensional analysis says it's units must be derived as

	kevlin = (1 * volts) / temp_scale.
	
	tempscale = volts/ kelvin.

So I think it is probably mV_per_kelvin

I might have the logic wrong there but it's definitely not in mV.

Jonathan





> +	bool has_temp_channel;
>  };

