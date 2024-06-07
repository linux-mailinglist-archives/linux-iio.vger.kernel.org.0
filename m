Return-Path: <linux-iio+bounces-5992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A29000C2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D601F287393
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15015B99D;
	Fri,  7 Jun 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHc1N2ZT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799A15B99E;
	Fri,  7 Jun 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755952; cv=none; b=DgYgxzbsdeqh814VK/mlWsE3VjfdSXG2v8DJrOJXnv7ve0Z/b4+NU0N0GyYXcGe4K8EOilh4Z+LyjLbErNmun1yOmxTkRTPvGApB95xNrb1mYy7ratT0hirPL4kTM1HgoX+J6zMsxWWZ0nJc2/7ZK8YjnBEGqdmqFUWGaz3CzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755952; c=relaxed/simple;
	bh=ePR5L9uzRmGZ2/l+rPY5V4sHdGShw3JNbFQ1NXJMV+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qiOnJMIElL4qCpp+NcvQqBMjjK8GiTS/YKVVliGh4D5tp21+cxzMug6T4xc2jbgPOa0VZXEPmHnWIAcXAsxECQh7qPJbE34ibB6tltTGiBXnb5Bgx5ntKuuuJ45y2TUgK5UKvQq5PSEWi6BN6h0ZRCb7k4/75Jsckf3qZzF7t68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHc1N2ZT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2454796a12.1;
        Fri, 07 Jun 2024 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755949; x=1718360749; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9D6hlcUsTO5fR/09Mtgz61tNe8CVO0ndZCfy91DgDB0=;
        b=lHc1N2ZTBoIAGVloFmO2BfyPjqOCzMUG4x3couPWcL9etx/ipM3MYc/VlrXA9ZAfSi
         jnURkJ754YrtKS4Sr1CI4FSEo/7hcwlD463Kx2xP4xj6y4DrtZGXw6a7kptz36OAHwms
         C2ekbwHDJZAchZaavcNpwwhiGBu9bUty88INgz9h0aiSoHha2T09yE/mU980w3N1+zAI
         GW5qMOZLfYPHRwDRe6S6IddmnUWybr8ZcNIzKxzlVrcTDUpSwEQLbObEPrHIg/Pm9AD5
         IROWcs9Fsb6dcQSvx4/OFlHQE1DsfoWD5uAohyHVek22G8N5eRDxjB/5d2VYzp/BH08v
         ELHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755949; x=1718360749;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D6hlcUsTO5fR/09Mtgz61tNe8CVO0ndZCfy91DgDB0=;
        b=Ehx+WDobzSrcrTdiF78ownzhtg6nCXhoR79aNBUO8TpbjOYN+j+/sBgQab34xmy4Bu
         bTZj6n81dAkKT1XP1/6JfgMBzLiQA5sV77+dVZFG8ZLYhzpioozEuZGlLbGzq5HvfLk7
         HyKI5BBZM23ano3DHqpEDK5u73ALz6Om7uySEWq58LBWQ9QdICFtHgGVHG3rk4tZGgOK
         fNOTksKQeN0Uy4ldGWwpg+uVyjDQTBbj0OFRuZWic2LEUWieAevC2xEHf0WBvYG3qF8X
         VqlLGAiPS2FzPD94FZhRXxVYvATjwc4cu8Y0cniDTGsOjSBrlD+aQv/wuNK3KRJ7Q4N9
         Dg5g==
X-Forwarded-Encrypted: i=1; AJvYcCVam7xIN+zQttdeRlAWFi5fPSMin6QT0lbdovE+FBKprZs1Dt+DXCP8enL2pl4sh8xbV7lpewNUjpKwFGbrs0j4gEK20KLEoYSdf0sqiSncWOVZvbtYyAA9s/tAZ3l0dX8qnsYnNoZcUq8Valc9J7D7x1Z6nVXhcSXjD0oEPzGcAuIvmA==
X-Gm-Message-State: AOJu0YxEmefc36Uj2vlziWBksueMmFs2Ln2RcsWSwFhHyut+z2rMZ54W
	zeaTd29CD1+NR1jH25Z2VrQTfNbVGAZr1/cBHAiVvdhgwn1xC53rWX30QZj8zc6PRw==
X-Google-Smtp-Source: AGHT+IETzgA5SSY2Hwey7XPCbUjqrSKhmAlMmV1eOarp7bzm8WNZyAKTCO5swlmZ+ii88i49P4s5YA==
X-Received: by 2002:a50:bb28:0:b0:57a:2330:ebc5 with SMTP id 4fb4d7f45d1cf-57c508292d3mr1124854a12.9.1717755949236;
        Fri, 07 Jun 2024 03:25:49 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202341sm2516373a12.70.2024.06.07.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:25:49 -0700 (PDT)
Message-ID: <4b1d0a0cc9f05f68d586e9ac8d40b8028a96e341.camel@gmail.com>
Subject: Re: [PATCH v6 6/9] iio: adc: ad7173: add support for special inputs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 12:29:36 +0200
In-Reply-To: <849357a8-848e-4b9f-9683-1db2eeda39af@gmail.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-6-573981fb3e2e@analog.com>
	 <822eec36a530f659e4924886ad8d2bf272accd59.camel@gmail.com>
	 <849357a8-848e-4b9f-9683-1db2eeda39af@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 12:34 +0300, Ceclan, Dumitru wrote:
> On 07/06/2024 12:06, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > =C2=A0Add support for selecting REF+ and REF- inputs on all models.
> > > =C2=A0Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
> > > =C2=A0 on supported models.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7173.c | 29 +++++++++++++++++++++++++++--
> > > =C2=A01 file changed, 27 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > > index 4040edbd1c32..d16fa081a285 100644
> > > --- a/drivers/iio/adc/ad7173.c
> > > +++ b/drivers/iio/adc/ad7173.c
> > > @@ -66,6 +66,13 @@
> > > =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> > > =C2=A0#define AD7173_AIN_TEMP_POS	17
> > > =C2=A0#define AD7173_AIN_TEMP_NEG	18
> > > +#define AD7173_AIN_POW_MON_POS	19
> > > +#define AD7173_AIN_POW_MON_NEG	20
> > > +#define AD7173_AIN_REF_POS	21
> > > +#define AD7173_AIN_REF_NEG	22
> > > +
> > > +#define AD7173_IS_REF_INPUT(x)		((x) =3D=3D AD7173_AIN_REF_POS || \
> > > +					(x) =3D=3D AD7173_AIN_REF_NEG)
> > > =C2=A0
> > > =C2=A0#define AD7172_2_ID			0x00d0
> > > =C2=A0#define AD7175_ID			0x0cd0
> > > @@ -146,6 +153,8 @@ struct ad7173_device_info {
> > > =C2=A0	unsigned int id;
> > > =C2=A0	char *name;
> > > =C2=A0	bool has_temp;
> > > +	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> > > +	bool has_pow_supply_monitoring;
> > > =C2=A0	bool has_input_buf;
> > > =C2=A0	bool has_int_ref;
> > > =C2=A0	bool has_ref2;
> > > @@ -216,6 +225,7 @@ static const struct ad7173_device_info
> > > ad7173_device_info[] =3D {
> > > =C2=A0		.has_temp =3D true,
> > > =C2=A0		.has_input_buf =3D true,
> > > =C2=A0		.has_int_ref =3D true,
> > > +		.has_pow_supply_monitoring =3D true,
> > > =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> > > =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> > > =C2=A0		.num_sinc5_data_rates =3D
> > > ARRAY_SIZE(ad7173_sinc5_data_rates),
> > > @@ -230,6 +240,7 @@ static const struct ad7173_device_info
> > > ad7173_device_info[] =3D {
> > > =C2=A0		.has_temp =3D false,
> > > =C2=A0		.has_input_buf =3D true,
> > > =C2=A0		.has_ref2 =3D true,
> > > +		.has_pow_supply_monitoring =3D true,
> > > =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> > > =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> > > =C2=A0		.num_sinc5_data_rates =3D
> > > ARRAY_SIZE(ad7173_sinc5_data_rates),
> > > @@ -245,6 +256,7 @@ static const struct ad7173_device_info
> > > ad7173_device_info[] =3D {
> > > =C2=A0		.has_input_buf =3D true,
> > > =C2=A0		.has_int_ref =3D true,
> > > =C2=A0		.has_ref2 =3D true,
> > > +		.has_pow_supply_monitoring =3D false,
> >=20
> > No need to set the 'false' cases...
> >=20
> >=20
> > - Nuno S=C3=A1
>=20
> This was suggested by David Lechner to ensure consistency with has_temp
> regarding another field, I considered that it would apply here as well.
> https://lore.kernel.org/all/CAMknhBGaJxXvsQ8cZkgDsKLVjOY5y2pzox-99hdOCrUa=
oZdsxg@mail.gmail.com/
>=20

Well, I would argue that the has_temp flag being set to 0 is also unneeded =
and
can be removed (in another patch).
> This would also increase visibility towards what features does a specific
> model support as it is clearly stated with "=3D false" rather than lookin=
g
> for what fields are not set within the struct.

IMO, the omission of the flag is already pretty clear that the feature is n=
ot
available. Typically we don't initialize things that do not need to be
initialized (less LOC)...

- Nuno S=C3=A1


