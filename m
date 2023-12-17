Return-Path: <linux-iio+bounces-1004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBB815FA5
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 15:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517D0281511
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00B446C6;
	Sun, 17 Dec 2023 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYgohpRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1144C65
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EE2C433C8;
	Sun, 17 Dec 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702822980;
	bh=qOsrk6f4puRqwTxfERwejjowyuSp/mN36/2CtvGL0NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYgohpRjOGDrwDdflmpLW+oeBdOVWEcsQCRigbAKt9NX1yRS+N8qy/bTzbuSz3ExA
	 /9L06Mz7S5VQ7rohC4wYiNvZ3rFPx3NGbkGuBsBR3miR8FenKhO588UNSUXCOlbRlz
	 6QdQ8Owf7XmFX1wVr/s1ZEtRrKUAhbTXNmkgm48utt7/4j436oeo2uM/42cB+X836U
	 V/LP0Vhfx/PJGlADtcIMggoMMBFDw7KSIsTAnAQf6KnnBawuGmy47gBxen1sDg6L6L
	 SzFYl9jQyIrujeyX9PbduqSCyTfvfxD/yLAZFEBQqxeyW6Q2IfCY6Qy9Qmde549q/X
	 l3pD7va3QIAfQ==
Date: Sun, 17 Dec 2023 14:22:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Jonathan.Cameron@huawei.com, lars@metafoo.de,
 Qing-wu.Li@leica-geosystems.com.cn, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmi088: update comments and Kconfig
Message-ID: <20231217142247.0accd7bf@jic23-huawei>
In-Reply-To: <20231214142733.85910-1-jerrysteve1101@gmail.com>
References: <20231214142733.85910-1-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 22:27:33 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> update the comments and Kconfig file with more descriptive and
> accurate information about newly added device: BMI085, BMI090L.
> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Hi Jun Yan,

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig             | 7 ++++---
>  drivers/iio/accel/bmi088-accel-core.c | 2 ++
>  drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index f113dae59048..91adcac875a4 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -260,10 +260,11 @@ config BMI088_ACCEL
>  	select REGMAP
>  	select BMI088_ACCEL_SPI
>  	help
> -	  Say yes here to build support for the Bosch BMI088 accelerometer.
> +	  Say yes here to build support for the following Bosch accelerometers:
> +	  BMI088, BMI085, BMI090L. Note that all of these are combo module that
> +	  include both accelerometer and gyroscope.
>  
> -	  This is a combo module with both accelerometer and gyroscope. This
> -	  driver only implements the accelerometer part, which has its own
> +	  This driver only implements the accelerometer part, which has its own
>  	  address and register map. BMG160 provides the gyroscope driver.
>  
>  config BMI088_ACCEL_SPI
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 84edcc78d796..4d989708e6c3 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -2,6 +2,8 @@
>  /*
>   * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
>   *  - BMI088
> + *  - BMI085
> + *  - BMI090L
>   *
>   * Copyright (c) 2018-2021, Topic Embedded Products
>   */
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index ee540edd8412..7b419a7b2478 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -2,6 +2,8 @@
>  /*
>   * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
>   *  - BMI088
> + *  - BMI085
> + *  - BMI090L
>   *
>   * Copyright (c) 2018-2020, Topic Embedded Products
>   */


