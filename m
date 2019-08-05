Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF57382052
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfHEPeU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfHEPeU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:34:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C3720B1F;
        Mon,  5 Aug 2019 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565019259;
        bh=nFZl8Ezzm4gz9Nz30tAC5bC8jHrdhY6mFkbX5D53lx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=daZiDgOftPc6OZSPYfT2nfPYh92+bhwM0gB0iubHKicm5h1tCvzPQikK4rKVrN0zu
         +iY1U/uFL6RGRp77MTpUDPYiMsaYX344zG79UtK+StVjJ/uZGcQz0hjfOCEkbBwxA3
         Uu+9h9XjqjG9ViChTTV8Sx0Rb4Q2jhFN13s+mgMg=
Date:   Mon, 5 Aug 2019 16:34:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: tsl2772: Use regulator_bulk_() APIs
Message-ID: <20190805163414.369561ab@archlinux>
In-Reply-To: <20190801073619.9743-1-hslester96@gmail.com>
References: <20190801073619.9743-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Aug 2019 15:36:19 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use regulator_bulk_() APIs to shrink driver size.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v4:
>   - Change the var name of regulator_bulk_data.
>   - Adjust alignment.
>   - Add a new line between two if blocks.
> 
>  drivers/iio/light/tsl2772.c | 87 +++++++++++++------------------------
>  1 file changed, 29 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 680afdb078d2..be37fcbd4654 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -134,6 +134,12 @@ enum {
>  	TSL2772_CHIP_SUSPENDED = 2
>  };
>  
> +enum {
> +	TSL2772_SUPPLY_VDD = 0,
> +	TSL2772_SUPPLY_VDDIO = 1,
> +	TSL2772_NUM_SUPPLIES = 2
> +};
> +
>  /* Per-device data */
>  struct tsl2772_als_info {
>  	u16 als_ch0;
> @@ -161,8 +167,7 @@ struct tsl2772_chip {
>  	struct mutex prox_mutex;
>  	struct mutex als_mutex;
>  	struct i2c_client *client;
> -	struct regulator *vdd_supply;
> -	struct regulator *vddio_supply;
> +	struct regulator_bulk_data supplies[TSL2772_NUM_SUPPLIES];
>  	u16 prox_data;
>  	struct tsl2772_als_info als_cur_info;
>  	struct tsl2772_settings settings;
> @@ -697,46 +702,7 @@ static void tsl2772_disable_regulators_action(void *_data)
>  {
>  	struct tsl2772_chip *chip = _data;
>  
> -	regulator_disable(chip->vdd_supply);
> -	regulator_disable(chip->vddio_supply);
> -}
> -
> -static int tsl2772_enable_regulator(struct tsl2772_chip *chip,
> -				    struct regulator *regulator)
> -{
> -	int ret;
> -
> -	ret = regulator_enable(regulator);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static struct regulator *tsl2772_get_regulator(struct tsl2772_chip *chip,
> -					       char *name)
> -{
> -	struct regulator *regulator;
> -	int ret;
> -
> -	regulator = devm_regulator_get(&chip->client->dev, name);
> -	if (IS_ERR(regulator)) {
> -		if (PTR_ERR(regulator) != -EPROBE_DEFER)
> -			dev_err(&chip->client->dev,
> -				"Failed to get %s regulator %d\n",
> -				name, (int)PTR_ERR(regulator));
> -
> -		return regulator;
> -	}
> -
> -	ret = tsl2772_enable_regulator(chip, regulator);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -
> -	return regulator;
> +	regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
>  }
>  
>  static int tsl2772_chip_on(struct iio_dev *indio_dev)
> @@ -1804,14 +1770,26 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	chip->client = clientp;
>  	i2c_set_clientdata(clientp, indio_dev);
>  
> -	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
> -	if (IS_ERR(chip->vddio_supply))
> -		return PTR_ERR(chip->vddio_supply);
> +	chip->supplies[TSL2772_SUPPLY_VDD].supply = "vdd";
> +	chip->supplies[TSL2772_SUPPLY_VDDIO].supply = "vddio";
>  
> -	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
> -	if (IS_ERR(chip->vdd_supply)) {
> -		regulator_disable(chip->vddio_supply);
> -		return PTR_ERR(chip->vdd_supply);
> +	ret = devm_regulator_bulk_get(&clientp->dev,
> +				      ARRAY_SIZE(chip->supplies),
> +				      chip->supplies);
> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&clientp->dev,
> +				"Failed to get regulators: %d\n",
> +				ret);
> +
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
> +	if (ret < 0) {
> +		dev_err(&clientp->dev, "Failed to enable regulators: %d\n",
> +			ret);
> +		return ret;
>  	}
>  
>  	ret = devm_add_action_or_reset(&clientp->dev,
> @@ -1900,8 +1878,7 @@ static int tsl2772_suspend(struct device *dev)
>  	int ret;
>  
>  	ret = tsl2772_chip_off(indio_dev);
> -	regulator_disable(chip->vdd_supply);
> -	regulator_disable(chip->vddio_supply);
> +	regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
>  
>  	return ret;
>  }
> @@ -1912,16 +1889,10 @@ static int tsl2772_resume(struct device *dev)
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = tsl2772_enable_regulator(chip, chip->vddio_supply);
> +	ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = tsl2772_enable_regulator(chip, chip->vdd_supply);
> -	if (ret < 0) {
> -		regulator_disable(chip->vddio_supply);
> -		return ret;
> -	}
> -
>  	usleep_range(TSL2772_BOOT_MIN_SLEEP_TIME, TSL2772_BOOT_MAX_SLEEP_TIME);
>  
>  	return tsl2772_chip_on(indio_dev);

