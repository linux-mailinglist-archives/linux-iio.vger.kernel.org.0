Return-Path: <linux-iio+bounces-10408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA287998F75
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DD61F221B9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D661CDFD3;
	Thu, 10 Oct 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQxePJ7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78C19D07B;
	Thu, 10 Oct 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583754; cv=none; b=A8a9XjOe3xzWpaCH5lEPWhZTVkPHQjig4L9vx6jw3vH6+zNJK2NVN6vtWrRXsVNmd7eykZ0EXtZeVqSX/y0yNsLoYUuZSo0eWGKBqBzjvJfiqAOCiSyGia2YeoycMkoNezWvqlMOjvBHjqMXcBtW9mU6i5Xp1aeCIOpq7WwW6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583754; c=relaxed/simple;
	bh=aJh8hqhZ6jb+TxSaj3u+M+TB08HBSsjpDstazo9dh/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOcOh8kFO8mAZJtop72IOWnWd7viU3XPvQ0VAvOQME7BddreJq4m1n7esOqvdszZoiyCFtu7WXpAzhFgVDnWMns8zdJQVyTvhjCsKsu3z23VGAd6KIe7rz8bWavcLwEO3zXRWa01uMjJ7+8/XjR7F+Z3zQN6Gf1ymnFBqqfIW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQxePJ7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E7DC4CEC5;
	Thu, 10 Oct 2024 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583754;
	bh=aJh8hqhZ6jb+TxSaj3u+M+TB08HBSsjpDstazo9dh/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQxePJ7g2uhhBotcxea8bJpwbLUF2M0WubO/Mjxn8XnJ0gKAZiXxox7MpjjC9aNMM
	 MxV3S+8Nqj7b1y/Php/xD6iMgY6/tmX7PE6GFgRyYwXC1DZqnsOwwreJQAHkf6YS0m
	 W5t8JDkIAI9hT3jDGFs5tgsPCdSQwZNK2eeTZiSgIPYejM5QXXnoGeQTjUpftq3Szj
	 Hl6DV9Wo6AlL1XiNJWdL3LqTiv9P8SiZ+5bzgoEiUjmiSewIQqrkEj5+E5aN2Snijw
	 XlITCfM36CSdEcYn4MP5sKIbpFXWpqNPlb9FwkcWtSSHaP6VzkP2QQKr9sMO7pg9x9
	 BghzAf1YITY/w==
Date: Thu, 10 Oct 2024 19:09:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: imu: bmi270: Add spi driver for bmi270 imu
Message-ID: <20241010190910.383f4489@jic23-huawei>
In-Reply-To: <20241002033628.681812-1-lanzano.alex@gmail.com>
References: <20241002033628.681812-1-lanzano.alex@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 23:36:22 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> Implement SPI driver for the Bosch BMI270 6-axis IMU. Provide raw read
> write access to acceleration and angle velocity measurements via the SPI
> interface on the device.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>

Hi Alex,

Applied with one minor tweak. See below.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see if we missed anything.

Thanks,

Jonathan

p.s. Thought I'd sent this already - hence I actually applied this last weekend :(

>  struct bmi270_data {
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 8e45343d6472..638ce2c30d0e 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -66,12 +66,6 @@ enum bmi270_scan {
>  	BMI270_SCAN_GYRO_Z,
>  };
>  
> -const struct regmap_config bmi270_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -};
> -EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
> -
>  static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  			   int chan_type, int axis, int *val)
>  {
> @@ -90,7 +84,9 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
> +	ret = regmap_bulk_read(bmi270_device->regmap, reg,
> +			       &sample,
> +			       sizeof(sample));
Trivial but this is an unrelated change.  Possibly valid but doesn't belong
in this patch set. I'll drop it whilst applying.

>  	if (ret)
>  		return ret;
>  


