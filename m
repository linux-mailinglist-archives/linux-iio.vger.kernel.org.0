Return-Path: <linux-iio+bounces-15703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D75A38605
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92877A19B0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9B221D87;
	Mon, 17 Feb 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNMisclN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AEB21D58E;
	Mon, 17 Feb 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802037; cv=none; b=ghsJ84JJbvEjn1pLraskZUSay2mICNNiCKpMoxG6QGKQmfxNSBCqsz4p3XJMdz6KGmJsYXSnJeiJH4TAJCOiuZYoYxlKCUOwEp66Gq+zUWFsgOV6gZn6HeLMV4fRdCl3nknSeeMSekCO1FkF2p2YzL0rdb2ZXMJqVMF40umH+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802037; c=relaxed/simple;
	bh=WoX4rkGG8IX4/MIvEe5QvsSw6rLdg3EL18aXO3EDuMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ3eUv5hWzJmHKKKMuxTxfvBfCUACdOQ/pdFazMuqDdub/1mIedZ+/SV1/0KV8V1ZZozEsTlCHdyaFPqQlj3rxeGX7xUle0OJxLRfY5RWlEg7efpQtuuI2k2s6nai05iiNmpuHNBdAeReJVXi2LDCtopGY17PYZOoM0o2F/pzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNMisclN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B73C4CED1;
	Mon, 17 Feb 2025 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802036;
	bh=WoX4rkGG8IX4/MIvEe5QvsSw6rLdg3EL18aXO3EDuMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNMisclN05MapFH/wKCmpUrZeGa+QVxql7qMOrY0rIxLL5MMys4qWhoV8ypiOpsbi
	 px1sxpeIRv8w+8fMbwvJh7HxHdMoxBVrWlpAEnnuLZCtZ5yHT12xmPlmqWAuryVV45
	 RUBNyy7pz8AHu9IpL8O50oIFhbwaaZMuMz61GRPI+z+i8O7maWjReDJmqqJWpA3lhM
	 G6hiidczzudm0qnpPLr5OYuVtp8rpcmGIdF7QoEYQpLNPrAVDiCkdxWJEtvHxTHXnE
	 X2bZM7D/qdyHIoWm+8H9wd04aXRdKlqPPTRN7CtZUWs6acrGOL80Z8Yedk+QBAn3dz
	 wdueL70DUbZ7g==
Date: Mon, 17 Feb 2025 14:20:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <20250217142024.1a7bea7e@jic23-huawei>
In-Reply-To: <CAPVz0n2s1mxuheAadhFMHnmm6DtdMYzLHaBQDB_TEF--tWktrw@mail.gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
	<20250215103159.106343-3-clamor95@gmail.com>
	<1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz>
	<CAPVz0n1T_jXXDhm6gF7gDDqZ=b6abR1Tqk=5kLo=Ws4FF2EVJw@mail.gmail.com>
	<20250216144436.70ff78c3@jic23-huawei>
	<CAPVz0n2s1mxuheAadhFMHnmm6DtdMYzLHaBQDB_TEF--tWktrw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Feb 2025 16:47:52 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:44 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =20
> > > > > +
> > > > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > > > +                         struct iio_chan_spec const *chan, int *=
val,
> > > > > +                         int *val2, long mask)
> > > > > +{
> > > > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > > > +     int ret, gain;
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA,=
 &gain);
> > > > > +             if (ret < 0)
> > > > > +                     return ret;
> > > > > +
> > > > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK]; =20
> > > >
> > > > Why did you chosen to do post-processing in the RAW channel instead
> > > > doing it in INFO_SCALE (same as al3010 does)?
> > > > =20
> > >
> > > From my observation INFO_SCALE will just perform multiplication of RAW
> > > to SCALE. In this case values which are read are not actual raw values
> > > of illumination. Next is my assumption (since there is no datasheet),
> > > but values obtained from register are similar to values from adc
> > > thermal sensors, they need be converted via reference table to get
> > > actual data. =20
> >
> > Please add a comment somewhere here to say that we don't know the
> > relationship of these values to illuminance hence providing
> > _RAW and _SCALE would not be helpful.
> > =20
>=20
> We do know relationship of these values to illuminance thanks to
> conversion table provided.

Then convention is treat them not as IIO_LIGHT but as IIO_INTENSITY
which is unit free.  IIO_LIGHT is only for when we know the value
we are providing to userspace is illuminance and measured in Lux.

Jonathan


>=20
> > > =20
> > > > Except this, LGTM.
> > > >
> > > > Documentation and DT patch:
> > > >
> > > > Reviewed-by: David Heidelberg <david@ixit.cz> =20
> > > > > +
> > > > > +             return IIO_VAL_INT;
> > > > > +     case IIO_CHAN_INFO_SCALE:
> > > > > +             *val =3D 1;
> > > > > + =20
> >
> > Don't do this.  The above lack of known relationship has to be
> > expressed by not providing the _scale attribute.
> > =20
> > > > > +             return IIO_VAL_INT;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static const struct iio_info al3000a_info =3D {
> > > > > +     .read_raw       =3D al3000a_read_raw,
> > > > > +}; =20
> >
> > =20


