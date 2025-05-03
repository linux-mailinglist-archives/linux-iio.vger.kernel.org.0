Return-Path: <linux-iio+bounces-19019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD7AA8161
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C477F189E918
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A45269811;
	Sat,  3 May 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg71ppPp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62A1D516F;
	Sat,  3 May 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285684; cv=none; b=pTRh8ZItUE9loQf+uA/a9IewKIE/bQOICwY8yuiWpSq0u3E8hmK+p02nkkO8glmaDEx/AFTxz7CRgrrCtT80ta+fsB++SONUEMhjByXlW5DpaueVZMScR33YTDjp6FXP/LrUB4kccWEZ6V6c97N2eLISRbskv5gsEaS0StmBSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285684; c=relaxed/simple;
	bh=SpJDUPr0U8TkbmUTQyNs659xyulgzQJ4MpAQ8Dg7G9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSfH+gFDuRsAHTovlurPaUisSo3PWXtpwgAsVBmgvTpJaqBU1ibFsp4Ote+QEsh4jMmLTzcgNrH+vIThGYm1s6GiWpt4ILSAfU8Kcu6jsVLQpoISr7TfsDD+yifGz1hYuv0kgutefM4aGRVyWIprHbDkrebQSHFqR4XsG93XIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg71ppPp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c277331eso3914468b3a.1;
        Sat, 03 May 2025 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746285682; x=1746890482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ceE3GFXp3363IGmCZMbOrujPi+bJut1p/8h1YkV0Ew=;
        b=Qg71ppPpgCQEmZVO98XOg9fHSZ0WG092PPp/JFxOWj38Y+Z3ZXnhFcghe22gwR1VpN
         3xBQSUJ/bAKzYX/sEl+0iErcmsX00OeJEFR4odXQmdqrGraesv6Bn3sWrYUVU/bQsixB
         JxRg1DulxLkJwYMO1DQFNfADgP7c71PfgoUDNaERzpEVHL/aMNuUvflVXgNmWDkbirqC
         czN7ghZgg5QrjWWxkGs1WDVs+FJHYtaOjOvZaD/56LbMHiamsBdJNu57QLzZi7uz1lzR
         tV0XdMikW7YqSona/PYxyNlECwwMY3GdE+oiMFYU0h7LH4PI/QnfcU8BVlsY0x1WavoF
         bFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746285682; x=1746890482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ceE3GFXp3363IGmCZMbOrujPi+bJut1p/8h1YkV0Ew=;
        b=wPePN62U+uPPRGtLNSXStirvYzkUSoc9zbj/0xPRKQkHrveOlC3SWHJQ6kEgWN1pR3
         dwR/O02D9fpDC+x28jlgX3U5p9xEGw1C8ytRszDrXhvWVbsg3ePQSE+qDc/LbL0r7HAb
         93DGE+ih6yOLTdo88z6YImwZrOBGjw7nuju8Zy5AyhYEHgbBghHVT5id4v6c/G3dVs0h
         ZRSQpJsBzuhDsmYhxjvTTreF/YsyV2r4kk8WL0QhX4ez8rNqoYc4Lg0DGmAn/swZAHKK
         hYzdjtCIfKricMwDroQjaSF2xSi3TF1VkODnLyXRYb0i2Egld6UvyfJDrEepstjx+mS0
         5Tig==
X-Forwarded-Encrypted: i=1; AJvYcCU5fTxDF9sq3nOC0Qzy76Ri2W6wQoSIi1PZBo9ZiyF30N3QlieqmJ1lvjNSU+FxGVC9LtVDBsuaDo+w@vger.kernel.org, AJvYcCVn0cyraPxx8cm/X5vz4/f/xxvCuFqB9H7KKW+NwaB2UYcsAC4LubttoqK7OQwalUrQUoILSdfRpyMm@vger.kernel.org, AJvYcCXhEX6n02VW3hfWMONVW5g7kKL+OdqKrFoikfeWCBiiBhTpxf7hOi/q81RKfZWsY3a/YdsSCXhGrpWBIooR@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTDAiP+ZJBewg3PZ++AtuBGNh7VAuQw33cG1cVxemszeQsPEc
	2PuqPgrcGmy1Gyiwm1W21lB92BSK6F0G892e3sYNnXwYttC6I/ymaufHs+9nQJM=
X-Gm-Gg: ASbGncv0i2aoiZSxXbkmDalMPW44kgHlqiPpxoF0dMY9rnFAZMOVwOh7U/uWVPdgZgi
	J/tttY8kV4t/i68W99O5eSoPQVEt+6X9xT1PVD4v5IUnb5Dn+/ddP4kHq2h+I2/MjO5/9JEfBpx
	UzvhJTS04RT0gepnvNtaGf4wEm02HuunKv5hvr+JT9l+crYbW9qwYPqCiGXO+0b6ORKMPI6OIw1
	C19ra3U/bMVYQEXGQvdj1LdhrWjI12FWw0wjIcDvhV2cSrmBCIBpK4fU99a4l8xwhuF54Wb1ste
	KJYZRjpkk+OLbXgjmiit+0XVMt+YS3kiUhQt1e2RNiLil3qbqA==
X-Google-Smtp-Source: AGHT+IGB1eVC7bpXKehsOgrTdh5zfEiwEb4D0LPEyTWErLbbJuBw7p9mdKcuvmqdRMbF5D1Ru8iF9w==
X-Received: by 2002:a05:6a21:3416:b0:1ee:450a:8259 with SMTP id adf61e73a8af0-20bd8d4b1cdmr15194234637.18.1746285682276;
        Sat, 03 May 2025 08:21:22 -0700 (PDT)
Received: from localhost ([2804:30c:4024:1700:8e03:72a4:b895:b221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058d7a3a6sm3450199b3a.2.2025.05.03.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 08:21:21 -0700 (PDT)
Date: Sat, 3 May 2025 12:22:40 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: akshay bansod <akshaybansod997@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad559*: fixed coding style issue (shorthand
 unsigned)
Message-ID: <aBY0wHEzjbBex-Hn@debian-BULLSEYE-live-builder-AMD64>
References: <20250503095532.132041-1-akshaybansod997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503095532.132041-1-akshaybansod997@gmail.com>

Hello akshay,

Overall, your patch looks good to me.
Though, I think it may get slightly better if you consider my suggestions below.

Regards,
Marcelo

On 05/03, akshay bansod wrote:
> checkpatch.pl flagged use of shorthand 'unsigned' as warning
> trivial fix: replaced use of shorthand 'unsigned' with 'unsigned int'
> 
> Signed-off-by: akshay bansod <akshaybansod997@gmail.com>
> ---
...
> @@ -55,7 +55,7 @@ static int ad5592r_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	return st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>  }
>  
> -static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> +static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)

Hmm, the driver code was mostly contained within 80 columns before.
While it doesn't break any code style rule having it like that, I'd break the
line to keep the code under 80 columns.

static int ad5592r_gpio_direction_input(struct gpio_chip *chip,
					unsigned int offset)

Though, since that's just my personal preference, I think it should be fine if
you decide to keep the function declaration in one line.

>  {
>  	struct ad5592r_state *st = gpiochip_get_data(chip);
>  	int ret;
...
> @@ -30,7 +30,7 @@ static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, __be16 *buf)
>  	return spi_sync_transfer(spi, &t, 1);
>  }
>  
> -static int ad5592r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
> +static int ad5592r_write_dac(struct ad5592r_state *st, unsigned int chan, u16 value)

I'd also break this one, but you may chose not to if you think it's better to
keep it in one line.

>  {
>  	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>  
> @@ -39,7 +39,7 @@ static int ad5592r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
>  	return spi_write(spi, &st->spi_msg, sizeof(st->spi_msg));
>  }
>  
> -static int ad5592r_read_adc(struct ad5592r_state *st, unsigned chan, u16 *value)
> +static int ad5592r_read_adc(struct ad5592r_state *st, unsigned int chan, u16 *value)

Same here.

>  {
>  	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>  	int ret;
...
> @@ -102,6 +102,7 @@ static const struct ad5592r_rw_ops ad5593r_rw_ops = {
>  static int ad5593r_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> +
The addition of a blank line here is desirable, but it doesn't fit this patch's
scope. Drop that from this patch. You may propose another patch adding that if
you want.

