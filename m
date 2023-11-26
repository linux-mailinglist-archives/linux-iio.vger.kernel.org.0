Return-Path: <linux-iio+bounces-400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B77F946A
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D48B20DBB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE07DDD8;
	Sun, 26 Nov 2023 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRTmJQ3x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A375DDA7;
	Sun, 26 Nov 2023 17:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A08C433C7;
	Sun, 26 Nov 2023 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701018428;
	bh=XUM7qw4H5Ny7dZR+MIodYJqjaaevZ0Fq9kn1EHutWXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LRTmJQ3xoY1hLDtcHRx+zh0vqin88ikJAaqkKXbeQBPgdpdMb7EN9II+FYQWLCxKN
	 x1fY/MjjzXIbFiFikjMXSjppbLfeEzTWcyLudo4O+CnVfWRx5I6KvFArjkT7qSmMpD
	 CyapR6bScFuplZRJOSSwOFqsxWTwW11PWMlNtPZllln7CSZMpa8vk7ghopfSLZSvdY
	 8Xp2M7TjfAI8sPpupBhPDJpOZyaSqg8v+tDmbtDRQZCkUIKAHS0Zdedjslwb7/17u0
	 9gD++jL+iZtGHHwF6z+8xvzJsZPdcmS6EA0AHIFwxOA3LMZQrizz1hnWdOlESxu74E
	 ma4FxdS0A3xjA==
Date: Sun, 26 Nov 2023 17:07:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: lars@metafoo.de, jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
 andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: return callee's error code
 rather than -EINVAL
Message-ID: <20231126170700.550d20e7@jic23-huawei>
In-Reply-To: <20231030020752.67630-1-suhui@nfschina.com>
References: <20231030020752.67630-1-suhui@nfschina.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 10:07:53 +0800
Su Hui <suhui@nfschina.com> wrote:

> regmap_bulk_write()/regmap_bulk_read() return zero or negative error
> code, return the callee's error code is better than '-EINVAL'.
Thanks and fully agree - though one small tweak I made whilst applying is mentioned
below.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if we missed anything.

> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index a9a5fb266ef1..5ded0781797c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -572,7 +572,7 @@ static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
>  	ind = (axis - IIO_MOD_X) * 2;
>  	result = regmap_bulk_write(st->map, reg + ind, &d, sizeof(d));
>  	if (result)
> -		return -EINVAL;
> +		return result;
>  
>  	return 0;
I tweaked this to go further

	return regmap_bulk_write();

>  }
> @@ -586,7 +586,7 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  	ind = (axis - IIO_MOD_X) * 2;
>  	result = regmap_bulk_read(st->map, reg + ind, &d, sizeof(d));
>  	if (result)
> -		return -EINVAL;
> +		return result;
>  	*val = (short)be16_to_cpup(&d);
>  
>  	return IIO_VAL_INT;


