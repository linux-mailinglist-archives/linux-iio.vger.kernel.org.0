Return-Path: <linux-iio+bounces-12538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D89D69B5
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68AF281B5D
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5093398B;
	Sat, 23 Nov 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8ea3q+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DED2C190;
	Sat, 23 Nov 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376751; cv=none; b=ujePU/ghAteTciQ2+GgIbIFUK3oYmqcyTgEFh9LJccaTz9sh2NI74UoWp/AeM68EH99zDOtTnkEr0b/9yX5hnOMlLh6xbz69+j9g0r2xFVw45leogFR+DtT9XddlbwDjDmV8HUufIWQzIKHSTineCGwtSsqDtgyHXPRPJu3RQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376751; c=relaxed/simple;
	bh=ZrkA5xuO+gdrfeTs7ByiSa4VefQvO+x+GA3jra+ffcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVWCHrp6zBVOk/6qmn57ic6V91Fvd1MIR98B3ei+lQ6O01zdhMqI8GOLtlrojwLznXlqvrUMPFe2w/xuUHWScdHueKuZT2XSeM1qFVrQarWxestHxtRTywflYWLVMwZMiwKiVb0ah2hFdSvp6/tHvQHBhUefR/pLm0ScdDhyzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8ea3q+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F521C4CECD;
	Sat, 23 Nov 2024 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376750;
	bh=ZrkA5xuO+gdrfeTs7ByiSa4VefQvO+x+GA3jra+ffcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8ea3q+nk8dedNARoy2cYmCRti7P+QbSn7WgOC7Urc4TE8fK71CrSpeuYOsIZPqoW
	 rJVb43scwZMtVCmTGbrsxDIkLwswMglwW9mT97Hq3ayWfIIL4Gyit6T+QtPeI3KPdB
	 THe7HHeEyKCb1jreag1mSrVgElOCRmWqBl0cx2INWVyQxZW5CYw0sWcJBaVweww6kE
	 I6zzKUnyvd/1iMJk2Rm7O/+jC3qm5dGzow7yjAZDq0Rlhqes2P+DZ4l+upsDA/1JVo
	 ss8/1o4D2ixt3ulqOYQMh6avD3kEYUycfdLHlJhhTb7D2ul+d9N6pOb+aHpZcilUz7
	 Vd4BrRtFQAJ5A==
Date: Sat, 23 Nov 2024 15:45:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] iio: dac: ad5686: drop driver remove function
Message-ID: <20241123154544.110eff2c@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-4-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-4-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:27 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Remove driver remove callback for ad5686 SPI and I2C drivers.
> 
> By making use of devm_iio_device_register(), we no longer need a driver
> remove callback. Also since this was the last user of dev_get_drvdata(),
> we can drop the call to dev_set_drvdata().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied 1-4 
> ---
>  drivers/iio/dac/ad5686-spi.c |  6 ------
>  drivers/iio/dac/ad5686.c     | 11 +----------
>  drivers/iio/dac/ad5686.h     |  2 --
>  drivers/iio/dac/ad5696-i2c.c |  6 ------
>  4 files changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 8ba2ea70451a..79cfae7a1048 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -95,11 +95,6 @@ static int ad5686_spi_probe(struct spi_device *spi)
>  			    ad5686_spi_write, ad5686_spi_read);
>  }
>  
> -static void ad5686_spi_remove(struct spi_device *spi)
> -{
> -	ad5686_remove(&spi->dev);
> -}
> -
>  static const struct spi_device_id ad5686_spi_id[] = {
>  	{"ad5310r", ID_AD5310R},
>  	{"ad5672r", ID_AD5672R},
> @@ -126,7 +121,6 @@ static struct spi_driver ad5686_spi_driver = {
>  		.name = "ad5686",
>  	},
>  	.probe = ad5686_spi_probe,
> -	.remove = ad5686_spi_remove,
>  	.id_table = ad5686_spi_id,
>  };
>  
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index a8a38879fc40..b848b076851c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -464,7 +464,6 @@ int ad5686_probe(struct device *dev,
>  		return  -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	dev_set_drvdata(dev, indio_dev);
>  
>  	st->dev = dev;
>  	st->write = write;
> @@ -521,18 +520,10 @@ int ad5686_probe(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	return iio_device_register(indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad5686_probe, IIO_AD5686);
>  
> -void ad5686_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -
> -	iio_device_unregister(indio_dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(ad5686_remove, IIO_AD5686);
> -
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 62eb309711af..e7d36bae3e59 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -155,7 +155,5 @@ int ad5686_probe(struct device *dev,
>  		 const char *name, ad5686_write_func write,
>  		 ad5686_read_func read);
>  
> -void ad5686_remove(struct device *dev);
> -
>  
>  #endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 81541f755a3e..a56a7a410111 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -65,11 +65,6 @@ static int ad5686_i2c_probe(struct i2c_client *i2c)
>  			    ad5686_i2c_write, ad5686_i2c_read);
>  }
>  
> -static void ad5686_i2c_remove(struct i2c_client *i2c)
> -{
> -	ad5686_remove(&i2c->dev);
> -}
> -
>  static const struct i2c_device_id ad5686_i2c_id[] = {
>  	{"ad5311r", ID_AD5311R},
>  	{"ad5337r", ID_AD5337R},
> @@ -116,7 +111,6 @@ static struct i2c_driver ad5686_i2c_driver = {
>  		.of_match_table = ad5686_of_match,
>  	},
>  	.probe = ad5686_i2c_probe,
> -	.remove = ad5686_i2c_remove,
>  	.id_table = ad5686_i2c_id,
>  };
>  
> 


