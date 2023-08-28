Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABB78AF4F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjH1Lue (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjH1Lub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC45A6;
        Mon, 28 Aug 2023 04:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA8763BCD;
        Mon, 28 Aug 2023 11:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17650C433C7;
        Mon, 28 Aug 2023 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693223428;
        bh=8xo8j+niCNMxfIkp+dOj3mvzxqKTb/LA6X3WeKgkXko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oLzkdH2GI2GPVGYU6Zs64ts2l6qzM+rwoJyT3itxtJcbRniSPKb+Hzuo6yZa3VQiz
         bla7c3eNCCe+vVpdSYNWIbDdhloAahGKdWHYh7JtwhBtsII/F0sP0SAcb2N4ya9z/b
         Ws5D5kbFpAx/xguU+9XjXv8qwjJI7WB/bt6Ayq3c/ql4sOfsqiC29jM8RvxNDdaYOr
         0Q+BQaiDVFj2B1Wx0XVYMl4AGH9BjicSlTv4N2PGZ1dhYyxWIAWIO474xBhqm6Uml5
         k1Lh0ZYt4q50X3Dc/knBziMscYzlignrMKesH7UosQPFnlpqg7TvXU6SbAMys0SOvQ
         3LW2HmHM6Hjyg==
Date:   Mon, 28 Aug 2023 12:50:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: adxl345: Convert enum->pointer for data
 in match data table
Message-ID: <20230828125047.406d667b@jic23-huawei>
In-Reply-To: <20230818181229.329055-1-biju.das.jz@bp.renesas.com>
References: <20230818181229.329055-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 19:12:29 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in match data table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Add struct adxl3x5_chip_info and replace enum->adxl3x5_chip_info in the
> match table and simplify adxl345_probe().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Replaced EINVAL->ENODEV for invaild chip type.
>  * Kept leading commas for adxl345_*_info and adxl375_*_info.
>  * Restored switch statement in adxl345_core_probe()

One more thing inline.

> ---
>  drivers/iio/accel/adxl345.h      |  5 +++++
>  drivers/iio/accel/adxl345_core.c | 16 ++++++----------
>  drivers/iio/accel/adxl345_i2c.c  | 20 +++++++++++++++-----
>  drivers/iio/accel/adxl345_spi.c  | 20 +++++++++++++++-----
>  4 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index d7e67cb08538..8df1b7f43cb9 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -13,6 +13,11 @@ enum adxl345_device_type {
>  	ADXL375 = 2,
>  };
>  
> +struct adxl3x5_chip_info {
> +	const char *name;
> +	unsigned int type;
> +};
> +
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap);
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 1919e0089c11..810048099ba9 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -222,23 +222,19 @@ static void adxl345_powerdown(void *regmap)
>  
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  {
> -	enum adxl345_device_type type;
> +	const struct adxl3x5_chip_info *info;
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
> -	const char *name;
>  	u32 regval;
>  	int ret;
>  
> -	type = (uintptr_t)device_get_match_data(dev);
> -	switch (type) {
> +	info = device_get_match_data(dev);
> +	switch (info->type) {
>  	case ADXL345:
> -		name = "adxl345";
> -		break;
>  	case ADXL375:
> -		name = "adxl375";
>  		break;
>  	default:
> -		return -EINVAL;
> +		return -ENODEV;
>  	}
Why not just
	if (!info)
		return -ENODEV;

All of the structures have one of these two types anyway, so what is the point
in checking the type field.


>  
>  	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> @@ -255,7 +251,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> -	data->type = type;
> +	data->type = info->type;
>  	/* Enable full-resolution mode */
>  	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
>  
> @@ -264,7 +260,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to set data range\n");
>  
> -	indio_dev->name = name;
> +	indio_dev->name = info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl345_channels;
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index e47d12f19602..219de556e81a 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -30,22 +30,32 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	return adxl345_core_probe(&client->dev, regmap);
>  }
>  
> +static const struct adxl3x5_chip_info adxl345_i2c_info = {
> +	.name = "adxl345",
> +	.type = ADXL345,
> +};
> +
> +static const struct adxl3x5_chip_info adxl375_i2c_info = {
> +	.name = "adxl375",
> +	.type = ADXL375,
> +};
> +
>  static const struct i2c_device_id adxl345_i2c_id[] = {
> -	{ "adxl345", ADXL345 },
> -	{ "adxl375", ADXL375 },
> +	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
> +	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
>  
>  static const struct of_device_id adxl345_of_match[] = {
> -	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
> -	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
> +	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
> +	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adxl345_of_match);
>  
>  static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", ADXL345 },
> +	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index aaade5808657..3acdacc07293 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -36,22 +36,32 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	return adxl345_core_probe(&spi->dev, regmap);
>  }
>  
> +static const struct adxl3x5_chip_info adxl345_spi_info = {
> +	.name = "adxl345",
> +	.type = ADXL345,
> +};
> +
> +static const struct adxl3x5_chip_info adxl375_spi_info = {
> +	.name = "adxl375",
> +	.type = ADXL375,
> +};
> +
>  static const struct spi_device_id adxl345_spi_id[] = {
> -	{ "adxl345", ADXL345 },
> -	{ "adxl375", ADXL375 },
> +	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
> +	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
>  
>  static const struct of_device_id adxl345_of_match[] = {
> -	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
> -	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
> +	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
> +	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adxl345_of_match);
>  
>  static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", ADXL345 },
> +	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);

