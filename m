Return-Path: <linux-iio+bounces-26884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA5CAB66E
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85414301EFB7
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D6D2F549C;
	Sun,  7 Dec 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5HFndjR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB21E0AF;
	Sun,  7 Dec 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120520; cv=none; b=GlVZzitGrAO5UtgnpU+w0aysdxBM4K5/UZ58qsYcppqe4it7V1r26T8ZBwJpCiQWJXXhb0tnloEVQRUbKPnQ+L6BelUzaP6maEcbxI7E2/MBp/hvOtgVSZ4SEGuVkysD8UBTXf1QfjTJ3+cRJ8IbxjwxrDbCM+Wk6hJSZ6ODJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120520; c=relaxed/simple;
	bh=uWez4Md2XNWwzgrUO7SzOgx+DS7rw1hqVEUegVDzevw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8+1nGBLPZHVAGGG8otB2VXWJscQzZ8qGhMQtEgb7EjKJWWvKFyX7JCY18Utz8K+/nJPLSynu6CJjl5tODS+NjHsLOoFE3bpGCIfSFUBzD5I7cpKRoJpEPTefd2THpBry8Z1nnzpek6bXHjU16TjNssO8/ED5JP/pmjIS4f7dYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5HFndjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99CC4CEFB;
	Sun,  7 Dec 2025 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120520;
	bh=uWez4Md2XNWwzgrUO7SzOgx+DS7rw1hqVEUegVDzevw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5HFndjRvd8qEvbSV5N7po9NMYWSfA7/x/eEYDrqqmpfFf3+1ZRX1+9r30xFEWdbb
	 k/ULXL52knRnthbXNPxbPuA8I/G8A19vR12UO3dymOGTlAH3Qz4MVSoNFAFaDQOIH1
	 xznSol+YiP81aZdFr/1958uFNgqBsYvG3+Dvl/Q237CZP5rl+D+zuvs9aUCsHs9sAc
	 4RX8m/tin599O4hHbWE6BMZgfZZEksG09HD/LPAzRSJvsxKFBv4vAXnNKqXGYv1Mg6
	 NUqZZw3uRayzWd3wef5ky/hKkh9EmGsH7vAlej0aFxZqD1UixPVrbPrSJnOlfaG7Ez
	 2nY7eKDBqUMOA==
Date: Sun, 7 Dec 2025 15:15:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 1/9] iio: imu: st_lsm6dsx: fix iio_chan_spec for
 sensors without event detection
Message-ID: <20251207151515.276d2b95@jic23-huawei>
In-Reply-To: <20251201100018.426749-2-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-2-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:10 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The st_lsm6dsx_acc_channels array of struct iio_chan_spec has a non-NULL
> event_spec field, indicating support for IIO events. However, event
> detection is not supported for all sensors, and if userspace tries to
> configure accelerometer wakeup events on a sensor device that does not
> support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences a NULL
> pointer when trying to write to the wakeup register.
> Define an additional struct iio_chan_spec array whose members have a NULL
> event_spec field, and use this array instead of st_lsm6dsx_acc_channels for
> sensors without event detection capability.
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the fixes-togreg branch of iio.git (which I might not push out
until I can rebase on rc1) and marked for stable.

If this causes conflicts with the rest of the series that will have to wait
until this is in upstream and can merge that into the main iio tree.

This feels to urgent to sit on for a whole extra cycle.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 216160549b5a..a09df9d772dd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -103,6 +103,13 @@ static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec st_lsm6ds0_acc_channels[] = {
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
> @@ -144,8 +151,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  		.channels = {
>  			[ST_LSM6DSX_ID_ACC] = {
> -				.chan = st_lsm6dsx_acc_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +				.chan = st_lsm6ds0_acc_channels,
> +				.len = ARRAY_SIZE(st_lsm6ds0_acc_channels),
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.chan = st_lsm6ds0_gyro_channels,
> @@ -1445,8 +1452,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  		.channels = {
>  			[ST_LSM6DSX_ID_ACC] = {
> -				.chan = st_lsm6dsx_acc_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +				.chan = st_lsm6ds0_acc_channels,
> +				.len = ARRAY_SIZE(st_lsm6ds0_acc_channels),
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.chan = st_lsm6dsx_gyro_channels,


