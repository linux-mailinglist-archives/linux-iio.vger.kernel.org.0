Return-Path: <linux-iio+bounces-338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996297F8AC0
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38B0B21258
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CFFBF6;
	Sat, 25 Nov 2023 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kycsenS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B45D301;
	Sat, 25 Nov 2023 12:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF557C433C7;
	Sat, 25 Nov 2023 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700915204;
	bh=sN2RXnutKRKrOHSA14p+xIODmdty21sisiNrxS+AUDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kycsenS2fbwm3vPrWVjKGm8M2c6Nk1CEJIB4hkvSIfgQgqInrYgCWbQEyj7Ea+Nst
	 QxooLL6tQXJCuWjKwW3beUttAhHXxlT1KbWCLDbcm9Ql0+wbj3LjOPEwzSJNChty+V
	 EgB6+gvO45kt2Qpqq1XqWk0DWj3CN457NmhgK0Tfr98lfQqAKdc0u00S2BKTw4+2cz
	 4iHBW1ax7zlNOtieGLLHQGuu5Dimp7ZuqRWI/w1jmWy1XYXaNH/3oPya8f0OOl686x
	 BOxWmnfAUIPgHGFdIUvmDrTCok6/+Fugie9BDsTyqFWhpPnFm3Wt0IJqDjL3ykbUeu
	 D+MhIQjvZ1ZCQ==
Date: Sat, 25 Nov 2023 12:26:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 3/3] iio: chemical: add support for Aosong AGS02MA
Message-ID: <20231125122635.77186f4e@jic23-huawei>
In-Reply-To: <20231125100139.193584-3-anshulusr@gmail.com>
References: <20231125100139.193584-1-anshulusr@gmail.com>
	<20231125100139.193584-3-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 15:31:38 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:
Hi Anshul

Comments inline.


> A simple driver for the TVOC (Total Volatile Organic Compounds)
> sensor from Aosong: AGS02MA
> 
> Steps in reading the VOC sensor value over i2c:
>   1. Read 5 bytes from the register `AGS02MA_TVOC_READ_REG` [0x00]
>   2. The first 4 bytes are taken as the big endian sensor data with final
>      byte being the CRC
>   3. The CRC is verified and the value is returned over an
>      `IIO_CHAN_INFO_RAW` channel as percents

We have standard units for VOC sensors of percents. So if your device
already outputs in that you should make it an IIO_CHAN_INFO_PROCESSED
to reflect that.  If not, I'd expect to see a IIO_CHAN_INFO_SCALE
for any necessary conversion.

> 
> Tested on Raspberry Pi Zero 2W
> 
> Datasheet:
>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Make this a formal tag in the tag block below.
> Product-Page:
>   http://www.aosong.com/m/en/products-33.html
This one isn't a standard tag, so fine to keep as you have it here.
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

...

> diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
> new file mode 100644
> index 000000000000..b23160eac99f
> --- /dev/null
> +++ b/drivers/iio/chemical/ags02ma.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> + *
> + * Driver for Aosong AGS02MA
> + *
> + * Datasheet:
> + *   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> + * Product Page:
> + *   http://www.aosong.com/m/en/products-33.html
> + *
> + * TODO:
> + *   - Support for ug/m^3 units of measurement

Why? I'd assume that's some linear conversion of the percent value.  Leave
that to userspace.

> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#define AGS02MA_DEVICE_NAME		   "ags02ma"
> +
> +#define AGS02MA_TVOC_READ_REG		   0x00
> +#define AGS02MA_VERSION_REG		   0x11
> +
> +#define AGS02MA_VERSION_PROCESSING_DELAY   30
> +#define AGS02MA_TVOC_READ_PROCESSING_DELAY 1500
> +
> +#define AGS02MA_CRC8_INIT		   0xff
> +#define AGS02MA_CRC8_POLYNOMIAL		   0x31
> +#define AGS02MA_PPB_PERCENT_CONVERSION     10000000
> +
> +DECLARE_CRC8_TABLE(ags02ma_crc8_table);
> +
> +struct ags02ma_data {
> +	struct i2c_client *client;
> +};
> +
> +struct ags02ma_reading {
> +	__be32 data;
> +	u8 crc;
> +} __packed;
> +
> +static u32 ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay)
> +{
> +	int ret;
> +	u8 crc;
> +	struct ags02ma_reading read_buffer;
> +
> +	ret = i2c_master_send(client, &reg, sizeof(reg));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to send data to register 0x%x: %d", reg, ret);
> +		return ret;
> +	}
> +
> +	/* Processing Delay, Check Table 7.7 in the datasheet */
> +	msleep_interruptible(delay);
> +
> +	ret = i2c_master_recv(client, (u8 *)&read_buffer, sizeof(read_buffer));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to receive from register 0x%x: %d", reg, ret);
> +		return ret;

function returns a u32... 
I'd separate the return value from the data read.  Use
a u32 *val parameter for the data.

> +	}
> +
> +	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
> +		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
> +	if (crc != read_buffer.crc) {
> +		dev_err(&client->dev, "CRC error\n");
> +		return -EIO;
> +	}
> +
> +	return be32_to_cpu(read_buffer.data);

> +}
> +
> +static int ags02ma_read_raw(struct iio_dev *iio_device,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret;
> +	struct ags02ma_data *data = iio_priv(iio_device);
> +
> +	if (mask == IIO_CHAN_INFO_RAW) {
> +		/* The sensor reads data as ppb */
> +		ret = ags02ma_register_read(data->client, AGS02MA_TVOC_READ_REG,
> +					    AGS02MA_TVOC_READ_PROCESSING_DELAY);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		*val2 = AGS02MA_PPB_PERCENT_CONVERSION;

Use IIO_CHAN_INFO_SCALE to deal with the division. Not all applications will care, so make it
a userspace decision rather than doing it in driver (or a consumer decision if for some
reason we end up with an inkernel consumer of VOC data)  If you enhance this driver
later to support buffering, you will have made it very challenging by doing
this conversion in driver.

> +		return IIO_VAL_FRACTIONAL;
> +	} else {
> +		return -EINVAL;
	Flip logic to exit in error case out of main line of code flow.

	if (mask != IIO_CHAN_INFO_RAW)
		return -EINVAL;
	
	/* The sensor read as ppb */
	ret = ...

> +	}
> +}
> +
> +static const struct iio_info ags02ma_info = {
> +	.read_raw = ags02ma_read_raw,
> +};
> +
> +static const struct iio_chan_spec ags02ma_channels[] = {
> +	{ .type = IIO_CONCENTRATION,
	{
		.type = ..
or given there is one, flatten it a level and just fill in
1 explicitly for num channels.

> +	  .channel2 = IIO_MOD_VOC,
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) }
						  RAW),
	},

> +};
> +
> +static int ags02ma_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct ags02ma_data *data;
> +	struct iio_dev *indio_dev;
> +	u32 version;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	crc8_populate_msb(ags02ma_crc8_table, AGS02MA_CRC8_POLYNOMIAL);
> +
> +	ret = ags02ma_register_read(client, AGS02MA_VERSION_REG,
> +				    AGS02MA_VERSION_PROCESSING_DELAY);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read device version: %d", ret);
> +		return ret;

Prefer
	return dev_err_probe(&client->dev, ret, "Failed to read device version\n");
for any errors that show up in probe.
It's shorter + provides advantages if you end up adding some calls that
can defer probing later.

> +	}
> +	version = ret;
> +	dev_dbg(&client->dev, "Aosong AGS02MA, Version: 0x%x", version);
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Why? I don't think you use it (which is expected in a simple driver - tend
to need this only when adding power management or having to do explicit
remove() handling for some reason.

> +	data->client = client;
> +	indio_dev->info = &ags02ma_info;
> +	indio_dev->channels = ags02ma_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ags02ma_channels);
> +	indio_dev->name = AGS02MA_DEVICE_NAME;

I'm not a fan of defines for name strings because I'd rather just see them
where they are used - why hid this away?  It's not saving code
and a string is as good as a define in all the places it's used
(there is not real reason they have to have the same value, even though
they happen to do so in this driver).

> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ags02ma_id_table[] = {
> +	{ AGS02MA_DEVICE_NAME, 0 },

Don't put the 0 as it implies some data in there, when it's never
read (C will put a 0 in there anyway but that doesn't matter)

> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ags02ma_id_table);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ags02ma_of_table[] = {
> +	{ .compatible = "aosong,ags02ma"},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ags02ma_of_table);
> +#endif

With of_match_ptr() dropped below y ou will again not need these.

> +
> +static struct i2c_driver ags02ma_driver = {
> +	.driver = {
> +		.name = AGS02MA_DEVICE_NAME,
> +		.of_match_table = of_match_ptr(ags02ma_of_table),
Never have of_match_ptr() in an IIO driver.
It breaks ACPI PRP0001 based bindings which are frequently used with
IIO devices - also saves trivial amoutn of space.

> +	},

All minor stuff and great to have more of these VOC drivers in supported.

Thanks,

Jonathan


