Return-Path: <linux-iio+bounces-10951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04F9AB60F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4301C234AE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617131C9EB8;
	Tue, 22 Oct 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJKajDpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F51C9DFF;
	Tue, 22 Oct 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622641; cv=none; b=iy9m2jMRHqVfqg4S6MjyBEfG4/TaF1J7JW+z6DR830sYynrk5nPEpGzabucnNpwiXcEu0xZ3tzcgEoQ9JvW4aupLhQjyypsu13tFpPyskzK0UgLR5FTNdMlVXQ8YM63Tu+EiFFVcqW7JhimPUWHP6SWflmNJngB3GtswX4rFW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622641; c=relaxed/simple;
	bh=S9Iu6MS/RKcuXO5OOHTkDgzUZg37PqUq2KzxpZk2RdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzMj2tRL7m08ODSla/540RfQ2WT4QjUWmcC4ga6uJ+yoYJe6k2DfMLQytui/ricGRpDz6bSeypyfNEqD65v0iBTT3uQCjw+dKWUIoOEJUAy+SarmE2qz3RQJhg53LH1vIsNa2jCwGThtm4/S/qs7nZUqjufXDxbziL8zq+iiuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJKajDpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FABC4CEC3;
	Tue, 22 Oct 2024 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729622640;
	bh=S9Iu6MS/RKcuXO5OOHTkDgzUZg37PqUq2KzxpZk2RdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FJKajDpG2OBwYmrajraR2uJuY2P2Q7jlrDcMIeRRT1Jt2/vPd+8W8g8TJ9qsVsZpk
	 c1wzL94kA9u/zC5O1fDRa5zXMYdCpsKiYLbJV74CXW0P6P4hCP/Yvf1tohOsl4m2Zh
	 gXyM6HYDlb/FG1lPS8IztNHGHqhh99qh27FuK47ld5SOwnn1E+1nvgAPpZ5nS0nytY
	 PvwHVCtY87IeGXQ2iLk/PK8LNqDI6VOQ90tw7txDlhUwKs79wcnwVWjr7JWhFG4TGn
	 CStx7WOKK9uhlvPmySjKiBdXhPLoPvZRM2AB1WUEGe3BVUhC+GIHP9TknX5KuVzNPB
	 szfeW/UjnFVnA==
Date: Tue, 22 Oct 2024 19:43:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v3 2/6] iio: imu: bmi270: Provide chip info as
 configuration structure
Message-ID: <20241022194351.39c832d3@jic23-huawei>
In-Reply-To: <20241020220011.212395-3-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-3-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 15:00:06 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Prepare the bmi270 driver to support similar devices like the bmi260.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
In the interests of reducing how many patches are in flight I'll
pick this one as well. Can't go beyond this point though until patch 3
gets a DT RB.
> ---
>  drivers/iio/imu/bmi270/bmi270.h      | 11 ++++++++++-
>  drivers/iio/imu/bmi270/bmi270_core.c | 18 ++++++++++++++----
>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 11 ++++++++---
>  drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
>  4 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 8ac20ad7ee94..93e5f387607b 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -10,10 +10,19 @@ struct device;
>  struct bmi270_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	const struct bmi270_chip_info *chip_info;
> +};
> +
> +struct bmi270_chip_info {
> +	const char *name;
> +	int chip_id;
> +	const char *fw_name;
>  };
>  
>  extern const struct regmap_config bmi270_regmap_config;
> +extern const struct bmi270_chip_info bmi270_chip_info;
>  
> -int bmi270_core_probe(struct device *dev, struct regmap *regmap);
> +int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> +		      const struct bmi270_chip_info *chip_info);
>  
>  #endif  /* BMI270_H_ */
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index e598c642178f..5f08d786fa21 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -66,6 +66,13 @@ enum bmi270_scan {
>  	BMI270_SCAN_GYRO_Z,
>  };
>  
> +const struct bmi270_chip_info bmi270_chip_info = {
> +	.name = "bmi270",
> +	.chip_id = BMI270_CHIP_ID_VAL,
> +	.fw_name = BMI270_INIT_DATA_FILE,
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
> +
>  static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  			   int chan_type, int axis, int *val)
>  {
> @@ -150,7 +157,7 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>  
> -	if (chip_id != BMI270_CHIP_ID_VAL)
> +	if (chip_id != bmi270_device->chip_info->chip_id)
>  		dev_info(dev, "Unknown chip id 0x%x", chip_id);
>  
>  	return 0;
> @@ -183,7 +190,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to prepare device to load init data");
>  
> -	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
> +	ret = request_firmware(&init_data,
> +			       bmi270_device->chip_info->fw_name, dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to load init data file");
>  
> @@ -270,7 +278,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
>  	return bmi270_configure_imu(bmi270_device);
>  }
>  
> -int bmi270_core_probe(struct device *dev, struct regmap *regmap)
> +int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> +		      const struct bmi270_chip_info *chip_info)
>  {
>  	int ret;
>  	struct bmi270_data *bmi270_device;
> @@ -283,6 +292,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
>  	bmi270_device = iio_priv(indio_dev);
>  	bmi270_device->dev = dev;
>  	bmi270_device->regmap = regmap;
> +	bmi270_device->chip_info = chip_info;
>  
>  	ret = bmi270_chip_init(bmi270_device);
>  	if (ret)
> @@ -290,7 +300,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
>  
>  	indio_dev->channels = bmi270_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
> -	indio_dev->name = "bmi270";
> +	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmi270_info;
>  
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index d59161f23f9a..394f27996059 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -17,22 +17,27 @@ static int bmi270_i2c_probe(struct i2c_client *client)
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
> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
>  	{ }
>  };
>  
>  static const struct of_device_id bmi270_of_match[] = {
> -	{ .compatible = "bosch,bmi270" },
> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
>  	{ }
>  };
>  
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index b53784d4a1f4..7c2062c660d9 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -49,6 +49,11 @@ static int bmi270_spi_probe(struct spi_device *spi)
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
> @@ -56,16 +61,16 @@ static int bmi270_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to init i2c regmap");
>  
> -	return bmi270_core_probe(dev, regmap);
> +	return bmi270_core_probe(dev, regmap, chip_info);
>  }
>  
>  static const struct spi_device_id bmi270_spi_id[] = {
> -	{ "bmi270" },
> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
>  	{ }
>  };
>  
>  static const struct of_device_id bmi270_of_match[] = {
> -	{ .compatible = "bosch,bmi270" },
> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
>  	{ }
>  };
>  


