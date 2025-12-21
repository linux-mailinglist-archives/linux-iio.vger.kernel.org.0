Return-Path: <linux-iio+bounces-27288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E4CD441F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08FDB30047B4
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA1299929;
	Sun, 21 Dec 2025 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUEEiEAH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABC2236F3;
	Sun, 21 Dec 2025 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342597; cv=none; b=PiPi0wsJram2LDHVB4AfsYj4EdcZn6Le+lS1LkPxh8jkTQ8ErtLxdmln4F18iJMh58tLnXw86nY+91m4wpIDbpZIrHxUOFOJ6yreRRYVuVWpKyNH4txec8spkf/jplIpjbVALsiqnxKLJ8+krXj9cYOB4RbtClxE0RbZVxfGBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342597; c=relaxed/simple;
	bh=f9Iwdrf7oglzSW0nQQwVzcBHDkSVxpFUz7EaXDgLe5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4+sJf/d+fbyXGPrfHE/KX6EPfvQPrNkmFDzL+Lv/jw7cXsHKHXnJJjhI06dqIma5IucO3h2oTQPUf7VqaJsErMylvIEyewcfLTzOSqlEURetlgrxdUo3n1h3/PwZ/v8crUsvFMhwmQV6f7/AJBONZyOPJcmxBZkE+lImy/R11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUEEiEAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334F9C4CEFB;
	Sun, 21 Dec 2025 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766342597;
	bh=f9Iwdrf7oglzSW0nQQwVzcBHDkSVxpFUz7EaXDgLe5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUEEiEAHsqrtEkhsgpdZDIZ6XqhqWHOVNCTgN3mShBf0/NegShDojrC6VLK3ldhtg
	 kYnznEyFOT9B/kcwL3hx2MBBoI/sFLm+tGi31NadexGrWY6GUntpA9+bLUrF8+p6Kd
	 4ghWi9tYdeTmlsEzCrnlruYq78rOsnEgRr9njN+gKnVBLvxxk+/SX3WgybVeZNXwFY
	 QHroXlvU70yU5JiZEGBzBtM7y7D28RCXKAZejbyg91xm2w3yEit+LgLEM9qUvllzDV
	 MWhTQk7CO8U5maCs9nTQGv9Dq9/ONHFHJ2w04BDUQVD4V0XkEr7q/CqdKh0fXSHYop
	 ZTVBoeR++mPbg==
Date: Sun, 21 Dec 2025 18:43:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: enable temp polling when buffer
 is on
Message-ID: <20251221184309.3d01ab88@jic23-huawei>
In-Reply-To: <20251218-inv-icm42600-do-not-block-temperature-polling-v1-1-909fbd4e240a@tdk.com>
References: <20251218-inv-icm42600-do-not-block-temperature-polling-v1-1-909fbd4e240a@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 10:21:17 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Delete iio_device_claim_direct_mode() when reading temperature.
> It enables polling of temperature data while buffer is on and it
> doesn't have any impact on the other sensors.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
to let 0-day take a look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> index 30f6a9595eea2308ef9ab0660210fc14ca758198..727b03d541a58a27cc9d793da78d1f4a1c460297 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> @@ -59,10 +59,7 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (!iio_device_claim_direct(indio_dev))
> -			return -EBUSY;
>  		ret = inv_icm42600_temp_read(st, &temp);
> -		iio_device_release_direct(indio_dev);
>  		if (ret)
>  			return ret;
>  		*val = temp;
> 
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251218-inv-icm42600-do-not-block-temperature-polling-6533056cb30f
> 
> Best regards,


