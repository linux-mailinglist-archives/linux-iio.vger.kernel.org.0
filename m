Return-Path: <linux-iio+bounces-5977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E18FFE8C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C42868AB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713F15B0FC;
	Fri,  7 Jun 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHxEbv4p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE61BC23;
	Fri,  7 Jun 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750847; cv=none; b=C1RJbRWKSmAOJ5SPa3WJTjsZl4lfQ9qJXJhAmXgLc2kIAskKPPcVTLQ+i4VzRZZfM8IPJnAiFYz1vlp9B6F9CilRBYlv/tWr7hnBv6WhlbeUDCXcOt8Ir+SAsiAY41EfONFoJM/jmwGtp84HZVvsoD+cjd+I9ZIK9t3F7ZrPhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750847; c=relaxed/simple;
	bh=6d2oyaveoYD51b3+do73Byor0bMXDI/B0IVfCP0qQpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q4ZwkdVuI1wZXHmWcC7cUeQRPzj56m2hIUgecMUkYzxUgRPBc62CXMOgG4KiUBbY81tYP88bYV177Aurn4Hh6bUmvTnu2LYrJLeCNT/hMiw0SFC69lpwdWsQTLB9W1Dy9i6Gr6azTv69kxk6hjVg/X7A8GFcvIZaEI+1c/WtpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHxEbv4p; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a626919d19dso545368366b.0;
        Fri, 07 Jun 2024 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750844; x=1718355644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njCJhsy2MgojMs7qfkzrTmxM/SuOjJ6hLPnSqBOXbMI=;
        b=CHxEbv4p1k1FHzTi9/AIzCicyZql11dX2HvOnMAEUxG1s7ouaouCwQB7VfN3nRByBQ
         UV76HqKAlE0sXIaMwxtdsV6tkmreumawWcZoZjj/og8D5VnNHiLU79IJ12sEiERfVQvm
         +cihiP+WFTawSAbTdcscl5YiF+hlwClblVqdamfyLYemJYpum4/UQPaocIceNW2KyPxb
         Elhol7kvDUISs2a2i/z8UFN3kEnvxHx4J4erTNkH1pSCfPDE8xleKJ028HyeVTOQ4VMI
         IP0opcZg3UoURej+UC1PgtDAeomZ1FnHgEAflTaIGOGagSXihSZTyWk7GECFJxSVkcOl
         bfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750844; x=1718355644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njCJhsy2MgojMs7qfkzrTmxM/SuOjJ6hLPnSqBOXbMI=;
        b=DOyKzr1fBmIFlygdODy/RWdsdXbc22Xjp6nvKagonTMyojKKX8AXzR7SKKKwPzabJC
         MPD1wGXkbZ1GI+8txYNoBbVC8f6UrqlzaSvQOTXs072XkbjdL5ZokJ5XXixKtuGxHbKM
         CNek/uPbRUA/lx13VwwN/+ggWN453ILw1bNLyz7buMkWKD1du/+6RadWziRI75FMRiHL
         clmxThaJ/y+PPSwjfloakqFjEc3yrAGBR6cvvzrMZjIEvP0avCIE2l7eU+MK9N/pdK+b
         xN5WxRXPiWnQfyKkFMd+EqIMVg6T5cbAvXMlVVNuDHdz0dQY3g/bCBpXJwa1O1KqLH52
         wXBw==
X-Forwarded-Encrypted: i=1; AJvYcCWseqVRnDY65YPa5xfi7NEARvZgk74ogP+J2VCVuuxglJIZukc8fnanozZ8vQTLfAiZVG2SPqhPBPCyrxSm9nGNeXEG1RFYK2cNQqvsv+7Kn4kPUYN5mXKm47fA5nyDFIkqNWEGjgJJrtXjO+0/fpdXx4AIA1GAlPTDQ3rtwmeBbut2WQ==
X-Gm-Message-State: AOJu0Yx8PJuwtBYnlbhH1k4Z4mLZhfj3Yeqn1da3qJmgjM1v8yLNOwKk
	ifC78p5KR0Ouf7pgYRuT2sarCvWWE/GvLC478JsEto6EomD6tBGE
X-Google-Smtp-Source: AGHT+IHLiLFheQj+yJQdq9hnRsDDDu9iBd3tmzAObK/st+kKWoHSHuDiy/xJciPfciWurAnMG9pnsA==
X-Received: by 2002:a17:906:c254:b0:a6c:70f3:de0f with SMTP id a640c23a62f3a-a6cbc6ca035mr174610166b.28.1717750843414;
        Fri, 07 Jun 2024 02:00:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ce1a4sm215208066b.75.2024.06.07.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:00:43 -0700 (PDT)
Message-ID: <8f74bb906951f56c753081af1462560fe98bc822.camel@gmail.com>
Subject: Re: [PATCH v6 5/9] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:04:30 +0200
In-Reply-To: <20240606-ad4111-v6-5-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-5-573981fb3e2e@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Move validation of analog inputs and reference voltage selection to
> separate functions to reduce the size of the channel config parsing
> function and improve readability.
> Add defines for the number of analog inputs in a channel.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 68 +++++++++++++++++++++++++++++++++----=
----------
> -
> =C2=A01 file changed, 47 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 8631f218b69e..4040edbd1c32 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -60,6 +60,7 @@
> =C2=A0#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> =C2=A0#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> =C2=A0
> +#define AD7173_NO_AINS_PER_CHANNEL	2
> =C2=A0#define AD7173_CH_ADDRESS(pos, neg) \
> =C2=A0	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> @@ -629,6 +630,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
> =C2=A0static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_stat=
e *st,
> =C2=A0						 u8 reference_select)
> =C2=A0{
> +	struct device *dev =3D &st->sd.spi->dev;
> =C2=A0	int vref;
> =C2=A0
> =C2=A0	switch (reference_select) {
> @@ -652,9 +654,11 @@ static unsigned int ad7173_get_ref_voltage_milli(str=
uct
> ad7173_state *st,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	if (vref < 0)
> +	if (vref < 0) {
> +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
> +			reference_select, vref);
> =C2=A0		return vref;
> -
> +	}
> =C2=A0	return vref / (MICRO / MILLI);
> =C2=A0}

unrelated?

- Nuno S=C3=A1


