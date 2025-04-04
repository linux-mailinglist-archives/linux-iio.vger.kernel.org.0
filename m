Return-Path: <linux-iio+bounces-17630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E3DA7C550
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48E61897E50
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F919CC05;
	Fri,  4 Apr 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4jYuA3/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B213CA9C;
	Fri,  4 Apr 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801085; cv=none; b=pmAA3N+1KlZON7926nvE5b/wisaW9PigiWdrK+9q89Q+TlzOHPcLJDLoOl16ZxttAq3ug8c/OWX64IEcaoY6z86ny3Z4dvz4ghtD88qusYrMxvg3aI6xaV6DGk5PE9ysfvMLjdpPdS1gzG5Z0GtjjTfQ6VOx3DscFNeLsadyvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801085; c=relaxed/simple;
	bh=MjG7WDVtAWWUYawY2kCjjrRaSUwGOVTw+twD7YyzniI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti1u1LlelY0l03pLSBS0hJGlpfNZUc3Ag+DWO7mFtYvMdmDkwLN2Zh6FaSG+BXTjLT57HR7FbGx4gTVdB4rGkck7unoQBqgsaWOib0TdObsar8EmDHeHiNwFSTnzSy69C6LXjpIeRKyOuwu/ZShFhxXXYubdN2n/E5DCofzldF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4jYuA3/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399838db7fso2313046b3a.0;
        Fri, 04 Apr 2025 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743801083; x=1744405883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ5Ax+b/+r9SViBdjupPBgBblmSsLmDgYIPTd3L/ObA=;
        b=D4jYuA3//wFS15gywYlnET75MvbPnO5EpPVbaqT46kgDKTXuN4iKIKHv1ROEawpWWQ
         j3FcBVx2OVVORpB1oBzUSWtZYH4GqQCUDrzSq79SOgnbI7wIv5iRkcmhy3ZVciEHWYn2
         7E2sXK15+wf3+RDkfDfWpAbkFJ550dtMYCAGNSsmswPJMJw4km2puWUtRK7PofUu4XOZ
         tppZSqputv/NYFO+CDOaU4y2AXbwAboltjw17fSKnkG/MWY2HWrPVt177yFWzygSESUN
         EOEe817hmpnLkz/GKSGmp3wPLiUn9t6xEHEO4YnWqYKNPeeZ+kSrkRUPPDdLcltskQ1s
         jqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801083; x=1744405883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ5Ax+b/+r9SViBdjupPBgBblmSsLmDgYIPTd3L/ObA=;
        b=HUChG22IMSTCmq/2M593KEn9mmqf+quLFjMgwVMeMf6xMA5iz6uBEby80A3K8R6NxK
         Tlpa9VrWHahAnbsRclk8WTMMaoY9y3Fe0IguRGep54uco+gHxKlFFvxnouUP6cX9Dr/F
         WT/+BA2jva0+gpJUlSPO61xgDel7V0CQo2U5djhqZMYf9Z2fu0o5/u0Azqaadz58O2Ct
         gm1KznT1n3p2C6w6kF8aOns8bkNWRN7Oge81dWTpGs4X6quts3FfJ32G8iYina/urCW9
         FhbFXLyi7xCyZV3bsRA0MRxenRZszDeG8x1mTKNGTdrYI9RcLvlt0BYn6n1D/yuJksKY
         CWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8C0goORXpsHNZfxpRl1sDW4XKyINWfh4V3UMh8Frb5pD2EK7CCdryZ1x4ykvNP2fND7yVRETSZcQ7Q==@vger.kernel.org, AJvYcCVHMXUT+7lFdvGKLCYywtaAe1ME1E7C564IRYRNfbowgKtF0mN/GUVOETaAAM+3jkvoG/2C4M8k/cKk4/YL@vger.kernel.org, AJvYcCXklX+vRakGu78R2O43CBVX3cmdUjykv3m2Mo3uee94a0a1VTk/BRgFfASChv2KSTwdG5rK+8Svuher@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZQHEhszeTqgf++1tJR0BCTYfHmSdAKyMptoZGtVXhywOp35O
	YpgHdTcYDCpI7P327474ifhlJhG8L5heRXxEqdhRl6KB8idH9T8Q
X-Gm-Gg: ASbGncuST1JH2Dxsd0ZFU+K3SSRNghZHYYw2b/59iaB7wzL0xbdh2+HudUsO16OaxM6
	QHYSYitVPLpGgiyW6PZJ5UsMMI14EEnWZ6t6/wFvVq1iX/MqmyPYQ4Sf06tu67/2P/M99qGzIR2
	4Mw4yJiaG9c5e7hOUXghRZwxIrFpv21jjrUCrNB2tWbLdIsY8f56rKqzprsY2cRgx3O349n2Ag6
	6pSUwBWTNmP+ome9ySOX830WsCbgk0J3gKH17hs8UUkUSp7tdvJf3D3OHZlz8JL0yxW55+d7T/0
	Erv9ReAt7g2GpQUZHUVO8KMHooq6+Sxcde+wQavvSzgQ5RUPMtiPxQ0=
X-Google-Smtp-Source: AGHT+IH42CCq/W/EvmBslR7WSG2Y/2tJDvNHR8eQZSvFsgksiebLqGqMnBl3sbjeiQ3LoEp5Fd0/Cw==
X-Received: by 2002:a05:6a00:3242:b0:732:56a7:a935 with SMTP id d2e1a72fcca58-739d65872a2mr12032822b3a.12.1743801083259;
        Fri, 04 Apr 2025 14:11:23 -0700 (PDT)
Received: from localhost ([2804:30c:1f4f:6800:9245:316f:6226:cc1e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d9ea097asm4021937b3a.90.2025.04.04.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 14:11:22 -0700 (PDT)
Date: Fri, 4 Apr 2025 18:12:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
	jonath4nns@gmail.com
Subject: Re: [PATCH v4 12/17] iio: adc: ad7768-1: Add GPIO controller support
Message-ID: <Z_BLOjVxtPF_eyOj@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>

Hey Jonathan, 

The AD7768-1 GPIO controller support looks good to me.
Besides reviewing it, I've also inspired on your patch to implement GPIO
controller support for AD4170. I have one inline suggestion, though.

With that sorted out
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks,
Marcelo

On 03/06, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> Add direct mode conditional locks in the gpio callbacks to prevent register
> access when the device is in buffered mode.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
...
> ---
>  drivers/iio/adc/ad7768-1.c | 143 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 2 deletions(-)
> 
...
> +static int ad7768_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			   AD7768_GPIO_UNIVERSAL_EN);
> +	if (ret)
> +		return ret;
> +
> +	st->gpiochip = (struct gpio_chip) {
> +		.label = "ad7768_1_gpios",
> +		.base = -1,
> +		.ngpio = 4,
> +		.parent = &st->spi->dev,
> +		.can_sleep = true,
> +		.direction_input = ad7768_gpio_direction_input,
> +		.direction_output = ad7768_gpio_direction_output,
> +		.get = ad7768_gpio_get,
> +		.set = ad7768_gpio_set,
> +		.owner = THIS_MODULE,
> +	};
> +
> +	return gpiochip_add_data(&st->gpiochip, indio_dev);
Use devm_gpiochip_add_data(), otherwise the gpiochip is not removed on device
detach.

> +}
> +

