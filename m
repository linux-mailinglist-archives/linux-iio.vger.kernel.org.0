Return-Path: <linux-iio+bounces-10771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD1E9A4D2E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203BD1C21395
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973841E0091;
	Sat, 19 Oct 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVASYNh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60318CBF7;
	Sat, 19 Oct 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338021; cv=none; b=aSyYXsKwUQMolpOEPpQfWHYKlX1ZlXSGpuRR1nAuvO5mkUnUwOW8gXt3rk37pLJp9i3it/LsguIoLPYk3MmHvZlqtsyud+BK7DpVOP26HNv56Ipbe98T53AUjYR/F4u0JFhoXRytwExB3BOZD6MDh3eaA52+F0R+zaIV8QDVoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338021; c=relaxed/simple;
	bh=v4LkJ80NQPm85wR1G2ziYwxdba3NkVX/9/XwrEpfKJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2LSqmtxFjqEJa87GFoDvDdJU/7YwPkJ5d3rXTKSBxExTlYBqRxH8sTdO73DyV0u3h7Xv1Tmd93i44IgDaedEXUVz5RJ++67/WA1dotq2gVRKKMZcvmPsXOf322wc5GKUc80cvCvR5Vs7QhGt27E049IoUhNCIfv1Z8VV5MqUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVASYNh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC56C4CEC5;
	Sat, 19 Oct 2024 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729338020;
	bh=v4LkJ80NQPm85wR1G2ziYwxdba3NkVX/9/XwrEpfKJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RVASYNh8QV6z1j2M3mrQdgp2SzqMwQEupADP1lKkQM8Ky4UqNfpP7hxnkiy39VhaL
	 DEjpHpa1VhayTRDdcGBj5mlp+yd8lx84JavkIIFCjb1Tc/RL/clqjTBre3K12frHE5
	 KSYxm7Np/Y8cd+mJEPSXw0wTxytitNhUJAmW1/HxeM0lIO1h1P9ytPXhL8sOUUvzj3
	 s5f6W8XeR8PwEtyC14dTlaVYoblVyRJGEolSe2NNPjjmZ1M31sdQEEbKvOQ/soclMR
	 GmSEj+gpX0iEmqJsCZywxV0gf5Hjz0LI9n9fa83Q06xLbrJfOuzsPMxNcLPmJe48q/
	 +KTQ3bdBf442w==
Date: Sat, 19 Oct 2024 12:40:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <20241019124013.0575e05b@jic23-huawei>
In-Reply-To: <20241018233723.28757-5-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-5-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:36:10 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Adds support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
> driver. Setup and operation is nearly identical to the Bosch BMI270,
> but has a different chip ID and requires different firmware.
> 
> Firmware is requested and loaded from userspace.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
Trivial comments inline and a discussion on whether my earlier
don't use an array comment makes sense in this particular case.

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270.h      |  1 +
>  drivers/iio/imu/bmi270/bmi270_core.c | 25 +++++++++++++++++++++++--
>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 13 +++++++++++++
>  drivers/iio/imu/bmi270/bmi270_spi.c  |  8 ++++++++
>  4 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 2e8d85a4e419..51e374fd4290 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -14,6 +14,7 @@ struct bmi270_data {
>  };
>  
>  enum bmi270_device_type {
> +	BMI260,
>  	BMI270,
>  };
>  
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 799df78ec862..b30201dc4e22 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -11,6 +11,8 @@
>  #include "bmi270.h"
>  
>  #define BMI270_CHIP_ID_REG				0x00
> +#define BMI160_CHIP_ID_VAL				0xD1

This one looks like a cut and paste error.

> +#define BMI260_CHIP_ID_VAL				0x27
>  #define BMI270_CHIP_ID_VAL				0x24
>  #define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
>  
> @@ -55,6 +57,7 @@
>  #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
>  #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
>  
> +#define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>  
>  enum bmi270_scan {
> @@ -67,6 +70,11 @@ enum bmi270_scan {
>  };
>  
>  const struct bmi270_chip_info bmi270_chip_info[] = {
> +	[BMI260] = {
> +		.name = "bmi260",
> +		.chip_id = BMI260_CHIP_ID_VAL,
> +		.fw_name = BMI260_INIT_DATA_FILE,
> +	},
>  	[BMI270] = {
>  		.name = "bmi270",
>  		.chip_id = BMI270_CHIP_ID_VAL,
> @@ -163,8 +171,21 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>  
> -	if (chip_id != BMI270_CHIP_ID_VAL)
> -		dev_info(dev, "Unknown chip id 0x%x", chip_id);
> +	/*
> +	 * Some manufacturers use "BMI0160" for both the BMI160 and
> +	 * BMI260. If the device is actually a BMI160, the bmi160
> +	 * driver should handle it and this driver should not.
> +	 */
> +	if (chip_id == BMI160_CHIP_ID_VAL)
> +		return -ENODEV;
> +
> +	if (chip_id != bmi270_device->chip_info->chip_id)
> +		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
> +
> +	if (chip_id == BMI260_CHIP_ID_VAL)

Ah. My argument on separate IDs means you'd have to do it this way whereas
I was thinking maybe a loop would be a better idea.  Ah well if we
get a lot of supported chips, then we can rethink how to handle this.
For now what you have here is fine and should deal with lack of appropriate
ACPI ID mess.

> +		bmi270_device->chip_info = &bmi270_chip_info[BMI260];
> +	else if (chip_id == BMI270_CHIP_ID_VAL)
> +		bmi270_device->chip_info = &bmi270_chip_info[BMI270];
>  
>  	return 0;
>  }

