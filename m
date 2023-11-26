Return-Path: <linux-iio+bounces-401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB87F9470
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE841C20B26
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D812CDDDC;
	Sun, 26 Nov 2023 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COWYlnyu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91369D52B;
	Sun, 26 Nov 2023 17:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5DC433C8;
	Sun, 26 Nov 2023 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701018584;
	bh=S3oBnSKIVaAwos9u+x7GmQmmKapxv7I388lspEsC2bI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COWYlnyuDob5yZ/8Wr0ZT0tTymWeBTs52UHwhZ45F7Vf49nLqkI/Zqz6Lu9snAc7K
	 rD3LPgpyU6NjlH1idl6LlzIhSuqwTK8+T9Ai7hutimfIPITJmSY82Ta08JXAYFwiQn
	 A0Fw/9ZjDl+4cJj3FKonCc0pZu1Sx88r0G2fmRwITZo7v/uEYIGe/n238eRE8zTIzq
	 X0KmtkrBdYwJQ4q8MZJMjtowWZSOblsA+frByz9n3jTZhSltS0bbzaIc4obztti8Tt
	 cQ10yzvs+unZa+dYECjn38p7l7jpd+2VK/1PonTEXXfZSVzK1DC804wU934mWZlV/b
	 KsspJp5eQJA3w==
Date: Sun, 26 Nov 2023 17:09:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
 andy.shevchenko@gmail.com, chenhuiz@axis.com, mranostay@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Message-ID: <20231126170935.3074a06e@jic23-huawei>
In-Reply-To: <20231030020218.65728-1-suhui@nfschina.com>
References: <20231030020218.65728-1-suhui@nfschina.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 10:02:19 +0800
Su Hui <suhui@nfschina.com> wrote:

> inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
> true value rather than only return IIO_VAL_INT.
> 
> Fixes: d5098447147c ("iio: imu: mpu6050: add calibration offset support")
> Signed-off-by: Su Hui <suhui@nfschina.com>
Applied to the fixes-togreg branch of iio.git.

It's independent enough from the improved error reporting that they can hopefully
got through different branches.

Thanks,

Jonathan

> ---
> v3:
>  - add Fixes tag
> v2:
>  - fix the error of commit title.
> v1: 
>  - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 29f906c884bd..a9a5fb266ef1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  
>  		default:
>  			return -EINVAL;


