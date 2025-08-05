Return-Path: <linux-iio+bounces-22312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4FB1B7F3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 18:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930FE16B9DC
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B9291C09;
	Tue,  5 Aug 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUvc7u/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EA21C9F9;
	Tue,  5 Aug 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410068; cv=none; b=EILrpRsdmLU0D5B99TbL60YKDejI5aMitDaGbYHsZ5xccNNj03W72umnzX6XcTEYZkeOSocsJSLuFS3N9F5sxffz63PwklJFMpemuTpfVPF8LkqaOFpeeaJizyp2xHQW4KsetnrlBIkx1Nvp8Qouh5bQUbyeXgmslkJbCPOQO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410068; c=relaxed/simple;
	bh=pKwmUyx45Llqb2q5qXCVQ/DpOaVLBHlMo4ORG3v1vtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nClnxfzJdPZce+AMd8MHCX/gvE7w/wnPMQes9lpcqCNtWVMi9dOQlg+VbeFX9gOyKfyl2tCgrwKZZb20xAgoJvR1imXbBSmPKB2HiO47QenzUn0Qo2e5NjtpbOpdynVkyqZKGCADV6isNeApzXPFMis3528trFsn8El86u2O+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUvc7u/6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458ba079338so202645e9.1;
        Tue, 05 Aug 2025 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410065; x=1755014865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GU5bgiIwiBooyJdawhsjEUsmRYCncA7weQlPR+RPElI=;
        b=XUvc7u/6nznpMWU1pKFWMrx5akDupE7026VK5ahu1e5tsPg8i8KoR4gdgAyQl31mAR
         cfl83SSs50P6CGoJ+aJVQicnOt4zzR3jzJNUjW6b+v11/89D/7/3VTLpZj5aZw0CdqYd
         c20qj+zBOEXFwgpD1DhS3jBw/iRkga2hAhhr/fxL2OEnc5dSv1HvmLYttaT/56nTQRq1
         Mbv1lyJSSfFZIcSd6ebfULk7+oMD0gBEzxiwLtKtCQGv241hSEKZy/CKRBUrIgWXykFf
         413QkE80e25N7hAQaGf451V9aUeMTu9CtfQp/Y27fYcS0u/ElTyyh1l//ixA0wVllFQd
         MeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410065; x=1755014865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GU5bgiIwiBooyJdawhsjEUsmRYCncA7weQlPR+RPElI=;
        b=KeHdbk/1Ohbhu9Ejtazvr/vcDBZzweF8d7Z0NWqYUdquZWaNQ3Q5UIY7Wf1LqyLrjA
         E5455RQTLOThyB/0E1vbD3J8U3vat81lDuUl7/iCHMkqrBhsFl9054gMblkrlg9b3G2q
         UDR147LwozjiMO6T1zAdSa1NB4FpU+m2NgvYReR2O8/cD6z2enUZ7yYXOaqqKxKn7+mf
         ehI9eAdVFfg6M3Cj2z8slGZKkvWtpxM0/uHOLwKarjyNjl0gVhXIbCoVI2S8wyNo7t0t
         XA9DNuyYIlsz1tmth07l3P5FjdCQsRPiqTZP7P+JfWDbiZK61HGHog8ZOl6/N8n4ZzJC
         TGOw==
X-Forwarded-Encrypted: i=1; AJvYcCV4nZ+ZFvUeHMmx7hadnCQlcVlhWVSNr2G+S03Efawyntbkp9o0oNj4Pe8qHMxcwKXYxPxd/Hprj3P5fDXV@vger.kernel.org, AJvYcCWIAn66DdwC5Uh32OBsi0aFuw40wmS1WpZSV+642Ztuu+sF/lohitQ85zXsB3/5ZO4RRqUzOHX/qjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5jB8ifvpxLTAOQ7+JXHcJvC+oiPUs22JhX0WYgZdo3BhIKCi
	vramCwLgeYPGI6oo2rtTwJI0nmygOoM7sAo5ycD9IhCi7hgow9uf8GYn
X-Gm-Gg: ASbGncvamSwT6SheTNb3MGWYjqBdrSl1j7N4tZuMGF82yxwlLesbGEfY3FgXGH+XQ2B
	AsPBIKAExmfz2/rPxd3dtRYf/wq96mjEjubG7gCszVQLsOmzoa+SyGKMRZ9yYy8sIY9Lu+dMAc7
	ZG+amV8b9zEhAdvhVKLSWz+pyUAANRJvZsbtVIvUnISZbp+cCWRF8tR+iEsHPbM3k6+rPcjFdtT
	yfEs1aWnPIsQ97hOeIJHkfN8xR1VKFrpkRQ5cpoe7TLCIWUuvpkUV6Nj9LAGdfBpy4C/CyYdrUk
	KwhDUJ3bc8i2ORB+a5czOjja+sCQW1LPiXMqme46XxKGLO+v/cu4vcKQFTYgy5RkRtWSQXfoWwu
	AzETnNo/c4wIhMg==
X-Google-Smtp-Source: AGHT+IEVF2LDgHDXN1VzGtGccdIlvCW+TzXU0H2YrdmX5ZHgSwBhCDp/boeIm8qUq3oh8mVv9xUiog==
X-Received: by 2002:a05:600c:15cb:b0:459:dbc2:201e with SMTP id 5b1f17b1804b1-459e611e82fmr2217115e9.9.1754410064607;
        Tue, 05 Aug 2025 09:07:44 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862fd9sm10943955e9.16.2025.08.05.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:07:44 -0700 (PDT)
Date: Tue, 5 Aug 2025 17:08:00 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Francesco Dolcini <francesco@dolcini.it>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Gerald Loacker <gerald.loacker@wolfvision.net>, Song Qiang <songqiang1304521@gmail.com>, 
	Crt Mori <cmo@melexis.com>, kernel@axis.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iio: Remove error prints for
 devm_add_action_or_reset()
Message-ID: <szxvwg52wljg2hv55g2cx7xybpa53he2dpbecc6cimafoupe6d@qzeqdrwwoqcj>
References: <pndectqm7te.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pndectqm7te.a.out@axis.com>

On Tue, Aug 05, 2025 at 11:33:33AM +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
> 
> * Split the patch to one seperate patch for each sub-system.
> 
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
> 
>  drivers/iio/accel/msa311.c          | 2 +-
>  drivers/iio/adc/ad4130.c            | 3 +--
>  drivers/iio/adc/ad7124.c            | 2 +-
>  drivers/iio/adc/ad7173.c            | 3 +--
>  drivers/iio/adc/mt6577_auxadc.c     | 3 +--
>  drivers/iio/adc/pac1921.c           | 3 +--
>  drivers/iio/adc/rockchip_saradc.c   | 3 +--
>  drivers/iio/adc/ti-ads1119.c        | 3 +--
>  drivers/iio/adc/ti-ads7924.c        | 6 ++----
>  drivers/iio/frequency/adf4350.c     | 3 +--
>  drivers/iio/light/al3000a.c         | 2 +-
>  drivers/iio/light/apds9306.c        | 2 +-
>  drivers/iio/light/bh1745.c          | 3 +--
>  drivers/iio/light/opt4001.c         | 3 +--
>  drivers/iio/light/opt4060.c         | 3 +--
>  drivers/iio/magnetometer/als31300.c | 2 +-
>  drivers/iio/magnetometer/tmag5273.c | 2 +-
>  drivers/iio/proximity/vl53l0x-i2c.c | 3 +--
>  drivers/iio/temperature/mlx90635.c  | 6 ++----
>  19 files changed, 21 insertions(+), 36 deletions(-)

+1

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index 3e10225410e8..2ccb22317bdc 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -1195,7 +1195,7 @@ static int msa311_probe(struct i2c_client *i2c)
>  	 */
>  	err = devm_add_action_or_reset(dev, msa311_powerdown, msa311);
>  	if (err)
> -		return dev_err_probe(dev, err, "can't add powerdown action\n");
> +		return err;
>  
>  	err = pm_runtime_set_active(dev);
>  	if (err)
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index 6cf790ff3eb5..ff778a44323f 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -2035,8 +2035,7 @@ static int ad4130_probe(struct spi_device *spi)
>  
>  	ret = devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to add regulators disable action\n");
> +		return ret;
>  
>  	ret = ad4130_soft_reset(st);
>  	if (ret)
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9808df2e9242..4481a4ca7ac3 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1300,7 +1300,7 @@ static int ad7124_probe(struct spi_device *spi)
>  		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
>  					       st->vref[i]);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "Failed to register disable handler for regulator #%d\n", i);
> +			return ret;
>  	}
>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 4413207be28f..d15e305d3380 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1717,8 +1717,7 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
>  
>  	ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to add regulators disable action\n");
> +		return ret;
>  
>  	ret = device_property_match_property_string(dev, "clock-names",
>  						    ad7173_clk_sel,
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 3343b54e8e44..fe9e3ece3fda 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -297,8 +297,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  
>  	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "Failed to add action to managed power off\n");
> +		return ret;
>  
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 72aa4ca2e5a4..35433250b008 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1279,8 +1279,7 @@ static int pac1921_probe(struct i2c_client *client)
>  	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
>  				       priv->vdd);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -			"Cannot add action for vdd regulator disposal\n");
> +		return ret;
>  
>  	msleep(PAC1921_POWERUP_TIME_MS);
>  
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index bd62daea0a3e..926971cb50bf 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -527,8 +527,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	ret = devm_add_action_or_reset(&pdev->dev,
>  				       rockchip_saradc_regulator_disable, info);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to register devm action\n");
> +		return ret;
>  
>  	ret = regulator_get_voltage(info->vref);
>  	if (ret < 0)
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index d2f86e1ec656..3e4f79dfb078 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -778,8 +778,7 @@ static int ads1119_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(dev, ads1119_powerdown, st);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to add powerdown action\n");
> +		return ret;
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> index b1f745f75dbe..46255c530cb4 100644
> --- a/drivers/iio/adc/ti-ads7924.c
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -399,8 +399,7 @@ static int ads7924_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(dev, ads7924_reg_disable, data->vref_reg);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to add regulator disable action\n");
> +		return ret;
>  
>  	ret = ads7924_reset(indio_dev);
>  	if (ret < 0)
> @@ -414,8 +413,7 @@ static int ads7924_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(dev, ads7924_set_idle_mode, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to add idle mode action\n");
> +		return ret;
>  
>  	/* Use minimum signal acquire time. */
>  	ret = regmap_update_bits(data->regmap, ADS7924_ACQCONFIG_REG,
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 47f1c7e9efa9..6665409a9a87 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -673,8 +673,7 @@ static int adf4350_probe(struct spi_device *spi)
>  
>  	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret,
> -				     "Failed to add action to managed power down\n");
> +		return ret;
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
> diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> index 6f301c067045..9871096cbab3 100644
> --- a/drivers/iio/light/al3000a.c
> +++ b/drivers/iio/light/al3000a.c
> @@ -94,7 +94,7 @@ static int al3000a_init(struct al3000a_data *data)
>  
>  	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add action\n");
> +		return ret;
>  
>  	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
>  	if (ret)
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index f676da245aa7..5eb33e8e3ad9 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -1309,7 +1309,7 @@ static int apds9306_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add action or reset\n");
> +		return ret;
>  
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 4e9bd8f831f7..c7c604c96f6e 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -814,8 +814,7 @@ static int bh1745_init(struct bh1745_data *data)
>  
>  	ret = devm_add_action_or_reset(dev, bh1745_power_off, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to add action or reset\n");
> +		return ret;
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index ba4eb82d9bc2..95167273bb90 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -428,8 +428,7 @@ static int opt4001_probe(struct i2c_client *client)
>  					opt4001_chip_off_action,
>  					chip);
>  	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret,
> -				     "Failed to setup power off action\n");
> +		return ret;
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index 566f1bb8fe2a..7a1b6c703823 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -1299,8 +1299,7 @@ static int opt4060_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
>  	if (ret < 0)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to setup power off action\n");
> +		return ret;
>  
>  	ret = opt4060_setup_buffer(chip, indio_dev);
>  	if (ret)
> diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
> index f72af829715f..928e1378304c 100644
> --- a/drivers/iio/magnetometer/als31300.c
> +++ b/drivers/iio/magnetometer/als31300.c
> @@ -373,7 +373,7 @@ static int als31300_probe(struct i2c_client *i2c)
>  
>  	ret = devm_add_action_or_reset(dev, als31300_power_down, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
> +		return ret;
>  
>  	indio_dev->info = &als31300_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
> index 2ca5c26f0091..bdb656b031b1 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -642,7 +642,7 @@ static int tmag5273_probe(struct i2c_client *i2c)
>  	 */
>  	ret = devm_add_action_or_reset(dev, tmag5273_power_down, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
> +		return ret;
>  
>  	ret = pm_runtime_set_active(dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index ef4aa7b2835e..b92fbd27755b 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -352,8 +352,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  
>  	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
>  	if (error)
> -		return dev_err_probe(&client->dev, error,
> -				     "Failed to install poweroff action\n");
> +		return ret;
>  
>  	indio_dev->name = "vl53l0x";
>  	indio_dev->info = &vl53l0x_info;
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index f7f88498ba0e..1175c7887ae1 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -977,8 +977,7 @@ static int mlx90635_probe(struct i2c_client *client)
>  	ret = devm_add_action_or_reset(&client->dev, mlx90635_disable_regulator,
>  				       mlx90635);
>  	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret,
> -				     "failed to setup regulator cleanup action\n");
> +		return ret;
>  
>  	ret = mlx90635_wakeup(mlx90635);
>  	if (ret < 0)
> @@ -986,8 +985,7 @@ static int mlx90635_probe(struct i2c_client *client)
>  
>  	ret = devm_add_action_or_reset(&client->dev, mlx90635_sleep, mlx90635);
>  	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret,
> -				     "failed to setup low power cleanup\n");
> +		return ret;
>  
>  	ret = regmap_read(mlx90635->regmap_ee, MLX90635_EE_VERSION, &dsp_version);
>  	if (ret < 0)
> 
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
> -- 
> 2.39.5
> 

