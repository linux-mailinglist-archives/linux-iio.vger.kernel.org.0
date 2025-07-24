Return-Path: <linux-iio+bounces-21991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDBCB10F64
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39373AE0C78
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57352EA493;
	Thu, 24 Jul 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilIxMiKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1431E1C36;
	Thu, 24 Jul 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373149; cv=none; b=bnjUpvOLKN+qWnuT4VExgBLm4jKKk/T0kEwNjMaQPXhr3cfO9Xup9DtlJzOHUySdqHmHUP692q/gTSdedwV99G00vXltLFWgPuBvSiU5wfTXlSRgA3IFUdxDLHKb7havRgHTnq/LU6glnkKa/MsKYavTjP2JtyhpZJSQho7iIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373149; c=relaxed/simple;
	bh=GJhw+IDFcNu0ZATI0kH9MQ7rMbCT9gDxNBgjRWy5fJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxiqKw3YXbZKZx4OXexCZ+GQ4kvbVz1sCPV47Bepl+YmjXIpAK5nm0pR1DyvBMmU1KTcbMEoevfKdaaSaJyTHCCUWxfIDMbCL9Zzkh8DdlVD3qKZAl0bnsmFr8KlrIBduiNPptiYtrl4fC7eGgWX7HUkyA/LJRz4fog95ICxO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilIxMiKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA1DC4CEED;
	Thu, 24 Jul 2025 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753373149;
	bh=GJhw+IDFcNu0ZATI0kH9MQ7rMbCT9gDxNBgjRWy5fJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilIxMiKJ6KOdF3Fe1xa1v4qvSrXGNCkWEzwTUkvSueEs25FcoJGTTp8uyKSP5Outm
	 1IztDg9ZVUXQ/8k1+EL5ocp3v61IDrgm/bPc1ZWbM2PO2mbHLZcCWnE3Z9tpSSTQJH
	 N5etmzBoCoZRNmbaTB81ZJU0IEu+RZCMsoL+6qA38fhdA8+blEGEyUjw7yage6V0YB
	 gbjGjh4aNK2Gvq3pZ2n0fdFTQq8KmUH8lTabPMrFZZkdIooV1Rk1JcZkVZQ11DwcRo
	 QIwZFwZ0pqK+CZAX0nhb6lSYs3XLIaHKzSU14vSU1GHBjNJXCw4JmvjZDioP0WTNBs
	 7RYD+lc2cc4lg==
Date: Thu, 24 Jul 2025 17:05:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250724170539.13cface5@jic23-huawei>
In-Reply-To: <20250717-add_newport_driver-v3-3-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-3-c6099e02c562@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:25:55 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
A few minor things inline.

> ---
>  drivers/iio/imu/inv_icm45600/Makefile              |   1 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        |   7 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 514 +++++++++++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |  99 ++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 137 +++++-
>  5 files changed, 757 insertions(+), 1 deletion(-)
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

Fix this by adding one.

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> index 59aed59b94ca2d4709b0c986ddeda80b33064f90..5625c437b6f54336f6e652c2ae2e4ea8f88e2396 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h

>  
> +#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES {U8_MAX, U8_MAX, U8_MAX, U8_MAX, }
> +
>  struct inv_icm45600_conf {
>  	struct inv_icm45600_sensor_conf gyro;
>  	struct inv_icm45600_sensor_conf accel;
> @@ -127,6 +132,7 @@ extern const struct inv_icm45600_chip_info inv_icm45689_chip_info;
>   *  @indio_gyro:	gyroscope IIO device.
>   *  @indio_accel:	accelerometer IIO device.
>   *  @timestamp:		interrupt timestamps.
> + *  @fifo:		FIFO management structure.
>   *  @buffer:		data transfer buffer aligned for DMA.
>   */
>  struct inv_icm45600_state {
> @@ -143,6 +149,7 @@ struct inv_icm45600_state {
>  		s64 gyro;
>  		s64 accel;
>  	} timestamp;
> +	struct inv_icm45600_fifo fifo;

Having that 8 thousand element buffer in here seem unwise.  Normally I encourage putting
everything possible in here, but this maybe a case where a kzalloc() for that buffer is
going to wasted less space.

>  	union {
>  		u8 buff[2];
>  		__le16 u16;
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b37607e52721097daf6362bac20001b0d4210f4b
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -0,0 +1,514 @@

>
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

	st->fifo.period = min(period_gyro, period_accel);

> +	else
> +		period = period_accel;
> +
> +	st->fifo.period = period;
> +}

> +
> +static unsigned int inv_icm45600_wm_truncate(unsigned int watermark, size_t packet_size,
> +					     unsigned int fifo_period)
> +{
> +	size_t watermark_max, grace_samples;
> +
> +	/* Keep 20ms for processing FIFO. */
> +	grace_samples = (20U * 1000000U) / fifo_period;

I'mnot sure what the multipler here is but maybe 20U * MICRO
> +	if (grace_samples < 1)
> +		grace_samples = 1;
> +
> +	watermark_max = INV_ICM45600_FIFO_SIZE_MAX / packet_size;
> +	watermark_max -= grace_samples;
> +
> +	if (watermark > watermark_max)
> +		watermark = watermark_max;

min?

> +
> +	return watermark;
> +}



