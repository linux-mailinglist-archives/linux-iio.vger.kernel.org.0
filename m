Return-Path: <linux-iio+bounces-25177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6FBE7267
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FD3B5D94
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAEC283C8E;
	Fri, 17 Oct 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYAv31S9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13F27FB1E
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689558; cv=none; b=ksxBxyknM734Qx6NiRKkXnmsaD4bteJmG7DtIeVZhOajhKxle9cZcCP59Ql05BcASoqXfdOoHvgglqmLcNAyL+Fu698of6EP1CIB0UbB2KWp2b/t6/19688Zv5Vvcx5QhWvRb+GicoPeTwEe1ariDYMK/49ng7QGGC8ZtFg9dOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689558; c=relaxed/simple;
	bh=joEQQ7bhfysAQI45cw9isOk0CSftKCV6J0jUEbDNCvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMhxYBbLNFR781iS2Exv1L28aMZLQ7sqQbUQfmDYHjFsjBBEZcNtq+tyKPw4TXR0TiNdK83B8VzIUL9hyZVUqUrYSJw9eaPuuhVVj4xkePcQfLSMg3l2E85geVMmkb9OoEQIXG8PXDSq8XJTNhh5oq2+S6+/1h+YpKIS5YgQyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYAv31S9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bcb25so888986f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760689555; x=1761294355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v61flCR5vvlJAAL4RIpZN6lpDmoPC5xj/Uum81coq14=;
        b=AYAv31S9qtZsFwRC81hJjACZKA5fHyEq4ZNQI1Q2X1xsHe6LkdBVsSa5541zR+Fbmx
         BEnZZ7OCCscbnmT3nVsNK2/Q7Vju8TcwrZ7gBomlxzhpvrLtDXYH9kCBu4MqZwNf3EJ7
         a2dlgXKiQe1ZsLl5XlJrMEvHtcCck9enbMZB/0YaGRlI/Bz1SqI9HNbTrpkJhAqMP3qu
         5ETpBWedePF7xYWqpvDRHXL0S+LKrbrWDslA2UjCFQW+HX7XLYpWdSUQDDmEVb8C/tIQ
         7aQwvM4ghsfQCiFz8D25emzl/LADqwGqQLFmXrhJQNla0GXC1TpNieks8lg7uwCsJAtZ
         p9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689555; x=1761294355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v61flCR5vvlJAAL4RIpZN6lpDmoPC5xj/Uum81coq14=;
        b=RzT4lna9Kh0z9Qt1ZehMBTH80f7CgT7H9dIoMqmH6r1iv5yZjsC5ipPW5IRl+xhxds
         Uac74SXw4Mty8ibBweJdTkHzgofRMf7e230ZSxTPGH2zLa1YjTu8L9S16hlMrRDMkM6z
         L8DcSuThC06i6ifYVYhO1r8vRGwSvMaseKXoG0O9WzSNec/5oGcj2ZsQDJb3Fx23yCnD
         klsK5BZ6QdDDiFN2jzrfQjp+V9Ji8diMW7vYTp58Np7qJGpxnuAF4Ut8xbO3+cy73l6x
         7KyTgSYWyJ84mSLHZo8t2g1DB1eE3fKEVb7GjwcgkpmJZSs41bhROqoj+zNmnWom4ydB
         0w+A==
X-Forwarded-Encrypted: i=1; AJvYcCXCIJmy487HbHFZWskDTaxXeENRA83Uqd08NaWM8zT9UlT4CBbwSxqq0iCCqsHdiKuDDxf8Qarm9uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LjCExGFhyAlFC7lEZvhDWEyvTq1zAmq3X6Lj0Cwolh7lLO8u
	qX0BoGA+QZ7SzUpGTC/brBdMUOCrB/huxwtLuLy3UO+5D3biMHEkt+wf
X-Gm-Gg: ASbGncvqQbI6WIXWMi779HlWtV+m/JwkE6KotZVqFKfb/+ucaLTWZZue+Jzp28+tgkV
	WuXurCJbt8q3JwFBNIUlkF/TFpdnRzDD2e4KQIuXO2wY8548E99f+oB87k3jUh9brTDlPqpuGK1
	K0q+nHoHL5P9XwoPk2KEkTXnHufwFl/wvIvT6IWCEG17O9xKSzj3TZVunntJlFUJqN3iI2aubit
	muCUr0e34XO9usL4AdWNVvkD6EBFXZ+dgO1DCeFm04QFUvfQcPRF1Nlv1IuZDoFBiy9WGeLyzF9
	Y72UCUBY2artJ8sBSoFR5C5focfgwx/SMUcX8+MA0j/CndmkE5gZIxjnwdDhChJN2VKopgeAEX0
	gol8aQfrvI0hei4W0Fo+Q09GLnZrxBfa7S5wq7Jdj6ku4wiK5U0O/k9nGMs8bMJVeW1GvYfBZiL
	w=
X-Google-Smtp-Source: AGHT+IGEkSRHIiF1Z9hIjowIr0RYX6Ej1bYmZxsMMs5EVs/hxBN6ETWucMvo4l2QUKUsdowZiFc7yQ==
X-Received: by 2002:a05:6000:2f86:b0:426:fb28:7964 with SMTP id ffacd0b85a97d-42704dac9ddmr2119851f8f.61.1760689554315;
        Fri, 17 Oct 2025 01:25:54 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf6b4sm39603674f8f.25.2025.10.17.01.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:25:53 -0700 (PDT)
Message-ID: <10e119ee5a76f1c47d7eb6a15989c8ffc00ffc5f.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Fri, 17 Oct 2025 09:26:26 +0100
In-Reply-To: <20251017085904.07e40e37@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
		<20251015142816.1274605-3-herve.codina@bootlin.com>
		<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
		<20251015211420.031c61fa@bootlin.com>
		<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
		<20251016160202.3d4d0a5e@bootlin.com>
		<d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
	 <20251017085904.07e40e37@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 08:59 +0200, Herve Codina wrote:
> Hi Nuno,
>=20
> On Thu, 16 Oct 2025 16:26:28 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> ...
>=20
> ...
> > > > > > > +
> > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > adc_core[0],=C2=A0=C2=A0=C2=A0=20
> > > > > > > +					=C2=A0=C2=A0 "adc1-avdd", "adc1-
> > > > > > > vref");
> > > > > > > +	if (ret)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > adc_core[1],=C2=A0=C2=A0=C2=A0=20
> > > > > > > +					=C2=A0=C2=A0 "adc2-avdd", "adc2-
> > > > > > > vref");
> > > > > > > +	if (ret)
> > > > > > > +		return ret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > Hmm, is avdd really an optional regulator? I mean can the ADC p=
ower
> > > > > > up
> > > > > > at
> > > > > > all
> > > > > > without a supply in AVDD? Even vref seems to be mandatory as we
> > > > > > can't
> > > > > > properly
> > > > > > scale the sample without it.=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Where do you see that avdd is an optional regulator?=C2=A0=C2=A0=
=C2=A0=20
> > > >=20
> > > > You are using devm_regulator_get_optional(). That's for optional
> > > > regulators.
> > > > =C2=A0=20
> > >=20
> > > Indeed I use devm_regulator_get_optional().
> > >=20
> > > We have two similar function to get regulators:
> > > - devm_regulator_get() and
> > > - devm_regulator_get_optional().
> > >=20
> > > devm_regulator_get() returns a dummy regulator if the regulator is no=
t
> > > described in the device-tree. The calling code has no way to known if
> > > the regulator was present or not.=C2=A0=20
> >=20
> > Yeah because it's mandatory and the part cannot work without power :). =
So we
> > should not be allowed to operate without a regulator.
> >=20
> > >=20
> > > On the other hand, devm_regulator_get_optional() returns -ENODEV when=
 the
> > > regulator is not described.
> > >=20
> > > That's pretty confusing but it is the reality.
> > >=20
> > > I use devm_regulator_get_optional() but check for -ENODEV to see if t=
he
> > > regulator is provided or not.
> > >=20
> > > In order to use the ADC core (is_used flag), I need both the AVDD and=
 the
> > > VREF regulator available.=C2=A0=20
> >=20
> > And that is why I don't get why are we allowed to proceed if there's no
> > regulators? That seems wrong to me.=C2=A0
> >=20
> > So I think the regulators should be mandatory in the bindings and a dum=
my
> > regulator should also not be allowed in this case because that should g=
et
> > you=C2=A0
> > -EINVAL when calling regulator_get_voltage().
> >=20
>=20
> I have 4 regulators: avdd1, vref1, avvd2, vref2.
>=20
> The ADC controller can work with 2 internal ADC core (adc_core[0] and
> adc_core[1])
> in the driver. Those internal core are not directly accessed by the drive=
r.
> Only
> the ADC controller is accesses.
>=20
> Those cores have an AVDD and a VREF power supply.
>=20
> We can use either adc_core[0] only, adc_core[1] only or both adc cores.
>=20
> Depending on regulator described, the driver uses one or two adc cores.
>=20
> This choice is done by:
> --- 8< ---
> static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> 					 struct iio_dev *indio_dev)
> {
> 	int adc_used;
>=20
> 	adc_used =3D rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> 	adc_used |=3D rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
>=20
> 	switch (adc_used) {
> 	case 0x01:
> 		indio_dev->channels =3D rzn1_adc1_channels;
> 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc1_channels);
> 		return 0;
> 	case 0x02:
> 		indio_dev->channels =3D rzn1_adc2_channels;
> 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc2_channels);
> 		return 0;
> 	case 0x03:
> 		indio_dev->channels =3D rzn1_adc1_adc2_channels;
> 		indio_dev->num_channels =3D
> ARRAY_SIZE(rzn1_adc1_adc2_channels);
> 		return 0;
> 	default:
> 		break;
> 	}
> --- 8< ---
>=20
> In rzn1_adc_core_get_regulators(), looking at one core I do the
> following:
> =C2=A0- Try to get AVDD (using get_optional)
> =C2=A0- Try to get VREF (using get_optional)
> =C2=A0- Core is used only if both regulators are present.
>=20
> For one core to be used, both regulators have to be present.
>=20
> Regulators are mandatory but adc core usage is optional.
>=20
> This optional usage depends on related regulator presence.
>=20

Ok, then we could flip the logic and have boolean properties for the adc co=
re
usage and depending on that, requesting the regulators. To me, the intent w=
ould
be more clear (at the expense of more FW properties).

Having said that, the above helps a lot in understanding what's going on an=
d
explains the get_optional() usage. I'm not still 100% convinced but bah, fi=
ne :)

I would still argue that you should have a comment (likely in get_regulator=
s())
explaining the logic and the optional usage.

Given the above I think you could also remove:

if (!adc_core->vref)
	return -ENODEV;

from rzn1_adc_core_get_vref_mv() since the channels are only exposed in cas=
e the
regulators are present.


- Nuno S=C3=A1

