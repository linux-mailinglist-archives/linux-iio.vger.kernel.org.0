Return-Path: <linux-iio+bounces-3289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090D86F649
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FDD2824E0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78874410;
	Sun,  3 Mar 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brgQ6mpP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B388F9CB
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485127; cv=none; b=hPnKt2IBwkCVro/sJasIOAHUjUIeyZFqRNgmibzDYTv1yidrIQnEjT4QFqIFmz9S0wkJjgGHRzgVUcLSlMgpqND6f+mdsXweW9ufUj5QiBHmjYaspGiEYDYPOB5d7aDhVT4enTtKQk2wD+IDL3XO16cwcmp+xbOyDdqXuNfB/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485127; c=relaxed/simple;
	bh=fwQi0r6A42JsczG6XLfPJJCboDhVSXns7vXK1ApvY/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJOW9YhVpWys8BphTvNXnjd2qt/FxjV3kivamL/tRfssBfFEqHdx071k44bWmwBnb75U2QeUmcBL58KU7DJrGBBHJDm72cjgosMirDhwLsd/5i/rUmLjbODxHVnt7Z8+TkD2hlb+xsD356YU2lxdeUh8vo8XRMgvrhAnhzRRz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brgQ6mpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40A6C433F1;
	Sun,  3 Mar 2024 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709485126;
	bh=fwQi0r6A42JsczG6XLfPJJCboDhVSXns7vXK1ApvY/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brgQ6mpPVGs3twjJNheBZA/dwHm5jOQ9cztkXMN8WDo3sDBGJ6PCCP3EpwjzMUAEZ
	 fek/3oBeTxg2MEEBy40Fj3vBR9AB8a1jyssrUyWNRkJLpcl2+3aRih9B0jqlhk8OB7
	 rYxnT7aDofRLBUcnPuUP9jdHszfMZH7h0s9uiqC2rpHFcp/4j0fZc3fr2C+hBQHw3S
	 CqCkaEL1NrtNFWXGGffvPjuHwuSj0mHRHMNyiXy96uje5s6D0c+ckegjv8tRfZRb1j
	 v/SqojsAj+oAjNjI0oAdLee980iLU9+cAPAo3ejdsF1+DNFoQiU6lHcHJqD3xgLbXu
	 xtHd0F1AMnNYw==
Date: Sun, 3 Mar 2024 16:58:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/4] iio: imu: inv_mpu6050: add WoM event inside accel
 channels
Message-ID: <20240303165834.4db9ffdc@jic23-huawei>
In-Reply-To: <20240225160027.200092-3-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
	<20240225160027.200092-3-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 16:00:25 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM (mag_adaptive rising) event in accel channels for all
> chips >= MPU-6500. This requires to create new MPU-6500 channels
> as default and MPU-6050 channels for older chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Trivial comment inline - otherwise looks good beyond question of 
event type.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 132 ++++++++++++++-------
>  1 file changed, 89 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index fca7fc1ba4e2..d2544c758815 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1303,23 +1303,34 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
>  	{ }
>  };
>  
> -#define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
> -	{                                                             \
> -		.type = _type,                                        \
> -		.modified = 1,                                        \
> -		.channel2 = _channel2,                                \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	      \
> -				      BIT(IIO_CHAN_INFO_CALIBBIAS),   \
> -		.scan_index = _index,                                 \
> -		.scan_type = {                                        \
> -				.sign = 's',                          \
> -				.realbits = 16,                       \
> -				.storagebits = 16,                    \
> -				.shift = 0,                           \
> -				.endianness = IIO_BE,                 \
> -			     },                                       \
> -		.ext_info = inv_ext_info,                             \
> +static const struct iio_event_spec inv_accel_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +				       BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +#define INV_MPU6050_CHAN(_type, _channel2, _index, _events, _events_nb) \
> +	{                                                               \
> +		.type = _type,                                          \
> +		.modified = 1,                                          \
> +		.channel2 = _channel2,                                  \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	        \
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS),     \
> +		.event_spec = _events,                                  \
> +		.num_event_specs = _events_nb,                          \
> +		.scan_index = _index,                                   \
> +		.scan_type = {                                          \
> +				.sign = 's',                            \
Maybe take opportunity to tidy up these intents. One tab is enough.
			.sign = 's',

> +				.realbits = 16,                         \
> +				.storagebits = 16,                      \
> +				.shift = 0,                             \
> +				.endianness = IIO_BE,                   \
> +			     },                                         \
		},
> +		.ext_info = inv_ext_info,                               \
>  	}



