Return-Path: <linux-iio+bounces-23212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED14B33D4D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8297A6226
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692912DCF50;
	Mon, 25 Aug 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfhh1XYl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4102DC334;
	Mon, 25 Aug 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119362; cv=none; b=X5qoe7lzddGoOLxiLHEUBXMDWLE8rx6v/JBu5eZJJsC75NwModRYSKs7G69zKlwasX5payZIKVM4QhGP3mZh2Ygww7f9EDh35aM592+WqSy2nNtgy/XmZDfoiJV7Q3EC/6Ju/PI+RMjOjdalJiU3rgCzip1BFEb2qID0f5NdqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119362; c=relaxed/simple;
	bh=OkCfJU0z3FmlKCjw1ZiLXxsVjBBWcsaDb8j0QMm5vyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dApJt6I4xV8H+E5YGvt/gXYkQquerefPOzSXwn+wbS0vZwwbOuM0gAE0rBUHENxGCc9nyRkncCC1Dc41s59Z11FOmEJ3uSI7KHTVTCcTEsYu6Ap80oaGK1+3lM+jFWa4j0vcxlI6K9KGy9pjOgd2tZfsKo7VTbh+BiHp6Q1CI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfhh1XYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63327C4CEED;
	Mon, 25 Aug 2025 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756119361;
	bh=OkCfJU0z3FmlKCjw1ZiLXxsVjBBWcsaDb8j0QMm5vyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfhh1XYlW6fIQENl3wV0CAWdA8Zfv5YNdQYoJyV7LX5zvWB26r61Xzia7lWkodTZY
	 F9MOIE7CqQCSGbF2DfgKzbrtn43LcXQXdoptbPMRZUjW130Qt5DyjNaYIqi7luyGtr
	 ZnSH89s7iF6s0CsWu1dHM+wIwjCJG6JFC33aTPUD3KurCQ95sxoKCq7LC/m/aiO6BR
	 R8k/jX0UZ0nHK+TX5ZzoykMBF5xIBqZoZw0Op7DB4pVm19iHgjIRt+XAUy9LXnS6B7
	 m2AeDH4wGIRozfGe3xeDiuEwnfPnI3+7XnlPBgCSQ0hd+Sh1CIFkzJt6nz5tTmqRVz
	 aJtwGL2YW8x5g==
Date: Mon, 25 Aug 2025 11:55:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Message-ID: <20250825115552.69abe3b3@jic23-huawei>
In-Reply-To: <20250820-add_newport_driver-v5-4-2fc9f13dddee@tdk.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-4-2fc9f13dddee@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:24:22 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add IIO device for gyroscope sensor
> with data polling interface and FIFO parsing.

Wrap at 75 chars for commit messages.

> Attributes: raw, scale, sampling_frequency, calibbias.
> Temperature is available as a processed channel.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---

Only thing I noticed is some accelerometer calls are made
where the definitions are in the next patch.  To sanity check this
tweak the Kconfig to allow you to build it and make sure that it
builds after each patch.  At the end of the day we don't want to have
this build without the bus drivers, but hacking it to test 'it could'
is a great way to avoid issues of code in wrong patches etc, missing
definitions etc.

Jonathan

>  drivers/iio/imu/inv_icm45600/Kconfig               |   2 +
>  drivers/iio/imu/inv_icm45600/Makefile              |   1 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        |  29 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c |  76 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |   5 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 104 ++-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 792 +++++++++++++++++++++
>  7 files changed, 1006 insertions(+), 3 deletions(-)

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> index 50fd21a24e34decfbe10426946a51c61353eb6a9..5bf9535e27e8942312fe9749ce0c733149de0a9d 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c

> @@ -459,6 +462,77 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st)
>  	return 0;
>  }
>  
> +int inv_icm45600_buffer_fifo_parse(struct inv_icm45600_state *st)
> +{
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
> +	struct inv_sensors_timestamp *ts;
> +	int ret;
> +
> +	if (st->fifo.nb.total == 0)
> +		return 0;
> +
> +	/* Handle gyroscope timestamp and FIFO data parsing. */
> +	if (st->fifo.nb.gyro > 0) {
> +		ts = &gyro_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
> +						st->timestamp.gyro);
> +		ret = inv_icm45600_gyro_parse_fifo(st->indio_gyro);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Handle accelerometer timestamp and FIFO data parsing. */
> +	if (st->fifo.nb.accel > 0) {
> +		ts = &accel_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
> +						st->timestamp.accel);
> +		ret = inv_icm45600_accel_parse_fifo(st->indio_accel);

As below. No accel stuff available yet.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
> +				     unsigned int count)
> +{
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
> +	struct inv_sensors_timestamp *ts;
> +	s64 gyro_ts, accel_ts;
> +	int ret;
> +
> +	gyro_ts = iio_get_time_ns(st->indio_gyro);
> +	accel_ts = iio_get_time_ns(st->indio_accel);
> +
> +	ret = inv_icm45600_buffer_fifo_read(st, count);
> +	if (ret)
> +		return ret;
> +
> +	if (st->fifo.nb.total == 0)
> +		return 0;
> +
> +	if (st->fifo.nb.gyro > 0) {
> +		ts = &gyro_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
> +		ret = inv_icm45600_gyro_parse_fifo(st->indio_gyro);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->fifo.nb.accel > 0) {
> +		ts = &accel_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
> +		ret = inv_icm45600_accel_parse_fifo(st->indio_accel);

This call should be in the next patch as it's not defined yet.


> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

