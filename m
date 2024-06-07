Return-Path: <linux-iio+bounces-5981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C98FFF13
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084AC1C227CA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A215B57A;
	Fri,  7 Jun 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxWS4c+L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055873468;
	Fri,  7 Jun 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751828; cv=none; b=iqnn8HsdbMUDx+fFwpA5Fxb6s5/swyN1VIDdik2kW7UxWnrSp09127IeUaN7cdPmxOi47vQK5mpzKPrZHLE5enXg8QGGUDl9B/Fr6GOR5toYiKNmmP7U2B+jI0dtRlnvxMPBM8C5n/P0puhLZwK+YHICLcHfZ+bN/4XGU8yGVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751828; c=relaxed/simple;
	bh=Qc5A8wW1S4AxpcaSX5CLxLhReIvvGxK0np1BQAuHJUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFOjNOT+PaCXfg36Jdgk/5l9iHC5n8DebZOS0IvV/vrxsqHScV3VvKE6sHiDpsvE4Q4EeTSCTOLzHKQI4637hgfmFj5xVNfEtq2/qqTJGxE+OFa086FdTO7my9Ymqm18z2arWSvgiL83fpV5txMG57AQzDwCMulvDnBEgitsi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxWS4c+L; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso283214666b.1;
        Fri, 07 Jun 2024 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751825; x=1718356625; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pKVF5H7Af612iT5L8uzEkuJZLPXShQIxa9kUQtrflg8=;
        b=MxWS4c+LFo4gs6XkijEcTGuEaSYgbfC9v1XFDGNG7re2nu4E0lx815WMGOY6e23mIH
         Mbyl5wSEjeulI0QfkO9KDZP+HeaSM7ej0g/Xt7BaSzqq2X76iVBjCc0+vUSFhAIeM4gq
         jUvuteWTtOfQLjvROODAhaWo50zOq0mytKcagCl73IaO40BpvbFskgCyQN3R31OoRe0n
         SbrJK4DC6aUwgFLxE2Xjk4YfGZC2OT3KmlIQYHT9L0SQDCIS0XsFCCsKdQYGvoW9NbT/
         glZ4SxLp+nZqx5ZK9yvKGDpHMuaMkNjPBGV3SUt0GaPDy5RDe5YGg0+TPtXtTNt6gnlf
         zj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751825; x=1718356625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKVF5H7Af612iT5L8uzEkuJZLPXShQIxa9kUQtrflg8=;
        b=sscvUXs+ulAch3NjuiWAjvkhzHrmNrcjlAnWgEb5oeKhAFKhSLnbzv5jmwytgqbkrt
         VjXDj8WTzXae6ZiKeK9aD4Bx1issTmmSSIzePOYbfhgKsOCzRBlqgBxB9N3YlrseOIUi
         a/XJHEo8UNyKn86t+eq3J/pbIqtAXu+UZtFwDTNusU5alBRwVUA4aa1XyUMjuCQfDLI1
         +KnszmlOgsdgbeHxGSNiAmgOtd+XMyHnoFz24+YGEYNPDi68umx5YS+g3QCqHWRaSALE
         rgyzYaDAyLyh93HZ1gYAqg0BQ8x3VflrYwzP5V5fCwutHVGpWjlo7u1u+ojaP/BlSqOO
         v0TA==
X-Forwarded-Encrypted: i=1; AJvYcCWGdixuXJKgTS4rDq6Z3k4A39/GABnc3fnsXLIPCHfRqgW80FzcI2ISvmbrcapLFvzjb5oKj5Biu05+6MowO1gjBpdQhNDzcqsf1H/33ROXFGaPuZLdjH3k9UOwM87Q6CJ10Vkd6/788Cz3Ltsk9BP9OZbTGkTXEZPLBILYE/QAxxhbuw==
X-Gm-Message-State: AOJu0YyTsXVH6AES4n3ZMC4dvUPIK0cXuo01JJSac234zo+NtXK+AlyF
	lF38yiiyLam5JBNJWS83aQ6+3bjhc1vFDqWGz3zIkp0AzumwYfyP
X-Google-Smtp-Source: AGHT+IFZ9CrXNfTfZ9TvGHJ1UJDSFIxgqBj3iy3NGjFj3Kcu440uPOWocAks1Fs6i2sTyCvaHKCs/g==
X-Received: by 2002:a17:906:3610:b0:a69:7d72:b0d6 with SMTP id a640c23a62f3a-a6cdbef7773mr119943166b.71.1717751825299;
        Fri, 07 Jun 2024 02:17:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ac5asm215679066b.219.2024.06.07.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:17:05 -0700 (PDT)
Message-ID: <389546877ae11b18928b432e86710acf83974f67.camel@gmail.com>
Subject: Re: [PATCH v6 9/9] iio: adc: ad7173: Add support for AD411x devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:20:52 +0200
In-Reply-To: <20240606-ad4111-v6-9-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-9-573981fb3e2e@analog.com>
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
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>=20
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
>=20
> This family of ADCs integrates an analog front end suitable for processin=
g
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
>=20
> - All ADCs have inputs with a precision voltage divider with a division
> =C2=A0 ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> =C2=A0 shunt resistor.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 317 ++++++++++++++++++++++++++++++++++++=
++++++----
> -
> =C2=A01 file changed, 285 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 58da5717fd36..cfcd12447e24 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
>=20
...

> =C2=A0static const struct ad7173_device_info ad7172_2_device_info =3D {
> =C2=A0	.name =3D "ad7172-2",
> =C2=A0	.id =3D AD7172_2_ID,
> -	.num_inputs =3D 5,
> +	.num_voltage_in =3D 5,
> =C2=A0	.num_channels =3D 4,
> =C2=A0	.num_configs =3D 4,
> =C2=A0	.num_gpios =3D 2,
> +	.higher_gpio_bits =3D false,

No need to explicitly set to 'false'. Ditto for the other places...

...

>=20
> =C2=A0static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *=
st,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain0, unsigned int
> ain1)
> =C2=A0{
> @@ -946,15 +1145,30 @@ static int ad7173_validate_voltage_ain_inputs(stru=
ct
> ad7173_state *st,
> =C2=A0	=C2=A0=C2=A0=C2=A0 st->info->has_pow_supply_monitoring)
> =C2=A0		return 0;
> =C2=A0
> -	special_input0 =3D AD7173_IS_REF_INPUT(ain0);
> -	special_input1 =3D AD7173_IS_REF_INPUT(ain1);
> +	special_input0 =3D AD7173_IS_REF_INPUT(ain0) ||
> +			 (ain0 =3D=3D AD4111_VINCOM_INPUT && st->info-
> >has_vincom_input);
> +	special_input1 =3D AD7173_IS_REF_INPUT(ain1) ||
> +			 (ain1 =3D=3D AD4111_VINCOM_INPUT && st->info-
> >has_vincom_input);
> +

Wondering... can ain1 (or ain0) be AD4111_VINCOM_INPUT and !st->info-
>has_vincom_input? Would that actually be acceptable? It would assume it's =
not
so we should check that right? Or am I missing something?

- Nuno S=C3=A1


