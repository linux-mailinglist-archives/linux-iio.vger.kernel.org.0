Return-Path: <linux-iio+bounces-22462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC3B1EA48
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8163A385B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD902750ED;
	Fri,  8 Aug 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTUby8Tv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22FF4F1;
	Fri,  8 Aug 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662972; cv=none; b=qKeejky8tfiTmKUeTGV5emTnPeWbZ0uXZgI30idIFaPM1qztQtKclDxEwcN1mxQVAULv1af8mmTaXdhrhcyJolW54rsxWjrTSwTd6kFZ2qTFj+zbqv0rEE7o8yQdzRv4G0rNNbqMDN9fvi/rH79I0VFlF+kif5huQr1N1xKDZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662972; c=relaxed/simple;
	bh=e4cIma2bCVadsoxD9fLtfbZoX4Q0NQDC5sbF73+YsW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faEIAUNh6D2dQypUweaO/5yINnoiEGO68w1DH4ZBk2B6cxtCCH4EHEeJOtRy6Pj1oPDETD16245n4J11vvecx5Y3dUEn5QNvzHj6zuOQSffry99Fa0OD0aujQMr4WBGPpi/Egbrq8w6vtGRwkbIC3WU55cFVlVNI5GwWjNFzjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTUby8Tv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0619a353dso16212471cf.3;
        Fri, 08 Aug 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754662969; x=1755267769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEtVUmrObki/Euxb5LDpNJRPeU+d/0g/RUaMnwv20+8=;
        b=UTUby8TvZItP63m9we20RMnOujhXxbTvx/UgxuYmYR/6bAEVsXijNFB/79XNhAovg6
         tb81tbSp6Rc/FiatwjIm5umxMzzgNruLDGYTh2U+awePdVqG1ye8pBSYdGHZbfktlyT3
         dn8IRWvufAummVl1gmgJt21MxgNE/uUVLaPbrSvAgK0/qYz66oOxXSW+o5DIb14mCbNZ
         c6nH/SS8QRUwbmgfGN2+Bj7GfuU8OsOD8ezFXZCBMg8pSfLQ2NkBxh66E40n9KEevS8o
         GpySsdA+Sjq4dEFjq2SQxI6ngZ8WxjO/QZXE1haKdR/oDe41EzH/L81MpjklzpDT0wAu
         IFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662969; x=1755267769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEtVUmrObki/Euxb5LDpNJRPeU+d/0g/RUaMnwv20+8=;
        b=fb0piW3+q5uwvTdrLG33+IMASpfnxdBBhyUxlnFeth6UJGcKjzfCT+bD1h37bxj1Em
         CFnAHS5iPR3WRYirY7PqrU90gBexO9hbQ5jdPMbg0kNraaJ8GeL8yIDF6E42jcKv3OLl
         OVFpehuYgWq/TU3YDLSCnpNQQViGv3UVVRKD1Nrf50hLYoITxUr5VaSGYrVB5s60Yavr
         ZRD64HY7d0pwfZ3iYQqOpWD9J+7kh43uHDpAg4dfeSPjhzRL8sMo5VRYhBxN6LTTIYz7
         NFXE3y/gQ/9aJFfXhtsDp3+EoJSV4UMw7qzhqNDx+zzXFmrv2EytZR5kyuz3Bax8oYzZ
         l6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUDQgVUaNrBkdpEL/2pBneTlrIqp2NTGKOMuDje7UO3kcf8ciDOKFAqpZXOYGXHwbb1ZGF+fYHgLW8RtpCD@vger.kernel.org, AJvYcCWSTAjObF33EIjF4v5736+DW9xcX+FqTuYVO8KZaXzMXQAlFm1JRQGU3KME3DZN+p25VlrqvALnMK/+@vger.kernel.org, AJvYcCXm8FHVFt0BYxS6iI1W72sQm6NgKMXusnv1ikfACLNlSt3GoqyAqqxpM5EZHNcLETYu+FZR7pnI46k+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu26UTyegRYpP9LQMjpskPPYf3d9Q/LT9GDq7zbldU67JyoScr
	9pdZbEaC7IjGb83ax6PCE814CxNOQ9ilBQ2jHcFcQVehZhktfduupa1h
X-Gm-Gg: ASbGncvO2knCFlXUZzhfLcfwS0MVNdIj7+z9/ajspM0JMMnojR4rgT+ZAtOkDvA5PA3
	C44u69V58xjklM/Mgbeg1W3GuBoZIX+U+3hzOi+moChm/+x3SmWTahGYdAhBwFgEvkYSI+31+/x
	ippwg7Cs36TWn6Um07+rhbeMGAZ3+aFJjbalC9GCSIFcauwxN+O1IaE5SAtXvf/FY8G9KjCrqgx
	IUpD0WAI2Yk1SehJ5CgLLerLsgXYtmL6P1UsmXsedQgDpX58hON5eorqR4X3kp31aYQ9Yo7WC1b
	wB5qcHP+2AjWDTTW0MGE+y+HjkeapyBfnfQXJCue5ScCMA88Cf4EkN0CBT4llD8IC3bMgUGixfD
	sBWMnwbP7dOH6Mw==
X-Google-Smtp-Source: AGHT+IGSnRj6VSelZgrYBqF4Yc8p+ydCCeOhnViWtR8z4uk9qaXosPEeCGzav0ejjHuC/9aPMRFwYg==
X-Received: by 2002:a05:622a:53c4:b0:4af:2305:2c37 with SMTP id d75a77b69052e-4b0aed41cabmr45258421cf.21.1754662969440;
        Fri, 08 Aug 2025 07:22:49 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b099b2c4c9sm31120771cf.58.2025.08.08.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:22:49 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:23:03 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: adc: ad7476: use *_cansleep GPIO APIs
Message-ID: <i76z277zwb5kc3yn6eeniopobd5drotz6msah2u7phx6cgsb7s@ywssyjymmyms>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
 <d6a8f19e26ffaa97da32317a9601147a11a82622.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6a8f19e26ffaa97da32317a9601147a11a82622.1754641960.git.mazziesaccount@gmail.com>

On Fri, Aug 08, 2025 at 11:52:13AM +0300, Matti Vaittinen wrote:
> The ad7476 driver supports ADCs which require a GPIO pin to be used to
> start conversion. The GPIO line status seems to be always toggled from
> a process context, either from the user-initiated "raw-read conversion",
> or from a threaded IRQ handler. Furthermore, these ICs are connected via
> SPI bus, which is usually implemented in a way that the access to the
> device can sleep. The GPIO here is toggled from the same context which
> is reading the results over SPI.
> 
> Thus it seems very likely these GPIOs are toggled from a context which
> can sleep.
> 
> Swap the gpiod_set_value() to gpiod_set_value_cansleep() accordinlgy.
> 
> Suggested-by: Nuno Sá <noname.nuno@gmail.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2 => v3:
>  - New patch
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7476.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index fc701267358e..1445f0f599d9 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -57,9 +57,9 @@ static void ad7091_convst(struct ad7476_state *st)
>  	if (!st->convst_gpio)
>  		return;
>  
> -	gpiod_set_value(st->convst_gpio, 0);
> +	gpiod_set_value_cansleep(st->convst_gpio, 0);
>  	udelay(1); /* CONVST pulse width: 10 ns min */
> -	gpiod_set_value(st->convst_gpio, 1);
> +	gpiod_set_value_cansleep(st->convst_gpio, 1);
>  	udelay(1); /* Conversion time: 650 ns max */
>  }
>  
> -- 
> 2.50.1
> 



