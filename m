Return-Path: <linux-iio+bounces-7602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E559308C9
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D34281F0A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9910A24;
	Sun, 14 Jul 2024 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqrnulYy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728FFBEF;
	Sun, 14 Jul 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720937865; cv=none; b=Yh0gyPMPXDM418HMahu61m3WWV8/gjL4TzuxEJNm3w9QtZAmh1PRX1fDpcU8cUuQ/x/xX2RE3q/M4KN5gvoYkt36Q+iHh11DgSvWLDR8urNxLG8j/uRCU+FxujC39T3jSuwtdSXyj/0ZktGgvZqjiZLzJLatQIcxrcqMrYcI3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720937865; c=relaxed/simple;
	bh=9xr4AKUdhuZTubcwEoNJMc1pV6Ni+w++1nRH6K0oloM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsvD2wX3TnsjXFLslU8gwJJ2ANp557SjwZ8irHpDYvwHqEJg9tIkx+9euZM5HJoC04+wIPfYrHbX7OIkYCKp0D5FBn9D5R4EZrXp/vt17H5hOYCHQT4paPf4dvkAKFApaOpvl/EmClDo1r5Gek4XRIYNfCeM+L+Yrd5Y0vlfhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqrnulYy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c4309fc8so440764066b.3;
        Sat, 13 Jul 2024 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720937862; x=1721542662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQwZPrEnljss/y0TPSFPE6LroWZrMWEy9TSB17vuOF8=;
        b=EqrnulYyrO7ptLUkxUQ81RG9wcyAhi0u9A7tfbVVjRnJMVXPq9sG88/LtCjOeNhoGw
         /ov5EC93H37URrEofa9nsVEvWv1nzz6X4ztSf7dfrYOCuGeCY8r3jT2x2tI56I5bHmya
         cu4zt7+h0hYrbIYOBjYufB7r0h/Ev+gEWmyh41icChDiwEkFBBxZaRYgEZao/6G0paGO
         3v4BoF3cKH7P4g5WEmacoJcjVokz+vZ7OP5856Zw1dx2QjoAa86gm1f3VlGbSDucT+bu
         /iYr7fNXBOQImn88WPGJyWm5mJquJqihbmM13BNDJNBiBZ2I8RlPH8sZAVSjcRhh4HMr
         DTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720937862; x=1721542662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQwZPrEnljss/y0TPSFPE6LroWZrMWEy9TSB17vuOF8=;
        b=T2ZpCJBP+ax2NM5uVOsX5OSQIYbpPnqeaS0sWbiZStqDTw4ozrr2KbxLwgYr5xhLnK
         DLWoLK7QECJwo6k8tualAGeKZppqpIz+sJEspU9kECREZelgtZdZupxtTSLPYrqqxVKr
         hiY9lqH9RUiXEc/1o0G4KnstuAn9iE7vZtM0MEVZJiJLr6a6DWc9JRdqzDgJaAAfNDFG
         4Eol035YJhg3vo8gsbFG65yzM7pivykhJq/RkxsNP5NlUZG4mOYRLsvq6bmJKE7LsovE
         BhIQ36kTsRGvUkHB8+YKg4Pc+xrm03TP4E5bhEHq42IF3OcUedMDLDsiYVfRbhYDjuOB
         kZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXzh7woN/Rdq7zLdWuSuDFt+9Xc5w0zHkcQp44wtyHhxnoxf9Y1P7i8BN9rArdZayv4mb46mmbmBP7XIk6Tbm/8XpULhx82hh44s1/hiHpB1x8lKT1UAJp1nMH7sSb0aAeExbA6Wz8wlBcnGnLugRhSOCFfOczb2IKTKyibxw+umumQ==
X-Gm-Message-State: AOJu0Yz3ZSAyGCsbzQrouN1eDhseZhDaCIZr9qJ5308WsHShfcppmM9q
	HBH0K0fMsx3ruO+BseHzsM1fV88KOG5cO0pKZakFvJVtyX4d/JWY
X-Google-Smtp-Source: AGHT+IGp/uQTDMyRJcxL8K8iVFOlzJqwfAi2kX+AtAkztIgsoD/X8coocSdW8XsdhhErXv9sP86nUw==
X-Received: by 2002:a17:907:c1e:b0:a77:cdaa:88a9 with SMTP id a640c23a62f3a-a780b68a97cmr1295621366b.6.1720937861642;
        Sat, 13 Jul 2024 23:17:41 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1e4dsm101764466b.114.2024.07.13.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 23:17:41 -0700 (PDT)
Message-ID: <9c34cef044c5b22a189011045fcd8f5b229fee7d.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
  "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,  Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Nuno Sa <nuno.sa@analog.com>
Date: Sun, 14 Jul 2024 08:17:40 +0200
In-Reply-To: <20240713105719.0f9847c9@jic23-huawei>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	 <20240510064053.278257-3-Mariel.Tinaco@analog.com>
	 <20240511174405.10d7fce8@jic23-huawei>
	 <SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240628194546.2f608365@jic23-huawei>
	 <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240708170504.00006c9d@Huawei.com>
	 <ccce603d36fa2fd590b563955bcd2cda085773e5.camel@gmail.com>
	 <733f4f7b-53b2-46c1-8bf8-5ed357adab30@baylibre.com>
	 <468b5725d0f191c20ada9524ecb7da8a48d56d97.camel@gmail.com>
	 <20240713105719.0f9847c9@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-07-13 at 10:57 +0100, Jonathan Cameron wrote:
> On Fri, 12 Jul 2024 08:57:00 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-07-11 at 16:31 -0500, David Lechner wrote:
> > > On 7/11/24 4:20 AM, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > On Mon, 2024-07-08 at 17:05 +0100, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > On Mon, 8 Jul 2024 05:17:55 +0000
> > > > > "Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:
> > > > > =C2=A0=20
> > > > > > > -----Original Message-----
> > > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > > Sent: Saturday, June 29, 2024 2:46 AM
> > > > > > > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > > > > > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; li=
nux-
> > > > > > > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>;=
 Rob
> > > > > > > Herring
> > > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; =
Conor
> > > > > > > Dooley
> > > > > > > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; M=
ark Brown
> > > > > > > <broonie@kernel.org>; Hennerich, Michael
> > > > > > > <Michael.Hennerich@analog.com>;
> > > > > > > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > > > > > > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > > > > > > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Wavefor=
m DAC
> > > > > > >=20
> > > > > > > [External]
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +static int ad8460_get_powerdown_mode(struct iio_dev *i=
ndio_dev,
> > > > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spe=
c
> > > > > > > > > > *chan) {
> > > > > > > > > > +	return 0;=C2=A0=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > Why have the stubs in here?=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > Should I move the stubs to a different place in the code or=
 remove
> > > > > > > > them altogether since there is only a single powerdown mode
> > > > > > > > available=C2=A0=C2=A0=C2=A0=20
> > > > > > > Ah. I'd not really understood what was going on here.=C2=A0 T=
his is fine as
> > > > > > > is.
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > > AD8460_HVDAC_DATA_WORD_HIGH(index),=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > +			=C2=A0=C2=A0=C2=A0 ((val >> 8) & 0xFF));=C2=A0=C2=
=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > bulk write? or do these need to be ordered?=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > >=20
> > > > > > > > For this I used bulk read/write this way.
> > > > > > > >=20
> > > > > > > > static int ad8460_set_hvdac_word(struct ad8460_state *state=
,
> > > > > > > > 				 int index,
> > > > > > > > 				 int val)
> > > > > > > > {
> > > > > > > > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > regmap bulk accesses (when spi anyway) should be provided wit=
h DMA
> > > > > > > safe
> > > > > > > buffers.
> > > > > > > Easiest way to do that is add one with __aligned(IIO_DMA_MINA=
LIGN) to
> > > > > > > the
> > > > > > > end of the ad8460_state structure.=C2=A0 Possibly you'll need=
 a lock to
> > > > > > > protect it -
> > > > > > > I
> > > > > > > haven't checked.=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > 	regvals[0] =3D val & 0xFF;
> > > > > > > > 	regvals[1] =3D (val >> 8) & 0xFF;=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > That is an endian conversion so use appropriate endian functi=
on to
> > > > > > > fill it
> > > > > > > efficiently and document clearly what is going on.
> > > > > > >=20
> > > > > > >=20
> > > > > > > 	put_unaligned_le16()
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > 	return regmap_bulk_write(state->regmap,=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > AD8460_HVDAC_DATA_WORD_LOW(index),=C2=A0=C2=A0=C2=A0=20
> > > > > > > > 				 regvals,=C2=A0=C2=A0=C2=A0=20
> > > > > > > AD8460_DATA_BYTE_WORD_LENGTH); }=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=20
> > > > > > > > > > +}=C2=A0=C2=A0=C2=A0=20
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > +	state->regmap =3D devm_regmap_init_spi(spi,
> > > > > > > > > > &ad8460_regmap_config);
> > > > > > > > > > +	if (IS_ERR(state->regmap))
> > > > > > > > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state-=C2=A0=
=20
> > > > > > > > > > > regmap),=C2=A0=20
> > > > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize
> > > > > > > > > > regmap");
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev=
,
> > > > > > > > > > indio_dev,
> > > > > > > > > > +"tx",
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > IIO_BUFFER_DIRECTION_OUT);
> > > > > > > > >=20
> > > > > > > > > Ah. I take back my binding comment. I assume this is mapp=
ing some
> > > > > > > > > non standard interface for the parallel data flow?=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > Yes, the HDL side doesn't follow yet the standard IIO backe=
nd from
> > > > > > > > which this driver was tested=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > Hmm. I'd like to see this brought inline with the other iio b=
ackend
> > > > > > > drivers if
> > > > > > > possible.=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > Does this mean that we would need to implement an AXI IP core o=
n the
> > > > > > FPGA side to be able to test this?=C2=A0=20
> > > > >=20
> > > > > Don't think so.=C2=A0 That framework is meant to support any equi=
valent IP.
> > > > > So whatever you have should be supportable. Maybe it's somewhat o=
f a stub
> > > > > driver though if there isn't anything controllable.
> > > > >=20
> > > > > It's Nuno's area of expertise though +CC.
> > > > > =C2=A0=20
> > > >=20
> > > > Hi Jonathan,
> > > >=20
> > > > Yeah, I did reply David (IIRC) about the very same question. In the
> > > > design/HW Mariel
> > > > is working on the DAC is directly connected to the DMA core which i=
s handled
> > > > already
> > > > by a proper dma controller driver. So in this case I'm really not s=
eeing the
> > > > backend
> > > > need right now (maybe in the future we may have another design for =
this
> > > > device that
> > > > could justify for a backend device but no idea on that).
> > > >=20
> > > > As you mention, we could very well do a stub platform driver so we =
can use
> > > > the
> > > > backend framework (like dma-backend or something) that could pretty=
 much be
> > > > a stub
> > > > for the DMA controller. But is it worth it though? We'd actually be=
 "lying"
> > > > in terms
> > > > of HW description as the DMA is a property of the actual converter.
> > > >=20
> > > > - Nuno S=C3=A1
> > > >=20
> > > > =C2=A0=20
> > >=20
> > > I'm a bit inclined to agree with Jonathan here. I could see someone i=
n the
> > > future,
> > > wanting to, e.g., use DMA + a GPIO controller for the parallel interf=
ace if
> > > they
> > > didn't have an FPGA. So it seems a bit more future-proof to just alwa=
ys use
> > > the
> > > IIO backend framework for the parallel interface.=C2=A0=20
> >=20
> > I do agree it's more future but guessing usecases is not something I te=
nd to
> > like much (often just results in code that never gets __really__ used).=
 We can
> > very well take care of it when a usecase pops up and we have an actual =
device
> > that can be represented by a backend :).
> >=20
> > >=20
> > > FWIW, I don't think it would be "lying" since the io-backend DT node =
would be
> > > representing physical parallel bus between the DMA controller and the=
 ADC
> > > chip.=C2=A0=20
> >=20
> > To me, it's really a stretch having a backend with the only reason (op)=
 of
> > requesting the DMA channel. I still think you're pushing to much and go=
ing
> > around with wording to justify for the DMA property :). The parallel bu=
s is part
> > of the DAC and directly connects to the DMA data lines so it really loo=
ks to me
> > the dma is a property of the actual DAC.
> >=20
> > That said and Mariel can help here, I did not really looked into the de=
sign
> > myself and I'm just stating (or what I understood) what Mariel told me.=
 But if
> > there's some other piece of HW sitting between the DMA and the bus then=
 it would
> > be easier for me to agree even if we don't have any real control over t=
hat
> > device.
> >=20
> > > But if DT maintainers are OK with the idea that a DMA channel can be =
directly
> > > wired to an external chip, I guess I won't complain. :-)=C2=A0=20
> >=20
> > That's the case in here so I don't see why it should be a problem :). I=
t's the
> > same with the axi-dac/adc. It's all inside the FPGA but different cores=
/IPS.
> >=20
> > FWIW, I'm ok if we go the backend direction even if I don't fully agree=
 with it
> > (at least with the understanding I have so far about the design). I def=
initely
> > want to see more users of it but I also don't think it should be a rule=
 for any
> > fairly high speed converter to have a backend associated.
>=20
> ok. So short term, DT bindings that document the dma-channel
> and see what the DT maintainers think. Longer term, if things get more
> complex, that can become optional and a backend added.
>=20

Ack. Yeah, we'll eventually need an optional get on backends. We do have so=
me out of
tree examples where we have converters working together with an external IP=
 (backend
usecase) or being used in an "independent" mode.

- Nuno S=C3=A1

