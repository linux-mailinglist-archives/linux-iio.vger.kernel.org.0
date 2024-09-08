Return-Path: <linux-iio+bounces-9342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893997095C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65043B21149
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794117798F;
	Sun,  8 Sep 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGDIxygP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666C339A8;
	Sun,  8 Sep 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725822254; cv=none; b=uI0VfqCeamU/hqLgYIyS/Esso2tJXcL/9EiEGseCkcTsOj3b6caTFE7NWUFA0Vl2DSLPEsU0qK+iqu2yXVxdnjffkcldMbPx6Hah9fzQWilzLL8XZqT4OAXF49HT0Bif5+NtdizRJ/snRb1vxHrO8ynN+FU36s85ilIimMLk2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725822254; c=relaxed/simple;
	bh=wvoFQLXpDcwGOU+Ix+bGW5ByAfIzdxUZT3hcleVNDf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9KF94QVR8iJx2qlMgPg+p6tJ0r7Bbre9HW2Ll+OVnh72RMUjVvDQSbgfH6utuJeK3A1d5sB+yUlkyXY1FGZxdaZrlK8+Cdk+0LXChsROw5SoT1APYGRuoC62mGRLHnEqdsbzLuOTzcQK6yeEe5ZuAhMstp5ZSgS5NveYQ1Tl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGDIxygP; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e034fac53bso1225471b6e.3;
        Sun, 08 Sep 2024 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725822252; x=1726427052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7Pc8uemgNp7ujP3oIrZDplRhNU9YJTKtM4gsksl0to=;
        b=AGDIxygPreAx/RmIpob3DVkX2EDfkLaYiucEYQYAgTUT5YjlE1nRjd41n192cKLsSq
         Ts2W7EsOE+c8M6fxk2I2iDnMBr/uijHTmww80BehcwGxBkMf8zk+dGS7T5SJjwFMjA7H
         IlRjhcwG3YAd/fd0dG01FgHOOCbS9Dt/pC40iOjPU8zRlKh8Cvp8H3ERg8oGhLrtYS4S
         Z/tHY91gxkwICFl2gFRqHQC1gltCNwF0gkEzhFblC04YIZYoCH927URgbtblObfj4wo9
         qCVqpnBKh6PayaHQnswlUpo6obuo3IjKbxVBGanRbJXOMGxtVVfG7bbdPBV4uz7fSBLZ
         MRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725822252; x=1726427052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7Pc8uemgNp7ujP3oIrZDplRhNU9YJTKtM4gsksl0to=;
        b=q4osst0aHAyZhfpydbnPfXPDi6yK1V9Jz+beTwZXZa9U3pwDWKUtU6MGlUZtsHHcU7
         1VGcLwlrxdmK4g0GkDy3IgusRjEaz2nzlwlPaGtj00/lU4/YKQKQZVihxovrthCPbSEp
         za9WPeHh/4sNdL61c7cYnNnu4js/nQQL9aT04iR8osDl9Mm7R3DXYy2aRQ+Tbsdb5F4C
         T3sCph7IySUw/ZOQfFzYyf65xz0EQ02PasBB+lqQ8YepmZuyXO/dIn+G53oWs7N6R0xu
         lJF9L4nDLbCqUTm31TKtMRTvjX0P6V9VK8suWRkHI5comZeXrIH/kb7hMy3qowucqm+K
         SGlw==
X-Forwarded-Encrypted: i=1; AJvYcCV6dbN9u5rUCfzBDWy9IClfqHNGJl3l1hah5k0r5fMPp2Ts7W6tPQMXhKmVx/i/SPUT028qr7PY0wd3@vger.kernel.org, AJvYcCVCSgU/fQ2E2MjzXdvJvWvD3WN7SvcHAUWgO+lJsjTn51vBgxRZFrhpBSs/jBwWGjFA6ma0hNt5KuUM57Dp@vger.kernel.org, AJvYcCXvna91iV9ATXt5yZvucm7/N67oXkMLac4io48g7cOC49YCU7lxb6TvPdxGInbrvcyPiySoDGnvwT2n@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8z6xWAR6Z0rXxtEe4OvG+z/AXrno/ZB5Oj2JuM3YSa4o24mE
	8xUWWLQ/t0Rb3K9WQ8cvKs8VkWHZLCZvi4FBy2It3zi1hRE6bucCtZRyXf/v
X-Google-Smtp-Source: AGHT+IG80yHW3muzJZFhoTbxaKVvcuFOYmgX9h4T4v+XMAqyKZmyn2Bfi8Fg+jI7EgX8MLQi9k+D+A==
X-Received: by 2002:a05:6808:1a0a:b0:3de:220c:ace2 with SMTP id 5614622812f47-3e029df8226mr10345447b6e.14.1725822251576;
        Sun, 08 Sep 2024 12:04:11 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f993a3sm14224431cf.93.2024.09.08.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:04:06 -0700 (PDT)
Date: Sun, 8 Sep 2024 15:04:03 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <ltddorwstm4hbsczsf4klqaoboagvdj3bbdhwyvbeslfdnnoc6@6fow6su5fju4>
References: <20240906165322.1745328-1-lanzano.alex@gmail.com>
 <20240906165322.1745328-3-lanzano.alex@gmail.com>
 <20240907170844.7eadb406@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907170844.7eadb406@jic23-huawei>

On Sat, Sep 07, 2024 at 05:08:44PM GMT, Jonathan Cameron wrote:
> On Fri,  6 Sep 2024 12:52:51 -0400
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > Add initial i2c support for the Bosch BMI270 6-axis IMU.
> > Provides raw read access to acceleration and angle velocity measurements
> > via iio channels. Device configuration requires firmware provided by
> > Bosch and is requested and load from userspace.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> 
> Hi Alex,
> 
> Various comments inline.  Just to check, have you confirmed these have
> a substantially different interface to the other bosch IMU devices?
> 
> (I'm too lazy / busy to datasheet dive today!)
> 
> Jonathan
> 

Yes, the BMI270 has a different register layout and some features not
included in the existing BMI160 and BMI323 such as the wrist worn
gesture detection.

> > diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
> > new file mode 100644
> > index 000000000000..05e13c67db57
> > --- /dev/null
> > +++ b/drivers/iio/imu/bmi270/Kconfig
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# BMI270 IMU driver
> > +#
> > +
> > +config BMI270
> > +	tristate
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> So far the driver isn't using the buffer / triggered buffer
> so drop this until it does.
> 

Wiil do in v3!

> > +
> > +config BMI270_I2C
> > +	tristate "Bosch BMI270 I2C driver"
> > +	depends on I2C
> > +	select BMI270
> > +	select REGMAP_I2C
> > +	help
> > +	  Enable support for the Bosch BMI270 6-Axis IMU connected to I2C
> > +	  interface.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called bmi270_i2c.
> > +
> 
> > diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> > new file mode 100644
> > index 000000000000..f8c53e8e35a2
> > --- /dev/null
> > +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
> > +#include <linux/firmware.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "bmi270.h"
> > +
> > +#define BMI270_CHIP_ID 0x24
> > +#define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
> > +
> > +enum bmi270_registers {
> 
> Unless you use the type somewhere, ti's usually better to just
> use defines for register addresses.
> That lets you group them with the field definitions for the
> elements that make up each register.
> 

Will fix in v3!

> > +	BMI270_REG_CHIP_ID = 0x00,
> > +	BMI270_REG_INTERNAL_STATUS = 0x21,
> > +	BMI270_REG_ACC_CONF = 0x40,
> > +	BMI270_REG_GYR_CONF = 0x42,
> > +	BMI270_REG_INIT_CTRL = 0x59,
> > +	BMI270_REG_INIT_DATA = 0x5e,
> > +	BMI270_REG_PWR_CONF = 0x7c,
> > +	BMI270_REG_PWR_CTRL = 0x7d,
> > +};
> 
> > +static int bmi270_get_data(struct bmi270_data *bmi270_device,
> > +			   int chan_type, int axis, int *val)
> > +{
> > +	__le16 sample;
> > +	int reg;
> > +
> > +	switch (chan_type) {
> > +	case IIO_ACCEL:
> > +		reg = 0xc + (axis - IIO_MOD_X) * sizeof(sample);
> 
> 0xc and 0x12 are magic values, give them names via defines.
> I assume they are the x access data registers.
> 

Will fix in v3!

> > +		break;
> > +	case IIO_ANGL_VEL:
> > +		reg = 0x12 + (axis - IIO_MOD_X) * sizeof(sample);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
> check for an error return.
> 

Will fix in v3!

> It's fine with i2c to use a buffer on the stack (as it bounce buffers
> everything) but keep in mind that regmap in general doesn't guarantee that
> (even it happens to be the case today) so when you add SPI this will need
> to be a DMA safe buffer.  Either allocate one on the heap, or embed one
> marked __aligned(IIO_DMA_MINALIGN) at the end of your iio_priv() structure.
> 
> Note you only need to do this once you add spi support.
> 

Will make note of this for upcoming SPI support.

> > +	*val = sign_extend32(le16_to_cpu(sample), 15);
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmi270_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		bmi270_get_data(bmi270_device, chan->type, chan->channel2, val);
> 
> Check for error return and pass it on if there is one.
> 

Will fix in v3.

> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> unreachable code. Drop this last return.
> 

Will fix in v3.

> > +}
> > +
> > +static const struct iio_info bmi270_info = {
> > +	.read_raw = bmi270_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec bmi270_channels[] = {
> > +	{
> > +		.type = IIO_ACCEL,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_X,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_ACCEL_X,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> > +		},
> > +	},
> > +	{
> > +		.type = IIO_ACCEL,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_Y,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_ACCEL_Y,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> > +		},
> > +	},
> > +	{
> > +		.type = IIO_ACCEL,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_Z,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_ACCEL_Z,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> > +		},
> > +	},
> > +	{
> > +		.type = IIO_ANGL_VEL,
> 
> Perhaps a macro given 3 instances that only differ in _X _Y _Z.
> And another one for the acceleration channels.
> 
> 

Will create macro in v3.

> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_X,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_GYRO_X,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> > +		},
> > +	},
> > +	{
> > +		.type = IIO_ANGL_VEL,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_Y,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_GYRO_Y,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> > +		},
> > +
> > +	},
> > +	{
> > +		.type = IIO_ANGL_VEL,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_Z,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_FREQUENCY),
> > +		.scan_index = BMI270_SCAN_GYRO_Z,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_LE,
> 
> Until you add support for the buffer, scan_index and scan_type should be
> at least mostly irrelevant. If you aren't using them for something else, don't
> set them until the patch where you add buffer support.
> 

Will drop in v3.

> > +		},
> > +	},
> > +};
> > +
> > +static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
> > +{
> > +	int chip_id;
> > +	int ret;
> > +	struct device *dev = bmi270_device->dev;
> > +	struct regmap *regmap = bmi270_device->regmap;
> > +
> > +	ret = regmap_read(regmap, BMI270_REG_CHIP_ID, &chip_id);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read chip id");
> > +
> > +	if (chip_id != BMI270_CHIP_ID)
> > +		return dev_err_probe(dev, -ENODEV, "Invalid chip id");
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmi270_write_init_data(struct bmi270_data *bmi270_device)
> Consider renaming.  Perhaps bmi270_write_calibration_data()
> or something like that?
> 

Will rename in v3.

> > +{
> > +	int pwr_conf = 0;
> > +	int ret;
> > +	int status = 0;
> > +	const struct firmware *init_data;
> > +	struct device *dev = bmi270_device->dev;
> > +	struct regmap *regmap = bmi270_device->regmap;
> > +
> > +	ret = regmap_read(regmap, BMI270_REG_PWR_CONF, &pwr_conf);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read power configuration");
> > +
> > +	pwr_conf &=  0xfffffffe;
> 
> Probably define that as ~BIT(0) plus give it a name as that's not obvious.
> regmap_clear_bits() would be cleaner for clearing just one bit.
> 

Will use regmap_clear_bits() in v3.

> > +	ret = regmap_write(regmap, BMI270_REG_PWR_CONF, pwr_conf);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to write power configuration");
> > +
> > +	usleep_range(450, 1000);
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_INIT_CTRL, 0x0);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to prepare device to load init data");
> > +
> > +	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to load init data file");
> > +
> > +	ret = regmap_bulk_write(regmap, BMI270_REG_INIT_DATA,
> > +				init_data->data, init_data->size);
> > +	release_firmware(init_data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to write init data");
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_INIT_CTRL, 0x1);
> Give that bit a define even if it's the only one in the register.
> 

Will do in v3.

> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to stop device initialization");
> > +
> > +	usleep_range(20000, 55000);
> > +
> > +	ret = regmap_read(regmap, BMI270_REG_INTERNAL_STATUS, &status);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read internal status");
> > +
> > +	if (status != 1)
> 
> Define even for that 1.  It must mean something?
> 

Will define in v3.

> > +		return dev_err_probe(dev, -ENODEV, "Device failed to initialize");
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
> > +{
> > +	int ret;
> > +	struct device *dev = bmi270_device->dev;
> > +	struct regmap *regmap = bmi270_device->regmap;
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_PWR_CTRL, 0x0e);
> 
> Magic register values. Assuming you know what these break down into
> please add the defines for each field so see can see what is
> being controlled by each write.
> 

Will define in v3.

> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_ACC_CONF, 0xa8);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_GYR_CONF, 0xa9);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
> > +
> > +	ret = regmap_write(regmap, BMI270_REG_PWR_CONF, 0x02);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to set power configuration");
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmi270_chip_init(struct bmi270_data *bmi270_device)
> > +{
> > +	int ret;
> > +
> > +	ret = bmi270_validate_chip_id(bmi270_device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = bmi270_write_init_data(bmi270_device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = bmi270_configure_imu(bmi270_device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> 	return bmi270_configure_imu()
> saves a few lines for no significant loss of readability.
> 

Will do in v3.

> > +}
> > +
> > +int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> > +		      const char *name, bool use_spi)
> 
> Drop the use_spi parameter. That isn't relevant yet (and may never be!)
> 

Will do in v3.

> > +{
> > +	int ret;
> > +	struct bmi270_data *bmi270_device;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct bmi270_data *));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	bmi270_device = iio_priv(indio_dev);
> > +	bmi270_device->dev = dev;
> > +	bmi270_device->regmap = regmap;
> > +
> > +	dev_set_drvdata(dev, indio_dev);
> Is this ever used? If not, don't set it.
> 

Will drop in v3.

> > +
> > +	ret = bmi270_chip_init(bmi270_device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->channels = bmi270_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
> > +	indio_dev->name = name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &bmi270_info;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(bmi270_core_probe, IIO_BMI270);
> > +
> > +MODULE_AUTHOR("Alex Lanzano");
> > +MODULE_DESCRIPTION("BMI270 driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > new file mode 100644
> > index 000000000000..2a18c3af92d2
> > --- /dev/null
> > +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> 
> mod_devicetable.h
> 

Will add in v3.

> > +#include <linux/regmap.h>
> > +
> > +#include "bmi270.h"
> > +
> > +static int bmi270_i2c_probe(struct i2c_client *client)
> > +{
> > +	const char *name;
> > +	struct regmap *regmap;
> > +	struct device *dev = &client->dev;
> > +	const struct i2c_device_id *id;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "Failed to init i2c regmap");
> > +	}
> 
> No {} needed around a single statement like this.
> 

Will fix in v3.

> > +
> > +	id = i2c_client_get_device_id(client);
> 
> For modern drivers, should only need to get the associated data
> and i2c_get_match_data() deals with various firmware types.
> You only need that once multiple chips are supported.
> For now there should be no reason to query this.
> 

Will drop in v3.

> > +	if (id)
> > +		name = id->name;
> > +	else
> > +		name = dev_name(dev);
> 
> Until the driver supports multiple devices, hardcode this
> in the core code as "bmi270"
> 
> When multiple parts are supported, use a chip type specific
> structure with a const char * in it.
> naming via id->name or dev_name and similar tends to give
> unstable results that aren't always the part number of the
> device.
> 

Will hardcode this in v3.

> > +
> > +	return bmi270_core_probe(dev, regmap, name, false);
> > +}
> > +
> > +static const struct i2c_device_id bmi270_i2c_id[] = {
> > +	{"bmi270", 0},
> > +	{}
> > +};
> > +
> > +static const struct of_device_id bmi270_of_match[] = {
> > +	{.compatible = "bosch,bmi270"},
> > +	{},
> Preferred style (I'm slowly tidying this up across IIO) is
> 	{ .compatible = "bosch,bmi270" },
> 	{ }
> 
> So spaces and no comma after terminator as we never want to
> add anything after that.
> Applies to other similar cases.
> 

Will fix in v3!

> > +};
> 
> 

Thanks for the review! Will fix this up and resend!

Best regards,
Alex

