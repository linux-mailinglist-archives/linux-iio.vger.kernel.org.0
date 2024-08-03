Return-Path: <linux-iio+bounces-8179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353959468ED
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BCA1C209E8
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865A132105;
	Sat,  3 Aug 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjmI172N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F667A0D;
	Sat,  3 Aug 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678678; cv=none; b=ApAX2X7zKCkCGOpOGJMD5+LPYth1+I4RvtKpgjzFIAKhdqNHf1xqytRJmiD1YQGs3ALePeQFPx9UHAy23D/VABZbF9lpHEDR8n+MxY2WaWqgSBENOjEXELiAabapYSshwShlxUBYbSl/NWxLy6fbOv3tlJ0QsKMBJNiM5IJ0nfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678678; c=relaxed/simple;
	bh=OG+HBNNwOIHC/Q+Czcun5EKslZ+PL/rciETpjpmP738=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EujjDjDhxt/4BbRMAwoesX+Mt5MUIKGIVJywsUM1386XH+kiMxkeGH8WG8Jpj1s7dAFAj1rlBKoj33Aq/bZW6qAz1ICSzEfBHn1ZXDMVgOS6Ba+OYuLJYvz4RVbteAPEMOzmoOTgRDTmk85/bGAmSIxCaujhvWogrucIGh0jD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjmI172N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF05AC116B1;
	Sat,  3 Aug 2024 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722678677;
	bh=OG+HBNNwOIHC/Q+Czcun5EKslZ+PL/rciETpjpmP738=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qjmI172NIl3Z6tmxwlz5r8cFTIHze/zbCP9dLXIdMl6DBhpJxuzOyqBdS5yC2x9Hv
	 RthT8gXlKsVP8Bq4tWVeIGStiAQ6pjl3L2oBfw11P70kP9tEZCbEYBWiyYjd5BpkEE
	 B6wspAVevNvTqWJ0+6na6Lz7ZbFgDaCU6PqjAAjL8OYW0kmPzQVnDbTSAjQiDZuRLK
	 0qLgOVf5z8gr/CTnrnUcRGzRuFtvojKi8Ifq1UYwf7LArVuWKq/fxvBBjByEniwNAY
	 clpwkI3lcGhbf6wuS3XMWN36s12Q1q4UfFTKdWLNLedcfWQxelJbTxrRADE6giNBhb
	 8mGx4VI9HiQBA==
Date: Sat, 3 Aug 2024 10:51:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, baylibre-upstreaming@groups.io,
 Lars-Peter Clausen  <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski  <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 Sa  <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240803105107.43233ae1@jic23-huawei>
In-Reply-To: <ae7287257d6611ee27846643f48303c7e0dbb7ac.camel@gmail.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	<0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
	<D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
	<ae7287257d6611ee27846643f48303c7e0dbb7ac.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 10:56:22 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-07-26 at 15:38 +0200, Esteban Blanc wrote:
> > Hi Nuno,
> >  =20
> > > > +			struct {
> > > > +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> > > > +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB]; =20
> > >=20
> > > Not sure common makes sense as it comes aggregated with the sample. M=
aybe
> > > this
> > > could as simple as:
> > >=20
> > > struct {
> > > 	s32 val;
> > > 	u64 timestamp __aligned(8);
> > > } rx_data ... =20
> >=20
> > See below my answer on channels order and storagebits.
> >  =20
> > > So, from the datasheet, figure 39 we have something like a multiplexe=
r where
> > > we
> > > can have:
> > >=20
> > > - averaged data;
> > > - normal differential;
> > > - test pattern (btw, useful to have it in debugfs - but can come late=
r);
> > > - 8 common mode bits;
> > >=20
> > > While the average, normal and test pattern are really mutual exclusiv=
e, the
> > > common mode voltage is different in the way that it's appended to
> > > differential
> > > sample. Making it kind of an aggregated thingy. Thus I guess it can m=
ake
> > > sense
> > > for us to see them as different channels from a SW perspective (even =
more
> > > since
> > > gain and offset only apply to the differential data). But there are a=
 couple
> > > of
> > > things I don't like (have concerns):
> > >=20
> > > * You're pushing the CM channels into the end. So when we a 2 channel=
 device
> > > we'll have:
> > >=20
> > > =C2=A0in_voltage0 - diff
> > > =C2=A0in_voltage1 - diff
> > > =C2=A0in_voltage2 - CM associated with chan0
> > > =C2=A0in_voltage0 - CM associated with chan1
> > >=20
> > > I think we could make it so the CM channel comes right after the chan=
nel
> > > where
> > > it's data belongs too. So for example, odd channels would be CM chann=
els
> > > (and
> > > labels could also make sense). =20
> >=20
> > I must agree with you it would make more sense.
> >  =20
> > > Other thing that came to mind is if we could somehow use differential=
 =3D true
> > > here. Having something like:
> > >=20
> > > in_voltage1_in_voltage0_raw - diff data
> > > ...
> > > And the only thing for CM would be:
> > >=20
> > > in_voltage1_raw
> > > in_voltage1_scale
> > >=20
> > > (not sure if the above is doable with ext_info - maybe only with
> > > device_attrs)
> > >=20
> > > The downside of the above is that we don't have a way to separate the=
 scan
> > > elements. Meaning that we don't have a way to specify the scan_type f=
or both
> > > the
> > > common mode and differential voltage. That said, I wonder if it is th=
at
> > > useful
> > > to buffer the common mode stuff? Alternatively, we could just have the
> > > scan_type
> > > for the diff data and apps really wanting the CM voltage could still =
access
> > > the
> > > raw data. Not pretty, I know... =20
> >=20
> > At the moment the way I "separate" them is by looking at the
> > `active_scan_mask`. If the user asked for differential channel only, I =
put the
> > chip in differential only mode. If all the channels are asked, I put
> > the chip in differential + common mode. This way there is no need to
> > separate anything in differential mode. See below for an example where
> > this started.
> >  =20
> > > However, even if we go with the two separate channels there's one thi=
ng that
> > > concerns me. Right now we have diff data with 32 for storage bits and=
 CM
> > > data
> > > with 8 storage bits which means the sample will be 40 bits and in rea=
lity we
> > > just have 32. Sure, now we have SW buffering so we can make it work b=
ut the
> > > ultimate goal is to support HW buffering where we won't be able to to=
uch the
> > > sample and thus we can't lie about the sample size. Could you run any=
 test
> > > with
> > > this approach on a HW buffer setup?  =20
> >=20
> > Let's take AD4630-24 in diff+cm mode as an example. We would have 4 cha=
nnels:
> > - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> > ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample as =
sent
> > by the chip.
> >=20
> > The problem I faced when trying to do this in this series is that IIO d=
oesn't
> > seem to like 24 storagebits and the data would get garbled. In diff only
> > mode with the same channel setup (selecting only Ch0 diff and Ch1 diff)
> > the data is also garbled. I used iio-oscilloscope software to test this=
 setup.
> > Here is the output with iio_readdev:
> > ```
> > # iio_readdev -s 1 ad4630-24 voltage0
> > WARNING: High-speed mode not enabled
> > Unable to refill buffer: Invalid argument (22)
> > ```
> >=20
> > I think this is happening when computing the padding to align ch1 diff.
> > In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length);`
> > will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 di=
ff
> > and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> > specified in linux/align.h: =20
> > > @a is a power of 2 =20
> > In our case `a` is `length`, and 3 is not a power of 2.
> >=20
> > It works fine with Ch0/1 diff with 24 realbits and 32 storagebits with 8
> > bits shift. =20
>=20
> Yes, I do understand that and that we need a power of 2 for storage bits.=
 My
> concern, as stated, is that if we have HW buffering (High speed enabled) =
CHO
> will have a sample size of (with diff + cm) of 40 which is not really wha=
t comes
> from HW. I wonder if it will work in that case. Maybe we can (as this oft=
en
> happens on an FGPA) have the HW guys doing some data shuffling so things =
work in
> the high speed mode as well.

If it's possible to unscramble the data in an fpga, that would make our lif=
e easier
though things may get messy if we get multiple versions of that and some
unscramble, others don't.

What I really don't want to see is us having to describe all the crazy tran=
smission
formats hardware can use such as bit interleaving. The descriptions will
get so complex we'll more or less end up with per device handling in usersp=
ace.

Jonathan


>=20
> - Nuno S=C3=A1
>=20
>=20


