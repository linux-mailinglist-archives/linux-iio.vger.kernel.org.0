Return-Path: <linux-iio+bounces-11518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCE9B3B35
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5DC1C22079
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4991DFE38;
	Mon, 28 Oct 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwx/3aip"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D691DF753;
	Mon, 28 Oct 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146708; cv=none; b=F6F4k6Gcbf3yrkUHZpwYmuLR/9z4fnHlMdDyydnft4CgqZTYNoVVzd2nJkflOLEXSyHLLWl+U5EQMYsGZNh/77QWufKNK4N8mlY7pbcIqizE11ks8aR+lyGGN+qVgtjxEf7ljqDY5PesJfmxBJyckhnGhLcGNirsZ9Dp/7DTezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146708; c=relaxed/simple;
	bh=5SUnNxKVWVENJsAtwK7JAsZE/0C7b8RZuFMSyTpntOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfGVjxYo9Eb1yPBKcm4ZrxTOgCd44cjt29TL02bh5060zDklxw875tVrxmHkak5mVUqZlfLIDMezHqqwGSbXez2t2qjNQV1ZyoKJ6tCDpNd5TaVJgMQVyPiK1+CF2vPH6JVtWu+8KbFlP33CeHsL0+9iHv0QKlJqN7Z+rlsl19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwx/3aip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E168EC4CEE3;
	Mon, 28 Oct 2024 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146705;
	bh=5SUnNxKVWVENJsAtwK7JAsZE/0C7b8RZuFMSyTpntOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bwx/3aipWoMpQQIIgEkdjUGt1RCTQYebepjURPxWhOJj4Zzb63nHTkBq3CuOU1+64
	 0uRqcasUCaVi1p/6VExDHTwW456bOZDbwlBXkfh1aD2nr2kZR11J9+qWLOhY7PZy5h
	 ZUWcvcqM1MibBDcdfPEo0eTaiEl4zrSFuDLon+T+Ntcg4mZ7eCYk+uTfYrWMnB6kZa
	 QYi0CJ1dbp2YlyakUfAVfHxKRnYWc1LpNYH9aFvTUcqNPXi81MQRqE7Z9d5irnL/yo
	 +bbStYkeUO6Hzc70VDxB5lf5G2w6fCmSgvp76dUF2wdzKehYgVq6463J+LL52xwsPh
	 vhUYRONZw9ntQ==
Date: Mon, 28 Oct 2024 20:18:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v4 0/4] Add i2c driver for Bosch BMI260 IMU
Message-ID: <20241028201817.71bebfee@jic23-huawei>
In-Reply-To: <20241027172029.160134-1-justin@justinweiss.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 10:20:21 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Add support for the Bosch BMI260 IMU to the BMI270 device driver.
> 
> The BMI270 and BMI260 have nearly identical register maps, but have
> different chip IDs and firmware.
> 
> The BMI260 is the IMU on a number of handheld PCs. Unfortunately,
> these devices often misidentify it in ACPI as a BMI160 ("BMI0160," for
> example), and it can only be correctly identified using the chip
> ID. To avoid conflicts with the bmi160 driver, this driver will not
> probe if it detects a BMI160 chip ID.
> 
> Also add triggered buffer and scale / sampling frequency attributes,
> which the input tools commonly used on handheld PCs require to support
> IMUs.
> 
> Like the BMI270, the BMI260 requires firmware to be provided.
> Signed-off-by: Justin Weiss <justin@justinweiss.com>

Applied with a few tweaks thanks to Andy's review.

I'll push this out as testing to let 0-day poke at it before it goes
into linux-next in a few days time.

Thanks,

Jonathan

> ---
> 
> Changelog:
> 
> V4
> - Move triggered buffer and attributes patches to the front of the set
> - Add more detailed commit message to DT documentation patch
> - Remove ACPI IDs from SPI driver
> - Remove 10EC5280 and BMI0260 ACPI IDs from I2C driver
> - Add DSDT excerpt for BMI0160 ACPI ID
> 
> V3
> https://lore.kernel.org/lkml/20241020220011.212395-1-justin@justinweiss.com/
> - Fix: Remove SCALE and FREQUENCY attributes
> - Use separate configuration structures instead of an array
> - Add bmi260 as compatible ID in bmi270 dt binding doc
> - Check chip ID against value in configuration instead of constant
> - Update comment for DMA alignment
> - Remove unreachable return statement
> 
> V2
> https://lore.kernel.org/all/20241018233723.28757-1-justin@justinweiss.com/
> - Fix commit titles
> - Fix: Change FREQUENCY to SAMP_FREQ
> - Split chip_info refactor into a separate commit from adding bmi260
> - Only fail probe when BMI160 is detected
> - Update chip_info based on detected chip ID
> - Add BMI260 to DT documentation
> - Add BMI260 to of_device_id
> - Add expected BMI260 ACPI ID to the SPI driver
> - Remove unused/unexpected BMI260 ACPI IDs
> - Remove trailing comma for null terminators
> - Use DMA_MINALIGN for channel buffer
> - Read channels in bulk
> - Improve for loops for detecting scale / odr attrs
> - Add missing masks
> - Use FIELD_GET
> - Use read_avail instead of custom attrs
> - Misc. formatting and line wrapping improvements
> 
> V1
> https://lore.kernel.org/all/20241011153751.65152-1-justin@justinweiss.com/
> 
> Justin Weiss (4):
>   iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
>   iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
>   dt-bindings: iio: imu: bmi270: Add Bosch BMI260
>   iio: imu: bmi270: Add support for BMI260
> 
>  .../bindings/iio/imu/bosch,bmi270.yaml        |   4 +-
>  drivers/iio/imu/bmi270/Kconfig                |   1 +
>  drivers/iio/imu/bmi270/bmi270.h               |  10 +
>  drivers/iio/imu/bmi270/bmi270_core.c          | 424 +++++++++++++++++-
>  drivers/iio/imu/bmi270/bmi270_i2c.c           |   9 +
>  drivers/iio/imu/bmi270/bmi270_spi.c           |   2 +
>  6 files changed, 448 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090


