Return-Path: <linux-iio+bounces-22395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE7B1D7E2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A7256152D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49D7262F;
	Thu,  7 Aug 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzcdR1LM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B24A0A;
	Thu,  7 Aug 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569877; cv=none; b=Wd6LHUzw8xR9Q17rOaXzO/4e6g11+/zqwoTots+Gq+tkwDmYSmhz3xmZMkD3j13Chp+QZyo2CQiqPh/TFAcCB6Ji0RkyYf7N4mKMoHcInNYRj1997+b32yZ3memGNaiOl1B8GSlr+BJ5FuAfK8HTCGVqhO0rFe3+0luY5zrv4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569877; c=relaxed/simple;
	bh=1UeunbsNm3H6NZWYFoXSQI5UObs2SKNxCJQGZqsfbGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPyiiHAm/nn2tZh92glKDGF+Cco5Ve0BXR4wyqMozvppjS9s8wwxNBRy7uf7qaK9eJFhXy121hhbqO5J3hkjDWg4SKEUYjNQMVM0R107J7XiLOYoH3DfeIBuYvdHEfD17svOy7z5ta4Ttwb9hj6+xASVLrvpWLHRTmSFlRdPJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzcdR1LM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso1185192a12.2;
        Thu, 07 Aug 2025 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754569874; x=1755174674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/LclELrM2SPH3nt2lTqDvMka2Ew8PsvYc5UKtsfndag=;
        b=gzcdR1LMAvL8sOWbWhZrxtP63JfJtJsvi4GILaobHMmzV65EK4BbZhixO5636mXrAw
         qNN0k7EbAUOGPXCf47UDoWWOeahqcwG2+FpcRKtcn1331SGbwpEn5oj+noi0aQpLoEtL
         VBvPBt0WumMQnDhPk2ag9delU8ba1exr5sotM6dPMwr6L3DP59r/w3hyUd4b13jUSa8r
         0En9UmWygtadBzHkdS2ERwd8y83W//+xqhBBnYROynUH1YJ6Z4eqqt6WToP9sUzrTozM
         P29TntfEgvZL8EDIA/6dSgx1D8tLzsYbWJyEq6ADcBHlNj3450TJ7PU2IvS0kklLgbLk
         GLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569874; x=1755174674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LclELrM2SPH3nt2lTqDvMka2Ew8PsvYc5UKtsfndag=;
        b=i8OX/trV6RJ+i86VmK105Gap7POSvqcds4QhKrULjSSNdo8GOC6/9z2g4F8/4rbiiJ
         TMIGgu1vglBHPAn+OgY5ZraIlVkUpxaROyr/GfRNUiIFqkIhDUKSjPbQYaa3aSXspsRE
         axc5ORKHQtjhmdNvgP3w36twHXh2YA1ubS678dfjweiHlLueU91Z0dhCO0nxpXObKI3B
         f+MVw5W0oTnA1y2wy0Jk3wqZdnIZLQI5kc/7PFSoLLR5R1FXhBvv/MzHAyS5aGeTEXEq
         pKnuKeC2BYazwAxKA6OE+eyys0LN+Fcl69CQdYq7fu/8eRbsOhR7FHflijLa7duyy/MF
         kv1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDkXFbL+V47SsLENPPtywSEg1Ef0BzTFBVdJ9+s3mi3ksUFDGEGSs8SvY7jiO9Tg2uffgHQZRHIpQT@vger.kernel.org, AJvYcCWjyto8Pl0Ul2+ks41rpbJqY4yNBBOXnyDiOP9gxN1V8wqG3BAHYXSICMNGV+kgbpxa37MIdyROy6zo@vger.kernel.org, AJvYcCXSE7n9tp5268PEH1ZegNWA8Cfzc+UHjRu8RCNnPGikVzA6HKuRAeyTTyd/DbXh/qLp+PGW+G5WKqvswlZL@vger.kernel.org
X-Gm-Message-State: AOJu0YypL4f5XKJxfvRya1f1Ftkl9r0HQAgZgyu0a7mSfe87d6F+qUm5
	Yh5tUhCmx0lt9Bj+o2JL6/Z02TmrSJ250Fj+UPYbgoafFVIBurF7AOKx
X-Gm-Gg: ASbGnctuwDuw8rvlPlE5rrxXn8wv8NbykEt7sC0kfdQ1KQmMLOiWAK05qn96u3EHa6V
	27h/aqe9xgA0N9tUmPRY443gMTIv0KUPqg1xFu4HDPdxn6xG+mnBmkCjwlJzrOhe5/QSdGwcQ+2
	Hl6ytFBAA22qUg0GqGm+mEUovgCruYZP4ReGfxXtEERbVTE/LH8w8xFOT/yCDDm5nrvYPIuA5jH
	1V2+N78F9zZLpbhsSVU1jBvkVd5sWUTFGIU+YmNHzsRV7rT4ERlRQIU8auQX14j93iyBf4+TFzL
	SDx6ZTIID1OlTsiGBfr1nNZJ+f4c72JiY3YvIo+4bqDjUKvesEjXLOY1qaJoRQeHezr+C3/iNh6
	37HPqMnqHPJA=
X-Google-Smtp-Source: AGHT+IGAhxVVkCTaCyoJrxrCIohxaqzXqSvGlz/ZaiVjLTl9Dk7WwS8lDL2sFAwcEcteMWPGvy4sWg==
X-Received: by 2002:a17:907:9409:b0:af6:361a:eac0 with SMTP id a640c23a62f3a-af992b4c219mr543952766b.32.1754569873554;
        Thu, 07 Aug 2025 05:31:13 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a39c4sm1306188066b.43.2025.08.07.05.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:31:13 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:31:29 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: adc: ad7476: Use mV for internal reference
Message-ID: <qxgzakplhavmxk5ri6yghm3fkq33cbneclqrbwdlyviyzcadmx@cilvs5lb7kwp>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <415c4c8f8301395aee2a85d071722fd6bcb488ec.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <415c4c8f8301395aee2a85d071722fd6bcb488ec.1754559149.git.mazziesaccount@gmail.com>

On Thu, Aug 07, 2025 at 12:34:18PM +0300, Matti Vaittinen wrote:
> The ad7476 supports some ICs with an internal reference voltage. For
> those ICs the reference voltage has been hard-coded as micro volts, but
> the value which is later used in code needs to be milli volts. This
> results the need to divide hard coded voltage by 1000 before using it.
> 
> Simplify code by changing the hard-coded voltage to millivolts and by
> dropping the division.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v1 => :
>  - No changes
> ---

Makes sense

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7476.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index f117aafd8fad..7b6d36999afc 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -27,7 +27,7 @@
>  struct ad7476_state;
>  
>  struct ad7476_chip_info {
> -	unsigned int			int_vref_uv;
> +	unsigned int			int_vref_mv;
>  	struct iio_chan_spec		channel[2];
>  	/* channels used when convst gpio is defined */
>  	struct iio_chan_spec		convst_channel[2];
> @@ -172,7 +172,7 @@ static const struct ad7476_chip_info ad7091r_chip_info = {
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
>  	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> -	.int_vref_uv = 2500000,
> +	.int_vref_mv = 2500,
>  	.has_vref = true,
>  	.reset = ad7091_reset,
>  };
> @@ -229,7 +229,7 @@ static const struct ad7476_chip_info ad7475_chip_info = {
>  static const struct ad7476_chip_info ad7495_chip_info = {
>  	.channel[0] = AD7476_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> -	.int_vref_uv = 2500000,
> +	.int_vref_mv = 2500,
>  	.has_vdrive = true,
>  };
>  
> @@ -295,7 +295,7 @@ static int ad7476_probe(struct spi_device *spi)
>  		return -ENODEV;
>  
>  	/* Use VCC for reference voltage if vref / internal vref aren't used */
> -	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
> +	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
>  		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
>  		if (ret < 0)
>  			return ret;
> @@ -310,7 +310,7 @@ static int ad7476_probe(struct spi_device *spi)
>  		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
>  		if (ret < 0) {
>  			/* Vref is optional if a device has an internal reference */
> -			if (!st->chip_info->int_vref_uv || ret != -ENODEV)
> +			if (!st->chip_info->int_vref_mv || ret != -ENODEV)
>  				return ret;
>  		} else {
>  			st->scale_mv = ret / 1000;
> @@ -318,7 +318,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	}
>  
>  	if (!st->scale_mv)
> -		st->scale_mv = st->chip_info->int_vref_uv / 1000;
> +		st->scale_mv = st->chip_info->int_vref_mv;
>  
>  	if (st->chip_info->has_vdrive) {
>  		ret = devm_regulator_get_enable(&spi->dev, "vdrive");
> -- 
> 2.50.1
> 



