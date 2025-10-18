Return-Path: <linux-iio+bounces-25251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D0BED7C8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA4189E981
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0827703A;
	Sat, 18 Oct 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyxW1um6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB541A8F84;
	Sat, 18 Oct 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760812298; cv=none; b=oP111H03BxxImhMR0XHMzrt05kw/9u96TSm8JabTKCwGmhKrscmLv6LZTN42ex2CtJAil7NeZ3v0agsU6FGdwn48X37ziNw1y1NM1n40wLjGgJA4NMsO0ZhYILcxTtz3AjjWTBcpwGvcCmGuVX07+RAYMFhZOFcDe3NsyIktWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760812298; c=relaxed/simple;
	bh=RFUGt6wFf1CTHw/GUMp0FvTbQDXkUw9yH0yJJHo+PiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COth+hNYo9TvvNDCLK0lthUgt+cgbn0/3DUxIx2vZnHx3kq2Sso3jvIAszIRvzDytHOSReo8XQwVmG2BUFkR+uEPvGQtoeb1g2QoSI7otkSb3Y+EtsD+nH11KCUtjn+Fm1RrxdH8uJVx9PsXw8nKZBdfMmpEq4C15xly/kO7cHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyxW1um6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0240DC4CEF8;
	Sat, 18 Oct 2025 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760812297;
	bh=RFUGt6wFf1CTHw/GUMp0FvTbQDXkUw9yH0yJJHo+PiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TyxW1um6M2aXpQzSvSleD+4nh2+ni9MqDlNeqbdLmckWg3PZZyrwh8hMgrq5KAtW+
	 RjAaXOVhMWHj2QnfZ6pMDazZnwlmPF5dW8FLum6wmzDdceiFrCnFxjolciIGQwRYMt
	 2rkvVDKmqOl9AOEDLDJygV2w8iQ1pLKnx5fUFhDlb4UzCABApHQmGWoMT/4MV66OBr
	 AIJfDAoj4mBOqriz+jLTyV/0lAT1vknOS1kA46hzgMl8DdCJBQF/yr8zJctXq+a6t2
	 dvLrDv4Y2A9HX9VHBwgslB1gCJ5y8gO4Xs6dDN30HQ8H04QdUbY2g8Q6SSPBMLMDfB
	 5iSP5J3Fe6MPQ==
Date: Sat, 18 Oct 2025 19:31:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251018193128.799490fa@jic23-huawei>
In-Reply-To: <f73f73e6b2aae53fa6bdae7c9d2970ba1caed7e5.camel@gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
	<20251015211420.031c61fa@bootlin.com>
	<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
	<20251016160202.3d4d0a5e@bootlin.com>
	<d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
	<20251017085904.07e40e37@bootlin.com>
	<10e119ee5a76f1c47d7eb6a15989c8ffc00ffc5f.camel@gmail.com>
	<20251017174322.07997789@bootlin.com>
	<f73f73e6b2aae53fa6bdae7c9d2970ba1caed7e5.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Oct 2025 17:29:34 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-10-17 at 17:43 +0200, Herve Codina wrote:
> > I Nuno,
> >=20
> > On Fri, 17 Oct 2025 09:26:26 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Fri, 2025-10-17 at 08:59 +0200, Herve Codina wrote: =20
> > > > Hi Nuno,
> > > >=20
> > > > On Thu, 16 Oct 2025 16:26:28 +0100
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > >=20
> > > > ...
> > > >=20
> > > > ...=C2=A0  =20
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc,
> > > > > > > > > > &rzn1_adc-
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > adc_core[0],=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > +					=C2=A0=C2=A0 "adc1-avdd",
> > > > > > > > > > "adc1-
> > > > > > > > > > vref");
> > > > > > > > > > +	if (ret)
> > > > > > > > > > +		return ret;
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc,
> > > > > > > > > > &rzn1_adc-
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > > adc_core[1],=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > > > > > +					=C2=A0=C2=A0 "adc2-avdd",
> > > > > > > > > > "adc2-
> > > > > > > > > > vref");
> > > > > > > > > > +	if (ret)
> > > > > > > > > > +		return ret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  =20
> > > > > > > > >=20
> > > > > > > > > Hmm, is avdd really an optional regulator? I mean can the=
 ADC
> > > > > > > > > power
> > > > > > > > > up
> > > > > > > > > at
> > > > > > > > > all
> > > > > > > > > without a supply in AVDD? Even vref seems to be mandatory=
 as we
> > > > > > > > > can't
> > > > > > > > > properly
> > > > > > > > > scale the sample without it.=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  =20
> > > > > > > >=20
> > > > > > > > Where do you see that avdd is an optional regulator?=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > >=20
> > > > > > > You are using devm_regulator_get_optional(). That's for optio=
nal
> > > > > > > regulators.
> > > > > > > =C2=A0=C2=A0=C2=A0  =20
> > > > > >=20
> > > > > > Indeed I use devm_regulator_get_optional().
> > > > > >=20
> > > > > > We have two similar function to get regulators:
> > > > > > - devm_regulator_get() and
> > > > > > - devm_regulator_get_optional().
> > > > > >=20
> > > > > > devm_regulator_get() returns a dummy regulator if the regulator=
 is not
> > > > > > described in the device-tree. The calling code has no way to kn=
own if
> > > > > > the regulator was present or not.=C2=A0=C2=A0=C2=A0  =20
> > > > >=20
> > > > > Yeah because it's mandatory and the part cannot work without powe=
r :).
> > > > > So we
> > > > > should not be allowed to operate without a regulator.
> > > > > =C2=A0  =20
> > > > > >=20
> > > > > > On the other hand, devm_regulator_get_optional() returns -ENODE=
V when
> > > > > > the
> > > > > > regulator is not described.
> > > > > >=20
> > > > > > That's pretty confusing but it is the reality.
> > > > > >=20
> > > > > > I use devm_regulator_get_optional() but check for -ENODEV to se=
e if
> > > > > > the
> > > > > > regulator is provided or not.
> > > > > >=20
> > > > > > In order to use the ADC core (is_used flag), I need both the AV=
DD and
> > > > > > the
> > > > > > VREF regulator available.=C2=A0=C2=A0=C2=A0  =20
> > > > >=20
> > > > > And that is why I don't get why are we allowed to proceed if ther=
e's no
> > > > > regulators? That seems wrong to me.=C2=A0
> > > > >=20
> > > > > So I think the regulators should be mandatory in the bindings and=
 a
> > > > > dummy
> > > > > regulator should also not be allowed in this case because that sh=
ould
> > > > > get
> > > > > you=C2=A0
> > > > > -EINVAL when calling regulator_get_voltage().
> > > > > =C2=A0  =20
> > > >=20
> > > > I have 4 regulators: avdd1, vref1, avvd2, vref2.
> > > >=20
> > > > The ADC controller can work with 2 internal ADC core (adc_core[0] a=
nd
> > > > adc_core[1])
> > > > in the driver. Those internal core are not directly accessed by the
> > > > driver.
> > > > Only
> > > > the ADC controller is accesses.
> > > >=20
> > > > Those cores have an AVDD and a VREF power supply.
> > > >=20
> > > > We can use either adc_core[0] only, adc_core[1] only or both adc co=
res.
> > > >=20
> > > > Depending on regulator described, the driver uses one or two adc co=
res.
> > > >=20
> > > > This choice is done by:
> > > > --- 8< ---
> > > > static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > > > 					 struct iio_dev *indio_dev)
> > > > {
> > > > 	int adc_used;
> > > >=20
> > > > 	adc_used =3D rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > > > 	adc_used |=3D rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > > >=20
> > > > 	switch (adc_used) {
> > > > 	case 0x01:
> > > > 		indio_dev->channels =3D rzn1_adc1_channels;
> > > > 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc1_channels);
> > > > 		return 0;
> > > > 	case 0x02:
> > > > 		indio_dev->channels =3D rzn1_adc2_channels;
> > > > 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc2_channels);
> > > > 		return 0;
> > > > 	case 0x03:
> > > > 		indio_dev->channels =3D rzn1_adc1_adc2_channels;
> > > > 		indio_dev->num_channels =3D
> > > > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > > > 		return 0;
> > > > 	default:
> > > > 		break;
> > > > 	}
> > > > --- 8< ---
> > > >=20
> > > > In rzn1_adc_core_get_regulators(), looking at one core I do the
> > > > following:
> > > > =C2=A0- Try to get AVDD (using get_optional)
> > > > =C2=A0- Try to get VREF (using get_optional)
> > > > =C2=A0- Core is used only if both regulators are present.
> > > >=20
> > > > For one core to be used, both regulators have to be present.
> > > >=20
> > > > Regulators are mandatory but adc core usage is optional.
> > > >=20
> > > > This optional usage depends on related regulator presence.
> > > > =C2=A0  =20
> > >=20
> > > Ok, then we could flip the logic and have boolean properties for the =
adc
> > > core
> > > usage and depending on that, requesting the regulators. To me, the in=
tent
> > > would
> > > be more clear (at the expense of more FW properties). =20
> >=20
> > This introduces a new property and duplicates the information:
> > - flag to tell if adc core is used
> > - regulators described only if used
> >=20
> > And so, the possible flag set to "adc core used" but regulators not
> > described. This is error prone.
> >=20
> >=20
> > I have chosen to rely only on regulators description to avoid the
> > information redundancy.
> > =C2=A0 - regulators described -> adc core used
> > =C2=A0 - regulators not described -> adc core not used =20
>=20
> I'll leave it up to you but while I know it introduces new properties, yo=
u could
> still do it in a way that minimizes errors:
>=20
>  - In the bindings, if the property is set, then the regulators are a
> __required__;
>  - In the driver, if the boolean is true, then use devm_regulator_get()
>=20
> - Nuno S=C3=A1

I'd add a question on this under the --- in the next version of the binding
doc. This is a fairly unusual situation. I think the regulators presence is
sufficient but it may surprise people enough to make it worth calling out.

Jonathan



