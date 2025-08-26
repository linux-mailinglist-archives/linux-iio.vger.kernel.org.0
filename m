Return-Path: <linux-iio+bounces-23279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7AB351EB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 04:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C998B1B285D6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94D29CB2D;
	Tue, 26 Aug 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agN/Qt5e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D51BD9F0;
	Tue, 26 Aug 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176785; cv=none; b=qa1uy7LsLXzR14dJqCM/RXBVSd5/iPpVWA6TSkd4CiWwcZrKANHrmfd8Pvk9KwruUPyz78/x9g4xUvN9Wz/6vJTvD26OMz0bstiToGtjyNdgcdvKI53b7vEgI3eUZSPhrYmbehqGJO99Rf20QW3BXsTrbn9NXCfevZrQFOzbO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176785; c=relaxed/simple;
	bh=jIKwXCuyetH00kw8QDzM9LpC7E0LAPwl76vifYGzwbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj2HnNCtI1PTs7NarIwggJZcfhebig0n6CCPE72h2i2HQ63ESNEeRJmkoh1Rz9uBYktZigslxeuXiINhgjq9kj2LBcnttNftpfBBMulAM36jMfuAU7nZHMiI/pH2kcR8wrdnWHzdIf/EBD/Gtun8I7De+BpwY85uTOZ1tVNTQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agN/Qt5e; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bc52fd7a4so3528798eaf.0;
        Mon, 25 Aug 2025 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756176782; x=1756781582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wiU3FfQ1ao4ae7gTdcb97fPlhi1QmyJ3mzBpnSI75k=;
        b=agN/Qt5esjuIXaWsHgzEguVak8lChVWYnMsiUqvs25bwHj2FG0ZhXRhIdYicLIWTNR
         0IcRAZrQ2f0KdCN895u1tN3RGoSAMhCtenYQyPvFKKRwe3kpc3jGoKSxOk0lX3v0y2KG
         5VjM6OYa9HpkK9F6XwkQhOQ+y/mTCLtpRI6K7Q3fAM2NmiicMayop1vwmy3ukUrPqd1x
         ncO7pE14bOTwM26uN3iq+/FcLHIjZYmGVrSZqS+Atk/jdVR4tktb1Q8xh9cISGIspKAS
         wKO5+TT90QcHfn6YHpSzJmaGyN0aLlvZYLWgEbr+KiW47D8+IMhsTTwqInV8cQIfICR+
         Tuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756176782; x=1756781582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wiU3FfQ1ao4ae7gTdcb97fPlhi1QmyJ3mzBpnSI75k=;
        b=NPzt1A1NOxqZRLZo1nrODKp+US2okFTxNMun/qLLrprJj93LTEXOmU823IMeab+bny
         8EbAD08uvmjwpys08JYtoi0Hj1EXiBYhR5FiLLVVPvwsQwkcaUZWokQn1D7mhMB4Sp2O
         Z1RsAuAKR+x6kyWYczuRUutq6BJyGvyHzIJfKtTVj5TD+OsgsCOBc1b7+tj3xzil7BLV
         UAeUN8ZorpC7Ooitd9i93/ViFzCO/LU0x7ZzIfzsCY8o62gonOFXjA7xL98KfrjLTMZQ
         w4JBRtjXVR65zXCqnoUSCk906AqnnVthgh3MPOs8ZJU70+23fZgHy3yv+lF2eyE2Ka3G
         Y8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVJnVFO4P4Mj3f730/IYhja/vhXQdKfzMdghNRhp03TBUP20UZnzwVEtMDIKzQ9stChix9poa73ydlk@vger.kernel.org, AJvYcCWcOPNk++M0g7znkhg9GS7oWg+Pxunn7H0/la8Bv/0a0IjSttI1TirAScqw3wAlcL+9GU/slEjHa18NvJ7n@vger.kernel.org, AJvYcCXCGwlFjD9K86sAjQ2ouKr9777xbaA3yJP3cLcjk+bzO1x1REbE3895AM7RhY976qbdtngToOxrwn/W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2M5UFM6cwUqLmnGpgfR5+/57A2LFPgMDsSY+wFli9xOmv+YxN
	cvqVgYZCk1dCvvlhaEZ4/pjgI0ZHqT7xyjmbA/TYRZ3xm8hOrdEaGNmew9hhr2v893DYL1OIs0m
	zG+GHdmvvF6fZ+6m8+rE22rQhOhWT4R8=
X-Gm-Gg: ASbGncsbq2ryoybsO3Uu5Wb1uKM6R5bB2T+1kH9IzIp7a2AJ4cmAPfMshEpqgeuCVdI
	iz8JPe0po2FoQtzDzeTdWVwlkBYn6pHaDUDvXEHBlQasjYZGgQrrc9q8qOftVnffGAn0O51bWMh
	86lY/KJ9y3c9wPGjEsqzdWPrPBlqIj7V2Qat36S+5YPzolek8YearPSZIouedQjwQ3G1cTVLiQS
	qy5I/QXbWC1+NJ67hQor/Sh5NJJx1y5NYVqFqa2MA==
X-Google-Smtp-Source: AGHT+IGO9u5xmjKFwVj2+DEw6IkIDeQabtz+UPKNGARUbp7G6/6nHgULH1RPqxPQYH/lc3vlw+v8T4vUHEbVjBHCso0=
X-Received: by 2002:a05:6808:6807:b0:437:75ea:6c7b with SMTP id
 5614622812f47-437be07c682mr1181796b6e.24.1756176782462; Mon, 25 Aug 2025
 19:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com> <aKaMPMnGRyvKqTny@dixit>
 <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
 <aKfYlP-yWdQi34db@dixit> <CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
 <20250825105032.45f33b12@jic23-huawei>
In-Reply-To: <20250825105032.45f33b12@jic23-huawei>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Tue, 26 Aug 2025 08:22:47 +0530
X-Gm-Features: Ac12FXx9WxjdZAKTizoXrZkyNmq2ndi8tUUkkuWHCkB0726aB5x6PzxNuf8VLqA
Message-ID: <CAFmh=S1hdCMnWYzHsvTDb4C1vvinMCeG_=1m-N+psw5tp4nm7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > > > > > >  st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
> > > > > > >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
> > > > > > >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
> > > > > > >
> > > > > > > +obj-$(CONFIG_INFINEON_TLV493D)             += tlv493d.o
> > > > > > > +
> > > > > > >  obj-$(CONFIG_SENSORS_HMC5843)              += hmc5843_core.o
> > > > > > >  obj-$(CONFIG_SENSORS_HMC5843_I2C)  += hmc5843_i2c.o
> > > > > > >  obj-$(CONFIG_SENSORS_HMC5843_SPI)  += hmc5843_spi.o
> > > > > >
> > > > > > I haven't got the ordering rules here and in Kconfig. Can it be alphabetical?
> > > > > From what I can see, the order is alphabetical based on the CONFIG option in the
> > > > > Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFIG_IIO_ST*.
> > > > > Isn't it in correct order? or my understanding is incorrect?
> > > >
> > > > I dunno, The file name there is with the vendor prefix, in many cases
> > > > the configuration option is with vendor prefix as well, but the file.
> > > Hi Jonathan, Can you please suggest best possible way here?
> > Hi Jonathan, When you get a chance, please share your thoughts on this.
>
> No hard rules on this.  We should probably make some but don't have
> them yet, so try to go with what seems most common in the particular file.
>
> Jonathan
Okay. I believe we are good considering most of the drivers are having
vendor prefix,
so does this driver too, and its currently in correct alphabetical
order. Considering
the alphabetical order followed is for CONFIG options.
Thanks,
Dixit

