Return-Path: <linux-iio+bounces-21779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B64DB0B107
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 19:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E435AA1FB4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D092882BC;
	Sat, 19 Jul 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCL31juy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6986352;
	Sat, 19 Jul 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945198; cv=none; b=kXmzReeQJXvvtAnXE1Gh7pwENhcHG47HV2bBtquYwA0qvwGGW/Up17hGr7S6Un6EP4AG0MHUa3BeioDGRmgLot7uQj9W4Arh/yphSY1Zhjdgj5WC/4dvGpguQ1zntC6m58icb5RcnjgURLUK+RVP6kaYJNEvGAFLe6rLXwLxe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945198; c=relaxed/simple;
	bh=1Jar+Yx49EFElUCCKG9zjE7yeAM24bhqG28+S0W1bI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLzt7fechG3IrDNyXaW+u1aKLooVyM4pFfd6LvAXyxbap2yfNq/GKawJgYBRMPVAKd+cShZ4xUw60gJcjwlIN7Aoae3VpBokj5L0Wln+oxP+BSxwvYvlhRf3oFm3GuZ4r1057D3PvEICPTS6R1PLKyHt7VL3MuD4UI5ivuL/VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCL31juy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB75CC4CEE3;
	Sat, 19 Jul 2025 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752945196;
	bh=1Jar+Yx49EFElUCCKG9zjE7yeAM24bhqG28+S0W1bI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCL31juyFkSmc/xTAEGowsSChS17KgEmckdBD7luj8Q0zbARyKSeoGKbnt2K0Os2M
	 Bl0tZGHpQ8hhVOruzeYSC1wNULW6IFeBtJ/Fqa45g31BVWuTSQvyF6jsj7LfwS9pza
	 LuuhABjIH9tv5bIRh+uBK9cRUFYs+aNOaN/xivlPkNAcq86zMKP2qnx9obMb9AjGNg
	 VrohOssZ05BohG5ToVhOSbh1Dxs9NbVkhpwvVxqX1u3mpZaN/xzfOVLtZgtu7I/WeR
	 mihETWrm69BGr+8A6MdjzUg0UQqyyD8cJYikygKsnuaX2NYCMU84oJ6dUDry8YmYd0
	 Hc7KolDO3XLdg==
Date: Sat, 19 Jul 2025 18:13:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, arthur.becker@sentec.com,
 perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
 muditsharma.info@gmail.com, clamor95@gmail.com, emil.gedenryd@axis.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250719181305.738641cb@jic23-huawei>
In-Reply-To: <20250715085810.7679-3-ak@it-klinger.de>
References: <20250715085810.7679-1-ak@it-klinger.de>
	<20250715085810.7679-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 10:58:09 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
A few minor things inline.  We are now at the point where anything other than
fixes is 6.18 material so no great rush.

> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
> new file mode 100644
> index 000000000000..bad4bd7f3f3f
> --- /dev/null
> +++ b/drivers/iio/light/veml6046x00.c
> @@ -0,0 +1,1037 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6046X00 High Accuracy RGBIR Color Sensor
> + *
> + * Copyright (c) 2025 Andreas Klinger <ak@it-klinger.de>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Check these includes.  This one for example is only use for custom
attributes and you don't seem to have any.

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>


> +
> +static int veml6046x00_single_read(struct iio_dev *iio,
> +				   enum iio_modifier modifier, int *val)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int addr, it_usec;
> +	int ret;
> +	__le16 reg;
> +
> +	switch (modifier) {
> +	case IIO_MOD_LIGHT_RED:
> +		addr = VEML6046X00_REG_R;
> +		break;
> +	case IIO_MOD_LIGHT_GREEN:
> +		addr = VEML6046X00_REG_G;
> +		break;
> +	case IIO_MOD_LIGHT_BLUE:
> +		addr = VEML6046X00_REG_B;
> +		break;
> +	case IIO_MOD_LIGHT_IR:
> +		addr = VEML6046X00_REG_IR;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = pm_runtime_resume_and_get(dev);

Will be interesting to consider the new ACQUIRE stuff that will (I think)
hit cleanup.h in the new cycle can be applied to runtime pm.
Note I'm not asking for a change, but more saying I might look into updating
this code during the next cycle.

> +	if (ret)
> +		return ret;
> +
> +	ret = veml6046x00_get_it_usec(data, &it_usec);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get integration time ret: %d", ret);
> +		goto no_data;
> +	}
> +
> +	ret = regmap_field_write(data->rf.mode, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed to write mode ret: %d", ret);
> +		goto no_data;

I'm struggling a bit with why these error paths result in the
runtime pm calls, but some below do not.  Seems to be a lack
of consistency that will leave missbalanced counts.


> +	}
> +
> +	ret = regmap_field_write(data->rf.trig, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed to write trigger ret: %d", ret);
> +		goto no_data;
> +	}
> +
> +	/* integration time + 12.5 % to ensure completion */
> +	fsleep(it_usec + it_usec / 8);
> +
> +	ret = veml6046x00_wait_data_available(iio, it_usec * 4);
> +	if (ret < 0)
here for example.

> +		return ret;
> +	if (ret == 0)
> +		return -EAGAIN;
> +
> +	if (!iio_device_claim_direct(iio))
> +		return -EBUSY;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	iio_device_release_direct(iio);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	*val = le16_to_cpu(reg);
> +
> +	return IIO_VAL_INT;
> +
> +no_data:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return -EAGAIN;
> +}



> +static int veml6046x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6046x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6046x00_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to set regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	/* struct iio_dev is retrieved via get_drv_data(). */

dev_get_drvdata()

> +	i2c_set_clientdata(i2c, iio);
> +	data->regmap = regmap;

> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6046x00_trig_handler,
> +					      &veml6046x00_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer");
> +
> +	pm_runtime_mark_last_busy(dev);

Given this will now merge after 6.17-rc1 you could drop this as now incorporated
in the next call. It's harmless and I'll hopefully remember to tweak all code
for next cycle that has pm_runtime_mark_last_busy() in it.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	return 0;
> +}


