Return-Path: <linux-iio+bounces-27176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F43CCC0FE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C92E8301C0B3
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D6334C0A;
	Thu, 18 Dec 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgFj7LTZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9732E697
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065389; cv=none; b=K1SlnLRBjiLJ4TSPqntAK1hyG1AotctRp6PDU1XjVABWmwL8nyIFGGPJNLGnqn8Pp8E340UDNectV/YeZAK5QIWl0YYrhdWGFrGmSwq8iHmOjiYY75BvUrN7uINVTjn2NhL1yZbzyOtoYm4oub4+6Q9aFjgGveCSS8K9Uk0DzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065389; c=relaxed/simple;
	bh=3uKgmcbEavrud2dny+EGlUg4Q9Rhn8PqzITF6l8cU3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=im295W/+8D1xDQzSOGpmOxSD04mpbbFkEn9bQnwECILPAW1qscWj6S8z2g/A7eYGkQnF1TZ9xPEl83VqXnKa92i9RUIhDwOZ+AW8OhyI3RldqeysyfbrhVzfIXKLiVTVJTHr8yrssFkABv2epDIMJhgukOWsq4ETyOm5YPtboWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgFj7LTZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7a72874af1so111755466b.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766065383; x=1766670183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9MNCy+3Op+1UssWJjdakMXoziKFg7kF95mrRH4k/yFY=;
        b=LgFj7LTZUXcLDrrx262QS8knur89BbHgc6/loCfQ8lowTpvQ83wlNiEmv5+p2yXUjg
         yOC3i2np51U8CHZI0L1M3iI2yn5fhDlU/FRJNCqZtrYSfkqJYXI4JEnrrE2mDHSjkrcA
         U+GGcRP4785HO2iXoJWfcCtTIn0rIKE6fSyrKEcPOkf0ExJsS3MLKreYSTDYFXdcD4aR
         B3F6DECam5IDEAK9otP5GufwAwplokeOrVbwrryjCCpPFNCPNj8k/A+cqD4VCzrqDrl7
         anB5w0NUMG1Gb79aNHh/ZPHXp+vpjyCImUcaJhHtD1F7QiO8PYelHR3iiBbRb/tLVT2M
         oZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065383; x=1766670183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MNCy+3Op+1UssWJjdakMXoziKFg7kF95mrRH4k/yFY=;
        b=Oy9mVOMtzFHr1GeK+RPZFyeFtaIyZaZSQa/P9IFj0akO9sSywqJXL/9Yn8I7qNc6rB
         XKHWlGgLDKPczyWTLhIaiym4LAEr3mRxJ96/O86apSIDL/5fP/AFbmmofSz95o908892
         vIopwW/RyzdVAzIHPP+NoTbxlgtHh7ESkLIBlzfYDcqpmXxLLw7tiqaurkgmSq93lM8F
         1E1TaPtkNgOvKtuxli2kmYRL01UypUGIZGGiRMDRWfSn88qlylouh5BQWvWKgJpu0Gs5
         WYyVwBExSNL7lfwPfD5KzKNPQuq846tsgGe8IbWTEnhxG2GGDr52dsEpFrXlB+z2qTQK
         Zdyw==
X-Gm-Message-State: AOJu0Yz8lMeDXEqmMkF6cYD2dU2jUnd5bIEHy7B+s1BcSnwND8e5IVou
	MISqLD2U58gzy+mGxXDzdgqNK1g3Iivm3HYQnwcw1ryhDi/yZwOlXvxluju4oA==
X-Gm-Gg: AY/fxX7JteLzSqmEB7lXHyEGgqE+TIaxzFlAbMK58AVxZb5sSu7kQgImV7rmjMpEXI/
	XwsgUkh5s2HgyikEsjB9dc7mcodCx6xP62WrBQtTsuf+zTXDSYiaiUhq7rYMjB83kHvvJmzV9jw
	bMKgTXc8tdcBjCJC6pvEwrQGdypa/FmC7wk7dG6lE1uC4dcURkaEZrqhSY8pSSg4vcdgZifMSiG
	/1p8fmIwxBjjOzq2WbqEUwVWinTPrtg2iQzCIA7+JFMo2/NGCoGj1Fqh9R2qqoetrt0t1MZBW0D
	8WfPrAXqOIgHH3YQN8MF1SQk8eOi2RkeNeE883y2JA5pX2NjxKF87vXiqVySgjhC5uQmoc5sqeK
	5d3itIiTnNAKJaOLoO6v4E4pzJxcgBQFanCmcaIT3VrEYV4nfc/PJXVYn+wfdZwV/W+VUxCExbv
	LGfgHHbpflSuc=
X-Google-Smtp-Source: AGHT+IEIvgQZ6GSNj21nMDBBGU3lT72Djs9e9SGoncRuFMosxpAYOsMQzte+sKYjy/n3c9LS8LDddA==
X-Received: by 2002:a17:907:6d24:b0:b7a:1bde:1223 with SMTP id a640c23a62f3a-b7d23ad88e6mr2046349966b.64.1766065382942;
        Thu, 18 Dec 2025 05:43:02 -0800 (PST)
Received: from [10.5.0.2] ([45.94.208.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b802350db89sm233624166b.63.2025.12.18.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:43:02 -0800 (PST)
Message-ID: <b5e91011ce6628542da7bd25d7b143401b155406.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad9467: include two's complement in
 default mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Dec 2025 13:43:43 +0000
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> All supported drivers currently implicitly use two's complement mode.
> Make this clear by declaring two's complement in the default
> output mode. Calibration mode uses offset binary, so change the output
> mode only when running the calibration or other test mode.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++--------
> =C2=A01 file changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..60fc3361b2689a4c38287c613=
ef93fe00338e5fa 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -72,6 +72,7 @@
> =C2=A0#define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
> =C2=A0#define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
> =C2=A0#define AN877_ADC_OUTPUT_MODE_GRAY_CODE		0x2
> +#define AN877_ADC_OUTPUT_MODE_MASK		GENMASK(1, 0)
> =C2=A0
> =C2=A0/* AN877_ADC_REG_OUTPUT_PHASE */
> =C2=A0#define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
> @@ -85,7 +86,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9211			0x06
> -#define AD9211_DEF_OUTPUT_MODE		0x00
> +#define AD9211_DEF_OUTPUT_MODE		0x01
> =C2=A0#define AD9211_REG_VREF_MASK		GENMASK(4, 0)
> =C2=A0
> =C2=A0/*
> @@ -93,7 +94,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9265			0x64
> -#define AD9265_DEF_OUTPUT_MODE		0x40
> +#define AD9265_DEF_OUTPUT_MODE		0x41
> =C2=A0#define AD9265_REG_VREF_MASK		0xC0
> =C2=A0
> =C2=A0/*
> @@ -101,7 +102,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9434			0x6A
> -#define AD9434_DEF_OUTPUT_MODE		0x00
> +#define AD9434_DEF_OUTPUT_MODE		0x01
> =C2=A0#define AD9434_REG_VREF_MASK		0xC0
> =C2=A0
> =C2=A0/*
> @@ -109,7 +110,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9467			0x50
> -#define AD9467_DEF_OUTPUT_MODE		0x08
> +#define AD9467_DEF_OUTPUT_MODE		0x09
> =C2=A0#define AD9467_REG_VREF_MASK		0x0F
> =C2=A0
> =C2=A0/*
> @@ -117,6 +118,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9643			0x82
> +#define AD9643_DEF_OUTPUT_MODE		0x01
> =C2=A0#define AD9643_REG_VREF_MASK		0x1F
> =C2=A0
> =C2=A0/*
> @@ -124,6 +126,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9652=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xC1
> +#define AD9652_DEF_OUTPUT_MODE		0x01
> =C2=A0#define AD9652_REG_VREF_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xC0
> =C2=A0
> =C2=A0/*
> @@ -131,6 +134,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#define CHIPID_AD9649			0x6F
> +#define AD9649_DEF_OUTPUT_MODE		0x01
> =C2=A0#define AD9649_TEST_POINTS		8
> =C2=A0
> =C2=A0#define AD9647_MAX_TEST_POINTS		32
> @@ -461,6 +465,7 @@ static const struct ad9467_chip_info ad9643_chip_tbl =
=3D {
> =C2=A0	.test_mask =3D BIT(AN877_ADC_TESTMODE_RAMP) |
> =C2=A0		GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY, AN877_ADC_TESTMOD=
E_OFF),
> =C2=A0	.test_mask_len =3D AN877_ADC_TESTMODE_RAMP + 1,
> +	.default_output_mode =3D AD9643_DEF_OUTPUT_MODE,
> =C2=A0	.vref_mask =3D AD9643_REG_VREF_MASK,
> =C2=A0	.has_dco =3D true,
> =C2=A0	.has_dco_invert =3D true,
> @@ -479,6 +484,7 @@ static const struct ad9467_chip_info ad9649_chip_tbl =
=3D {
> =C2=A0	.test_mask =3D GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 AN877_ADC_TESTMODE_OFF),
> =C2=A0	.test_mask_len =3D AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY + 1,
> +	.default_output_mode =3D AD9649_DEF_OUTPUT_MODE,
> =C2=A0	.has_dco =3D true,
> =C2=A0	.has_dco_invert =3D true,
> =C2=A0	.dco_en =3D AN877_ADC_DCO_DELAY_ENABLE,
> @@ -496,6 +502,7 @@ static const struct ad9467_chip_info ad9652_chip_tbl =
=3D {
> =C2=A0	.test_mask =3D GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 AN877_ADC_TESTMODE_OFF),
> =C2=A0	.test_mask_len =3D AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
> +	.default_output_mode =3D AD9652_DEF_OUTPUT_MODE,
> =C2=A0	.vref_mask =3D AD9652_REG_VREF_MASK,
> =C2=A0	.has_dco =3D true,
> =C2=A0};
> @@ -671,10 +678,14 @@ static int ad9467_backend_testmode_off(struct ad946=
7_state *st,
> =C2=A0
> =C2=A0static int ad9647_calibrate_prepare(struct ad9467_state *st)
> =C2=A0{
> +	unsigned int cmode;
> =C2=A0	unsigned int c;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D ad9467_outputmode_set(st, st->info->default_output_mode);
> +	cmode =3D (st->info->default_output_mode & ~AN877_ADC_OUTPUT_MODE_MASK)=
 |
> +		FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
> +			=C2=A0=C2=A0 AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
> +	ret =3D ad9467_outputmode_set(st, cmode);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -778,7 +789,7 @@ static int ad9647_calibrate_stop(struct ad9467_state =
*st)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -	mode =3D st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COM=
PLEMENT;
> +	mode =3D st->info->default_output_mode;
> =C2=A0	return ad9467_outputmode_set(st, mode);
> =C2=A0}
> =C2=A0
> @@ -1174,12 +1185,18 @@ static ssize_t ad9467_chan_test_mode_write(struct=
 file *file,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		out_mode =3D st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWO=
S_COMPLEMENT;
> +		out_mode =3D st->info->default_output_mode;
> =C2=A0		ret =3D ad9467_outputmode_set(st, out_mode);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	} else {
> -		ret =3D ad9467_outputmode_set(st, st->info->default_output_mode);
> +		unsigned int cmode;
> +
> +		cmode =3D (st->info->default_output_mode &
> +			~AN877_ADC_OUTPUT_MODE_MASK) |
> +			FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
> +				=C2=A0=C2=A0 AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
> +		ret =3D ad9467_outputmode_set(st, cmode);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0

