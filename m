Return-Path: <linux-iio+bounces-4588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA88B4C8F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8552815A8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4096F506;
	Sun, 28 Apr 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjg+v0kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C466EB7D;
	Sun, 28 Apr 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714320195; cv=none; b=TGgOS9JcnBIsFnl1KVpiE+jfu931+a4NgIDHrKCZ48GDmp11+pa0K0TLcrdIFFLsEdO1fPPSU/+4Xn9chqElbhYWgEqk65Z42I+KwOzHe5EPwAkAhyx+XdweuFXet8SI4Sbo++GhcwTTQ5eCAmnXoQhOlxrp5YgL6PHAXB3Rov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714320195; c=relaxed/simple;
	bh=POEt0jqQt1D7BK1WyESa7X5PnNNdquqVF2VX6nCqx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9Uf+TZ+0jTrg7XYE+v/x0QZkS9BsqAfwaqjnkG4ArqqIuXfsA4j80G1uWqNCy2TJETPjT63azMMtL6bLDtbgvGFaHwT0ZF/iMTlZUfsptieJNrc4+1ovAOjvLDHBSZMU6PnUyGnOLnMLkFHFs4Yu7BC05cXUKvAU9psINQkYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjg+v0kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DAAC113CC;
	Sun, 28 Apr 2024 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714320195;
	bh=POEt0jqQt1D7BK1WyESa7X5PnNNdquqVF2VX6nCqx3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjg+v0kfLKHskPotpOv9r/8AU4qkQCTVpSqwCBnhVJBp6we/vmnlFxwmnQ6+gCFSo
	 sPYzRlmu/fbuzmoXmdQpV0u+ZDxRoC4GeVeowmnusmPEF2wtZ24iYa7oTyJ5tSy5dz
	 yIhL33nSBqUq6d9ilIs/ttPIFel0RKkOCUtymjTtbODYhOSMLY+5UqyHonvYybYGSd
	 imSLGynFQjrI2vNctM9/YsQFmgamEReof1EUekEPP+8nE0I8AzLLVuVJ3oGTnd81Np
	 t8UYYYROtSPcv7macqcCfzXTM9OFN3QjsXxiwUGxxmsSusL69DJqbX01DOapfxp52/
	 WMX38//Gk1eSA==
Date: Sun, 28 Apr 2024 17:03:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add support of ICM-42686-P
Message-ID: <20240428170303.11b532c9@jic23-huawei>
In-Reply-To: <20240422152240.85974-3-inv.git-commit@tdk.com>
References: <20240422152240.85974-1-inv.git-commit@tdk.com>
	<20240422152240.85974-3-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 15:22:40 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add ICM-42686-P chip supporting high FSRs (32G, 4000dps).
> 
> Create accel and gyro iio device states with dynamic scales table
> set at device init.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Some comments inline, but given this is in line with the existing driver
approaches, those can wait for another day. I'll tidy up the blank line
comment.

Applied to the togreg branch of iio.git and pushed out initially as
testing for all the normal boring reasons.

Jonathan


> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 82e0a2e2ad70..42316fb72674 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -65,6 +65,21 @@ static const struct inv_icm42600_conf inv_icm42600_default_conf = {
>  	},
>  	.temp_en = false,
>  };
Blank line here.

> +static const struct inv_icm42600_conf inv_icm42686_default_conf = {
> +	.gyro = {
> +		.mode = INV_ICM42600_SENSOR_MODE_OFF,
> +		.fs = INV_ICM42686_GYRO_FS_4000DPS,
> +		.odr = INV_ICM42600_ODR_50HZ,
> +		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
> +	},
> +	.accel = {
> +		.mode = INV_ICM42600_SENSOR_MODE_OFF,
> +		.fs = INV_ICM42686_ACCEL_FS_32G,
> +		.odr = INV_ICM42600_ODR_50HZ,
> +		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
> +	},
> +	.temp_en = false,
> +};
>  
>  static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
>  	[INV_CHIP_ICM42600] = {
> @@ -82,6 +97,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
>  		.name = "icm42605",
>  		.conf = &inv_icm42600_default_conf,
>  	},
> +	[INV_CHIP_ICM42686] = {
> +		.whoami = INV_ICM42600_WHOAMI_ICM42686,
> +		.name = "icm42686",
> +		.conf = &inv_icm42686_default_conf,
> +	},
>  	[INV_CHIP_ICM42622] = {
>  		.whoami = INV_ICM42600_WHOAMI_ICM42622,
>  		.name = "icm42622",
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 3df0a715e885..e6f8de80128c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

> @@ -716,8 +750,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
>  {
>  	struct device *dev = regmap_get_device(st->map);
>  	const char *name;
> +	struct inv_icm42600_sensor_state *gyro_st;
>  	struct inv_sensors_timestamp_chip ts_chip;
> -	struct inv_sensors_timestamp *ts;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> @@ -725,9 +759,21 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
>  	if (!name)
>  		return ERR_PTR(-ENOMEM);
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
>  	if (!indio_dev)
>  		return ERR_PTR(-ENOMEM);
> +	gyro_st = iio_priv(indio_dev);
> +
> +	switch (st->chip) {
> +	case INV_CHIP_ICM42686:
> +		gyro_st->scales = inv_icm42686_gyro_scale;
> +		gyro_st->scales_len = ARRAY_SIZE(inv_icm42686_gyro_scale);

I'd have preferred this data being in the inv_icm42600_hw structures but that
is a more major refactor.   Longer term having any cases like this be simple
'data' rather than code would make for a cleaner and more flexible driver.

> +		break;
> +	default:
> +		gyro_st->scales = inv_icm42600_gyro_scale;
> +		gyro_st->scales_len = ARRAY_SIZE(inv_icm42600_gyro_scale);
> +		break;
> +	}


