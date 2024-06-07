Return-Path: <linux-iio+bounces-5991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C926D90009A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734A6286C52
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0D15CD41;
	Fri,  7 Jun 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo0Ldluo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5B15B55F;
	Fri,  7 Jun 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755675; cv=none; b=MqsbkD6UhWIqaHIHamO6A1J+ATOzqYf3FA0Cuud3UB5sDqfX6BtF7hZOl4hLb4Vuyx/yNiCQ5oIUMJB5UilSScW9D5916Lg5uoWFlyRMklN8sPaM8tb8Uwypdzmfg9pGhovdpBTKD/lUHv5SPm8z1+hh7hL0XXDtIQQAZRdhRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755675; c=relaxed/simple;
	bh=Dks7OxXyBlyHmAOgz5BZhV2eq197RmmI4/NeHgpMpQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtiCtShDE/7Mqb+IjSzPbKbPyuYEkYfU5flTGOUPUV8H9xIAeag6OihwX/Xg0p7r9nlNqPnYs1Wv9IZl3z+2TackTB2j1xZfNje1PaO40mp0QDEXsxYwwOlR8+szbNoOnHT5IYJUcw9MhPGx4PMSvh04U49RvSL80v1Lw3v4y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo0Ldluo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68b54577aaso250756666b.3;
        Fri, 07 Jun 2024 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755670; x=1718360470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QcBsgWbss1EmWhGcEgsrw0bt0a7lGJfPQQEMYFDspo=;
        b=Vo0LdluoLqyALSxQHXZBs++Ah67q/gZPNkb2Gc6y4Ryy7N5mZbkGbaRUUB2BGK+vjJ
         vLVEUT9VBJpdJJ99GGvHEHI6JgweDHGczTl4DSf6fQic+QD2kPyEKWIC+3dDeiEZnv40
         GlJNFvYleaF3rQEkCLCdMxhLGfXcj6mrqv6Ln1SVqk2rh7J/ZgeBQ87muN5HGw94c5Wg
         mcPrkFuDXMsCf7VOIWY83lW71ZhmepANyLlcB4+fM2YdcQUpKL+1ppBtMmJSyIAbOetb
         b437Dh/h0LrvuVpE0GJSNnhUHFvQdZ/cejVYeI0RD30G71rMpfKlwJVrSQK8pRarBJjv
         w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755670; x=1718360470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QcBsgWbss1EmWhGcEgsrw0bt0a7lGJfPQQEMYFDspo=;
        b=RIdW9D2bnR6ELZs7Xla+eJreUOvoWrub8IkDxnt9Lw/rPLNIa6u6uy0e/9ml6x1qGx
         /uqJMOM5704KYb14AZ0603r9CnYWSB+v/HBCr4I3lIvzWi665MEpc+ezYzZdtA1gmwFj
         ZSZS1AYivIq2HYSpYPbYXO0GH7py4TzVdIA880llobX99WY5kFf5EEoG8B00zogt8L1a
         KPHXIkRuRQFDWX2veGjy3/VAYIa5KIBbbDZuMxOYaoeiY6IMj8DbokyZjzHQlCVxxCim
         zUMVFbBcIrg5xaZaHynumN3wmpuOcbegNI6PE/0DI6x2RsC+J96q5qEJD5H4/bQJhb5v
         /YkA==
X-Forwarded-Encrypted: i=1; AJvYcCW+xKkZi5YkLVjDLnLBE0BmSxXISpV/C3JWK0N5SHI6P2nPU6m9Eu+63CvCIILKMfseTDqDZ1OeC+ClRE/MFRcHQAmWcPug7k/USm9n4eqDsNQIJVR7M8xu+PAkyof/fuN02UbI0N8l3mozjrhEwE7VWHzjsqcQuqE2Vde9N7bT9ADrWQ==
X-Gm-Message-State: AOJu0YwhvlH06MBZyuUiTH1kEDJ5J4w/87FcODkzq/hR0uLlftz6xdWb
	GpDG55divBFzMLTWUpnbXMXj+mp73YHWqirz1pnqYbGA8tTRAHs2
X-Google-Smtp-Source: AGHT+IHHu/XB4j36RfnBoCcgy8Of3JZV/a6yi0TUcpN0xv4exB18c3i0eNgoKfCDmUyRrJGfGg2+RQ==
X-Received: by 2002:a17:906:81c3:b0:a68:baca:f120 with SMTP id a640c23a62f3a-a6cdc0e089fmr134924966b.73.1717755670428;
        Fri, 07 Jun 2024 03:21:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070eaf7sm228367566b.172.2024.06.07.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:21:10 -0700 (PDT)
Message-ID: <7c016774f3892e4fa34d4c3fb770d8581e4787d9.camel@gmail.com>
Subject: Re: [PATCH v6 5/9] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 12:24:57 +0200
In-Reply-To: <0f230e9a-31bb-45e1-ab86-b80b30ad8502@gmail.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-5-573981fb3e2e@analog.com>
	 <8f74bb906951f56c753081af1462560fe98bc822.camel@gmail.com>
	 <0f230e9a-31bb-45e1-ab86-b80b30ad8502@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 12:37 +0300, Ceclan, Dumitru wrote:
> On 07/06/2024 12:04, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > Move validation of analog inputs and reference voltage selection to
> > > separate functions to reduce the size of the channel config parsing
> > > function and improve readability.
> > > Add defines for the number of analog inputs in a channel.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7173.c | 68 +++++++++++++++++++++++++++++++++=
----------
> > > ----
> > > -
> > > =C2=A01 file changed, 47 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > > index 8631f218b69e..4040edbd1c32 100644
> > > --- a/drivers/iio/adc/ad7173.c
> > > +++ b/drivers/iio/adc/ad7173.c
> > > @@ -60,6 +60,7 @@
> > > =C2=A0#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> > > =C2=A0#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> > > =C2=A0
> > > +#define AD7173_NO_AINS_PER_CHANNEL	2
> > > =C2=A0#define AD7173_CH_ADDRESS(pos, neg) \
> > > =C2=A0	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> > > =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> > > @@ -629,6 +630,7 @@ static int ad7173_setup(struct iio_dev *indio_dev=
)
> > > =C2=A0static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_=
state *st,
> > > =C2=A0						 u8 reference_select)
> > > =C2=A0{
> > > +	struct device *dev =3D &st->sd.spi->dev;
> > > =C2=A0	int vref;
> > > =C2=A0
> > > =C2=A0	switch (reference_select) {
> > > @@ -652,9 +654,11 @@ static unsigned int
> > > ad7173_get_ref_voltage_milli(struct
> > > ad7173_state *st,
> > > =C2=A0		return -EINVAL;
> > > =C2=A0	}
> > > =C2=A0
> > > -	if (vref < 0)
> > > +	if (vref < 0) {
> > > +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
> > > +			reference_select, vref);
> > > =C2=A0		return vref;
> > > -
> > > +	}
> > > =C2=A0	return vref / (MICRO / MILLI);
> > > =C2=A0}
> >=20
> > unrelated?
> >=20
> > - Nuno S=C3=A1
> >=20
>=20
> Hmm, maybe I misunderstood "Any error log needed should be done inside
> ad7173_get_ref_voltage_milli()"
> https://lore.kernel.org/all/71452f6882efe6a181d477914488617d28a38e2f.came=
l@gmail.com/
>=20
> This change should be in a different patch or should it not've been done
> this way?

Ohh right... Mentioning this particular log change in the commit message wo=
uld
avoid my question. Also, note that you're still doing:

ret =3D ad7173_get_ref_voltage_milli(st, ref_sel);
if (ret < 0)
	return ret;

instead of:

return ad7173_get_ref_voltage_milli(...)

which defeats the purpose of having the log inside
ad7173_get_ref_voltage_milli()=20

But after stepping back I see ad7173_get_ref_voltage_milli() is also being =
used
in a non probe path. Hence, doing the log out of the function using
dev_err_probe() may be reason enough to keep things as you had before my
comments. Will leave that up to you (sorry for the noise).

- Nuno S=C3=A1
=20

