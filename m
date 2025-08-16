Return-Path: <linux-iio+bounces-22801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C47B28D92
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19165E356A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9392C21EE;
	Sat, 16 Aug 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B12Xdd39"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4347248F4E;
	Sat, 16 Aug 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346113; cv=none; b=EH0wv0ZQYv5o9huIOM95JXS2O8lNtlR93VaTWO+Bsg0s/hzsG0qr+o3PomTkSYQqRDxkQxNcwB5Bi8a3a510Zzrrd1rAX27vBjp6FbovFZNa33XxM6yNLF07H1Lgye+WWnANhaPxvwXfleIKIJf1G/On7F/lm9g0pLZaEKxZciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346113; c=relaxed/simple;
	bh=qlB4X8NEdQ6H1pEuGtG2U39RBECS7RzEFldDRG+JH8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGWCA2IyE85It7gGz5VRfUijc2VgrN8LKOEaCpIgVWo2LRiycC6ruBQN6fFslpSZeOm2+P5eW+CJx4Jnc8+9jWRn0HhVHtMgm4WwrWykOZoso3oEF5oFI1vWVm/J9d5L/4D2SFxu6sOINGc5/aWtpJJib4VXC3n1Ysuy6WxLXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B12Xdd39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C522C4CEF1;
	Sat, 16 Aug 2025 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755346113;
	bh=qlB4X8NEdQ6H1pEuGtG2U39RBECS7RzEFldDRG+JH8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B12Xdd39E5EgFqfC1+nwjbiIqR6E/+ZVUD+juS9DMrxLGKGmhrDEFhdNtDz6eIRHa
	 jyEkBFMTgcDpXQw02gCjBS2hoEIgpJfwEk/2sfIyrmb2w5Ohb4kUYshAT1C/CzWuWd
	 k0q7caCSyXrZK6WqZb22Rj+MGZsZVhaOsUxUj/GmOEtmwssCFNSOWsFHSJ42zN2zJA
	 MoMpxAFEfe4uBLOAa3FWxFohMwht4ZQ3VbNM9In33Y8KxCs1B3069Ze4gl6go6JJ54
	 k7pucOViUeMUyrW1dehZz4/UoFW67ozOwS0WW55GFp6vjPwQBHrvpnGSd34Lu7T0ed
	 uuRSNjf1O5K2g==
Date: Sat, 16 Aug 2025 13:08:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Message-ID: <20250816130823.3cb14980@jic23-huawei>
In-Reply-To: <20250814-add_newport_driver-v4-4-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-4-4464b6600972@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:57:18 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add IIO device for gyroscope sensor
> with data polling interface and FIFO parsing.
> Attributes: raw, scale, sampling_frequency, calibbias.
> Temperature is available as a processed channel.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
A few minor comments.

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7a5a2ce77f3e176bdcb5657c0b8d547024d04930
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c

> +int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev)

Ah. This is where this comes in.  Add header definition in this
patch as well.

> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> +		struct inv_icm45600_gyro_buffer buffer = { };
> +		const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> +		const __le16 *timestamp;
> +		const s8 *temp;
> +		unsigned int odr;
> +		s64 ts_val;
> +
> +		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],

can drag size into this scope as well.

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
> +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);

Please switch to new iio_push_to_buffers_with_ts().
I want to get rid of the with_timestamp() version eventually as we might as well
always provide the buffer size.

> +	}
> +
> +	return 0;
> +}
> 


