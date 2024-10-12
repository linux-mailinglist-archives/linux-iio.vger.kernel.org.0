Return-Path: <linux-iio+bounces-10491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8199B345
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C4CB23371
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735015A84E;
	Sat, 12 Oct 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaoC8X7p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F9156871;
	Sat, 12 Oct 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731317; cv=none; b=e+aXBk+HNjC1q2B5Mhccwd6EiGDH6G6gzwkMxPKVluOeaadgDKS+cXczX+H1vLpxTVGcS5LBF7GHJ2dYSacbvfoPtOVAG/YXB8JZoxuD8QqeHeJQam2GDocbWV/vsNQdDMHySsxZ5X5ka5hPPB/qvuEFp5+oteTZB51UIu+7yFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731317; c=relaxed/simple;
	bh=0rYcylrefL4m81qr72QhLD3AAm1h6fiG93/c5iVDlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFA0xpUzCfNhDo+pfSQgAI4mmhPCfOwE6Mwem4MmeP3deow8uqSyHv/DQBV8xmPnp0civvlDEfad2Zh5nZCn0nudDAvYO+ibf2GJbXojRWfvFjaAiO1/uG8V/BkmsYoGhmLeOkFeFDcp8F2cf/WU6rci7DEHreVx1ynRLqCNPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaoC8X7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20DCC4CEC7;
	Sat, 12 Oct 2024 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728731317;
	bh=0rYcylrefL4m81qr72QhLD3AAm1h6fiG93/c5iVDlSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AaoC8X7p0jaXqz/fj6RlnP9PlXv0y6nQ7pPw3srXn3wXbOE1ClxXxLDpEdfzKko0n
	 M/mo09DDO4fPMYfEsyImQ5ZZ8CC7w2WLf9ws5uo7ZC5U2tmT3ntwzNcu1Y5AVDFrkx
	 19NoyqGnfYJRh9ypXGNHqZYYFirW246jlL5cWPGAZFXUjrSvwqCAS0aplZu8hw+tGP
	 l2P1+BxJr/kO2tDq2Iu9I70bX4ARxicAHKyVh1zc6U12seRyztksmmat5+B+OFEXio
	 pZzNQSHnIwczngeLxFdEKmIzOfUbrsuMHGa7GVnMIMMFLObxvfpbVkvcbkv6n9oSia
	 0NaT9yrhBE/jg==
Date: Sat, 12 Oct 2024 12:08:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
Message-ID: <20241012120830.338aca19@jic23-huawei>
In-Reply-To: <20241011153751.65152-2-justin@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-2-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 08:37:47 -0700
Justin Weiss <justin@justinweiss.com> wrote:

Title needs an edit to reflect the description that follows.

iio: imu: bmi270: Add i2c support for bmi260


> Adds i2c support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
> driver. Setup and operation is nearly identical to the Bosch BMI270,
> but has a different chip ID and requires different firmware.
> 
> Firmware is requested and loaded from userspace.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> ---
>  drivers/iio/imu/bmi270/bmi270.h      | 16 ++++++++++++++-
>  drivers/iio/imu/bmi270/bmi270_core.c | 29 +++++++++++++++++++++++-----
>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 22 ++++++++++++++++++---
>  drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
>  4 files changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 8ac20ad7ee94..51e374fd4290 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -10,10 +10,24 @@ struct device;
>  struct bmi270_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	const struct bmi270_chip_info *chip_info;
> +};
> +
> +enum bmi270_device_type {
> +	BMI260,
> +	BMI270,
> +};
It is obviously fairly trivial in this case, but the 'ideal' form for
a patch series adding this flexibility is:
Patch 1) Add a noop refactor to include the configuration structures etc.
Patch 2) Add the support for the new device.

First patch can then be reviewed on basis it's not destructive and second one just for
the chip specific data added


> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index aeda7c4228df..e5ee80c12166 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -11,6 +11,7 @@

>  static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  			   int chan_type, int axis, int *val)
>  {
> @@ -154,8 +170,8 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>  
> -	if (chip_id != BMI270_CHIP_ID_VAL)
> -		dev_info(dev, "Unknown chip id 0x%x", chip_id);
> +	if (chip_id != bmi270_device->chip_info->chip_id)
If we have multiple known IDs it can be slightly more friendly to check them all
and if another one matches, just moan about broken firmware before carrying on
using the correct data.

> +		return dev_err_probe(dev, -ENODEV, "Unknown chip id 0x%x", chip_id);
>  
>  	return 0;
>  }
> @@ -187,7 +203,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to prepare device to load init data");
>  
> -	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
> +	ret = request_firmware(&init_data,
> +			       bmi270_device->chip_info->fw_name, dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to load init data file");
>  
> @@ -274,7 +291,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
>  	return bmi270_configure_imu(bmi270_device);
>  }

> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index e9025d22d5cc..c8c90666c76b 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -18,28 +18,44 @@ static int bmi270_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	struct device *dev = &client->dev;
> +	const struct bmi270_chip_info *chip_info;
> +
> +	chip_info = i2c_get_match_data(client);
> +	if (!chip_info)
> +		return -ENODEV;
>  
>  	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to init i2c regmap");
>  
> -	return bmi270_core_probe(dev, regmap);
> +	return bmi270_core_probe(dev, regmap, chip_info);
>  }
>  
>  static const struct i2c_device_id bmi270_i2c_id[] = {
> -	{ "bmi270", 0 },
> +	{ "bmi260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
>  	{ }
>  };
>  
> +static const struct acpi_device_id bmi270_acpi_match[] = {
> +	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> +	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> +	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> +	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },

Sigh.  That's not a valid ACPI ID or PNP ID.
(Well technically it is, but it belongs to the Benson Instrument Company
not Bosch)

Which of these have been seen in the wild?
For any that are not of the BOSC0160 type form add a comment giving
a device on which they are in use.

> +	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },

What's this one?  There is no such vendor ID.

> +	{ },
No trailing comma on null terminators like this.

> +};
> +
>  static const struct of_device_id bmi270_of_match[] = {
> -	{ .compatible = "bosch,bmi270" },
> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },

Add the 260 here as well + add to the dt docs.

>  	{ }
>  };
>  
>  static struct i2c_driver bmi270_i2c_driver = {
>  	.driver = {
>  		.name = "bmi270_i2c",
> +		.acpi_match_table = bmi270_acpi_match,
>  		.of_match_table = bmi270_of_match,
>  	},
>  	.probe = bmi270_i2c_probe,
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index 34d5ba6273bb..3d240f9651bc 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -50,6 +50,11 @@ static int bmi270_spi_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
>  	struct device *dev = &spi->dev;
> +	const struct bmi270_chip_info *chip_info;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODEV;
>  
>  	regmap = devm_regmap_init(dev, &bmi270_regmap_bus, dev,
>  				  &bmi270_spi_regmap_config);
> @@ -57,16 +62,16 @@ static int bmi270_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to init i2c regmap");
>  
> -	return bmi270_core_probe(dev, regmap);
> +	return bmi270_core_probe(dev, regmap, chip_info);
>  }
>  
>  static const struct spi_device_id bmi270_spi_id[] = {
> -	{ "bmi270" },
> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
>  	{ }
>  };
>  
>  static const struct of_device_id bmi270_of_match[] = {
> -	{ .compatible = "bosch,bmi270" },
> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },

If the bmi260 supports SPI, should be added here as well. (I've no idea if it does!)

Or is this because you can't test it?

>  	{ }
>  };
>  


