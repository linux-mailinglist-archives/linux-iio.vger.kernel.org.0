Return-Path: <linux-iio+bounces-16304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49249A4CDDD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654DC172B0B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067E23278D;
	Mon,  3 Mar 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG+DH1uY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6B2343AB;
	Mon,  3 Mar 2025 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039618; cv=none; b=rak+8+/h9XLkE6SuZXlvD/tKSo/uT9dDQziBzc/rvoiQvaaBegsfMDS+9v2Zwgpa9qYGh5x/5ABk7ICDDuKqbM2WPCkMCKzjMuE5yRFfVA80/iz/o8MUe+U4hwXTnVFMkIk23nuS1yODba0iVfcuzrF6Jpzdi28BtysKvD2ePrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039618; c=relaxed/simple;
	bh=JqxhaPx/4PkOgVkCLHhMzASh2FO9a3L/0EsE1pIt20Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1LSeWbrEohJTwlSrL5tItf8rUPTPZxuAb/d24thkqQ4Cw8fGR7jNxWJSxWEECtwVXsLjL4D6Iivu0iMW/t21katvuSujXxri2svwBzqt9JzsRNrQdfJWi39+PCNdcD0dcMRzXmB23OCzsiBK7LMT6f198JhXMvgzT/gliBsdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG+DH1uY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so94314505ad.1;
        Mon, 03 Mar 2025 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039616; x=1741644416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyrPi5HAkeHZcWwEBF6xTNbTlSUohW8oencgE4qGFYo=;
        b=nG+DH1uY2i9pl67ou9XrPKTn13BKTz6ymDFw5ErcbdcQja0GFOFhdMqlv5bX+tTGhg
         XbyX36BQN2iipvug1h+odU03UvuZ5wwCdKF+8KZ9o4LOFQGsh4N0AI+dmP/C3l0aBDzn
         IoxJdXyOL0J3EHdyalkRplJV16ouvZ/iaGz+E0AClxU7wiYTAZkCvvgJ0HPFMLAsMIbb
         9IoCVywEqrxf4sH9j2NeNOO2g4tSb3XcU7yaxHGTJqrSrPS1uKTfYkoLbcPusxLm+6QG
         QFT7sxw2EyKmWvvMJRiAh+r+KSHyg7iaa6vKOiYBCBwW4hNQVDnrzI6u6TpLhtpjty/b
         zSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039616; x=1741644416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyrPi5HAkeHZcWwEBF6xTNbTlSUohW8oencgE4qGFYo=;
        b=f+F/FNOwGVIqaO9lw9ZgWBsRXgkQ28XZkuTbhrtE1uIAjfL8pj0/IT1UoKEZejVNnr
         BHZaoN6D77VAM8NAP+RRN4ZisT/5fnTPBbT8WPVwNDWEnWYYQqLIenXFHBOO+Ni47SAW
         GOrNavn7ISVy5TWbbmm6hN37HxaBUjPKWWH4qsYpbwXWgzrP4SRHvpQ4r5VOADB/ckaA
         /o5b8OTbbNeDX8Zy/y7Y2vPg8R+54qPM+FzV/wwCIPCzenGjNLflQg+iR1OUkF1lWYke
         ymgXL2uqOubVKUPAE9Juxxgr6oB8JPEZhLU1W5B5OoYPaI0v6b6YkUlXDaFYcqjyEaBf
         CdMg==
X-Forwarded-Encrypted: i=1; AJvYcCUV2DDCgcsdb1mill2ziZIBEOOwkvcyFO48gqVYRvJi7ALeb9Zai8TQ5MsQozdMZqJX2pKLoQ8Ue6/iBwcL@vger.kernel.org, AJvYcCXOVZNP0EwC9t2xyRQ+o3xv17W7gsiZzY/lQKLSTKI4B0DVweX73qZBRHrFT8TbD1QSSUXoU1xTOZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+FMeZiHGwncHacW/QrxB2vq2Oqu+zo/JK6ISQ/N1aNMO5z6Q
	EB740f+UGWxfU5SGM1Ap8Qy3w8BbBcjgBZCvjiuPpyGp5dhkagHd
X-Gm-Gg: ASbGncvxHki9ynlphFH+LwLNpdFqkrkVKo2VfwBEaV5uTCBCZKANLuiBxBEhi5atTiF
	/McZHTACIypEubktWp9oNmaismXWNlqCySIslOwFyd1+ZTTFCMoBZXjGAUwxh4kEonZULmZfMt+
	yZPmUZB9N+4BxXQmO9rliT35ZVJmg3ZZRmW8JhDAqWVF+2GB7BeCc/WV0bKjSdd2jeSPOX2SFyu
	RmNCjern2lOSvU/k9RM0H7e6z23D+WmlTVjCoJ6TYPV2+lIj3ibAcbPBjQ5RpWLCCqynru0lS1Z
	6JGf1lBbe/qgpDKOrXQyjz7jgE4oczBkFn0HAXjrH9ijfKAzTAnpViU=
X-Google-Smtp-Source: AGHT+IF210btO6rb30eQ+sEDHAyP6Jb2nAg1Js5HWY+VJpxXxEm3Ip9l6khqtgq0M00D4C6JjlL1cA==
X-Received: by 2002:a62:f20c:0:b0:736:3184:7fe8 with SMTP id d2e1a72fcca58-73631848087mr13036440b3a.2.1741039615593;
        Mon, 03 Mar 2025 14:06:55 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7ddf230dsm8757673a12.8.2025.03.03.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:06:54 -0800 (PST)
Date: Mon, 3 Mar 2025 19:07:47 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Saalim Quadri <danascape@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC] staging: iio: ad9832: Use
 devm_regulator_get_enable_read_voltage()
Message-ID: <Z8YoM4ycB0qMQwOG@debian-BULLSEYE-live-builder-AMD64>
References: <20250303200347.23354-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303200347.23354-1-danascape@gmail.com>

Hello Saalim,

On 03/04, Saalim Quadri wrote:
> Use devm_regulator_get_enable_read_voltage() to reduce boiler plate
> code.
> 
> * Here I am particularly confused about regulator_enable(), part where I should
>   use devm_regulator_get_enable() to enable avdd supply?

I misread the driver yesterday and thought avdd and dvdd regulator voltages were
being read, but that is not true. devm_regulator_get_enable() is enough for the
cases where the voltage is not read.

> * I can resend this as a patch if everything is alright, specifically with
>   devm_regulator_get_enable() for dvdd
> 
If I'm not missing anything else, you'll probably be using
devm_regulator_get_enable() for both avdd and dvdd. And probably ok to update
both in a single patch.

Regards,
Marcelo

> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..9e7975265454 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -74,8 +74,6 @@
>  /**
>   * struct ad9832_state - driver instance specific data
>   * @spi:		spi_device
> - * @avdd:		supply regulator for the analog section
> - * @dvdd:		supply regulator for the digital section
>   * @mclk:		external master clock
>   * @ctrl_fp:		cached frequency/phase control word
>   * @ctrl_ss:		cached sync/selsrc control word
> @@ -94,8 +92,6 @@
>  
>  struct ad9832_state {
>  	struct spi_device		*spi;
> -	struct regulator		*avdd;
> -	struct regulator		*dvdd;
>  	struct clk			*mclk;
>  	unsigned short			ctrl_fp;
>  	unsigned short			ctrl_ss;
> @@ -297,11 +293,6 @@ static const struct iio_info ad9832_info = {
>  	.attrs = &ad9832_attribute_group,
>  };
>  
> -static void ad9832_reg_disable(void *reg)
> -{
> -	regulator_disable(reg);
> -}
> -
>  static int ad9832_probe(struct spi_device *spi)
>  {
>  	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -320,33 +311,13 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->avdd = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->avdd))
> -		return PTR_ERR(st->avdd);
> -
> -	ret = regulator_enable(st->avdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
>  	if (ret)
> -		return ret;
> -
> -	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> -	if (IS_ERR(st->dvdd))
> -		return PTR_ERR(st->dvdd);
> +			return dev_err_probe(&spi->dev, ret, "failed to get AVDD voltage\n");
>  
> -	ret = regulator_enable(st->dvdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return ret;
> +			return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
> -- 
> 2.34.1
> 
> 

