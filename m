Return-Path: <linux-iio+bounces-24514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0EBA6B6A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3F3AD12E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4A1D7984;
	Sun, 28 Sep 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRth4uvt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F8233136;
	Sun, 28 Sep 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048235; cv=none; b=n6g4BSCo+IV7ILOhx/W+rVhzB30eeP1X3A76Xt0zEeKrF12KH68Rg11kXWWrWZrDYUmqh53GFI3dZnvo2JaW+om5GxDvN0Bv9/63GoF38GKjv42TzscZWWH8SEwe3uDUYijibQgfQ7DUiETmJ5QDVZMQWztJO2F5Bw7iQZ/9daM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048235; c=relaxed/simple;
	bh=GMKC96tBhh8BbSxjp97CncZ4AG2zr2v2pDiVFBNdiXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhRU7wVLvhLkGSpKTEEKXKli1+Sy3ZN59Wra4aJnO939IFWnWOKNWquJpm0DVvhata7p4RkYgs8IP1UjlUKYc6CQ+7wIA24L0a93K9IHwivz0ljnZUwU8yk0UikuqF1fbMYiE5M893+Fwx9p77zx8M2k2Oo+0F5tOsnYsdRfT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRth4uvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6FFC4CEF0;
	Sun, 28 Sep 2025 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759048235;
	bh=GMKC96tBhh8BbSxjp97CncZ4AG2zr2v2pDiVFBNdiXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRth4uvtTfYhFnlOwi2b4sWyak1UL8Gs9PC+43Khq+mki1d43bVRwzINtK+wB20qx
	 xOasy5sRa/PD49CTXisBzz7V4zBKzb/gDrhWy3+11pXDXB0MpKdp2OJGm0y/qCyBeX
	 pRUSWRZwttaTy9orVPXY1sAZ2CfQQFZQSMqDx4f1K0ROytwnSJ0vWRKPhffxhqIWVS
	 mjW9ETRVwu42/vXcOaPLz/nqnHKweYNaDkzKJWJ0jz16Dqq6J/F2yCdG3NASQXQagk
	 M4bjO3KNM+31ydN9shIvOL4RxzMdepEJcZU6NRWgcL6Bc2iDbFcfPsKije7qu3wh6B
	 SGJp0B4pEoANA==
Date: Sun, 28 Sep 2025 09:30:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250928093000.6753d920@jic23-huawei>
In-Reply-To: <20250924-add_newport_driver-v6-2-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-2-76687b9d8a6e@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:23:55 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Core component of a new driver for InvenSense ICM-45600 devices.
> It includes registers definition, main probe/setup, and device
> utility functions.
> 
> ICM-456xx devices are latest generation of 6-axis IMU,
> gyroscope+accelerometer and temperature sensor. This device
> includes a 8K FIFO, supports I2C/I3C/SPI, and provides
> intelligent motion features like pedometer, tilt detection,
> and tap detection.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Hi Remi,

Just a few really minor things from a fresh read through.
Given the request for a commit message change on the DT that is slightly
beyond what I'd normally just tweak whilst applying I think we'll have
a v7 anyway, so if you could tidy these up that would be great.
We are very early in this cycle anyway, so I'm not inclined to rush!

Jonathan

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..04f04c72e1710efde0ab8e83f9ce26d28e102c9b
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -0,0 +1,623 @@



> +u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr)
> +{
> +	static const u32 odr_periods[INV_ICM45600_ODR_MAX] = {
> +		0,		/* reserved value */
> +		0,		/* reserved value */
> +		0,		/* reserved value */

I'd preferred this done with the enum values.
	[INV_ICM45600_ODR_6400HZ_LN] = 156250,
etc and just a comment to say there are some reserved initial values.
that way we don't have to compare the comments with the enum values to be sure
there isn't one missing etc.


> +		156250,		/* 6.4kHz */
> +		312500,		/* 3.2kHz */
> +		625000,		/* 1.6kHz */
> +		1250000,	/* 800kHz */
> +		2500000,	/* 400Hz */
> +		5000000,	/* 200Hz */
> +		10000000,	/* 100Hz */
> +		20000000,	/* 50Hz */
> +		40000000,	/* 25Hz */
> +		80000000,	/* 12.5Hz */
> +		160000000,	/* 6.25Hz */
> +		320000000,	/* 3.125Hz */
> +		640000000,	/* 1.5625Hz */
> +	};
> +
> +	return odr_periods[odr];
> +}

> +
> +/**
> + *  inv_icm45600_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @chip_info:	detected chip description
> + *  @reset:	define whether a reset is required or not
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns: 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm45600_setup(struct inv_icm45600_state *st,
> +				const struct inv_icm45600_chip_info *chip_info,
> +				bool reset, inv_icm45600_bus_setup bus_setup)
> +{
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	/* Set chip bus configuration if specified. */
> +	if (bus_setup) {
> +		ret = bus_setup(st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Check chip self-identification value. */
> +	ret = regmap_read(st->map, INV_ICM45600_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +	if (val != chip_info->whoami) {
> +		/*
> +		 * SPI interface has no ack mechanism.
> +		 * 0xFF or 0x00 wwhoami means no response from the device.
whoami?

> +		 */
> +		if (val == U8_MAX || val == 0)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Invalid whoami %#02x expected %#02x (%s)\n",
> +					     val, chip_info->whoami, chip_info->name);
> +
> +		dev_warn(dev, "Unexpected whoami %#02x expected %#02x (%s)\n",
> +			 val, chip_info->whoami, chip_info->name);
> +	}
> +
> +	st->chip_info = chip_info;
> +
> +	if (reset) {
> +		/* Reset previous state. */
> +		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
> +				   INV_ICM45600_MISC2_SOFT_RESET);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * IMU reset time.
> +		 * Datasheet: 16.84 REG_MISC2
> +		 */
> +		fsleep(USEC_PER_MSEC);
> +
> +		if (bus_setup) {
> +			ret = bus_setup(st);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_read(st->map, INV_ICM45600_REG_INT_STATUS, &val);
> +		if (ret)
> +			return ret;
> +		if (!(val & INV_ICM45600_INT_STATUS_RESET_DONE)) {
> +			dev_err(dev, "reset error, reset done bit not set\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return inv_icm45600_set_conf(st, chip_info->conf);
> +}



> +
> +/* Runtime suspend will turn off sensors that are enabled by iio devices. */
> +static int inv_icm45600_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* disable all sensors */
> +	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
> +					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
> +	if (ret)
> +		return ret;
> +
> +	regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}
> +
> +/* Sensors are enabled by iio devices, no need to turn them back on here. */
> +static int inv_icm45600_runtime_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&st->lock);

Trivial but why is the lock needed?  I'm fairly sure nothing can race
with this regulator getting reenabled.

I guess, given you are holding the lock in the suspend path across regulator
disable this is reasonable for balance if not strictly needed.
So leave this if you like.

> +
> +	return inv_icm45600_enable_regulator_vddio(st);
> +}
> +
> +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
> +	SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
> +	RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
> +			   inv_icm45600_runtime_resume, NULL)
> +};
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-456xx device driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
> 


