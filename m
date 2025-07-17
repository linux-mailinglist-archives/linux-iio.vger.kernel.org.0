Return-Path: <linux-iio+bounces-21750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74766B08F89
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A251169FE7
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125A2D9ED4;
	Thu, 17 Jul 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQn9RGXJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE114E2E2;
	Thu, 17 Jul 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762827; cv=none; b=VblbX6orLZQPY9Dx9Pp34yyfLDc4MQTGlwbrCDAWrNagrlk4bNYuUN63q0QpWpQs3lVpEE/E2IRF8zwNzv6G4nNY3IIhry6wly1agjLCwt5zKiwapXUSV/XUGgoYIxHvsqZqwQJFz/usvClNdSijF9ZQ+E7k3/u+fcdLmSEPCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762827; c=relaxed/simple;
	bh=Mk0mrvNVmTEaCN8UAAyUHUuZCbjlFslfuMdpYDLRRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuKD5Y9x3+IoO1YUqGoWxrEw5fHL9aVmWlF1YadeqsONxjdv7l3l3aHW4Ipneb6gJ03YHbra8t3FgohL0nKDB9g/Lh8WHaxM3ZMvDtVqvOD3hvG3Mxiy/6Ve1HNq8wpJuPBaqyVAjMjGY53BxxT/dSalEJtOtxjvMDbcAkBfILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQn9RGXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C57C4CEE3;
	Thu, 17 Jul 2025 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752762826;
	bh=Mk0mrvNVmTEaCN8UAAyUHUuZCbjlFslfuMdpYDLRRk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eQn9RGXJJzlTCY8n5Hzpn78jKktsYxS8YaVi/QTynhvoMmPkRQX0/BFw1DjDV656t
	 gWwvDq3RkzZ5OQFvLZmIiUODfOec5vf/+pq2Ukc8WiL2MFWD43Y0JDoq+OuQFoJHuv
	 cmPqg6AWa1Wio3rnRo54CnE1pBcI06lhonRUQhIIv1YrsrrmXMVv33/60vSVrPfOHu
	 2PZme5hBKREPM3XqssYC3fn1smSENKBRPH4Id57lXxZv8NSIa4800npOD0mnXMer0x
	 0xYUeCzTTC8IoySVo1Rkcskt9+vfjcNTdDZJzoHzstG5CDQ2rdGbMdMbKeNc5kS+ZS
	 Gz4XQmFbgEHhQ==
Date: Thu, 17 Jul 2025 15:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/8] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250717153340.33eb92b4@jic23-huawei>
In-Reply-To: <20250710-add_newport_driver-v2-3-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
	<20250710-add_newport_driver-v2-3-bf76d8142ef2@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:57:58 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Hi Remi,

Sorry for delay - hectic week.

Jonathan

> ---
>  drivers/iio/imu/inv_icm45600/Makefile              |   1 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        |   4 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 514 +++++++++++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |  99 ++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 137 +++++-
We used to do the buffer / core split a lot but it often ends up more trouble
that it is worth and we no longer make buffer support a build time option (which was
what motivated the separate files)  Consider how much simplification you'd get by squashing them into
one file.  

>  5 files changed, 754 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
> index 4f442b61896e91647c7947a044949792bae06a30..19c521ffba17b0d108a8ecb45ecdea35dff6fd18 100644
> --- a/drivers/iio/imu/inv_icm45600/Makefile
> +++ b/drivers/iio/imu/inv_icm45600/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
>  inv-icm45600-y += inv_icm45600_core.o
> +inv-icm45600-y += inv_icm45600_buffer.o
> \ No newline at end of file
Fix that.

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> index d56de75ab7f2168f22e25b5816cb361bef457c0d..0b97c54f74b30aef3842e34da098c2443347de00 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -10,6 +10,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/types.h>
>  
> +#include "inv_icm45600_buffer.h"
> +
>  #define INV_ICM45600_REG_BANK_MASK	GENMASK(15, 8)
>  #define INV_ICM45600_REG_ADDR_MASK	GENMASK(7, 0)
>  
> @@ -128,6 +130,7 @@ extern const struct inv_icm45600_chip_info inv_icm45689_chip_info;
>   *  @indio_gyro:	gyroscope IIO device.
>   *  @indio_accel:	accelerometer IIO device.
>   *  @timestamp:		interrupt timestamps.
> + *  @fifo:		FIFO management structure.
>   *  @buffer:		data transfer buffer aligned for DMA.
>   */
>  struct inv_icm45600_state {
> @@ -144,6 +147,7 @@ struct inv_icm45600_state {
>  		s64 gyro;
>  		s64 accel;
>  	} timestamp;
> +	struct inv_icm45600_fifo fifo;

This has a forced alignment at the end which is going to ensure the next bit
is pushed out a long way.  It it is possible to squash the definitions here
so we can see what is going on that would be good.

>  	union {
>  		u8 buff[2];
>  		__le16 u16;
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a07affa0e3c64f84330071c92018438882cdf686
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c

> +
> +struct inv_icm45600_fifo_1sensor_packet {
> +	u8 header;
> +	struct inv_icm45600_fifo_sensor_data data;
> +	s8 temp;
> +} __packed;
> +#define INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE		8
> +
> +struct inv_icm45600_fifo_2sensors_packet {
> +	u8 header;
> +	struct inv_icm45600_fifo_sensor_data accel;
> +	struct inv_icm45600_fifo_sensor_data gyro;
> +	s8 temp;
> +	__le16 timestamp;
> +} __packed;
> +#define INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE		16
This definition seems unnecessary given you have
	sizeof(struct inv_icm45600_fifo_2sensors_packet)
(or better yet sizeof(instance)) to use for it.




> +void inv_icm45600_buffer_update_fifo_period(struct inv_icm45600_state *st)
> +{
> +	u32 period_gyro, period_accel, period;
> +
> +	if (st->fifo.en & INV_ICM45600_SENSOR_GYRO)
> +		period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr);
> +	else
> +		period_gyro = U32_MAX;
> +
> +	if (st->fifo.en & INV_ICM45600_SENSOR_ACCEL)
> +		period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr);
> +	else
> +		period_accel = U32_MAX;
> +
> +	if (period_gyro <= period_accel)
> +		period = period_gyro;
> +	else
> +		period = period_accel;

	st->fifo.period = min(period_gyro, period_accel);
saves a few lines.

> +
> +	st->fifo.period = period;
> +}

> +static unsigned int inv_icm45600_wm_truncate(unsigned int watermark, size_t packet_size,
> +					     unsigned int fifo_period)
> +{
> +	size_t watermark_max, grace_samples;
> +
> +	/* Keep 20ms for processing FIFO. */
> +	grace_samples = (20U * 1000000U) / fifo_period;
> +	if (grace_samples < 1)
> +		grace_samples = 1;
> +
> +	watermark_max = INV_ICM45600_FIFO_SIZE_MAX / packet_size;
> +	watermark_max -= grace_samples;
> +
> +	if (watermark > watermark_max)
> +		watermark = watermark_max;

	return min(watermark, watermark_max);
> +
> +	return watermark;
> +}
> +
> +/**
> + * inv_icm45600_buffer_update_watermark - update watermark FIFO threshold
> + * @st:	driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * FIFO watermark threshold is computed based on the required watermark values
> + * set for gyro and accel sensors. Since watermark is all about acceptable data
> + * latency, use the smallest setting between the 2. It means choosing the
> + * smallest latency but this is not as simple as choosing the smallest watermark
> + * value. Latency depends on watermark and ODR. It requires several steps:
> + * 1) compute gyro and accel latencies and choose the smallest value.
> + * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
> + *    ones. Otherwise it is possible that you don't meet a requirement. (for
> + *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
> + *    value of 4 will not meet accel latency requirement because 6 is not a
> + *    multiple of 4. You need to use the value 2.)
> + * 3) Since all periods are multiple of each others, watermark is computed by
> + *    dividing this computed latency by the smallest period, which corresponds
> + *    to the FIFO frequency.

Nice explanation and clear code. Thanks!

> + */
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
> +{
> +	const size_t packet_size = INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
> +	unsigned int wm_gyro, wm_accel, watermark;
> +	u32 period_gyro, period_accel, period;
> +	u32 latency_gyro, latency_accel, latency;
> +
> +	/* Compute sensors latency, depending on sensor watermark and odr. */
> +	wm_gyro = inv_icm45600_wm_truncate(st->fifo.watermark.gyro, packet_size,
> +					   st->fifo.period);
> +	wm_accel = inv_icm45600_wm_truncate(st->fifo.watermark.accel, packet_size,
> +					    st->fifo.period);
> +	/* Use us for odr to avoid overflow using 32 bits values. */
> +	period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr) / 1000UL;
> +	period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr) / 1000UL;
> +	latency_gyro = period_gyro * wm_gyro;
> +	latency_accel = period_accel * wm_accel;
> +
> +	/* 0 value for watermark means that the sensor is turned off. */
> +	if (wm_gyro == 0 && wm_accel == 0)
> +		return 0;
> +
> +	if (latency_gyro == 0) {
> +		watermark = wm_accel;
> +		st->fifo.watermark.eff_accel = wm_accel;
> +	} else if (latency_accel == 0) {
> +		watermark = wm_gyro;
> +		st->fifo.watermark.eff_gyro = wm_gyro;
> +	} else {
> +		/* Compute the smallest latency that is a multiple of both. */
> +		if (latency_gyro <= latency_accel)
> +			latency = latency_gyro - (latency_accel % latency_gyro);
> +		else
> +			latency = latency_accel - (latency_gyro % latency_accel);
> +		/* Use the shortest period. */
> +		if (period_gyro <= period_accel)
> +			period = period_gyro;
> +		else
> +			period = period_accel;
> +		/* All this works because periods are multiple of each others. */
> +		watermark = latency / period;
> +		if (watermark < 1)
> +			watermark = 1;
> +		/* Update effective watermark. */
> +		st->fifo.watermark.eff_gyro = latency / period_gyro;
> +		if (st->fifo.watermark.eff_gyro < 1)
> +			st->fifo.watermark.eff_gyro = 1;
> +		st->fifo.watermark.eff_accel = latency / period_accel;
> +		if (st->fifo.watermark.eff_accel < 1)
> +			st->fifo.watermark.eff_accel = 1;
> +	}
> +
> +
> +	st->buffer.u16 = cpu_to_le16(watermark);
> +	return regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
> +				&st->buffer.u16, sizeof(st->buffer.u16));
> +}

> +
> +static int inv_icm45600_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Exit if there are several sensors using the FIFO. */
> +	if (st->fifo.on > 1) {
> +		/* decrease FIFO on counter */
> +		st->fifo.on--;
> +		return 0;
> +	}
> +
> +	/* Disable writing sensor data to FIFO. */
> +	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
> +				INV_ICM45600_FIFO_CONFIG3_IF_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Set FIFO in bypass mode. */
> +	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);

One more space.  Check for similar.

> +	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
> +				 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable FIFO threshold and full interrupt. */
> +	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_INT1_CONFIG0,
> +				INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN |
> +				INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush all FIFO data. */
> +	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
> +			   INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH);
> +	if (ret)
> +		return ret;
> +
> +	/* Decrease FIFO on counter. */
> +	st->fifo.on--;
> +	return 0;
> +}

> +
> +static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int sensor;
> +	unsigned int *watermark;
> +	unsigned int sleep;
> +	int ret;
> +
> +	if (indio_dev == st->indio_gyro) {
> +		sensor = INV_ICM45600_SENSOR_GYRO;
> +		watermark = &st->fifo.watermark.gyro;
> +	} else if (indio_dev == st->indio_accel) {
> +		sensor = INV_ICM45600_SENSOR_ACCEL;
> +		watermark = &st->fifo.watermark.accel;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mutex, &st->lock)
> +		ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);
> +
> +	/* Sleep required time. */
> +	if (sleep)

Is there a case where sleep is 0?  If not just do it unconditionally perhaps.


> +		msleep(sleep);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +const struct iio_buffer_setup_ops inv_icm45600_buffer_ops = {
> +	.preenable = inv_icm45600_buffer_preenable,
> +	.postenable = inv_icm45600_buffer_postenable,
> +	.predisable = inv_icm45600_buffer_predisable,
> +	.postdisable = inv_icm45600_buffer_postdisable,
> +};
> +
> +int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
> +				  unsigned int max)
What is max here?  Seems to be passed 0 in the only caller.
> +{
> +	const ssize_t packet_size = INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
> +	__le16 *raw_fifo_count;
> +	size_t fifo_nb, i;
> +	ssize_t size;
> +	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> +	const __le16 *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	int ret;
> +
> +	/* Reset all samples counters. */
> +	st->fifo.count = 0;
> +	st->fifo.nb.gyro = 0;
> +	st->fifo.nb.accel = 0;
> +	st->fifo.nb.total = 0;
> +
> +	/* Read FIFO count value. */
> +	raw_fifo_count = &st->buffer.u16;
> +	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_FIFO_COUNT,
> +			       raw_fifo_count, sizeof(*raw_fifo_count));

For IIO drivers at least we still operated under some guidance the regmap maintainer
gave years ago to never assume regmap (for busses that otherwise require DMA safe
buffers) will always bounce the data.  So bulk reads with SPI buffers need
DMA safe buffers. Easiest is usually an __aligned(IIO_DMA_MINALIGN) buffer
(or set of buffers) at the end of st.

In practice last time I checked regmap doesn't bother with the zero copy
optimization that would need this safety so you won't actually hit this
issue.

> +	if (ret)
> +		return ret;
> +	fifo_nb = le16_to_cpup(raw_fifo_count);
> +
> +	/* Check and limit number of samples if requested. */
> +	if (fifo_nb == 0)
> +		return 0;
> +	if (max > 0 && fifo_nb > max)
> +		fifo_nb = max;
> +
> +	/* Try to read all FIFO data in internal buffer. */
> +	st->fifo.count = fifo_nb * packet_size;
> +	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> +				st->fifo.data, st->fifo.count);
> +	if (ret == -ENOTSUPP || ret == -EFBIG) {
> +		/* Read full fifo is not supported, read samples one by one. */

Interesting. Maybe we could push the fallback to regmap or further given it's
emulating the big read version.

> +		ret = 0;
> +		for (i = 0; i < st->fifo.count && ret == 0; i += packet_size)
> +			ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> +							&st->fifo.data[i], packet_size);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < st->fifo.count; i += size) {
> +		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
> +			&accel, &gyro, &temp, &timestamp, &odr);
> +		if (size <= 0)
> +			break;
> +		if (gyro != NULL && inv_icm45600_fifo_is_data_valid(gyro))
> +			st->fifo.nb.gyro++;
> +		if (accel != NULL && inv_icm45600_fifo_is_data_valid(accel))
> +			st->fifo.nb.accel++;
> +		st->fifo.nb.total++;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..09595a41cf637a3ba9bc44e4df53a9d0aa11f485
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
> @@ -0,0 +1,99 @@


> +/**
> + * struct inv_icm45600_fifo - FIFO state variables
> + * @on:		reference counter for FIFO on.
> + * @en:		bits field of INV_ICM45600_SENSOR_* for FIFO EN bits.
> + * @period:	FIFO internal period.
> + * @watermark:	watermark configuration values for accel and gyro.
> + * @count:	number of bytes in the FIFO data buffer.
> + * @nb:		gyro, accel and total samples in the FIFO data buffer.
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
> +	u8 data[8192] __aligned(IIO_DMA_MINALIGN);

Doing this inside an embedded structure isn't great for readability.
See comment above on putting them next to each other. Also worth thinking
about structure padding that is going on here - maybe point pahole at the
result.

> +};
> +
> +/* FIFO data packet */
> +struct inv_icm45600_fifo_sensor_data {
> +	__le16 x;
> +	__le16 y;
> +	__le16 z;
> +} __packed;
> +#define INV_ICM45600_FIFO_DATA_INVALID		-32768
> +
> +static inline s16 inv_icm45600_fifo_get_sensor_data(__le16 d)
> +{
> +	return le16_to_cpu(d);
> +}
> +
> +static inline bool
> +inv_icm45600_fifo_is_data_valid(const struct inv_icm45600_fifo_sensor_data *s)
> +{
> +	s16 x, y, z;
> +
> +	x = inv_icm45600_fifo_get_sensor_data(s->x);
> +	y = inv_icm45600_fifo_get_sensor_data(s->y);
> +	z = inv_icm45600_fifo_get_sensor_data(s->z);
> +
> +	if (x == INV_ICM45600_FIFO_DATA_INVALID &&
> +	    y == INV_ICM45600_FIFO_DATA_INVALID &&
> +	    z == INV_ICM45600_FIFO_DATA_INVALID)
> +		return false;
> +
> +	return true;
> +}
> +
> +ssize_t inv_icm45600_fifo_decode_packet(const void *packet,
> +					const struct inv_icm45600_fifo_sensor_data **accel,
> +					const struct inv_icm45600_fifo_sensor_data **gyro,
> +					const s8 **temp,
> +					const __le16 **timestamp, unsigned int *odr);
> +
> +extern const struct iio_buffer_setup_ops inv_icm45600_buffer_ops;
> +
> +int inv_icm45600_buffer_init(struct inv_icm45600_state *st);
> +
> +void inv_icm45600_buffer_update_fifo_period(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_buffer_set_fifo_en(struct inv_icm45600_state *st,
> +				    unsigned int fifo_en);
> +
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
> +				  unsigned int max);
> +
> +int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
> +				     unsigned int count);

The comment above about considering a single file was because there is a lot in this header
rather implying maybe there isn't a good separation of code.

> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> index 022eb9180b5a750e8fba4a1cd873041c27f59880..37487e9174bf53f2fc6583f37ac7542ea31b0643 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c


>  static int inv_icm45600_timestamp_setup(struct inv_icm45600_state *st)
>  {
>  	/* Enable timestamps. */
> @@ -627,6 +717,14 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
>  	if (ret)
>  		return ret;
>  
> +	ret = inv_icm45600_buffer_init(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm45600_irq_init(st, irq, irq_type, open_drain);
> +	if (ret)
> +		return ret;
> +
>  	/* Setup runtime power management. */
>  	ret = devm_pm_runtime_set_active_enabled(dev);
>  	if (ret)
> @@ -658,6 +756,22 @@ static int inv_icm45600_suspend(struct device *dev)
>  	if (pm_runtime_suspended(dev))
>  		return 0;
>  
> +	/* Disable FIFO data streaming. */
> +	if (st->fifo.on) {
> +		unsigned int val;
> +
> +		ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
> +					INV_ICM45600_FIFO_CONFIG3_IF_EN);
> +		if (ret)
> +			return ret;
> +		val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);

Align second line after (

> +		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
> +					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
>  					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
>  	if (ret)

