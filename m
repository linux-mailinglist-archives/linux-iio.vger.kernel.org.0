Return-Path: <linux-iio+bounces-8178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDE9468E9
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C91F217AF
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283022EAEA;
	Sat,  3 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcWvDNr4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF239131E2D;
	Sat,  3 Aug 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678517; cv=none; b=dPTXr2FwY7gFavJf4qcpacf/5M04lYXEI4TmTPIv2f0WjQ7bSM1cevMCH6SljtWkM0cEQIRuI6qN3Zb+GaQr9ZBnu7KjuhUD0d5teIKOYF1nvDPSPXWCYyhGo91aoh/SIEVMd4bHFCK8Tmm+fjoF5zcYy13Rr4os7/OYNLkgSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678517; c=relaxed/simple;
	bh=6OZRF91Ww9hN1HHvXLs4V2mK79YGrVx2+YTs2sA3ZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unq0KWAIiXFL7KH9KOd6ZMh2pi95/8dGZhey/QGCEOMrmL5ocWfI40LismWaiYW5vj5w/CIf84rkfB8N0+N95HC9HDHX6OIs+r9TkSc9X2hY/mLN84NSP2gOkslHRhbaZgXF/9+3NkO3GzDIjytgjwQiudJGRaFUaQrJrKG7c5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcWvDNr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E5FC116B1;
	Sat,  3 Aug 2024 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722678517;
	bh=6OZRF91Ww9hN1HHvXLs4V2mK79YGrVx2+YTs2sA3ZpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcWvDNr4zVsLU7vChO7eAHWcMwLMsLS7XJmdSI0VCBzjAbWB6omZ+HEqAX57qoV6k
	 bcWKl9mq0Xp0mQxL5QVoL2y7Cot0xf7RYSxk9QvBX3KErtxhLuxEl056Pc8mDs7Ed3
	 4rwzrut9nfLIQO+pYZTJ0VkPhH81SrRh6+X2NbO9/VPEcgItkjyVGK9FsSu8NPchfi
	 W0bEkX0aXBwt1/69nXj9XKrVB8YGDd4JHVH+1iop3J8/5cjmYU5qn7qHrbkEkyiIJ1
	 Y9daDT1Kberi+mlCDZw/YLarjZ8l/1lwm8L8xoDF0PSkZqHajJwVRKc3Qht8ffEVIr
	 TzHBXS/16hbmA==
Date: Sat, 3 Aug 2024 10:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, baylibre-upstreaming@groups.io,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240803104828.3c9159ef@jic23-huawei>
In-Reply-To: <f6c9f7730541a6a97e4ce0005bb4cf600973e691.camel@gmail.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	<0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
	<D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
	<20240728160408.4b810505@jic23-huawei>
	<f6c9f7730541a6a97e4ce0005bb4cf600973e691.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 11:07:14 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-07-28 at 16:04 +0100, Jonathan Cameron wrote:
> > One quick comment form me inline.
> >=20
> > The short version is non power of 2 storage is not an option because
> > it is a major ABI change and we aren't paying the cost of complexity
> > that brings to userspace for a very small number of drivers where
> > there is any real advantage to packing them tighter.
> >  =20
> > >  =20
> > > > So, from the datasheet, figure 39 we have something like a multiple=
xer
> > > > where we
> > > > can have:
> > > >=20
> > > > - averaged data;
> > > > - normal differential;
> > > > - test pattern (btw, useful to have it in debugfs - but can come la=
ter);
> > > > - 8 common mode bits;
> > > >=20
> > > > While the average, normal and test pattern are really mutual exclus=
ive,
> > > > the
> > > > common mode voltage is different in the way that it's appended to
> > > > differential
> > > > sample. Making it kind of an aggregated thingy. Thus I guess it can=
 make
> > > > sense
> > > > for us to see them as different channels from a SW perspective (eve=
n more
> > > > since
> > > > gain and offset only apply to the differential data). But there are=
 a
> > > > couple of
> > > > things I don't like (have concerns):
> > > >=20
> > > > * You're pushing the CM channels into the end. So when we a 2 chann=
el
> > > > device
> > > > we'll have:
> > > >=20
> > > > =C2=A0in_voltage0 - diff
> > > > =C2=A0in_voltage1 - diff
> > > > =C2=A0in_voltage2 - CM associated with chan0
> > > > =C2=A0in_voltage0 - CM associated with chan1
> > > >=20
> > > > I think we could make it so the CM channel comes right after the ch=
annel
> > > > where
> > > > it's data belongs too. So for example, odd channels would be CM cha=
nnels
> > > > (and
> > > > labels could also make sense).=C2=A0  =20
> > >=20
> > > I must agree with you it would make more sense.
> > >  =20
> > > > Other thing that came to mind is if we could somehow use differenti=
al =3D
> > > > true
> > > > here. Having something like:
> > > >=20
> > > > in_voltage1_in_voltage0_raw - diff data
> > > > ...
> > > > And the only thing for CM would be:
> > > >=20
> > > > in_voltage1_raw
> > > > in_voltage1_scale
> > > >=20
> > > > (not sure if the above is doable with ext_info - maybe only with
> > > > device_attrs)
> > > >=20
> > > > The downside of the above is that we don't have a way to separate t=
he scan
> > > > elements. Meaning that we don't have a way to specify the scan_type=
 for
> > > > both the
> > > > common mode and differential voltage. That said, I wonder if it is =
that
> > > > useful
> > > > to buffer the common mode stuff? Alternatively, we could just have =
the
> > > > scan_type
> > > > for the diff data and apps really wanting the CM voltage could still
> > > > access the
> > > > raw data. Not pretty, I know...=C2=A0  =20
> > >=20
> > > At the moment the way I "separate" them is by looking at the
> > > `active_scan_mask`. If the user asked for differential channel only, =
I put
> > > the
> > > chip in differential only mode. If all the channels are asked, I put
> > > the chip in differential + common mode. This way there is no need to
> > > separate anything in differential mode. See below for an example where
> > > this started.
> > >  =20
> > > > However, even if we go with the two separate channels there's one t=
hing
> > > > that
> > > > concerns me. Right now we have diff data with 32 for storage bits a=
nd CM
> > > > data
> > > > with 8 storage bits which means the sample will be 40 bits and in r=
eality
> > > > we
> > > > just have 32. Sure, now we have SW buffering so we can make it work=
 but
> > > > the
> > > > ultimate goal is to support HW buffering where we won't be able to =
touch
> > > > the
> > > > sample and thus we can't lie about the sample size. Could you run a=
ny test
> > > > with
> > > > this approach on a HW buffer setup?=C2=A0=C2=A0  =20
> > >=20
> > > Let's take AD4630-24 in diff+cm mode as an example. We would have 4
> > > channels:
> > > - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> > > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > > - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> > > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> > > ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample a=
s sent
> > > by the chip.
> > >=20
> > > The problem I faced when trying to do this in this series is that IIO
> > > doesn't
> > > seem to like 24 storagebits and the data would get garbled. In diff o=
nly
> > > mode with the same channel setup (selecting only Ch0 diff and Ch1 dif=
f)
> > > the data is also garbled. I used iio-oscilloscope software to test th=
is
> > > setup.
> > > Here is the output with iio_readdev:
> > > ```
> > > # iio_readdev -s 1 ad4630-24 voltage0
> > > WARNING: High-speed mode not enabled
> > > Unable to refill buffer: Invalid argument (22)
> > > ```
> > >=20
> > > I think this is happening when computing the padding to align ch1 dif=
f.
> > > In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length)=
;`
> > > will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 =
diff
> > > and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> > > specified in linux/align.h: =20
> > > > @a is a power of 2=C2=A0  =20
> > > In our case `a` is `length`, and 3 is not a power of 2.
> > >=20
> > > It works fine with Ch0/1 diff with 24 realbits and 32 storagebits wit=
h 8
> > > bits shift.
> > >=20
> > > Intrestingly, a similar setup works great on AD4630-16:
> > > - Ch0 diff with 16 bits of realbits and 16 bits of storagebits
> > > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > > - Ch1 diff with 16 bits of realbits and 16 bits of storagebits
> > > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> > >=20
> > > In `iio_compute_scan_bytes` we will have ALIGN(3, 2) which will output
> > > 4, everything is fine. The output of iio-oscilloscope is as expected,
> > > a clean sinewave and iio_readdev does not throw an error.
> > >=20
> > > All this to say that at the moment, I'm not sure how I will be able to
> > > put the CM byte in a separate channel for AD4630-24 without buffering=
 it.
> > > It would be useful to return a "packed" buffer. =20
> >=20
> > Whilst it might be useful to allow non power of 2 storage formats,
> > that's a break of the IIO userspace ABI so that isn't an approach to
> > consider. You must shuffle the data in the driver. =20
>=20
> Yeah, I do agree the breakage is really not the way to go...
>=20
> OTOH, I'm seeing more and more of these devices with kind of multiplexed
> data/channels in one sample (like cm and diff in this case) and while in =
SW
> buffering we can workaround it in the driver, for HW buffering things may=
 be not
> that "simple".
>=20
> Not sure what we can do about it but one concept that came to mind when I=
 was
> giving some thinking about this was kind of a virtual scan element that w=
ould
> essentially map/link to a (physical) scan element (so virtual_scan + scan=
 =3D
> storage_size of the real scan element). Kind of a basic idea for now and =
I'm not
> really sure how much work would this be or even how could we expose this =
to
> userspace without breaking current ABI (basically if it's doable at all :=
)).
>=20
> The only other option I see for these kind of devices (if there's nothing=
 we can
> do in HW for shuffling data) is to expose a different channel setup that =
does
> not "lie" about the sample size. And it's up to userspace to parse the sa=
mple
> data. Far from pretty though...

For stuff that is coming out of the DMA / bulk interfaces, I'm rather
more flexible on new data layouts.  That tends to run against a narrow
range of tooling + generally users have a better idea of what they
are doing (after all they probably bought some pricey hardware :)

So there I'd be happy to see proposals for other storage format descriptions
or indeed relaxing the requirements on existing description.

If there is a software path to simply reorganize the data, keep
to existing interfaces with the power of 2 aligned data requirements.

Jonathan

>=20
> - Nuno S=C3=A1


