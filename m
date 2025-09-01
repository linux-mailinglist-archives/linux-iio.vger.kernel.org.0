Return-Path: <linux-iio+bounces-23592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ECB3EC9B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48715189042A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61232E041D;
	Mon,  1 Sep 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aki2bgBA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC31E2853;
	Mon,  1 Sep 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745254; cv=none; b=TSfBQSe7+71SYxgkMXv3USrXmPhboUxoB5RPtrbMAUsgMqrovG8uhCE/iX50xGDdqgKNZyFxY+ZLUJ0/LZwU2SYkq3rk3TJZgSgAWpt5WCWbwoWBn0YycRDJWma7uQr7x+yaN6CCzMvp0VuNWzOt6bafPxlKCUs7ik94YCTeVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745254; c=relaxed/simple;
	bh=G9RVU0XMahbtLMFQF4HVKxUSFrJaGgUuOm1NURKyju8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6+v2YAySeCXbsNLiScl/zRAOGxxR7yOcbT9I4n6cLYenlNCxnjcEuBaAqnP6nf0u35dpEb5cR5tjiCj0OWeug0NyaJqUv7q/18soRDiKcHMkLISpjEJGge0byVHaW16owhV6xgGB05LMf6lt5/cUhJKUNq3ln+8I2ysBPp21VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aki2bgBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3645FC4CEF0;
	Mon,  1 Sep 2025 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756745254;
	bh=G9RVU0XMahbtLMFQF4HVKxUSFrJaGgUuOm1NURKyju8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aki2bgBANIr2O+LWByCAgEOs4u7GS1rW1uLMpuC6dUg2gF+lEB/SO4RFCCAO2Cr03
	 VBZQ9gF4CHTvX0u4xQQKqwZu0TVu4xisiQAGjBhvCc6HQqKdszRLqoOssdfwJXDD4/
	 e+FeieuZRfmCg2rxIlcPG0S/TiDZupzIAyNhQ1HXzsP3OltFW/Am9gw5za31mHC0YL
	 WOfJgZ3Pn8p73NbyzY+6lLQZFVUB3WGxckTRZKFeWI/9DYmw3GTtZ/wslcMe13JEkL
	 6dAeL9qrJx/dboNL7JPBD3oJAdimX5FOPnLbUs1f7Iu+qeU7tvwe2xCXw/tXbQwrrC
	 NVD1YJ/TjWb0g==
Date: Mon, 1 Sep 2025 17:47:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <20250901174724.351237f0@jic23-huawei>
In-Reply-To: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
References: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 11:07:50 +0330
Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com> wrote:

> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences

Split this into two patches (but wait a few days for current discussions to
finish).  Patch 1 do the SPI / GPIO groups (and use guard() as Andy pointed out).

> - Updates to device state via sysfs store functions (mode, channel, oti)

This one is less clearly required. We might get races but it's not obvious
to me that they will hurt as tends to be one writer / one reader of a
small variable. In theory the accesses might get split / torn but in practice that
doesn't happen.  Anyhow, that one needs more info on why the protection
is necessary.

One other comment inline.


Jonathan


> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> 
> ---
> Changes in v3:
> - Restore proper capitalization in From:/Signed-off-by lines
> - Move v2 changelog below the --- line
> 
> Changes in v2:
> - Fixed mismatch between From: and Signed-off-by lines
> - Verified style compliance with checkpatch.pl
> ---
>  drivers/staging/iio/adc/ad7816.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..06567d048a6d 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex io_lock;	/* Protects SPI transactions and GPIO toggling */
>  };
>  
>  enum ad7816_type {
> @@ -67,13 +68,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	mutex_lock(&chip->io_lock);
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  
>  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> @@ -92,13 +93,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	ret = spi_read(spi_dev, &buf, sizeof(*data));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI data read error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	*data = be16_to_cpu(buf);
>  
> +unlock:
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> @@ -107,12 +108,13 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
>  
> +	mutex_lock(&chip->io_lock);
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &data, sizeof(data));
> -	if (ret < 0)
> -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
>  
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> @@ -136,6 +138,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> +	mutex_lock(&chip->io_lock);
>  	if (strcmp(buf, "full") == 0) {
>  		gpiod_set_value(chip->rdwr_pin, 1);
>  		chip->mode = AD7816_FULL;
> @@ -143,6 +146,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  		gpiod_set_value(chip->rdwr_pin, 0);
>  		chip->mode = AD7816_PD;
>  	}
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }
> @@ -200,7 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&chip->io_lock);
>  	chip->channel_id = data;
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }
> @@ -322,7 +328,9 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
>  	if (ret)
>  		return -EIO;
>  
> +	mutex_lock(&chip->io_lock);
>  	chip->oti_data[chip->channel_id] = data;
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }
> @@ -363,6 +371,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
>  
>  	chip->spi_dev = spi_dev;
> +	mutex_init(&chip->io_lock);
For new mutex prefer 
	ret = devm_mutex_init();
	if (ret)
		return ret;

The advantage this brings for very particular log debugging cases isn't
huge, but it is also not remotely costly to do this (in new code, 
I don't want the churn of mass updates!)

>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  


