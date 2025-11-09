Return-Path: <linux-iio+bounces-26099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3133C442DF
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43BA5346A3C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE872FFDC0;
	Sun,  9 Nov 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P13zxzlt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD51F4180;
	Sun,  9 Nov 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707292; cv=none; b=QfwmfCfykh8TMCsazAy0llkCY6r46vXaVvARTsb0EVTvxdPgKARJHDNJXFarALuEuimaXKuFc+YfFSGRP3DfqIsMGzEXpxKZ+h/Cfof8DVCJYB3ESRD0Vn2tcfcZYIA5s+Vhagy4vlDY20tN8gQ4NV9OQoAve5ylmMMHEqzK9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707292; c=relaxed/simple;
	bh=/wpTCdz3UjmMfn5iwAu+TiyZ5R+huaPQIxtcSKNdxXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck9NzY4NUn29nKTaXdR64iRKgp8GFnBwbT/jvNMTx3Kx9al+ZAaWzvw+HJwIVZvsdFnqfmSZHFLqCCq6NVe7PBCKEop8oAOnCYmt4DIUOAVHdi9ICzhxLMbsWvhn7ooAy73Kvuyleq7uoVSEkqagvBGzPmT6LvF1an3cop4nSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P13zxzlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E23C19421;
	Sun,  9 Nov 2025 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707292;
	bh=/wpTCdz3UjmMfn5iwAu+TiyZ5R+huaPQIxtcSKNdxXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P13zxzltTdBOJQPKI9i51AQzbbRh+hQruZh/uaiLDtzOJYGZwXRRAQ0Tax4Uv1ab5
	 twin2+GjW/2MnDcx/cex61HtRgXF11rEjkXLty3lORlcCpUUSC3661mj5n/pDZSVXS
	 Fpk1Glj6YEEZxCRev7fNxZP6I8oHCo3+qcwyjQN45hUnYzAZS1QLJ7NJnleVI8qGG1
	 JONFssx6C5DKdO55B+wD8wbbhsLhQ5QWaqZLc03L07GGu8CwpD6cAHiEG6QgWDLkye
	 BlK8IjMcoW/VjTIJoLuahgQQf0Zf+2bLkt992MD7RabO7oWVusnqO8zexsThnIQe2Y
	 UVMvAh5zzch3w==
Date: Sun, 9 Nov 2025 16:54:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Message-ID: <20251109165446.5ef7be81@jic23-huawei>
In-Reply-To: <20251107-icm45600_fix_buffer_sleep_init-v4-1-5648fbfb57ad@tdk.com>
References: <20251107-icm45600_fix_buffer_sleep_init-v4-1-5648fbfb57ad@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Nov 2025 09:13:58 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> The sleep variable in inv_icm45600_buffer_postdisable could be used without
> being assigned in case of error. It must be initialized to 0 by default.
> 
> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> Closes: https://lore.kernel.org/linux-iio/aPi6Xw-ZoUkW76zR@stanley.mountain/
I added a reported-by for Dan as well based on that link.

Applied to the togreg branch of iio.git as this is new code we are fixing from this cycle.

Thanks,

Jonathan

> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
> Changes in v4:
> - Add space in closse tag in commit message
> - Remove extra blank line in commit message
> - Link to v3: https://lore.kernel.org/r/20251106-icm45600_fix_buffer_sleep_init-v3-1-ea3af68a3e61@tdk.com
> 
> Changes in v3:
> - Fix commit message: fix and closes moved to SoB
> - Fix assignement of sleep variable after declaration.
> - Link to v2: https://lore.kernel.org/r/20251031-icm45600_fix_buffer_sleep_init-v2-1-5cdc04e1bcba@tdk.com
> 
> Changes in v2:
> - Moving pacth description from cover-letter to single commit
> - Link to v1: https://lore.kernel.org/r/20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> index 2efcc177f9d60a6a2509e448c0ddaf4b9e1fd755..2b9ea317385ceb680f013c4c1b2a6a74fbe5d7e7 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -370,6 +370,7 @@ static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	sleep = 0;
>  	scoped_guard(mutex, &st->lock)
>  		ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);
>  
> 
> ---
> base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
> change-id: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84
> 
> Best regards,


