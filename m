Return-Path: <linux-iio+bounces-13458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612499F1F33
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB851889D2E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4C1922E0;
	Sat, 14 Dec 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcXnGHGW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1827D53C;
	Sat, 14 Dec 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734185461; cv=none; b=ladkudRoookE5lrvCpoQrUgy82zIrUJBApaibw9XVDHxpeMFWnj1FShPDDxTjS6P4BCa6Q7Fkg8NUWiCdNszSEwTmBRjVHIAoqpyHy/tb3N+JoXbrY1QiOA+dkg2HOKllMlQwB2GoWjrnIeM8hPdfKyaY1NsXAC6TijSD73Sfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734185461; c=relaxed/simple;
	bh=nZR5IyZ4JBoHlrm0wnKGiw70Qdc5RwrXxIxFX0DMXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9hn26ApoWlUMCHQhXQXRFW+W/FmlitiJ9eckyFfehXZzi/tzGm8/RYvrZvAK8kKINrGDAlDlELr+ZBYdXw3avPEArUvcdSl1aiaOf16feFACA/Ro7RzwhAADkCyJUa5c+X3pV4fjOId+lMOT7Fhq4bkOiVnVtluD1ed0iV9/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcXnGHGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA6CC4CED1;
	Sat, 14 Dec 2024 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734185460;
	bh=nZR5IyZ4JBoHlrm0wnKGiw70Qdc5RwrXxIxFX0DMXh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kcXnGHGWutOJAye+fXblZ/I8GknmvOMypBOxIjRem1kitXYbjuD5SgeIvtEtVsaVf
	 8xCF5wxHXHJX1MjHr8QzGakiJpP92UWDlvET5mWgmoov5w9yDLst0SQWUxUw3LSeOK
	 NcIOLhEhmBf0kXDmRGi3A7bO5djVPFPrfilQ1VgMpNALpSl2ksxhWRS9W8kdZt8jDk
	 lWqDmSDk/M2i1wN9OY6gfFSId02FlvH/qInNRDiY77Yo6TZmb04JSkuJje6c+wK8yY
	 i1odFuTK1jU1fZcUDHQqdE7OPVjWGPEVYlM1iDqlFzKoGR8LUc+RHOqDYLtnMCIYzN
	 tEX3Khqp/x12Q==
Date: Sat, 14 Dec 2024 14:10:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] iio: accel: adxl367: add support for adxl366
Message-ID: <20241214141050.5763b781@jic23-huawei>
In-Reply-To: <20241213095201.1218145-2-darius.berghe@analog.com>
References: <20241213095201.1218145-1-darius.berghe@analog.com>
	<20241213095201.1218145-2-darius.berghe@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 11:52:00 +0200
Darius Berghe <darius.berghe@analog.com> wrote:

> Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
> Digital Output MEMS Accelerometer into the existing adxl367 iio
> subsystem driver.
> 
> adxl366 supports all the features of adxl367 but has a few
> additional features for which support is added in this patch:
>  - built-in step counting (pedometer)
>  - non-linearity compensation for Z axis
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>
Hi Darius,

General approach to cases which are adding the second device to an existing
driver is to do it in two steps.
1) Refactor to expose all the existing stuff that will be somewhat device
  dependent.  This should be a noop patch that we can quickly see doesn't
  break the existing device support.

2) Add the new stuff + support for the new device.

Various comments inline. Big one being the common one of : Where are the docs?
I'm thinking that they maybe got accidentally dropped given you cc'd linux-doc!

Thanks,

Jonathan


> ---
>  drivers/iio/accel/adxl367.c     | 233 +++++++++++++++++++++++++++++++-
>  drivers/iio/accel/adxl367.h     |   5 +
>  drivers/iio/accel/adxl367_i2c.c |   6 +-
>  drivers/iio/accel/adxl367_spi.c |   6 +-
>  4 files changed, 242 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 90b7ae6d42b7..95fd365c0a27 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>

after change suggested below this won't be needed
as you won't be calling device_get_match_data()

>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <asm/unaligned.h>
> @@ -96,8 +97,17 @@
>  #define ADXL367_POWER_CTL_MODE_MASK	GENMASK(1, 0)
>  
>  #define ADXL367_REG_ADC_CTL		0x3C
> -#define ADXL367_REG_TEMP_CTL		0x3D
>  #define ADXL367_ADC_EN_MASK		BIT(0)
> +#define ADXL367_REG_TEMP_CTL		0x3D
> +#define ADXL367_NL_COMP_EN_MASK         BIT(7)
> +
> +#define ADXL367_REG_PEDOMETER_STEP_CNT_H        0x47

This is never used... Given I assume it is the step counter, that
seems unlikely to be intent.

> +#define ADXL367_REG_PEDOMETER_CTL               0x49
> +#define ADXL367_PEDOMETER_RESET_STEP_MASK       BIT(2)
> +#define ADXL367_PEDOMETER_RESET_OF_MASK         BIT(1)
> +#define ADXL367_PEDOMETER_EN_MASK               BIT(0)
> +#define ADXL367_REG_PEDOMETER_THRESH_H          0x4A
> +#define ADXL367_REG_PEDOMETER_SENS_H            0x4C
>  
>  enum adxl367_range {
>  	ADXL367_2G_RANGE,
> @@ -177,6 +187,9 @@ struct adxl367_state {
>  	unsigned int	fifo_set_size;
>  	unsigned int	fifo_watermark;
>  
> +	int             steps_en;
> +	int             nl_comp_en;

These sound like bools. 


> +
>  	__be16		fifo_buf[ADXL367_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
>  	__be16		sample_buf;
>  	u8		act_threshold_buf[2];
> @@ -221,6 +234,13 @@ static const int adxl367_range_scale_factor_tbl[] = {
>  	[ADXL367_8G_RANGE] = 4,
>  };

> +static int adxl367_write_word(struct adxl367_state *st, int reg, int *val)
> +{
> +	u8 steps_raw[2];
> +
> +	put_unaligned_be16(*val, steps_raw);
If you are going to not use it as u8 at all, use __be16 and 
cpu_to_be16() to fill it.

Same for other cases.  We only do it with u8 if we need to write it
one byte at a time or it isn't a power of 2 long.

> +
> +	return regmap_bulk_write(st->regmap, reg,
> +				steps_raw, 2);
One line.

> +}
> +
>  static int adxl367_read_sample(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int *val)
> @@ -920,6 +964,17 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
>  		*val2 = adxl367_samp_freq_tbl[st->odr][1];
>  		mutex_unlock(&st->lock);
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_STEPS:
> +			*val = st->nl_comp_en;

Not number of steps? 

> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}

> +
> +static ssize_t adxl367_write_attr(struct iio_dev *indio_dev,
> +				  uintptr_t private,
> +				  const struct iio_chan_spec *chan,
> +				  const char *buf, size_t len)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	int ret = 0;
ret always set so no need to init.

> +	unsigned long value;
> +	int val;
> +
> +	ret = kstrtoul(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +	val = value;
> +
> +	switch (private) {
> +	case ADXL367_PEDOMETER_THRESHOLD:
We may want to make some of these standard attributes, but Documentation first
to get an idea of how consistent they are.

> +		ret = adxl367_write_word(st, ADXL367_REG_PEDOMETER_THRESH_H, &val);
> +		break;
> +	case ADXL367_PEDOMETER_SENSITIVITY:
> +		ret = adxl367_write_word(st, ADXL367_REG_PEDOMETER_SENS_H, &val);
> +		break;
> +	case ADXL367_PEDOMETER_RESET:
> +		if (val)


What does it mean to do have a value for a reset?
As below - I need to know more on why we care about reseting at all.

> +			ret = regmap_update_bits(st->regmap, ADXL367_REG_PEDOMETER_CTL,
> +						 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK,
> +						 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK);
ret not checked.

> +		ret = regmap_update_bits(st->regmap, ADXL367_REG_PEDOMETER_CTL,
> +					 ADXL367_PEDOMETER_RESET_STEP_MASK | ADXL367_PEDOMETER_RESET_OF_MASK,
> +					 0);
> +		break;
> +	case ADXL367_Z_NONLINEARITY_COMPENSATION:
> +		ret = regmap_update_bits(st->regmap, ADXL367_REG_TEMP_CTL,
> +					 ADXL367_NL_COMP_EN_MASK,
> +					 val ? ADXL367_NL_COMP_EN_MASK : 0);
> +		if (ret)
> +			return ret;
> +
> +		st->nl_comp_en = val ? 1 : 0;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	return ret ? ret : len;
>  }
>  
>  static int adxl367_write_raw_get_fmt(struct iio_dev *indio_dev,
> @@ -1376,6 +1518,37 @@ static const struct iio_event_spec adxl367_events[] = {
>  	},
>  };
>  
> +static const struct iio_chan_spec_ext_info adxl367_step_ext_info[] = {
> +	{
> +		.name = "threshold",
> +		.read = adxl367_read_attr,
> +		.write = adxl367_write_attr,
> +		.private = ADXL367_PEDOMETER_THRESHOLD,
> +	},
> +	{
> +		.name = "sensitivity",

Without docs, I'm not sure what this and threshold are.
There are some existing ABI controls for step detection but they are
around debouncing, so we may need more if this device uses a different
algorithm.

> +		.read = adxl367_read_attr,
> +		.write = adxl367_write_attr,
> +		.private = ADXL367_PEDOMETER_SENSITIVITY,
> +	},
> +	{
> +		.name = "reset",
Make the channel writeable and write a 0 to reset
(don't accept any other write).  Also update in_steps_input documentation
for that.  Right now it says the counter doesn't reset.
It is non obvious why we care though - if userspace wants to know
number of steps after time X then it can just save the counter at
time X.

So why provide a reset control at atll?




> +		.write = adxl367_write_attr,
> +		.private = ADXL367_PEDOMETER_RESET,
> +	},
> +	{ }
> +};
> +
> +static const struct iio_chan_spec_ext_info adxl367_z_ext_info[] = {
> +	{
> +		.name = "nl_comp_en",
This is new ABI. It must be accompanied by documentation in 
Documentation/ABI/testing/sysfs-bus-iio-*

I'd also be curious to why we'd ever turn it off.

> +		.read = adxl367_read_attr,
> +		.write = adxl367_write_attr,
> +		.private = ADXL367_Z_NONLINEARITY_COMPENSATION,
> +	},
> +	{ }
> +};
> +
>  #define ADXL367_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = (reg),						\
> @@ -1424,6 +1597,44 @@ static const struct iio_chan_spec adxl367_channels[] = {
>  			IIO_VOLTAGE),
>  };
>  
> +static const struct iio_chan_spec adxl366_channels[] = {
> +	ADXL367_ACCEL_CHANNEL(ADXL367_X_CHANNEL_INDEX, ADXL367_REG_X_DATA_H, X),
> +	ADXL367_ACCEL_CHANNEL(ADXL367_Y_CHANNEL_INDEX, ADXL367_REG_Y_DATA_H, Y),
> +	{
> +		.type = IIO_ACCEL,
> +		.address = ADXL367_REG_Z_DATA_H,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = adxl367_events,
> +		.num_event_specs = ARRAY_SIZE(adxl367_events),
> +		.scan_index = ADXL367_Z_CHANNEL_INDEX,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +			},
> +		.ext_info = adxl367_z_ext_info,
> +	},
> +	ADXL367_CHANNEL(ADXL367_TEMP_CHANNEL_INDEX, ADXL367_REG_TEMP_DATA_H,
> +			IIO_TEMP),
> +	ADXL367_CHANNEL(ADXL367_EX_ADC_CHANNEL_INDEX, ADXL367_REG_EX_ADC_DATA_H,
> +			IIO_VOLTAGE),
> +	{
> +		.type = IIO_STEPS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_ENABLE),
> +		.scan_index = -1, /* No buffer support */
> +		.ext_info = adxl367_step_ext_info,
> +	},
> +};
> +
>  static int adxl367_verify_devid(struct adxl367_state *st)
>  {
>  	unsigned int val;
> @@ -1479,6 +1690,9 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  	struct iio_dev *indio_dev;
>  	struct adxl367_state *st;
>  	int ret;
> +	enum adxl367_variant variant;
> +
> +	variant = (uintptr_t)device_get_match_data(dev);
Use the bus specific extractors to get this and pass it in to probe.

spi_get_device_match_data() / i2c_get_match_data()

They deal with the various ID table rather than simple the ones supported
by property.h

>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -1492,10 +1706,21 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  
>  	mutex_init(&st->lock);
>  
> -	indio_dev->channels = adxl367_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
> +	switch (variant) {
> +	case ADXL366:

Put everything here inside the adxl366_chip_info structure mentioned below
then these are simple unconditional assignments.

> +		indio_dev->name = "adxl366";
> +		indio_dev->channels = adxl366_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adxl366_channels);
> +		break;
> +	case ADXL367:
> +		indio_dev->name = "adxl367";
> +		indio_dev->channels = adxl367_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  	indio_dev->available_scan_masks = adxl367_channel_masks;
> -	indio_dev->name = "adxl367";
>  	indio_dev->info = &adxl367_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> diff --git a/drivers/iio/accel/adxl367.h b/drivers/iio/accel/adxl367.h
> index 4a42622149b1..21a6b06b774d 100644
> --- a/drivers/iio/accel/adxl367.h
> +++ b/drivers/iio/accel/adxl367.h
> @@ -9,6 +9,11 @@
>  
>  #include <linux/types.h>
>  
> +enum adxl367_variant {
> +	ADXL366,
> +	ADXL367,
> +};
> +
>  struct device;
>  struct regmap;
>  
> diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
> index b595fe94f3a3..b712e038183f 100644
> --- a/drivers/iio/accel/adxl367_i2c.c
> +++ b/drivers/iio/accel/adxl367_i2c.c
> @@ -61,13 +61,15 @@ static int adxl367_i2c_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id adxl367_i2c_id[] = {
> -	{ "adxl367", 0 },
> +	{ "adxl366", ADXL366 },
No enums here. Use a device type specific chip_info structure.
Couple of reasons.
1) 0 value is an error for some of the helpers, so can trip us up
  later.
2) It is way more extensible to have a single structure that is used
   for all device differences.

Just define them in the main c file + export them as needed. Then use
extern in the header so you can have pointers to them here.

> +	{ "adxl367", ADXL367 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
>  
>  static const struct of_device_id adxl367_of_match[] = {
> -	{ .compatible = "adi,adxl367" },
> +	{ .compatible = "adi,adxl366", .data = (const void *)ADXL366 },
> +	{ .compatible = "adi,adxl367", .data = (const void *)ADXL367 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adxl367_of_match);
> diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
> index 118c894015a5..ea8c0408281b 100644
> --- a/drivers/iio/accel/adxl367_spi.c
> +++ b/drivers/iio/accel/adxl367_spi.c
> @@ -138,13 +138,15 @@ static int adxl367_spi_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adxl367_spi_id[] = {
> -	{ "adxl367", 0 },
> +	{ "adxl366", ADXL366 },
> +	{ "adxl367", ADXL367 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(spi, adxl367_spi_id);
>  
>  static const struct of_device_id adxl367_of_match[] = {
> -	{ .compatible = "adi,adxl367" },
> +	{ .compatible = "adi,adxl366", .data = (const void *)ADXL366 },
> +	{ .compatible = "adi,adxl367", .data = (const void *)ADXL367 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adxl367_of_match);


