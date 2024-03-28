Return-Path: <linux-iio+bounces-3900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F58890657
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356492A66C8
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704D225D0;
	Thu, 28 Mar 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhGrWAlX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F527BA53;
	Thu, 28 Mar 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644764; cv=none; b=i61NZsCT105Y0mN5eLtQS2EKmi8fvJiNS8ZxHLa+d09tG1UgX3UV73yBVQ6re5Kq+akLY+n8bNRNCDzxdpPuT8HUwKOKYRgr4V+YkZvdeX3LDeAtOxk27hQbPxR5HWD9dYC4ymo3wF60IpV6eyXXkXSWIEfhDVRnmSZFKMDg178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644764; c=relaxed/simple;
	bh=2ORTtxxvKvQFajPnT/ogC//wL6WI/9Uh1mMt/Ql6hpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jci3IO/vttaAII6Mmf4tqS5MeI4B4AEyD7v5oe29zEPJVVvB1mi/Jc5E3ijhH5H0r9l7h3kyeVBlxIDGpoiRQ3Dw4IvKC1YhVW7I3MDvezUOHXzDj08yzoeN7uCDmgsEA4aB+IR/n5wVPQnF711qZSFun2RtSrWIEcbC8RBvcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhGrWAlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8493FC433F1;
	Thu, 28 Mar 2024 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711644763;
	bh=2ORTtxxvKvQFajPnT/ogC//wL6WI/9Uh1mMt/Ql6hpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhGrWAlXOixGOGpeHUzrjz0uTuq1mZW5R43hWoU8Q9rey7MnWglpOXCtabzgcvhYR
	 oNdagJ27qPRrU74rIiZc0PQEcwVAEpEuP0pUEp4MNkemIg0zVyesxsbCNmxf8vIgZr
	 WFXOFygyWJlN3x9TYloRNuXjvEBeGc40Va+Rv4w7faKXv0Z1/rg64HspLRxsII3uft
	 9aKtHPX8RzpMiJqEukU2MoL34qpo5SbK1vPeVcDGo96Lt5OttyDo0ZQ7pWq19hn2W/
	 3u95kIumG+78NnHnUf5ZpL0KAUrXPinxtxqhurBkZoeQnlauiQMrzLXkhM87qFUoa7
	 2YMAqJzZfMV7A==
Date: Thu, 28 Mar 2024 16:52:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Dragos Bogdan <dragos.bogdan@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 10/10] iio: dac: support the ad9739a RF DAC
Message-ID: <20240328165228.7fe827fc@jic23-huawei>
In-Reply-To: <62e07212e1eebf8bbc6a7f9ee27f670a6d79c57e.camel@gmail.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-10-afc808b3fde3@analog.com>
	<20240328155126.2575d754@jic23-huawei>
	<62e07212e1eebf8bbc6a7f9ee27f670a6d79c57e.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > +static int ad9739a_oper_mode_set(struct iio_dev *indio_dev,
> > > +				 const struct iio_chan_spec *chan, u32 mode)
> > > +{
> > > +	struct ad9739a_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	if (mode =3D=3D AD9739A_MIXED_MODE - 1)
> > > +		mode =3D AD9739A_MIXED_MODE; =20
> >=20
> > Why?=C2=A0 Feels like a comment is needed. Or a more obvious conversion=
 function.
> >  =20
>=20
> To match what we want to write in the register... With just two values it=
's too
> simple that opt not to have any helper function or table. Would you be fi=
ne with a
> comment?

yes

>=20
> > > +
> > > +	return regmap_update_bits(st->regmap, AD9739A_REG_DEC_CNT,
> > > +				=C2=A0 AD9739A_DAC_DEC, mode);
> > > +}
> > > +
> > > +static int ad9739a_read_raw(struct iio_dev *indio_dev,
> > > +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > > +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> > > +{
> > > +	struct ad9739a_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		*val =3D st->sample_rate;
> > > +		*val2 =3D 0;
> > > +		return IIO_VAL_INT_64; =20
> >=20
> > Big numbers :) =20
>=20
> My setup is using 2.5Ghz which is big enough to overflow INT but would wo=
rk on UINT.

I like big numbers so it's fine doing this. Just unusual to force
val2 to 0 so it made me look closer and appreciate just how big these were =
getting ;)
> > > +	if (id !=3D AD9739A_ID)
> > > +		return dev_err_probe(dev, -ENODEV, "Unrecognized CHIP_ID 0x%X",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 id); =20
> > Do we have to give up here?=C2=A0 Could it be a compatible future part?
> > If so we should fallback on what firmware told us it was + perhaps a
> > dev_info() to say we don't recognise the ID register value.
> >  =20
>=20
> I typically prefer to really give up in these cases but no strong opinion=
... Can turn
> this into a dev_warn()...

DT maintainers generally advise carrying on and trusting the firmware.
I used to agree with you that paranoia was good but I can see there point
and we do have cases where this happened in real parts.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


