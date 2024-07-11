Return-Path: <linux-iio+bounces-7493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DD92E355
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60932B229E8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E615572F;
	Thu, 11 Jul 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCWGq6zS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1111527AA;
	Thu, 11 Jul 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689622; cv=none; b=bBR6uN0f8wwZ6IulknT2xWZfGTofp4lBclKHIXAzy1sfgqWK2+OS24Ph1PCQ70jLYQPWeiLRV8XHrzQFKzl1dzQtNIvVof14nKKzMQL5jv7GzqFdy9SR+CttaN0CTH3I3b/X0XbjqxS4NKMy3dq485XxI+xFIl4nJFVzz6Li/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689622; c=relaxed/simple;
	bh=gwvvVLcKzF8lKnY96RVzXjOMU6Nj0tPSKdiRsfBXs4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=is46Iq72O+PAnSpeQNCoylRa8y0NuchKFfGp0XhTsRqoJzFCARCq6cXb+8N1cqboVrUnz6ciQshihbDjq7tJ94wKG1LO7WDbwJK2kTl17aFeQD3Dyr0rsfzkpi1BJlO4BAg17kNpMSkw3g+71Zn7A8NNZHeuipl3rcp9OOLXdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCWGq6zS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so7144051fa.3;
        Thu, 11 Jul 2024 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720689619; x=1721294419; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veH0AMOxhpArs3tYp8swPvMrbzFjXttVAA+G9fEZU0s=;
        b=ZCWGq6zSyIXcXrbwVk37vb4SRcca6taUQ2alAhTEcCHMw1j1xRuudSISDLTUNVhLC4
         7/PFf12CaaY0xW9TYYHHF7FzhTS/t7ccX155gxNzt8uVSqMA+9Nz9Ipj/uqP7qTkxwDu
         PcoD6aRoMZOhr31fGSGH8KjclEADSoCyJ3WgdOCYGiHQIRX68qJXyf6h6Ki5L5UJLvu+
         3E6OZniUILgmz0ptbzNEUuqMdMC1gSExzlDjt+MZb8/tF0wHXwhglifY0GXyZUzgY/dh
         ocY3YraW+0ptR+EbyDPXu0TxVKHT8GT/shkJfG1DM/Q+qZ3YrEgj+c3lYCm0hbhjFlQT
         PPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720689619; x=1721294419;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veH0AMOxhpArs3tYp8swPvMrbzFjXttVAA+G9fEZU0s=;
        b=sJDD3QJAhdQnCmugy48u88PbgPiseXmYUS4ecOYbEzntLA/QbpnaPOeIVUxqqQH9Vx
         6wq+57zm50gyAuAT5BHU/FSszsZKalR9DJer1UH3qfa3T0a6+LXaMfcBXcWs9iX/caGU
         TVcNnncr49DCjBsByZcRSlF8x2nk5XvfB1jcehwN/vac7KgE3gRr/FRI+aVCXnMvCCVL
         eGdgbWw40M2R1ZMD15wIZm4lCHBAjhONwJ2oSdXSbIsoG4wEY0Yhlf+JbWHyTqaPQyLL
         pZxsb+oPtWcIi2HeNge6BI/i240hYoyWqdZFN6EJ6Uq3ChnOlica2wzRHaxi9MXLl1o7
         eTug==
X-Forwarded-Encrypted: i=1; AJvYcCXjgMGlFNVzXh4DOkj72YHuWrC9HgS2UIURm0NrDNAPFYOMxgL7JWpeKaJd4p5WQQLUSlrTxbfcLhgM0xvWnCehnKmvR+fzAdFRqmJYEjNmaS4k3uP9oQbfVX4J41ODDO9nJf0KVxxeyQH9RXfor6IVkBXK+GqrbGk/7zfL3lh0uYUFBg==
X-Gm-Message-State: AOJu0YwT8rBjP8kP8G9q5FgOKwFwa8st6Zg2Jw1FYSIKB0VUofLrc4fN
	TRaS84g1lOjEQVDdR9FciPRP//focPkU9v0wez+m3JrvTDgeq6/f
X-Google-Smtp-Source: AGHT+IFNF3nE9tcbqgLUaGvr4jaJp7NNEj5UW6Mh4jCkQTmKxAAjFECZKcf2WAsdzOsFmkmOm0DtOA==
X-Received: by 2002:a05:6512:3f0a:b0:52c:ebd0:609 with SMTP id 2adb3069b0e04-52eb999116cmr5720327e87.7.1720689618767;
        Thu, 11 Jul 2024 02:20:18 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab141sm7212348f8f.96.2024.07.11.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:20:18 -0700 (PDT)
Message-ID: <ccce603d36fa2fd590b563955bcd2cda085773e5.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Tinaco, Mariel"
	 <Mariel.Tinaco@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>,  Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Nuno Sa <nuno.sa@analog.com>
Date: Thu, 11 Jul 2024 11:20:17 +0200
In-Reply-To: <20240708170504.00006c9d@Huawei.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	 <20240510064053.278257-3-Mariel.Tinaco@analog.com>
	 <20240511174405.10d7fce8@jic23-huawei>
	 <SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240628194546.2f608365@jic23-huawei>
	 <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240708170504.00006c9d@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 17:05 +0100, Jonathan Cameron wrote:
> On Mon, 8 Jul 2024 05:17:55 +0000
> "Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, June 29, 2024 2:46 AM
> > > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Her=
ring
> > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Do=
oley
> > > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brow=
n
> > > <broonie@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.co=
m>;
> > > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
> > >=20
> > > [External]
> > > =C2=A0=20
> > > > > > +};
> > > > > > +
> > > > > > +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev=
,
> > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)=
 {
> > > > > > +	return 0;=C2=A0=20
> > > > >=20
> > > > > Why have the stubs in here?=C2=A0=20
> > > >=20
> > > > Should I move the stubs to a different place in the code or remove
> > > > them altogether since there is only a single powerdown mode availab=
le=C2=A0=20
> > > Ah. I'd not really understood what was going on here.=C2=A0 This is f=
ine as is.
> > > =C2=A0=20
> > > > > AD8460_HVDAC_DATA_WORD_HIGH(index),=C2=A0=20
> > > > > > +			=C2=A0=C2=A0=C2=A0 ((val >> 8) & 0xFF));=C2=A0=20
> > > > >=20
> > > > > bulk write? or do these need to be ordered?=C2=A0=20
> > > >=20
> > > > For this I used bulk read/write this way.
> > > >=20
> > > > static int ad8460_set_hvdac_word(struct ad8460_state *state,
> > > > 				 int index,
> > > > 				 int val)
> > > > {
> > > > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];=C2=A0=20
> > > regmap bulk accesses (when spi anyway) should be provided with DMA sa=
fe
> > > buffers.
> > > Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN) to=
 the
> > > end of the ad8460_state structure.=C2=A0 Possibly you'll need a lock =
to protect it -
> > > I
> > > haven't checked.=C2=A0=20
> > > >=20
> > > > 	regvals[0] =3D val & 0xFF;
> > > > 	regvals[1] =3D (val >> 8) & 0xFF;=C2=A0=20
> > >=20
> > > That is an endian conversion so use appropriate endian function to fi=
ll it
> > > efficiently and document clearly what is going on.
> > >=20
> > >=20
> > > 	put_unaligned_le16()
> > > =C2=A0=20
> > > >=20
> > > > 	return regmap_bulk_write(state->regmap,=C2=A0=20
> > > AD8460_HVDAC_DATA_WORD_LOW(index),=C2=A0=20
> > > > 				 regvals,=C2=A0=20
> > > AD8460_DATA_BYTE_WORD_LENGTH); }=C2=A0=20
> > > >=20
> > > > =C2=A0
> > > > > > +}=C2=A0=20
> > > =C2=A0=20
> > > > > > +	state->regmap =3D devm_regmap_init_spi(spi,
> > > > > > &ad8460_regmap_config);
> > > > > > +	if (IS_ERR(state->regmap))
> > > > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap");
> > > > > > +
> > > > > > +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_=
dev,
> > > > > > +"tx",
> > > > > > +=C2=A0=20
> > > > > IIO_BUFFER_DIRECTION_OUT);
> > > > >=20
> > > > > Ah. I take back my binding comment. I assume this is mapping some
> > > > > non standard interface for the parallel data flow?=C2=A0=20
> > > >=20
> > > > Yes, the HDL side doesn't follow yet the standard IIO backend from
> > > > which this driver was tested=C2=A0=20
> > >=20
> > > Hmm. I'd like to see this brought inline with the other iio backend d=
rivers if
> > > possible.=C2=A0=20
> >=20
> > Does this mean that we would need to implement an AXI IP core on the
> > FPGA side to be able to test this?
>=20
> Don't think so.=C2=A0 That framework is meant to support any equivalent I=
P.
> So whatever you have should be supportable. Maybe it's somewhat of a stub
> driver though if there isn't anything controllable.
>=20
> It's Nuno's area of expertise though +CC.
>=20

Hi Jonathan,

Yeah, I did reply David (IIRC) about the very same question. In the design/=
HW Mariel
is working on the DAC is directly connected to the DMA core which is handle=
d already
by a proper dma controller driver. So in this case I'm really not seeing th=
e backend
need right now (maybe in the future we may have another design for this dev=
ice that
could justify for a backend device but no idea on that).

As you mention, we could very well do a stub platform driver so we can use =
the
backend framework (like dma-backend or something) that could pretty much be=
 a stub
for the DMA controller. But is it worth it though? We'd actually be "lying"=
 in terms
of HW description as the DMA is a property of the actual converter.

- Nuno S=C3=A1


