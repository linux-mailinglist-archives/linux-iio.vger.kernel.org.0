Return-Path: <linux-iio+bounces-24711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC74BB8E54
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42CD24E6AEE
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05591AA7A6;
	Sat,  4 Oct 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr5RXBGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D7CA4E;
	Sat,  4 Oct 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586136; cv=none; b=FODq/shoJGpfcl/G4OrEvCX16+ypAvM8BsPdqhnzN6QxQMboktGXEQtzCUJ5pTD5HkvGYw+cmfe93iN5AkGS1gc+y3P0xnFOrPtuG2yJXqw4TGu8YSfOqfzMPulxZJVr+otI6EG7JDrHrfyUIpg1dHrYMvGG/372r0qxZXpHoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586136; c=relaxed/simple;
	bh=0lcJTwiDz+X5ZWqWVnKnnPVH3k879M0u6FIgY+6M3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dxy3y99nfnvb4bm1QbviG2SEeyXC9LL39UzEPZ8auYfDrjybX8whU59i5O0lF8uEkS2nwN5YJ0HWuvKfMawogasZDNX2DLez33qFOjvSlMfg5yxS26BvNlUpFOXETUgOOj3C2FfwPsoRYJwmvoiqmAITRIWvBlIHKRWBl73qQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr5RXBGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A9FC4CEF1;
	Sat,  4 Oct 2025 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759586136;
	bh=0lcJTwiDz+X5ZWqWVnKnnPVH3k879M0u6FIgY+6M3nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vr5RXBGBKmPAjhB2fOd2nyGLYarow+Idh9wjEA37mP0o2UpHkIuD/ypI08FerBVoR
	 cX9jDWEGOG3iaEO332NXJVnXFCDgNtBTgKVboOocWHeKj7qizouAMlZQolWRwHU8iC
	 qqdnPtst5BJFgHeOri2OBlea6A/wppilobDxW0dzBzkc+gNvKFFhRda6/T7jWctj74
	 xBZBDIwocMaEJg0l0MjX4InMY6UXzTcTZb+OnFYsTfiPNl762SQTM/Wl8pMzmf6bdm
	 AOR31iktVqLX6sgv+joA0wKw7Su2086vp70U8qm6Iiw/RDjAzXSzo8L4KdG6/BdeGe
	 gbIl4DD5U56wA==
Date: Sat, 4 Oct 2025 14:55:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Carlos Song
 <carlos.song@nxp.com>
Subject: Re: [PATCH v3 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251004145526.13224aaf@jic23-huawei>
In-Reply-To: <20250930-i3c_ddr-v3-5-b627dc2ef172@nxp.com>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
	<20250930-i3c_ddr-v3-5-b627dc2ef172@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 15:34:24 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Hi Frank,

A few more minor things inline.

Thanks,

Jonathan

> ---
> Change in v3
> - remove mmc5633_hw_set
> - make -> Make
> - change indention for mmc5633_samp_freq
> - use u8 arrary to handle dword data
> - get_unaligned_be16() to get raw data
> - add helper function to check if i3c support hdr
> - use read_avail() callback
> 
> change in v2
> - new patch

> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..bcd79ab6053d50026961f7cf9da296c30c720399
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5633.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMC5633 - MEMSIC 3-axis Magnetic Sensor
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + * Copyright (c) 2025, NXP
> + *
> + * IIO driver for MMC5633, base on mmc35240.c
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>
> +
> +#define MMC5633_REG_XOUT_L	0x00
> +#define MMC5633_REG_XOUT_H	0x01
> +#define MMC5633_REG_YOUT_L	0x02
> +#define MMC5633_REG_YOUT_H	0x03
> +#define MMC5633_REG_ZOUT_L	0x04
> +#define MMC5633_REG_ZOUT_H	0x05
> +#define MMC5633_REG_XOUT_2	0x06
> +#define MMC5633_REG_YOUT_2	0x07
> +#define MMC5633_REG_ZOUT_2	0x08
> +
> +#define MMC5633_REG_STATUS1	0x18
> +#define MMC5633_REG_STATUS0	0x19
> +#define MMC5633_REG_CTRL0	0x1b
> +#define MMC5633_REG_CTRL1	0x1c
> +#define MMC5633_REG_CTRL2	0x1d
> +
> +#define MMC5633_REG_ID		0x39
> +
> +#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
> +
> +#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
> +#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
> +#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
> +#define MMC5633_CTRL0_RESET		BIT(4)
> +#define MMC5633_CTRL0_SET		BIT(3)
> +#define MMC5633_CTRL0_MEAS_T		BIT(1)
> +#define MMC5633_CTRL0_MEAS_M		BIT(0)
> +
> +#define MMC5633_CTRL1_BW0_BIT		BIT(0)
> +#define MMC5633_CTRL1_BW1_BIT		BIT(1)

Drop these and

> +
> +#define MMC5633_CTRL1_BW_MASK		(MMC5633_CTRL1_BW0_BIT | \
> +					 MMC5633_CTRL1_BW1_BIT)

use GENMASK(1, 0) here

> +
> +#define MMC5633_WAIT_CHARGE_PUMP	50000	/* us */

Name them so the unit is in the define and then you don't need
the comment + we can see the unit where they are used.
*PUMP_USECS for example

> +#define MMC5633_WAIT_SET_RESET		1000	/* us */
> +
> +#define MMC5633_HDR_CTRL0_MEAS_M	0x01
> +#define MMC5633_HDR_CTRL0_MEAS_T	0x03
> +#define MMC5633_HDR_CTRL0_SET		0X05
> +#define MMC5633_HDR_CTRL0_RESET		0x07
> +

> +static const struct {
> +	int val;
> +	int val2;
> +} mmc5633_samp_freq[] = {
> +	{1, 200000},
> +	{2, 0},
> +	{3, 500000},
> +	{6, 600000},

My preference for style in IIO is
	{ 1, 200000 },
	{ 2, 0 },
etc.

> +};


> +static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
> +{
> +	if (!data->i3cdev)
> +		return false;
> +
> +	return !!(i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR));
The !! isn't needed given assigning an integer to the bool will have same effect.
> +}



> +static const struct of_device_id mmc5633_of_match[] = {
> +	{ .compatible = "memsic,mmc5633", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mmc5633_of_match);
> +
> +static const struct i2c_device_id mmc5633_i2c_id[] = {
> +	{ "mmc5633" },
> +	{}
	{ }
Both for consistency and because I'm more broadly trying to standardize
on that formatting for IIO.

> +};
> +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> +
> +static struct i2c_driver mmc5633_i2c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i2c",
> +		.of_match_table = mmc5633_of_match,
> +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> +	},
> +	.probe	  = mmc5633_i2c_probe,
> +	.id_table       = mmc5633_i2c_id,

Mixture of tabs and spacing here.   I'd just use a single space
before the = and don't try to align them.

> +};

