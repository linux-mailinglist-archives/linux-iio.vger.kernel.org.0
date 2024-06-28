Return-Path: <linux-iio+bounces-7027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0399891C617
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347C61C22516
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B74D9EA;
	Fri, 28 Jun 2024 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9JLlm0A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C593FB88;
	Fri, 28 Jun 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600678; cv=none; b=HT9f+rVSN1yZXNq8PXva6vsaWjTAFAhS0LKHpsqQsBX0C+gRBY29T58tQajn5me7yxiMnPqSR5Ahz7fKbv8qQpWuttIXELZya6PFLqxz7dXlbTtpsmpzS7wL9WxI3Vu79hhze/PtyiUxWJuRBwZqMFS8l3cj769ivYqwohFOxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600678; c=relaxed/simple;
	bh=IRsyeZlE22rUDDc0+sSGMLdZ22/Kx3XdIJdAXDhbitw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoI2Fcog/VlSIEgy1nB8eFMqQX3jjz6HDleFNTtzY2MNjbT4iMWi0dCbmkw5j2cKu9dAai4OgEmI0FQi2SACyJggOeJmyDEJ8MiLlnAnPQZ43bhW392gEjW/y8EiX124G0wVmY5GY26Hd4kXLgq2/FUcsiR1qvrXOqaWiHEvHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9JLlm0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F2C116B1;
	Fri, 28 Jun 2024 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600677;
	bh=IRsyeZlE22rUDDc0+sSGMLdZ22/Kx3XdIJdAXDhbitw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9JLlm0ATACU3fcEBByrFM7REN2luh5VGlvNeWlbqxDHW8+XOdEfzrgwpD3fM1wYS
	 62PmGiQxzHm/AZ2CW2K51jWsfVzOv+QmuJrp6HIvowacYyFYiDmxCCU5MnWPRI3xbz
	 r3BLrEM1OvFxDAybmDc+JCVwIG6MhAoRMwvMdXhYZcQ4Tjhvw9pSlDRmMIRJC6cNT5
	 Ng6KdkSyq14NccIWdENRJr8Yuio1QioeWhO9KT+R15RCb+eRApHjQPndsoVNsG+eMS
	 P1so7xdtrOTqMdxURNY/RA8A0sExQsyvI1c7lDRrugKyNPcoLlUMVVHVKmsUCqgrtw
	 OikjF8+78ikRQ==
Date: Fri, 28 Jun 2024 19:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240628195106.215839df@jic23-huawei>
In-Reply-To: <SJ0PR03MB6224D9A14475071E8A1D921A91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB6224D9A14475071E8A1D921A91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 04:56:57 +0000
"Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, May 12, 2024 12:44 AM
> > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herri=
ng
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dool=
ey
> > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> > <broonie@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
> >=20
> > [External]
> >=20
> > On Fri, 10 May 2024 14:40:53 +0800
> > Mariel Tinaco <Mariel.Tinaco@analog.com> wrote:
> >  =20
> > > The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, hi=
gh-power,
> > > highspeed driver optimized for large output current (up to =C2=B11 A)=
 and
> > > high slew rate (up to =C2=B11800 V/=CE=BCs) at high voltage (up to =
=C2=B140 V) into
> > > capacitive loads.
> > >
> > > A digital engine implements user-configurable features: modes for
> > > digital input, programmable supply current, and fault monitoring and
> > > programmable protection settings for output current, output voltage,
> > > and junction temperature. The AD8460 operates on high voltage dual
> > > supplies up to =C2=B155 V and a single low voltage supply of 5 V.
> > >
> > > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com> =20
> >=20
> > I'd like to see some ABI docs for the debugfs interface.
> > The device is unusual enough that a general intro document or a lot mor=
e in the
> > series cover letter would be useful.
> >=20
> > I'm not sure what the dmaengine usage in here is doing for example?
> > Driving the parallel bus perhaps?  David was correct that the binding s=
hould
> > reflect that part as well. I was assuming you'd only implemented the sp=
i part.
> >=20
> > How to handle the pattern generator is also an interesting question.
> > That probably wants a version of the symbol interfaces we use for PSK a=
nd
> > similar.  We did have some DDS drivers a long time back in staging but =
they only
> > did a few fixed waveforms so this is breaking new ground. =20
>=20
> I also thought about how should the pattern generator be handled. IN the =
last
> revision, there were two debug attributes that make up this feature. Patt=
ern depth
> and pattern memory. Ultimately I found a way to combine these two attribu=
tes
> into one called "test_pattern". The attribute is a string containing an a=
rray
> of values with a maximum of 16 data words, which the DAC will cycle throu=
gh
> to generate a pattern. The number of values within the string can be anyw=
here
> between 1 to 16 and have a space in between. I also added a "test_pattern=
_enable"
> debug attribute. For the ABI file, should I create one alongside other "d=
ebugfs-*"
> files and just mention the name of the part? e.g. "debugfs-driver-ad8460"=
=20

Doing this in debugfs basically means you aren't intending it to get used i=
n real
usecases.  So we need some sysfs ABI.

That probably means a mode switch similar to the ones we have for devices t=
hat use
an external toggle (typically for Frequency Shift Keying or similar or some=
times just
to flip between two DC voltages).  We need a new term though as this isn't =
a toggle.

For the values we could map it to that interface which is something like

out_voltage0_raw0
out_voltage0_raw1

etc.  That avoids need for a new ABI for the values, but perhaps isn't that
elegant if the patterns on other devices we eventually support this on get
large.

Anyone know how large these typically get? I'm being lazy and don't want to
datasheet dive this evening!

Jonathan


