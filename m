Return-Path: <linux-iio+bounces-22398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC9B1D832
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 14:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506AB1AA3EC6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0B253B59;
	Thu,  7 Aug 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfLJWP0H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E455695;
	Thu,  7 Aug 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570844; cv=none; b=FmWWxFzqRKYWAarOCScFj1O2qniRy7yhe3TyN4eZ/Hs3o685Lu7dgXnvMXKqlgdufB3IzgFFI9iG2hA9biA69PMFnQPhsOfux/vqzeUSbzNbhAqJ+0+ZDsLpwA3KLzEdoQ96WyEgSjoMF3x+6GX5XZTujb5ivolwvjiD0OSxHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570844; c=relaxed/simple;
	bh=ohZUwlzNhrP3gzHlsaNTEoW1K6lJB6KtxB5geZsOcL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiTUNWhFC+hP/7SMTRldmY4fKykqmTeIHLPltOJT6xRwh8ywV3x9Av7IsoBI9sa569ObrzQ3C2VpghXL42IJOlSPqltLz07Ttj7juOuUyjCMujcuM7xzlvkkznOq8ELdR+lw+xoqdgG6adRPAB4GqikFI3iN4YOJb+F0rTSSJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfLJWP0H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b783d851e6so808420f8f.0;
        Thu, 07 Aug 2025 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754570841; x=1755175641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAlTws1iiWsnLLkn24/CvwlHxdksR+gtg1kFJzrBdI8=;
        b=SfLJWP0HZ7mmgtyr3WhgAEGF1Nb+PjCFVG02JLl2d0L+YCZ6RmSsLB3qUqWN7CIjxy
         iR/MawrZbVZB9rX8rU1OogjWtX0jzPH1xrdO7q1C4iecJ3niDLm9XtJuuwGA61POT4f1
         ltpsHD1xCM7vEzhTxGqxrvDYEUAL0/NvCyNQkarl+NXs23qJQyrmzm1qSrGqwyxnYn1/
         wA+QeEx0IaMvjbP6SJjkuHg6KbwPRZJkqp8RGTAgbx/IeMkyk8kQHF9PAOs9k5MrNyCy
         HG6u2vu8PnuWe4Pt1w3txLEsxxoSDWY2YudZBZHpGcZfcNZjI8ui/Nxbvy+ulRSYdtMV
         RaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570841; x=1755175641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAlTws1iiWsnLLkn24/CvwlHxdksR+gtg1kFJzrBdI8=;
        b=cZSuapjaptp517Oz+T0Rug1+j13oAMMI374vGYYmTWjy/DOommBOUdAej0WpNGP8Gt
         pQHxLlBffHK4gUp/iCB1opOpFwhk57K7gu4+5Lwl0lqcFjWnbRuR+5oZp6YrcHYFe6oU
         fYDGx3yi4JCRWcJBzYggHoG0pYNPdoHdKBRab9ELl36nPer6CAMacJWONamsqYtEQDNu
         AROE2dC7LXEe8Z/A3J2aG3uxyl4KEylEWhj5V40ynzA2a7+N85L/xGBMPo+IPG0VKt0n
         eUqRjAlBUTPE1ULqqtzuqz+8ySFITqdVrpt3e2pHzQypiWXla8rV8O0ZrKzF2xk4Ta7V
         RpLA==
X-Forwarded-Encrypted: i=1; AJvYcCUItqWhimS45k6XWduFmsSMzZpSIDChzPnVxWu1H+GWFCzK+3n+Y4gmpUkw6p5tPqXOrGqfBjfuUevvZ1j5@vger.kernel.org, AJvYcCWQ25kFKLAiOCKBYhBQQzXOSLyqrqkRUbVd137MGYF5zo2gfh2HzxyoK4DJ94slK9WxDmwt5VOvZ+Uu@vger.kernel.org, AJvYcCWrSKQZ95RHe+hwRE5n0ZNNH/3SLCY8JA697n3Ec8cbaF8QBiOGA01ctnWMuBxoCY9IGcRIiSjd2Yps@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpn/rKc/wD6xzIK9lav1RJgq+hJyJTmNIt87xeaKaJoODDblMj
	W3QpS8gK3uoVlEUMtf6aD8USlNmY96wqslJRdkYLbVlKYXOa7K6dHHwM
X-Gm-Gg: ASbGncvT5zgCPKWXFFqmLkWjllhvpXEcFsHF8MMu5hiJdm1TqlGn9zzsA9ga4ZxjOPC
	fFptbX5gID78DQpKAj7jE8iyEJIvVYTxNcdm2oMIPPHeyjUZSo1H7Sc4mt7TgwkBFVy0BBp87Xj
	jOXNuLNf3Iw7w+g7MgZ4mGIbb1qT4lq+QIncECdBAEQjObH6znjTKtm4BGTYnf2K0KWG1HImy36
	Gqb+nVCGDJsy9lHNBqvHkJZd23z2D1sX+07xsO8Mu/V+0OCNbjkhfCt3+ZBboZNLJrM8a5pYZb6
	9Z8jXV1bXQl2PsqaAraZutwow9D5eUrnZjjHfRHuaQwjLeqcZDZ6CPi8vLQDPRNo5v2krojBd+h
	JrAZfJEidK7w=
X-Google-Smtp-Source: AGHT+IG4d7j552qDyDgbbYwRGoYTjLez+9p2AbEs/1+ssaAWuuEwp6Vel/PSjycNO67HGpQT0ca/LQ==
X-Received: by 2002:a5d:64c3:0:b0:3b7:9141:f044 with SMTP id ffacd0b85a97d-3b8f48d8ed7mr5550820f8f.21.1754570840514;
        Thu, 07 Aug 2025 05:47:20 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm27151373f8f.4.2025.08.07.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:47:20 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:47:36 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] iio: adc: ad7476: Conditionally call convstart
Message-ID: <jqq73v23juc3wj3ykq5df3mevjatnq3zb2aq4w524xnl4xgban@qemnvtvs2twn>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <bb96107301b249d4be912fa4384ed4de7791410b.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb96107301b249d4be912fa4384ed4de7791410b.1754559149.git.mazziesaccount@gmail.com>

On Thu, Aug 07, 2025 at 12:35:03PM +0300, Matti Vaittinen wrote:
> The ad7476 supports two IC variants which may have a 'convstart' -GPIO
> for starting the conversion. Currently the driver calls a function which
> tries to access the GPIO for all of the IC variants, whether they
> support 'convstart' or not. This is not an error because this function
> returns early if GPIO information is not populated.
> 
> We can do a tad better by calling this function only for the ICs which
> have the 'convstart' by providing a function pointer to the convstart
> function from the chip_info structure, and calling this function only
> for the ICs which have the function pointer set.
> 
> This does also allow to support ICs which require different convstart
> handling than the currently supported ICs.
> 
> Call convstart function only on the ICs which can support it and allow
> IC-specific convstart functions for the ICs which require different
> handling.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v1 => v2:
>  - Adapt to the change which removed the chip_info pointer from the
>   driver's state structure.
> 
> The follow-up patch adding support for the ROHM BD79105 will bring
> different 'convstart' functions in use. The IC specific pointer will
> also prepare the way for this.
> ---
>  drivers/iio/adc/ad7476.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index a30eb016c11c..8914861802be 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -30,6 +30,7 @@ struct ad7476_chip_info {
>  	unsigned int			int_vref_mv;
>  	struct iio_chan_spec		channel[2];
>  	void (*reset)(struct ad7476_state *);
> +	void (*conversion_pre_op)(struct ad7476_state *st);
>  	bool				has_vref;
>  	bool				has_vdrive;
>  };
> @@ -37,6 +38,7 @@ struct ad7476_chip_info {
>  struct ad7476_state {
>  	struct spi_device		*spi;
>  	struct gpio_desc		*convst_gpio;
> +	void (*conversion_pre_op)(struct ad7476_state *st);

Ok, I was going to reply to patch patch 5 saying I was not sure about
the change. And now this makes it clear. My point would be that it's
fairly easiy to end up needing chip info after probe. The above function
pointer only has to exist because of patch 5. So I would better drop
patch 5 and...

>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
>  	struct iio_chan_spec		channel[2];
> @@ -68,7 +70,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	struct ad7476_state *st = iio_priv(indio_dev);
>  	int b_sent;
>  
> -	ad7091_convst(st);
> +	if (st->conversion_pre_op)
> +		st->conversion_pre_op(st);
>  
>  	b_sent = spi_sync(st->spi, &st->msg);
>  	if (b_sent < 0)
> @@ -158,12 +161,14 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  static const struct ad7476_chip_info ad7091_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	.conversion_pre_op = ad7091_convst,
>  	.reset = ad7091_reset,
>  };
>  
>  static const struct ad7476_chip_info ad7091r_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	.conversion_pre_op = ad7091_convst,
>  	.int_vref_mv = 2500,
>  	.has_vref = true,
>  	.reset = ad7091_reset,
> @@ -319,6 +324,7 @@ static int ad7476_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> +	st->conversion_pre_op = chip_info->conversion_pre_op;

... no need for the above. There's no real reason for the above to be
done at runtime.

- Nuno Sá

>  	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
>  						  "adi,conversion-start",
>  						  GPIOD_OUT_LOW);
> -- 
> 2.50.1
> 



