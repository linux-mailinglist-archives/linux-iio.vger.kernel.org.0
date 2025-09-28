Return-Path: <linux-iio+bounces-24515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F332BA6BC6
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0D617CA06
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CF2BE035;
	Sun, 28 Sep 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1aC0e7S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E882248AF;
	Sun, 28 Sep 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049134; cv=none; b=cQIOr/Lr1A1pEyXWpnQzAA3LJy1a9jLPBYCQUv07FRK2ol10iAiC+mN/QCXu8t5XFazCc33d5BirzVndG3tDO/pDfmz1QCRNVvERhMpIGP/oO2qGr1kCAip1Pfvp2mXOr5GtOkrSFtess61966guvIIe1TpfuEDkg/o0GyudfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049134; c=relaxed/simple;
	bh=6+lWkXIDs83yxVt9205UmMQwnhaToNASPxoh0v8cq1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZIke//UhFF1sTDB5L8uNU0XatgOngfhR8KWB593zvDQk82AqauLvKpeXuybXPpRwuWDV9imjYGAPS29MWz2pfLdxF9zbT6D4Y8kRP1d1mVxd7WJ7GV863c+uNf8+SIS3x3RcRK1Ge/YUYYo7B1uEOXsvfyV73uJ0oG5YqvVfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1aC0e7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17156C4CEF0;
	Sun, 28 Sep 2025 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759049134;
	bh=6+lWkXIDs83yxVt9205UmMQwnhaToNASPxoh0v8cq1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1aC0e7Si4iOf2qZrbsLw1sSiN2EOikX9267mqstsPDAgDHsvmn66hSCrJMc4eCuF
	 DgyGrcjDD6LUe5Pg4MhV+kIVHcyppYRYFYoo2Vtr83xwc6xMPvZzWH9K+LMRjwhNDz
	 pQJhCozQNKna5MveUKSzxhmwK1lGIbPKZXaz/xqoVmRVA+9o8wzj6VkIKgO0KSb+hA
	 Hi9OLN9gqZ/65Y3lTDAAeB45jOYoVhpILUZXfjRDXuFsUYjvYpQHHx/uYBw63Hp+lw
	 mQ8rRKJ/ESHW4prPnYd75rDvx4ZjVS8hbv5pK8McfsIIVxuzkWHekUK1CjmDPb3D37
	 +L5J2OtuJynyw==
Date: Sun, 28 Sep 2025 09:45:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/9] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250928094524.52d492a9@jic23-huawei>
In-Reply-To: <20250924-add_newport_driver-v6-3-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-3-76687b9d8a6e@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:23:56 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Hi Remi,

A few trivial things in here as well.

Jonathan

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> index 5f637e2f2ec8f1537459459dbb7e8a796d0ef7a6..aac8cd852c12cfba5331f2b7c1ffbbb2ed23d1c7 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -5,6 +5,7 @@
>  #define INV_ICM45600_H_
>  
>  #include <linux/bits.h>
> +#include <linux/limits.h>

Why this in the header?  Should be only needed in some of the c files I think
so push the include down there.

>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -14,6 +15,8 @@
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  #include <linux/iio/iio.h>
>  
> +#include "inv_icm45600_buffer.h"
> +
>  #define INV_ICM45600_REG_BANK_MASK	GENMASK(15, 8)
>  #define INV_ICM45600_REG_ADDR_MASK	GENMASK(7, 0)
>  
> @@ -94,6 +97,8 @@ struct inv_icm45600_sensor_conf {
>  	u8 filter;
>  };
>  
> +#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES { U8_MAX, U8_MAX, U8_MAX, U8_MAX }
> +
>  struct inv_icm45600_conf {
>  	struct inv_icm45600_sensor_conf gyro;
>  	struct inv_icm45600_sensor_conf accel;
> @@ -122,6 +127,7 @@ struct inv_icm45600_chip_info {
>   *  @indio_accel:	accelerometer IIO device.
>   *  @chip_info:		chip driver data.
>   *  @timestamp:		interrupt timestamps.
> + *  @fifo:		FIFO management structure.
>   *  @buffer:		data transfer buffer aligned for DMA.
>   */
>  struct inv_icm45600_state {
> @@ -138,6 +144,7 @@ struct inv_icm45600_state {
>  		s64 gyro;
>  		s64 accel;
>  	} timestamp;
> +	struct inv_icm45600_fifo fifo;
>  	union {
>  		u8 buff[2];
>  		__le16 u16;
> @@ -190,6 +197,7 @@ struct inv_icm45600_sensor_state {
>  #define INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS		0
>  #define INV_ICM45600_FIFO_CONFIG0_MODE_STREAM		1
>  #define INV_ICM45600_FIFO_CONFIG0_MODE_STOP_ON_FULL	2
> +#define INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MASK	GENMASK(5, 0)
>  #define INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX	0x1F
>  
>  #define INV_ICM45600_REG_FIFO_CONFIG2			0x0020
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f81a85c5c77a0b0bc729734a1256af0c896c8fbd
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2025 Invensense, Inc. */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm45600_buffer.h"
> +#include "inv_icm45600.h"
> +
> +/* FIFO header: 1 byte */
> +#define INV_ICM45600_FIFO_EXT_HEADER		BIT(7)
> +#define INV_ICM45600_FIFO_HEADER_ACCEL		BIT(6)
> +#define INV_ICM45600_FIFO_HEADER_GYRO		BIT(5)
> +#define INV_ICM45600_FIFO_HEADER_HIGH_RES	BIT(4)
> +#define INV_ICM45600_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
> +#define INV_ICM45600_FIFO_HEADER_ODR_ACCEL	BIT(1)
> +#define INV_ICM45600_FIFO_HEADER_ODR_GYRO	BIT(0)
> +
> +struct inv_icm45600_fifo_1sensor_packet {
> +	u8 header;
> +	struct inv_icm45600_fifo_sensor_data data;
> +	s8 temp;
> +} __packed;
> +
> +struct inv_icm45600_fifo_2sensors_packet {
> +	u8 header;
> +	struct inv_icm45600_fifo_sensor_data accel;
> +	struct inv_icm45600_fifo_sensor_data gyro;
> +	s8 temp;
> +	__le16 timestamp;
> +} __packed;


> +
> +int inv_icm45600_buffer_set_fifo_en(struct inv_icm45600_state *st,
> +				    unsigned int fifo_en)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	mask = INV_ICM45600_FIFO_CONFIG3_GYRO_EN |
> +	       INV_ICM45600_FIFO_CONFIG3_ACCEL_EN;
> +
> +	if ((fifo_en & INV_ICM45600_SENSOR_GYRO) || (fifo_en & INV_ICM45600_SENSOR_ACCEL))
> +		val = (INV_ICM45600_FIFO_CONFIG3_GYRO_EN | INV_ICM45600_FIFO_CONFIG3_ACCEL_EN);
maybe val = mask;?
> +	else
> +		val = 0;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3, mask, val);
Could use
	ret = regmap_assign_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3, mask,
				 (fifo_en & INV_ICM45600_SENSOR_GYRO) ||
				 (fifo_en & INV_ICM45600_SENSOR_ACCEL));

or something like.
	if ((fifo_en & INV_ICM45600_SENSOR_GYRO) || (fifo_en & INV_ICM45600_SENSOR_ACCEL))
		ret = regmap_set_bits(st->map, INV_IC..., mask);
	else
		ret = regmap_clear_bits();

Anyhow, up to you onthis one as none of the options look perfect to me.

> +	if (ret)
> +		return ret;
> +
> +	st->fifo.en = fifo_en;
> +	inv_icm45600_buffer_update_fifo_period(st);
> +
> +	return 0;
> +}



> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0c8caa8287dd4373cf11bb6c7b913a6c49e9eee5
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h

> +
> +/**
> + * struct inv_icm45600_fifo - FIFO state variables
> + * @on:		reference counter for FIFO on.
> + * @en:		bits field of INV_ICM45600_SENSOR_* for FIFO EN bits.
> + * @period:	FIFO internal period.
> + * @watermark:	watermark configuration values for accel and gyro.
Given the contents of this to me look like things to also document.e
 * @watermark.gyro:	....
etc as well would be good to add

> + * @count:	number of bytes in the FIFO data buffer.
> + * @nb:		gyro, accel and total samples in the FIFO data buffer.

This is more obvious.  Check if the kernel-doc script minds these subfields not
being defined.  If it does, add a the trivial documentation just to squash warnings
and make it easier to spot real issues.

> + * @data:	FIFO data buffer aligned for DMA (8kB)
> + */
> +struct inv_icm45600_fifo {
> +	unsigned int on;
> +	unsigned int en;
> +	u32 period;
> +	struct {
> +		unsigned int gyro;
> +		unsigned int accel;
> +		unsigned int eff_gyro;
> +		unsigned int eff_accel;
> +	} watermark;
> +	size_t count;
> +	struct {
> +		size_t gyro;
> +		size_t accel;
> +		size_t total;
> +	} nb;
> +	u8 *data;

> +				     unsigned int count);
> +
> +#endif



