Return-Path: <linux-iio+bounces-9915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7E989D01
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6685F1F23409
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5717C219;
	Mon, 30 Sep 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0qkg/Nr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F93FB0E;
	Mon, 30 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685666; cv=none; b=G4MsMRWEhlz0Y0xCNmyqudJ72e/Zs/xmjnb+ZXXp2Fw1lWQgL4VdWej+HmwhNrSFsAdINOBK0B1QbG1H6Czx1FwGlCOet1aDjarKyq66ePbw2d1CgchVEYCvIdiHJ1CvipLZulduDbktkX06Jrb4O0c/ozt+NsszOVUipLr89EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685666; c=relaxed/simple;
	bh=/IgEcOq/Pg9LpJttfLXnkydtM1MrKagW/YX3Y9ydk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/fA6WSpmnhTXrMVXL/vihQCPgYqS7Ct8G3maucPere59MBAuuP+QpVpgh7dh2Npgho2QYrnzFZ5gm+/gFQOoFCuMuTnLeac+qOQWcokeD2mTXGPkyxfXj/OX1kHXD9mpjrAZ1GH01+mCGN26mcVWH0YBdMi8fp3Lj2qPRA362Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0qkg/Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32788C4CECD;
	Mon, 30 Sep 2024 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727685665;
	bh=/IgEcOq/Pg9LpJttfLXnkydtM1MrKagW/YX3Y9ydk0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0qkg/Nr9hqD3CxrTeaPW6Cp1EtF4GfsVbaKNxkCCwH21N2EaE4lvjnWrFeO/tDfs
	 PkKZfwM1bYV8dBfxDoorRzr8DVvHHONwCYk1By+NmZAhXEB4x3XJP87OyJrrjuerkn
	 MqjJo1i9YBcjmYueXjZbCLMnMHsaw+sBI0kz/2UAsFW3HXI2hnDHYGzsIElrvuq5x9
	 YVR2G1uoWdoe5DBxoPL1c1jVklb7V9DX//MTWUx3YKAWlzatppE/CQmonmu3BJ8pnw
	 VaM0jD8KprZFH7UZd8+3F8qJ89tR1DWQNy0owN7lcpuxOMtVfGp76bKujshyM3k5tN
	 oUlqY/QLqKyzQ==
Date: Mon, 30 Sep 2024 09:40:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240930094054.30cb0365@jic23-huawei>
In-Reply-To: <SJ0PR03MB6224756A0B570A8CCAEF021091762@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
	<20240912095435.18639-3-Mariel.Tinaco@analog.com>
	<8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
	<20240928151930.0c22e5e9@jic23-huawei>
	<SJ0PR03MB6224756A0B570A8CCAEF021091762@SJ0PR03MB6224.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sep 2024 04:28:09 +0000
"Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, September 28, 2024 10:20 PM
> > To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Tinaco, Mariel <Mariel.Tinaco@analog.com>; linux-iio@vger.kernel.or=
g;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter Cl=
ausen
> > <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Conor Dooley <conor+dt@kernel.org>;
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > <dima.fedrau@gmail.com>; David Lechner <dlechner@baylibre.com>; Nuno S=
=C3=A1
> > <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
> >=20
> > [External]
> >=20
> > On Sat, 14 Sep 2024 20:21:56 +0200
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >  =20
> > > Le 12/09/2024 =C3=A0 11:54, Mariel Tinaco a =C3=A9crit=C2=A0: =20
> > > > The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, =
high-power,
> > > > high-speed driver optimized for large output current (up to =C2=B11=
 A)
> > > > and high slew rate (up to =C2=B11800 V/=CE=BCs) at high voltage (up=
 to =C2=B140 V)
> > > > into capacitive loads.
> > > >
> > > > A digital engine implements user-configurable features: modes for
> > > > digital input, programmable supply current, and fault monitoring and
> > > > programmable protection settings for output current, output voltage,
> > > > and junction temperature. The AD8460 operates on high voltage dual
> > > > supplies up to =C2=B155 V and a single low voltage supply of 5 V.
> > > >
> > > > Signed-off-by: Mariel Tinaco
> > > > <Mariel.Tinaco-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> > > > --- =20
> >=20
> > Rather than go around again, I fixed up all the comments made and the
> > autobuilder issues then applied this.
> >=20
> > Diff follows. The only bit I'm not 100% sure on was your intent with the
> > temperature channel. I've made it an input but shout if I'm missing som=
ething.
> >=20
> > With this diff applied on top, applied to the togreg branch of iio.git =
which is
> > only pushed out as testing for now as I'll rebase on rc1 once available.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
>=20
> Hi Jonathan,
>=20
> Thank you for finding the time to fix up the inline comments from the
> previous rounds! I have created a patch for that but was unable to send it
> yet because I'm still clueless about the temp channel. Apologies about th=
at
>=20
> About the temperature channel, it does make sense to set it as input sinc=
e the
> value is read-only.=20

Input means that we are measuring a signal from the outside world.  As you =
can
read the temperature it should be an input (doesn't matter that it comes fr=
om
elsewhere - in this case an ADC channel is providing the service of reading
that voltage for us).

> About the implementation of the channel, I'm wondering
> what would happen if the consumer-get-channel would throw -EPROBE_DEFER
> half the time?

It will return -EPROBE_DEFER, it then later the driver providing the ADC ch=
annel will probe
and we will go around again with it succeeding.  Roughly speaking every
time a driver is successfully bound (probe finishes) the kernel tries again
for any deferred instances.

The only nasty corner is the DT supplies the channel but we don't have the
driver for the ADC built. I'd argue that is a kernel miss configuration
where the right approach is to fix that and provide the ADC driver.


> Is it not possible to skip it over since the channel is optional
> anyway? Or does this defer error from the consumer mean that the other
> configurations for the succeeding attributes will be blocked, which is wh=
y we
> have to return probe instantly?

If we don't defer then we never try again and succeed.
We could skip it but that would effectively be so unreliable we would be
better off not providing that feature at all as it will be the source
of lots of bug reports.

>=20
> 	state->tmp_adc_channel =3D devm_iio_channel_get(dev, "ad8460-tmp");
> 	if (IS_ERR(state->tmp_adc_channel)) {
> 		state->tmp_adc_channel =3D NULL;
> 		indio_dev->channels =3D ad8460_channels;
> 		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> 	} else {
> 		ret =3D iio_get_channel_type(state->tmp_adc_channel, &temp);
> 		if (ret < 0)
> 			return ret;
>=20
> 		if (temp !=3D IIO_TEMP)
> 			return dev_err_probe(dev, -EINVAL,
> 					     "Incompatible channel type %d\n", temp);
>=20
> 		indio_dev->channels =3D ad8460_channels_with_tmp_adc;
> 		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> 	}
>=20
> I also found other implementations where the type of channel is checked. =
Thought
> That maybe it's a good addition for security.

in this case it would be a DT bug on a very simple binding so I'm not sure =
we care.
It is also very unlikely to be a temperature channel given we need to read =
the voltage
from this chips output pin

Jonathan


>=20
> Thanks,
>=20
> Mariel


