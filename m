Return-Path: <linux-iio+bounces-21408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE38AFA698
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F3B177D1F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7901288C19;
	Sun,  6 Jul 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCE64bBB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF678F36;
	Sun,  6 Jul 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751820816; cv=none; b=TMRw4ipMONEsRT0AhSjgLYKrd1LEbaI/LnW5vuG7qBU5RKEocfc4hIk9f5NAYx01KSPQPJNHqzL3zSHm0A0Mdgg8/m//5x5uQ6LJFO2FEAbuPyhKisH8MHOG++1oPDUdorrFTgmlRaxfZ7X12Ohc+cDvdmeSDQdI+kuums1uFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751820816; c=relaxed/simple;
	bh=DEB05qdKlmb0vTcXEpUS9nkwAoDUX1PUMixHQmW6YFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8YeMnJO53qNXLOWK0R8L60KHFOcS0txPAAPQ1iOsHHgbV3S/YwJKEZ50WFF4k7N9aOgoyluZAdVO92J4w5dgGPC0T6734xrNfcePlgj8lu/UppwY+nAUD7Vcir9Kw+8MiL04eaySqZWoNqQObg87y6ZZjtBRkPXe11OLKXyIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCE64bBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC3CC4CEED;
	Sun,  6 Jul 2025 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751820816;
	bh=DEB05qdKlmb0vTcXEpUS9nkwAoDUX1PUMixHQmW6YFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bCE64bBB1nS6ziC8/mu5uv+jyqO65a0pNVVwCYUwxvo00zvTOst4fpKfYSonOt108
	 qIDlrFgECAoL0n1SUJVHkFf+K/fD2qZhP5x331S1aKuJa+xph+s0iiTjRmLenAzcMp
	 qmmDcfikXKKxabLCt2MdDtfhlQVq208OuamZnEjukETnHlTZucg5J33pBFGxsGEsJk
	 cNB8Sbl+0Vf1fhRPsCTrXNte4cMVMayGWy0NAKeSTE2eUVazOgfzxulXdMvXk0HL8m
	 Tqs3pDYwtD/OMjBsZRkjY+uP5u+RLI3TL4ZLu4az/91gHdHMDCs2PnUcoyApdQDi1j
	 2sIr/YaQVjSAw==
Date: Sun, 6 Jul 2025 17:53:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v3 2/2] iio: imu: smi330: Add driver
Message-ID: <20250706175328.7207d847@jic23-huawei>
In-Reply-To: <20250703153823.806073-3-Jianping.Shen@de.bosch.com>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 17:38:23 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> 
> Add the iio driver for bosch imu smi330. The smi330 is a combined
> three axis angular rate and three axis acceleration sensor.
> 
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
Hi Jianping,

This is coming together nicely.   A few things inline.

Jonathan


> diff --git a/drivers/iio/imu/smi330/smi330.h b/drivers/iio/imu/smi330/smi330.h
> new file mode 100644
> index 00000000000..bd896e86977
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#ifndef _SMI330_H
> +#define _SMI330_H
> +
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>

Where possible use forwards declarations and keep the include
to where it is needed.  e.g.
struct iio_trigger;
should be enough for this one.

> +
> +#define SMI330_NO_ERROR_MASK (BIT(2) | BIT(0))
> +#define SMI330_ST_SUCCESS_MASK GENMASK(6, 0)
> +
> +#define SMI330_ALL_CHAN_MSK GENMASK(6, 0)
> +
> +#define SMI330_CHIP_ID 0x42
> +
> +#define SMI330_SPI_WR_MASK GENMASK(6, 0)
> +#define SMI330_SPI_RD_MASK BIT(7)
> +
> +#define SMI330_SOFT_RESET_DELAY 2000
> +
> +/* Register map */
> +#define SMI330_CHIP_ID_REG 0x00


I missed this until now, but you have done a good job of keeping all registers
accesses etc to the core driver, not the i2c and spi parts.  As such
why do we need all these defines in the header?  Push them down into the
C file (a the top) and keep only those things needed by both bus drivers
and the core driver in the header.

> +#define SMI330_ERR_REG 0x01
> +#define SMI330_STATUS_REG 0x02
> +#define SMI330_ACCEL_X_REG 0x03

> +
> +int smi330_core_probe(struct device *dev, struct regmap *regmap);
> +
> +#endif /* _SMI330_H */
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> new file mode 100644
> index 00000000000..23e65c1ed64
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_core.c

> +
> +static irqreturn_t smi330_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct smi330_data *data = iio_priv(indio_dev);
> +	int ret, chan;
> +	int i = 0;
> +
> +	ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data->buf,
> +			       ARRAY_SIZE(smi330_channels));
> +	if (ret)
> +		goto out;
> +
> +	if (*indio_dev->active_scan_mask != SMI330_ALL_CHAN_MSK) {
> +		iio_for_each_active_channel(indio_dev, chan)
> +			data->buf[i++] = data->buf[chan];

If I follow this correctly you are reading all the channels and just copying
out the ones you want.  Just let the IIO core do that for you by setting
iio_dev->available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }; and push the
whole buffer every time.

The handling the core code is reasonably sophisticated and will use bulk
copying where appropriate.

If there is a strong reason to not use that, add a comment here so we don't
have anyone 'fix' this code in future.

> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +static int smi330_dev_init(struct smi330_data *data)
> +{
> +	int ret, chip_id, val, mode;
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	ret = regmap_read(data->regmap, SMI330_CHIP_ID_REG, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id &= 0x00FF;

Perhaps GENMASK(7, 0) for that - perhaps with a define associated with
the CHIP_ID_REG define as this is a register field. When you've done
that apply FIELD_GET() so we don't need to know it's the lowest bits
in the register.

> +
> +	if (chip_id != SMI330_CHIP_ID)
> +		dev_info(dev, "Unknown chip id: 0x%04x\n", chip_id);
> +
> +	ret = regmap_read(data->regmap, SMI330_ERR_REG, &val);
> +	if (ret)
> +		return ret;
> +	if (FIELD_GET(SMI330_ERR_FATAL_MASK, val))
> +		return -ENODEV;
> +
> +	ret = regmap_read(data->regmap, SMI330_STATUS_REG, &val);
> +	if (ret)
> +		return ret;
> +	if (FIELD_GET(SMI330_STATUS_POR_MASK, val) == 0)
> +		return -ENODEV;
> +
> +	mode = FIELD_PREP(SMI330_CFG_MODE_MASK, SMI330_MODE_NORMAL);
> +
> +	ret = regmap_update_bits(data->regmap, SMI330_ACCEL_CFG_REG,
> +				 SMI330_CFG_MODE_MASK, mode);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, SMI330_GYRO_CFG_REG,
> +				  SMI330_CFG_MODE_MASK, mode);
> +}


> diff --git a/drivers/iio/imu/smi330/smi330_i2c.c b/drivers/iio/imu/smi330/smi330_i2c.c
> new file mode 100644
> index 00000000000..76b88bbd7d2
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_i2c.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
As for spi driver below, drop this and include
mod_devicetable.h instead.

> +#include <linux/regmap.h>
> +
> +#include "smi330.h"
> +
> +#define SMI330_NUM_DUMMY_BYTES 2
> +#define SMI330_I2C_MAX_RX_BUFFER_SIZE \
> +	(SMI330_NUM_DUMMY_BYTES + SMI330_SCAN_LEN * sizeof(s16))
> +
> +struct smi330_i2c_priv {
> +	struct i2c_client *i2c;
> +	u8 rx_buffer[SMI330_I2C_MAX_RX_BUFFER_SIZE];
> +};
> +
> +static int smi330_regmap_i2c_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct smi330_i2c_priv *priv = context;
> +	int ret, retry;
> +
> +	/*
> +	 * SMI330 I2C read frame:
> +	 * <Slave address[6:0], RnW> <x, Register address[6:0]>
> +	 * <Slave address[6:0], RnW> <Dummy[7:0]> <Dummy[7:0]> <Data_0[7:0]> <Data_1[15:8]>...
> +	 *                                                     <Data_N[7:0]> <Data_N[15:8]>
> +	 * Remark: Slave address is not considered part of the frame in the following definitions
> +	 */
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = priv->i2c->addr,
> +			.flags = priv->i2c->flags,
> +			.len = reg_size,
> +			.buf = (u8 *)reg_buf,
> +		},
> +		{
> +			.addr = priv->i2c->addr,
> +			.flags = priv->i2c->flags | I2C_M_RD,
> +			.len = SMI330_NUM_DUMMY_BYTES + val_size,

It might be worth adding a sanity check in ehre that this is never more
than SMI330_I2C_MAX_RX_BUFFER_SIZE.
That is obviously true, but none the less a check may make it 'locally'
clear that we can rely on that.

> +			.buf = priv->rx_buffer,
> +		},
> +	};
> +
> +	ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(val_buf, priv->rx_buffer + SMI330_NUM_DUMMY_BYTES, val_size);
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/imu/smi330/smi330_spi.c b/drivers/iio/imu/smi330/smi330_spi.c
> new file mode 100644
> index 00000000000..5b5aaaf0c5d
> --- /dev/null
> +++ b/drivers/iio/imu/smi330/smi330_spi.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2025 Robert Bosch GmbH.
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>

There aren't any calls that you need of.h for in here. If there had been
I'd probably be telling you to user property.h but its very simple so
no problem not including either.

What you probably want is the id tables which are in
linux/mod_devicetable.h which you should include here.

> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "smi330.h"



