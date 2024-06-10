Return-Path: <linux-iio+bounces-6156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837390241E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65D6286FEA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F575132129;
	Mon, 10 Jun 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkUQs4GQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3938FB0;
	Mon, 10 Jun 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029878; cv=none; b=dbFrqVBr5yOuetPn36ajTSATmFcoR5v0bL0mxZ5Sg4p57Qxdc9443qcTgKIQ6myNkUd1Q4M0wnLcVd5syXRYQ3abTqjt/Js4KquNMuU59lpyzH7rG95C+WMTsddB4BI8Yr4Xmj/ooTUxZFO9oqJjvBzf7GxPfqDWs4IiL3fLC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029878; c=relaxed/simple;
	bh=tZ/qdhdw8oAofl919/+MTxRzoITOMXF3xSmh1AJgjHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzzWpUvaPwGAkMYfFfwt/KEbTpGaCVT1fpQYFdh4/2WIFlpW8LsJZYaKQjM8m+kHt9X9oQBwlROGOV73avswKZJzmkl8rIA1ecGY6NDnyiVZrRKeMp+8YcPtYxFLJ/53uA2QpX4fF0cnOU3GR1hMYni/0iyR9rFENn5mc80xK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkUQs4GQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f1da33826so130548766b.0;
        Mon, 10 Jun 2024 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718029875; x=1718634675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wubzf2zJb6GjH7z1ypQ19XWF4Q2q1Y3h2F+rVP2N73A=;
        b=GkUQs4GQQGuFxpmjUSNSZPX+HiUQN2VaDfoEg72kNGJ8pczLicPDA1l8DOfQSr2kAW
         P6IY4+ybLYO/ZV4qppegV2o2gUrDBb8eOxE4nGB5z/ltl7/LsLDVNp4G94QSidyrEGxy
         kAnN6UCX9LzSjZURwE0hMgbEtvfe1ZtODCsEfRsZP6a388pJno/BkFlopEugrBfbWJzO
         p3XVg0Fm0Zrz4h28ea1pD574AcSS5qdTfq2YjT5FO1wLGl27iKkGOJmBoDM4oCG44pis
         UVELILDwKsmR6PhSEn35F3qeT6ufb2qaCTHIuSpE9sHhq6rrG24D7BztEJNf568ejsQd
         9SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029875; x=1718634675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wubzf2zJb6GjH7z1ypQ19XWF4Q2q1Y3h2F+rVP2N73A=;
        b=Cm2WRPOp8Wj+Hhn4am9UsXd/DL4k10M2rzVOC2WtKmuXtW2w+oAypjaQimQYHRhx9Z
         6GUxjpMixjUFkYhDzyZY8X0GdMQuCXm0ab5gjxmAnSXZHBmQ53DwwyjSHUhTGN8qb7zL
         6bylGVRskQklhkpHlmJmnSoPrqLDQI3fAXQFMLnTN6zK1wQI+N9++D3UjtXHn6QZJgsQ
         tF+ZtkCJBfMm98IkdCZjwZwOIB9SoyBy4U8NycDevsglCXndybOjBkdBEmjOIRM9/Uy7
         XftUoXXFZ921dXFrsXjQOaqCHRsKPIwFQ/MFlJCEGnmou+vnJT5kExVBKvfbWfV4JwJo
         nRjA==
X-Forwarded-Encrypted: i=1; AJvYcCW8TihQ+bqK9n16NT6zWsGz5WRo0RKYzIAlfwMNiD6TD1kkVPuFl9fv/VGE8DOJZXly1/4TFMg6ItjSPkWmQ0wSVN7dA7Nq9hQXqSgNzUSlgsS4qEDpdraBo7gjyPomMDUG8niTuVUA/IfJy+DgyPBdoWHOvr0r0XWge7UECa8Q/r2p6g==
X-Gm-Message-State: AOJu0YzPvAUTKNeEkcaQU4XARUw2wRpVhK/9ipgBGCqSf4MYRQKck25O
	oS/lEI3c1kmu3KUbkPjzJgbU3XMQxqGNCkjEn1EUu8cU38oK97VS
X-Google-Smtp-Source: AGHT+IFbcHvTRVo6FA4x4itzs10Qk0di57LCggffsz/jstUoeFqJUdFWy72rw8Hxd1lRLzz91eAafA==
X-Received: by 2002:a17:907:1c05:b0:a6d:de5b:5b1d with SMTP id a640c23a62f3a-a6dde5b5d36mr910450966b.18.1718029874403;
        Mon, 10 Jun 2024 07:31:14 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c75ab6297sm3172511a12.14.2024.06.10.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:31:13 -0700 (PDT)
Message-ID: <3340e6136ff03a64e839ac59c501e3be081ebf5c.camel@gmail.com>
Subject: Re: [PATCH v7 5/9] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Mon, 10 Jun 2024 16:35:01 +0200
In-Reply-To: <8cb3752a46f83fbadbc6d33105004f2986a470f5.camel@gmail.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	 <20240607-ad4111-v7-5-97e3855900a0@analog.com>
	 <8cb3752a46f83fbadbc6d33105004f2986a470f5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 09:23 +0200, Nuno S=C3=A1 wrote:
> On Fri, 2024-06-07 at 17:53 +0300, Dumitru Ceclan via B4 Relay wrote:
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >=20
> > Move validation of analog inputs and reference voltage selection to
> > separate functions to reduce the size of the channel config parsing
> > function and improve readability.
> > Add defines for the number of analog inputs in a channel.
> >=20
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
>=20
> One minor nit that maybe can be tweaked while applying. Anyways, no need =
for
> v8
> just because of it:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/ad7173.c | 62 +++++++++++++++++++++++++++++++++--=
----------
> > --
> > -
> > =C2=A01 file changed, 43 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index 8631f218b69e..1257303b0cf6 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -60,6 +60,7 @@
> > =C2=A0#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> > =C2=A0#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> > =C2=A0
> > +#define AD7173_NO_AINS_PER_CHANNEL	2
> > =C2=A0#define AD7173_CH_ADDRESS(pos, neg) \
> > =C2=A0	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> > =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> > @@ -906,13 +907,48 @@ static int ad7173_register_clk_provider(struct ii=
o_dev
> > *indio_dev)
> > =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> > =C2=A0}
> > =C2=A0
> > +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain0, unsigned
> > int
> > ain1)
> > +{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > +
> > +	if (ain0 >=3D st->info->num_inputs ||
> > +	=C2=A0=C2=A0=C2=A0 ain1 >=3D st->info->num_inputs)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Input pin number out of range for
> > pair
> > (%d %d).\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ain0, ain1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7173_validate_reference(struct ad7173_state *st, int ref_=
sel)
> > +{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > +	int ret;
> > +
> > +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF && !st->info-
> > > has_int_ref)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"Internal reference is not available on current
> > model.\n");
> > +
> > +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info-
> > >has_ref2)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"External reference 2 is not available on current
> > model.\n");
> > +
> > +	ret =3D ad7173_get_ref_voltage_milli(st, ref_sel);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ref_sel);
> > +
> > +	return 0;
>=20
> could be return ad7173_get_ref_voltage_milli()...
>=20

Bahh, disregard my comment. We went over this in v6 :facepalm:

- Nuno S=C3=A1

