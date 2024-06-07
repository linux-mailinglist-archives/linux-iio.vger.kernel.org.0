Return-Path: <linux-iio+bounces-5993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F681900108
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E341F2590A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221F15E5D6;
	Fri,  7 Jun 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7POC5YP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0713DDB1;
	Fri,  7 Jun 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756519; cv=none; b=OvPXr2RfNiLxCbW+LjtMTfwTUpXnTnshBtpudK/oNWEWTPNcA7PQc4mvcbZDV4INLHT5tRL3/np/OXMR4ADoiyLbOP6919umOFi7DqtCT209y07kO0dLU7UPDKnI+OIm64go4DXapWUxH+E2FaDrcfihLEfaqv/4B6aarFZn9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756519; c=relaxed/simple;
	bh=cEQNZnsBR2VQSTWPQWXJ4uAtDMxngmedxh84kXa5R9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baNWl3HeGohx3ZdKIhSNMo3Ei1XLdP+Nq5KuaGKZg4IMniTM6+4vt8dCxgQHbBmYfRYxCZrKF7CyW89CSdUimYaMAFAEuBjwwvzhpYw8w7DKNwpv21YEzgOUtpp/xdYiLwolgOORa/GUe6ssI8IAXOw6m1dLaRi/6O7rDbs7+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7POC5YP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso2805213a12.1;
        Fri, 07 Jun 2024 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756515; x=1718361315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SyqtvUG2CVqjseXG6FBne98Mm50tomI+i8lXDe9236g=;
        b=d7POC5YPpBjfLjQuHc2aBMWYH0lwnkmV447KUiJ3qtReAtHQMRjayLlEICu5Fl2AZs
         1zuuIG27dCSGYqD5oWaKPrE46ZAW95DDRnh00huqajmitiNTk4paKYBrwtP4hqrdDs34
         jJOxZ4hrJq46lXo7Kn67c8fSkleO6rCz35N9Rx8ak9xmUoPMutDc2Ljf2Tg3K3WXgt8s
         bvQEJrbZRj8x6JB0BNe3BJsM8OFvdZXLjNjHgrSmu59UP8zpaAB4EyTrKPzqbSlu7dZQ
         yShHK3Mf5h4YXg2CEoQe7TL7OOfHxLBzdnnnJbgIp/7YqpwBv5YoNFOx0nulwY3TyKT8
         cGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756515; x=1718361315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyqtvUG2CVqjseXG6FBne98Mm50tomI+i8lXDe9236g=;
        b=MRDlOunMbw/H5cUwp+6ds/QCoXYzaDrG/+aNW1DSUxZaYET9LJ4z/qL0wYrB4PtugC
         d91mFi/6vuuRKgWSaha4oM0oX06GUVMucv+emovfQ7r0FbjjuzgSVR15SBFubOvzjhuV
         OFmdVhm63oTR/mUFlHX6TKv2lVKDJ0GXyN8Q56RdpcgjX43tcJzezOmjE4ZtMOCaiea/
         7w5Eo1IFazxi/9W+HJAMXnicypx54xtNY2L0ihgOb1GD/AzKFxKBemQV3Qf2F035W9A9
         yYS//XRMoaqF0Si1hmYjIGeO+ePMhGF+7JTqhAgHM1Fpd54NtfO3L8dAAc+jfmwNn1V4
         UVEg==
X-Forwarded-Encrypted: i=1; AJvYcCVPx84sJgTC9wTYzNQpe4Yqm4OZAv13reKnHVXr7z8GiPo6XkTocLL5PbyDwjVEpVVpekm0sN3Tg7bsluXLpWZpH4mqHeI4TSMCcUmJ34u+4eSMBFp9ssYo+6K9B6Li8EPDVzKf24KAGZ5yQpEqZUHk0nygxuxdl/ZmU+Q+w+6xUNyQiQ==
X-Gm-Message-State: AOJu0YzfqtwvBI1nYLj6RqlNpNJFDdQi0r+FTI4NIxAX6vnsTL5U0KTw
	SttbDPvS9E7tFoDxGdSxUTjVeWDNTQf7qxAzN1zHRn4WEPnDu4Rt
X-Google-Smtp-Source: AGHT+IGDGqZF3EOJmlPdFpdDmBVl9/SkrPsskUQKi/KtpWFdtnkb6SE3DcmvaX2W4n1vN4ppbQl1IA==
X-Received: by 2002:a17:906:c302:b0:a59:c833:d274 with SMTP id a640c23a62f3a-a6cd76a92f2mr207366866b.37.1717756515271;
        Fri, 07 Jun 2024 03:35:15 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e7f3sm223747266b.155.2024.06.07.03.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:35:15 -0700 (PDT)
Message-ID: <a6c7e97b80e3448a40be95ef7aab0e0e74026edc.camel@gmail.com>
Subject: Re: [PATCH v6 9/9] iio: adc: ad7173: Add support for AD411x devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 12:39:02 +0200
In-Reply-To: <1c6d409b-ba9e-4a19-a6cb-e06209a24154@gmail.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-9-573981fb3e2e@analog.com>
	 <389546877ae11b18928b432e86710acf83974f67.camel@gmail.com>
	 <1c6d409b-ba9e-4a19-a6cb-e06209a24154@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 12:41 +0300, Ceclan, Dumitru wrote:
> On 07/06/2024 12:20, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> > >=20
> > > The AD411X family encompasses a series of low power, low noise, 24-bi=
t,
> > > sigma-delta analog-to-digital converters that offer a versatile range=
 of
> > > specifications.
> > >=20
> > > This family of ADCs integrates an analog front end suitable for proce=
ssing
> > > both fully differential and single-ended, bipolar voltage inputs
> > > addressing a wide array of industrial and instrumentation requirement=
s.
> > >=20
> > > - All ADCs have inputs with a precision voltage divider with a divisi=
on
> > > =C2=A0 ratio of 10.
> > > - AD4116 has 5 low level inputs without a voltage divider.
> > > - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50=
ohm
> > > =C2=A0 shunt resistor.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7173.c | 317
> > > ++++++++++++++++++++++++++++++++++++++++++----
> > > -
> > > =C2=A01 file changed, 285 insertions(+), 32 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > > index 58da5717fd36..cfcd12447e24 100644
> > > --- a/drivers/iio/adc/ad7173.c
> > > +++ b/drivers/iio/adc/ad7173.c
> > >=20
> > ...
> >=20
> > > =C2=A0static const struct ad7173_device_info ad7172_2_device_info =3D=
 {
> > > =C2=A0	.name =3D "ad7172-2",
> > > =C2=A0	.id =3D AD7172_2_ID,
> > > -	.num_inputs =3D 5,
> > > +	.num_voltage_in =3D 5,
> > > =C2=A0	.num_channels =3D 4,
> > > =C2=A0	.num_configs =3D 4,
> > > =C2=A0	.num_gpios =3D 2,
> > > +	.higher_gpio_bits =3D false,
> >=20
> > No need to explicitly set to 'false'. Ditto for the other places...
> >=20
> > ...
> >=20
> > >=20
> > > =C2=A0static int ad7173_validate_voltage_ain_inputs(struct ad7173_sta=
te *st,
> > > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain0, unsigned
> > > int
> > > ain1)
> > > =C2=A0{
> > > @@ -946,15 +1145,30 @@ static int
> > > ad7173_validate_voltage_ain_inputs(struct
> > > ad7173_state *st,
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 st->info->has_pow_supply_monitoring)
> > > =C2=A0		return 0;
> > > =C2=A0
> > > -	special_input0 =3D AD7173_IS_REF_INPUT(ain0);
> > > -	special_input1 =3D AD7173_IS_REF_INPUT(ain1);
> > > +	special_input0 =3D AD7173_IS_REF_INPUT(ain0) ||
> > > +			 (ain0 =3D=3D AD4111_VINCOM_INPUT && st->info-
> > > > has_vincom_input);
> > > +	special_input1 =3D AD7173_IS_REF_INPUT(ain1) ||
> > > +			 (ain1 =3D=3D AD4111_VINCOM_INPUT && st->info-
> > > > has_vincom_input);
> > > +
> >=20
> > Wondering... can ain1 (or ain0) be AD4111_VINCOM_INPUT and !st->info-
> > > has_vincom_input? Would that actually be acceptable? It would assume =
it's
> > > not
> > so we should check that right? Or am I missing something?
> >=20
> > - Nuno S=C3=A1
> >=20
>=20
> It will fail when we check for the number of voltage inputs:
> (ain0 >=3D st->info->num_voltage_in && !special_input0)=20
> as special_input will not be true if has_vincom_input is false
>=20
> Indeed this check is a bit hidden, should it be more explicit?
>=20

Hmm I see... Up to you. I guess I was not paying enough attention to=C2=A0
st->info->num_voltage_in and to the fact that VINCOM and REFs are not count=
ed by
it.

OTOH, yes, an explicit check could make sense because the log you output:

"Input pin number out of range for pair..."

It's really not mentioning the real problem (or it's a very hidden message =
IOW).
having something like

if (ain0 =3D=3D AD4111_VINCOM_INPUT && !st->info-has_vincom_input)
	return dev_err_probe(dev, -EINVAL, "VINCOM not supported for %s\n",
			part_name);

would be something way easier to understand :)

- Nuno S=C3=A1

