Return-Path: <linux-iio+bounces-23206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93593B33D0D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DE482422
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6242D978A;
	Mon, 25 Aug 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbhxhLex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F129AAF3;
	Mon, 25 Aug 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118536; cv=none; b=lKBH3nR43Pr0xAAUPu/DyioDdITzuoyL/tf8+DxIEFQZmnzjvnUHJ0kLE8o1QU0k6EMA/kFMbbvYcwasOrsy/g9393URgx1cDzExFjWrUvlijAnxsrDC1jhpcNrmh5UNStOaFKBoPMiA1S4bPRQI/RYReu8Njl00ONc8PW/KzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118536; c=relaxed/simple;
	bh=JIsJQK82/gVyeU3o7JYAJEm6AoNqmgTo50ph6GZjo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVbbu1heOO6HSpo6pQIkTS8m9CTyh+cpywCmGVEgXc3FzWkG1NFJFXPKI1ZEZte0bAJKCTyxaP0cBZCFNXd2ai2A6Q0JE5iym7AJsBRjZM81Hdju4g442zx/hDiNeUQ+KPbC78PG3/3+JVTyPArLVJerdxClpHkSM42FJ6vbs00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbhxhLex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B622C4CEED;
	Mon, 25 Aug 2025 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118535;
	bh=JIsJQK82/gVyeU3o7JYAJEm6AoNqmgTo50ph6GZjo1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbhxhLexWl8LZHQ+2AQwEueBQb3L7v0tTQ1pvw0j87rb0gjpmy3SVdlWN0pqoiwvQ
	 a6KpoOiqYyk8D1NqxM82dXPn8qjNH003+ObTEaxDeLf3MYX13BlRy7S6Q7E/Zgj3FZ
	 6b2pIFU2qLE0FjzaKgofm5+e9amXESpgIoeHBrSMFEszfWnUVttsO65EWzpL+WzV+W
	 8GM4zGXjseCFfdxgoFncTq2eQdFWy58yLeIfckKYPtYvnx0QFHReIKHjvK3I8/LdSM
	 WyZFOdUulXytEODZoJj82teZRnaqR56/hG7PVAnkT3Y89w6cismCScMKoDh+ppK5Cf
	 37K4RfnsIDZQw==
Date: Mon, 25 Aug 2025 11:42:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250825114205.65ec79bc@jic23-huawei>
In-Reply-To: <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:24:21 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

A few really minor things inline.

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..50fd21a24e34decfbe10426946a51c61353eb6a9
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c

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
> + */
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
> +{
> +	const size_t packet_size = sizeof(struct inv_icm45600_fifo_2sensors_packet);
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
> +		period = min(period_gyro, period_accel);
> +		/* All this works because periods are multiple of each others. */
> +		watermark = max(latency / period, 1);
> +		/* Update effective watermark. */
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
> +	}
> +

1 blank line is enough.

> +
> +	st->buffer.u16 = cpu_to_le16(watermark);
> +	return regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
> +				 &st->buffer.u16, sizeof(st->buffer.u16));
> +}
>
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..da463461b5f2708014126f868fa6008db0520a4e
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h


> +
> +static inline s16 inv_icm45600_fifo_get_sensor_data(__le16 d)
> +{
> +	return le16_to_cpu(d);
I'm not really seeing advantage of this wrapper vs just using le16_to_cpu()
inline.

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
	x = le16_to_cpu(s->x);

is pretty obvious.

> +
> +	if (x == INV_ICM45600_DATA_INVALID &&
> +	    y == INV_ICM45600_DATA_INVALID &&
> +	    z == INV_ICM45600_DATA_INVALID)
> +		return false;
> +
> +	return true;
> +}



