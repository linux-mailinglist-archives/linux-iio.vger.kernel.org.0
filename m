Return-Path: <linux-iio+bounces-7580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E39304D1
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F79283323
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FE4965B;
	Sat, 13 Jul 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blxb4Yzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EB4F1F2;
	Sat, 13 Jul 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720864653; cv=none; b=hli4fnOqXqg7GnlbtcRFyUV/WxqtSlipPZPDwaaYka7D4F/ChIqBM4f0y0hTLsLFZjj6tC1/LtLkWH31AiPCxXpzF1kZ5Zc1U5l9qYb/bj0l6KqPsv7R/8KzDR0mRv1U+c9yNYJ8Mz+kq/YF6eSctvfOEuHu4nnhzCbjLYEDFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720864653; c=relaxed/simple;
	bh=TUxSzenqpbfZ+yzfPlR26KV7WbEyltoPgjXyGzL6LkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0LaDC1EkNAhJWrLE1e2uDWw69LxjnqLYywMIqHpjmj/Clduq80KQdRIK4s9R4RndxpblqSh4KS1KaS6GpHW4eFcBERepftAkST83o3O0D/FGv0I+Wtiypmi+hJ6lLR3o+XM3qo2WGKEGHlhTDfH1C+MPyLgkMP6bHZwtBfACAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blxb4Yzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D1C32781;
	Sat, 13 Jul 2024 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720864653;
	bh=TUxSzenqpbfZ+yzfPlR26KV7WbEyltoPgjXyGzL6LkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blxb4YzxrTHJiwr4Jsqu57D4U9mceUzVXN/amebHV3wGQ7rS0U+MfkbkMyrp20lUV
	 QT/VfHzLxpvW24F5vRuCgH46NAKLNxDBtu1gAfXerv2G27c6I/KDJ0GHk/JDk0aoqr
	 FDCWuYlzfLjNjosYrEALdNeL5wlDKCfx5ii25T66EpRu09Lf1tudnCZcCMSg7yeXeF
	 vYBeznq1tCxiIt+CJZmxObTM12DSnA5Jd3ZBl7GzNEpQKH3zJiIph4KTtw0YVgwP7E
	 siczhmhsag2ftLt9UWhAtv8XVJcgF/6ZlVMjfo08o1TC1kjavwm+QAW5C9i93Vl/6B
	 EhTA6fpTUHNRA==
Date: Sat, 13 Jul 2024 10:57:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron 
 <Jonathan.Cameron@Huawei.com>, "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240713105719.0f9847c9@jic23-huawei>
In-Reply-To: <468b5725d0f191c20ada9524ecb7da8a48d56d97.camel@gmail.com>
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
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 08:57:00 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-07-11 at 16:31 -0500, David Lechner wrote:
> > On 7/11/24 4:20 AM, Nuno S=C3=A1 wrote: =20
> > > On Mon, 2024-07-08 at 17:05 +0100, Jonathan Cameron wrote: =20
> > > > On Mon, 8 Jul 2024 05:17:55 +0000
> > > > "Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:
> > > >  =20
> > > > > > -----Original Message-----
> > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > Sent: Saturday, June 29, 2024 2:46 AM
> > > > > > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > > > > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linu=
x-
> > > > > > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; R=
ob
> > > > > > Herring
> > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Co=
nor
> > > > > > Dooley
> > > > > > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mar=
k Brown
> > > > > > <broonie@kernel.org>; Hennerich, Michael
> > > > > > <Michael.Hennerich@analog.com>;
> > > > > > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > > > > > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > > > > > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform =
DAC
> > > > > >=20
> > > > > > [External]
> > > > > > =C2=A0  =20
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static int ad8460_get_powerdown_mode(struct iio_dev *ind=
io_dev,
> > > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec
> > > > > > > > > *chan) {
> > > > > > > > > +	return 0;=C2=A0  =20
> > > > > > > >=20
> > > > > > > > Why have the stubs in here?=C2=A0  =20
> > > > > > >=20
> > > > > > > Should I move the stubs to a different place in the code or r=
emove
> > > > > > > them altogether since there is only a single powerdown mode
> > > > > > > available=C2=A0  =20
> > > > > > Ah. I'd not really understood what was going on here.=C2=A0 Thi=
s is fine as
> > > > > > is.
> > > > > > =C2=A0  =20
> > > > > > > > AD8460_HVDAC_DATA_WORD_HIGH(index),=C2=A0  =20
> > > > > > > > > +			=C2=A0=C2=A0=C2=A0 ((val >> 8) & 0xFF));=C2=A0  =20
> > > > > > > >=20
> > > > > > > > bulk write? or do these need to be ordered?=C2=A0  =20
> > > > > > >=20
> > > > > > > For this I used bulk read/write this way.
> > > > > > >=20
> > > > > > > static int ad8460_set_hvdac_word(struct ad8460_state *state,
> > > > > > > 				 int index,
> > > > > > > 				 int val)
> > > > > > > {
> > > > > > > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];=C2=A0  =20
> > > > > > regmap bulk accesses (when spi anyway) should be provided with =
DMA
> > > > > > safe
> > > > > > buffers.
> > > > > > Easiest way to do that is add one with __aligned(IIO_DMA_MINALI=
GN) to
> > > > > > the
> > > > > > end of the ad8460_state structure.=C2=A0 Possibly you'll need a=
 lock to
> > > > > > protect it -
> > > > > > I
> > > > > > haven't checked.=C2=A0  =20
> > > > > > >=20
> > > > > > > 	regvals[0] =3D val & 0xFF;
> > > > > > > 	regvals[1] =3D (val >> 8) & 0xFF;=C2=A0  =20
> > > > > >=20
> > > > > > That is an endian conversion so use appropriate endian function=
 to
> > > > > > fill it
> > > > > > efficiently and document clearly what is going on.
> > > > > >=20
> > > > > >=20
> > > > > > 	put_unaligned_le16()
> > > > > > =C2=A0  =20
> > > > > > >=20
> > > > > > > 	return regmap_bulk_write(state->regmap,=C2=A0  =20
> > > > > > AD8460_HVDAC_DATA_WORD_LOW(index),=C2=A0  =20
> > > > > > > 				 regvals,=C2=A0  =20
> > > > > > AD8460_DATA_BYTE_WORD_LENGTH); }=C2=A0  =20
> > > > > > >=20
> > > > > > > =C2=A0 =20
> > > > > > > > > +}=C2=A0  =20
> > > > > > =C2=A0  =20
> > > > > > > > > +	state->regmap =3D devm_regmap_init_spi(spi,
> > > > > > > > > &ad8460_regmap_config);
> > > > > > > > > +	if (IS_ERR(state->regmap))
> > > > > > > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state- =20
> > > > > > > > > >regmap), =20
> > > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize
> > > > > > > > > regmap");
> > > > > > > > > +
> > > > > > > > > +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev,
> > > > > > > > > indio_dev,
> > > > > > > > > +"tx",
> > > > > > > > > +=C2=A0  =20
> > > > > > > > IIO_BUFFER_DIRECTION_OUT);
> > > > > > > >=20
> > > > > > > > Ah. I take back my binding comment. I assume this is mappin=
g some
> > > > > > > > non standard interface for the parallel data flow?=C2=A0  =
=20
> > > > > > >=20
> > > > > > > Yes, the HDL side doesn't follow yet the standard IIO backend=
 from
> > > > > > > which this driver was tested=C2=A0  =20
> > > > > >=20
> > > > > > Hmm. I'd like to see this brought inline with the other iio bac=
kend
> > > > > > drivers if
> > > > > > possible.=C2=A0  =20
> > > > >=20
> > > > > Does this mean that we would need to implement an AXI IP core on =
the
> > > > > FPGA side to be able to test this? =20
> > > >=20
> > > > Don't think so.=C2=A0 That framework is meant to support any equiva=
lent IP.
> > > > So whatever you have should be supportable. Maybe it's somewhat of =
a stub
> > > > driver though if there isn't anything controllable.
> > > >=20
> > > > It's Nuno's area of expertise though +CC.
> > > >  =20
> > >=20
> > > Hi Jonathan,
> > >=20
> > > Yeah, I did reply David (IIRC) about the very same question. In the
> > > design/HW Mariel
> > > is working on the DAC is directly connected to the DMA core which is =
handled
> > > already
> > > by a proper dma controller driver. So in this case I'm really not see=
ing the
> > > backend
> > > need right now (maybe in the future we may have another design for th=
is
> > > device that
> > > could justify for a backend device but no idea on that).
> > >=20
> > > As you mention, we could very well do a stub platform driver so we ca=
n use
> > > the
> > > backend framework (like dma-backend or something) that could pretty m=
uch be
> > > a stub
> > > for the DMA controller. But is it worth it though? We'd actually be "=
lying"
> > > in terms
> > > of HW description as the DMA is a property of the actual converter.
> > >=20
> > > - Nuno S=C3=A1
> > >=20
> > >  =20
> >=20
> > I'm a bit inclined to agree with Jonathan here. I could see someone in =
the
> > future,
> > wanting to, e.g., use DMA + a GPIO controller for the parallel interfac=
e if
> > they
> > didn't have an FPGA. So it seems a bit more future-proof to just always=
 use
> > the
> > IIO backend framework for the parallel interface. =20
>=20
> I do agree it's more future but guessing usecases is not something I tend=
 to
> like much (often just results in code that never gets __really__ used). W=
e can
> very well take care of it when a usecase pops up and we have an actual de=
vice
> that can be represented by a backend :).
>=20
> >=20
> > FWIW, I don't think it would be "lying" since the io-backend DT node wo=
uld be
> > representing physical parallel bus between the DMA controller and the A=
DC
> > chip. =20
>=20
> To me, it's really a stretch having a backend with the only reason (op) of
> requesting the DMA channel. I still think you're pushing to much and going
> around with wording to justify for the DMA property :). The parallel bus =
is part
> of the DAC and directly connects to the DMA data lines so it really looks=
 to me
> the dma is a property of the actual DAC.
>=20
> That said and Mariel can help here, I did not really looked into the desi=
gn
> myself and I'm just stating (or what I understood) what Mariel told me. B=
ut if
> there's some other piece of HW sitting between the DMA and the bus then i=
t would
> be easier for me to agree even if we don't have any real control over that
> device.
>=20
> > But if DT maintainers are OK with the idea that a DMA channel can be di=
rectly
> > wired to an external chip, I guess I won't complain. :-) =20
>=20
> That's the case in here so I don't see why it should be a problem :). It'=
s the
> same with the axi-dac/adc. It's all inside the FPGA but different cores/I=
PS.
>=20
> FWIW, I'm ok if we go the backend direction even if I don't fully agree w=
ith it
> (at least with the understanding I have so far about the design). I defin=
itely
> want to see more users of it but I also don't think it should be a rule f=
or any
> fairly high speed converter to have a backend associated.

ok. So short term, DT bindings that document the dma-channel
and see what the DT maintainers think. Longer term, if things get more
complex, that can become optional and a backend added.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


