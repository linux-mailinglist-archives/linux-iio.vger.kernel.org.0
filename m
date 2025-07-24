Return-Path: <linux-iio+bounces-21992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F4EB10F76
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709763AE28B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E622D9EDC;
	Thu, 24 Jul 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8MnQK6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9E9443;
	Thu, 24 Jul 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373757; cv=none; b=ADrU8qe/mv3CPRSeDxG7/RP2d877dwOV2/YZyPMouWRIL0n1nhZMjDvwcrAzn65EpnU80hosCjnUBjNABQtEhmG6+zvG1jDCJw35dqy7PDcKmEMNov0YIFeSg8mnqQzZRCPazvEvuu3b7E9hYTLL4l5ax4zeWtz/I8G8oIHkrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373757; c=relaxed/simple;
	bh=thzG3NkwY70/4fLOw3fOGRy49WMtxwFrTwb7G9MwZf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A66Kl+GtPUwUEJv1WomXT4twxe0oam6jSEgzT4oPQV0KSvpRy1QO9/Z7QpPUOmgb/XJsF66TZQQ/kNrgLrA2gCQkgvGZRvwQGqImwaxbeyzxyulJIeYquBTZgm4XWFDDPb3rambEZdPW3tlcYfQFSaHENtLSsmko7UUKcuPCGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8MnQK6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C3C4CEF6;
	Thu, 24 Jul 2025 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753373756;
	bh=thzG3NkwY70/4fLOw3fOGRy49WMtxwFrTwb7G9MwZf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8MnQK6kScMrgSqqutRU8JPaIhvioYeqgysFVNNU5szhM/31kepTWEmQjYF2ITCUN
	 G+z5dfJPuWDEtAkMyZvyv67Kz4C0IKi4abBM78aZPi2pxlbQWeLPo0wMh2Ix+RyZJz
	 E1Z/CNUuwrwVEV7S9lVUI+QYJu6BP+2tIteUqbbZeX9QKmMNJUN5oS05AfUocNv2x+
	 lyATZ9r0F+EN+z5XyQWlQpvEbxen+6aLg0UhaRBem5W949Ms8eItTaFXmVJXNH7LVN
	 dgOS1ggj6YP5/yg11cC5rpkNeIRvhHsiVZOsbz9hjmraoNRTTatDpQBRJFCdvK/R4I
	 7Z3Kq79I9qCKQ==
Date: Thu, 24 Jul 2025 17:15:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: imu: inv_icm45600: add IMU IIO devices
Message-ID: <20250724171547.4075f8ad@jic23-huawei>
In-Reply-To: <20250717-add_newport_driver-v3-4-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-4-c6099e02c562@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:25:56 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add IIO devices for accelerometer and gyroscope sensors
> with data polling interface and FIFO parsing.
> Attributes: raw, scale, sampling_frequency, calibbias.
> Temperature is available as a processed channel.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>


> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..bd6b85e25e1792744769916f6d529615f9acf723
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c

If possible it would have been better to do accel and gyro in different patches
(or more manageable size).  Note I didn't read this one on the assumption any
issues are likely to the same (and I'm out of time for today).

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..48373befafa0efe0e5dcb2c97b2c836436ce7d78
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
> +static const struct iio_chan_spec_ext_info inv_icm45600_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
> +	{ },

No comma on a terminating entry like this. We don't want to make it easy
to put things after it.

> +};

> +/* IIO format int + nano */
> +const int inv_icm45686_gyro_scale[][2] = {
> +	/* +/- 4000dps => 0.002130529 rad/s */
> +	[INV_ICM45686_GYRO_FS_4000DPS] = {0, 2130529},
> +	/* +/- 2000dps => 0.001065264 rad/s */
> +	[INV_ICM45686_GYRO_FS_2000DPS] = {0, 1065264},
> +	/* +/- 1000dps => 0.000532632 rad/s */
> +	[INV_ICM45686_GYRO_FS_1000DPS] = {0, 532632},
> +	/* +/- 500dps => 0.000266316 rad/s */
> +	[INV_ICM45686_GYRO_FS_500DPS] = {0, 266316},
> +	/* +/- 250dps => 0.000133158 rad/s */
> +	[INV_ICM45686_GYRO_FS_250DPS] = {0, 133158},
> +	/* +/- 125dps => 0.000066579 rad/s */
> +	[INV_ICM45686_GYRO_FS_125DPS] = {0, 66579},
> +	/* +/- 62.5dps => 0.000033290 rad/s */
> +	[INV_ICM45686_GYRO_FS_62_5DPS] = {0, 33290},
> +	/* +/- 31.25dps => 0.000016645 rad/s */
> +	[INV_ICM45686_GYRO_FS_31_25DPS] = {0, 16645},
> +	/* +/- 15.625dps => 0.000008322 rad/s */
> +	[INV_ICM45686_GYRO_FS_15_625DPS] = {0, 8322},

	[INV_ICM45686_GYRO_FS_15_625DPS] = { 0, 8322 },
etc

> +};

> +
> +static int inv_icm45600_gyro_write_offset(struct inv_icm45600_state *st,
> +					  struct iio_chan_spec const *chan,
> +					  int val, int val2)
> +{

> +
> +	/* clamp value limited to 14 bits signed */

Use clamp() then! :)

> +	if (offset < -8192)
> +		offset = -8192;
> +	else if (offset > 8191)
> +		offset = 8191;
> +
> +	st->buffer.u16 = cpu_to_le16(offset & INV_ICM45600_GYRO_OFFUSER_MASK);
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &st->lock)
> +		ret = regmap_bulk_write(st->map, reg, &st->buffer.u16, sizeof(st->buffer.u16));
> +
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}


> +static int inv_icm45600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
> +					  unsigned int count)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	if (count == 0)
> +		return 0;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm45600_buffer_hwfifo_flush(st, count);
> +	if (!ret)
> +		ret = st->fifo.nb.gyro;
I'd prefer keeping errors out of line.
	if (ret)
		return ret;

	return st->fifo.mb.gyro;

Such error formatting helps a bit when people are reading a lot of code
because it is very common.

> +
> +	return ret;
> +}

> +int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> +	const __le16 *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	s64 ts_val;
> +	struct inv_icm45600_gyro_buffer buffer;

Can we give some sort of order to these local variables. Pretty much anything is
fine. Failing anything else, reverse xmas tree. Maybe also push any
that are local to the loop in there?

> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> +		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <= 0)
> +			return size;
> +
> +		/* skip packet if no gyro data or data is invalid */
> +		if (gyro == NULL || !inv_icm45600_fifo_is_data_valid(gyro))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM45600_SENSOR_GYRO)
> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							st->fifo.nb.total, no);
> +
> +		/* buffer is copied to userspace, zeroing it to avoid any data leak */
> +		memset(&buffer, 0, sizeof(buffer));
We only care about not leaking data that is sensitive.  Not stale readings or
similar so can just do
	struct inv_icm45600_gyro_buffer buffer = { };
above and skip the memset here.

> +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
> +	}
> +
> +	return 0;
> +}
> 


