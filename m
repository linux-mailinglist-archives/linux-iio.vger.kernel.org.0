Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD57BD67
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGaJkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 05:40:19 -0400
Received: from onstation.org ([52.200.56.107]:45282 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfGaJkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jul 2019 05:40:19 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D0C2C3E910;
        Wed, 31 Jul 2019 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564566017;
        bh=I0papPTksij9ii1sn+NgdR9xpTJbqm6k5gNZvoHczdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUl9aY28ETvQkgZrciA7TcMsvicTu9VKRc6zFseB2fSDnV6+7goKfnZWASFQmzMJZ
         HN2CnYMCnhsbvEZ6ONsTDqkwNx4/CzFNywIotkKdgpURJNYR0su/WIG/ZfaYBLhq7w
         vFelqLPnDP8Nks6FRnaL0mrbe0vLotk35XR8/qcQ=
Date:   Wed, 31 Jul 2019 05:40:16 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: tsl2772: Use regulator_bulk_() APIs
Message-ID: <20190731094016.GB19501@onstation.org>
References: <20190731030423.8116-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731030423.8116-1-hslester96@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Chuhong,

On Wed, Jul 31, 2019 at 11:04:23AM +0800, Chuhong Yuan wrote:
> Use regulator_bulk_() APIs to shrink driver size.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Just a few minor nitpicks below. Overall, this is looking nice.

> ---
> Changes in v3:
>   - Split v2 into two patches.
>   - Add dev_err to log error messages.
>   - Add a check for EPROBE_DEFER.
> 
>  drivers/iio/light/tsl2772.c | 82 +++++++++++--------------------------
>  1 file changed, 24 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index f1134f183be7..fd6d44297dba 100644
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
> +	struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];

I prefer that this was named something other than 'reg'. Maybe
'supplies'? I know that there are a few other drivers in IIO that use
this name.

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
> +	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
>  }
>  
>  static int tsl2772_chip_on(struct iio_dev *indio_dev)
> @@ -1804,14 +1770,21 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	chip->client = clientp;
>  	i2c_set_clientdata(clientp, indio_dev);
>  
> -	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
> -	if (IS_ERR(chip->vddio_supply))
> -		return PTR_ERR(chip->vddio_supply);
> +	chip->reg[TSL2772_SUPPLY_VDD].supply = "vdd";
> +	chip->reg[TSL2772_SUPPLY_VDDIO].supply = "vddio";
>  
> -	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
> -	if (IS_ERR(chip->vdd_supply)) {
> -		regulator_disable(chip->vddio_supply);
> -		return PTR_ERR(chip->vdd_supply);
> +	ret = devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->reg),
> +								chip->reg);

This needs to be aligned with devm_regulator_bulk_get, not ARRAY_SIZE.

> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&clientp->dev, "Failed to get regulators: %d\n", ret);

Add newline.

Brian
