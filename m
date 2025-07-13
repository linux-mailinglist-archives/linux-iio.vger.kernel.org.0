Return-Path: <linux-iio+bounces-21615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D734B0317F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C5E178513
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03852149C4A;
	Sun, 13 Jul 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRVV++31"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6E367;
	Sun, 13 Jul 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417157; cv=none; b=MKhpNZLwpZ9H/6cxF7Kgx5Epgfl9pPw/bVALEPth7safMMJHAB+FRJG9B31ilja8qgpFOrWqcQCAngMCbj++FPheuz8j19IwV8WmKEoRFlgCAScKfXK4uYYgcGIEg0gzZsIrQBvx7Sfd7QlKk6QCqKvCyqhvMoFlzYTtgqlnUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417157; c=relaxed/simple;
	bh=x5ofSumaQaRcL7AQDn82wS+gba0wPX7jhDjlWM9CV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvpb80i9vi2dPYcR8+Rmeqz2zQjVZkZDqxY6cV1lDwO3qiORe+CdNk+79MvhFgueeeuZzP9iX5X28rgDYn0m1zESun32ye6FAcqKTHuECX7cy2BXru0lIQrmZVjLBQ0kDmPscLYhK4Tnoos2GTuvO68M3jDXQdOmfQ0pMgGj/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRVV++31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1452AC4CEE3;
	Sun, 13 Jul 2025 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752417155;
	bh=x5ofSumaQaRcL7AQDn82wS+gba0wPX7jhDjlWM9CV0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRVV++313u8VC/rCNQ9zdb6I+1ksxDw1Q9GYAgsl76IzqqE+i/9GeaUfh5vx2eLRk
	 63NJYOgM1DtZlJ45HIRmxVupRpI2m9Kpwq351GEhpqUZMuy4/JRIz6h0JGQtjn2Fmm
	 8AjitO8umuBihs3YruiUKYZ3OT7e15I00mesRulWGlOkdpjfqVr9Qt8yYAamsvCBLn
	 m2OgUOU/S5ayjkftP4tRwh9rm8OrQrGS7opMXYTkS+BM8+MjpViBGFocZ/9i/TvUUV
	 NfJJOoTC6ncxPkeZDqsnlCdm6XalJZrewMbd9trMCxkunRAK17/a29VZ6Orv5QHlVd
	 kHOBPbsl9OwAA==
Date: Sun, 13 Jul 2025 15:32:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: imu: inv_icm42600: Avoid configuring if
 already pm_runtime suspended
Message-ID: <20250713153227.08af0a54@jic23-huawei>
In-Reply-To: <20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:35:14 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Do as in suspend, skip resume configuration steps if the device is already
> pm_runtime suspended. This avoids reconfiguring a device that is already
> in the correct low-power state and ensures that pm_runtimeM handles the
> power state transitions properly.
> 
> Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Not really related to what you have here, but this code would really
benefit from using guard(mutex)()

Jonathan

>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 37b3a7754da1c4e381e38c9871e55a941e19cef4..d745a40b042e1c86b232aaae0820942d11d51c79 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -824,17 +824,15 @@ static int inv_icm42600_suspend(struct device *dev)
>  	struct device *accel_dev;
>  	bool wakeup;
>  	int accel_conf;
> -	int ret;
> +	int ret = 0;
>  
>  	mutex_lock(&st->lock);
>  
>  	st->suspended.gyro = st->conf.gyro.mode;
>  	st->suspended.accel = st->conf.accel.mode;
>  	st->suspended.temp = st->conf.temp_en;
> -	if (pm_runtime_suspended(dev)) {
> -		ret = 0;
> +	if (pm_runtime_suspended(dev))
>  		goto out_unlock;
> -	}
>  
>  	/* disable FIFO data streaming */
>  	if (st->fifo.on) {
> @@ -887,10 +885,13 @@ static int inv_icm42600_resume(struct device *dev)
>  	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct device *accel_dev;
>  	bool wakeup;
> -	int ret;
> +	int ret = 0;
>  
>  	mutex_lock(&st->lock);
>  
> +	if (pm_runtime_suspended(dev))
> +		goto out_unlock;
> +
>  	/* check wakeup capability */
>  	accel_dev = &st->indio_accel->dev;
>  	wakeup = st->apex.on && device_may_wakeup(accel_dev);
> 


