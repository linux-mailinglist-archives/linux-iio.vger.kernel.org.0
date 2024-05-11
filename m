Return-Path: <linux-iio+bounces-4952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022448C3104
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC781281AA4
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27954FB7;
	Sat, 11 May 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmGcQl9y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7554F87;
	Sat, 11 May 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428056; cv=none; b=K0ImvRHQz750N/HccCfQg47g5JGishLXH6bwXp5x//jOlAAsLlklkaEiehvScxlMeq6FDkt6xchKywRCswlDLNDrAAhHKtFf+2aDO3e6+EEBcwURT6Z+xoY2sZOTt4+2SkwMSWvr4hpLtO0bxeqh/bZbO+r6262G4B/u8hH1zVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428056; c=relaxed/simple;
	bh=Ad33EoIdC/2d9QPw323EcuvUf08B04qp9JzIxhTJ6h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlB4xkQaSuIDN6Kd8PIlIEyeJh3sQ8zm4MNadd6AMgV6SeYeyn4FU2pKPFuYl0kxHJxIUSyolBjjDqdql9MKaytMxX9EKbSBRnVh13Brn13L8rtiMEFtc7Y1UIKN37VQTF3Zc4r6yyqiC9k6VqY4Q4l9O5+TYWlMMZEexrKNWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmGcQl9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DB9C2BBFC;
	Sat, 11 May 2024 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715428055;
	bh=Ad33EoIdC/2d9QPw323EcuvUf08B04qp9JzIxhTJ6h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RmGcQl9yUW5OTZ2Nb3GPyhm2BoQKtxe1zflzeyb+dtk2tV55rWIb9/e5yHPWT1Fuy
	 kui8pAqAgXjJr+iwnn+LKQ2lCpZ7GUkEeBsVnVUtE+qXRWW1EMfFPdo65Bu9Km0KtD
	 BIX8ZDWxc/0xKYhu+evm26zpgxZuJ+fq1QZY442OtNklLXqI16rPXzxWT0WsVoO/O3
	 g3apNEv5fsSphGQwBavc4t0jZQebSjnw95aTbOIK8aY6ccZPRTIY4qwDPmyBe7dy5J
	 udQP7OZVBXceG7J5VhBRjXnone/9rblLQiXGHRs3sbjJl/t1x/JSGNB6lp6t3ggGY9
	 teVItshhMxmEQ==
Date: Sat, 11 May 2024 12:47:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Julien Stephan
 <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
Message-ID: <20240511124721.0d28bc11@jic23-huawei>
In-Reply-To: <CAMknhBH=R2D4yu6Psnh+gv=OpCNAEwi8fpvMcJd0n9-SBfNWqg@mail.gmail.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
	<20240506151725.10cf025e@jic23-huawei>
	<CAMknhBFx-KVPRbm1xmKeU8ZaA7qt_c0_6eiUT-5kqTWVAvf3hw@mail.gmail.com>
	<20240508122556.00005f71@Huawei.com>
	<CAMknhBH=R2D4yu6Psnh+gv=OpCNAEwi8fpvMcJd0n9-SBfNWqg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 May 2024 17:01:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, May 8, 2024 at 6:26=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 6 May 2024 10:04:10 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > On Mon, May 6, 2024 at 9:17=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > > >
> > > > On Wed, 01 May 2024 16:55:42 +0200
> > > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > > =20
> > > > > Adds support for rolling average oversampling mode.
> > > > >
> > > > > Rolling oversampling mode uses a first in, first out (FIFO) buffe=
r of
> > > > > the most recent samples in the averaging calculation, allowing th=
e ADC
> > > > > throughput rate and output data rate to stay the same, since we o=
nly need
> > > > > to take only one sample for each new conversion.
> > > > >
> > > > > The FIFO length is 8, thus the available oversampling ratios are =
1, 2, 4, 8
> > > > > in this mode (vs 1,  2, 4, 8, 16, 32 for the normal average) =20
> > > >
> > > > Ah. I should have read on!
> > > > =20
> > > > >
> > > > > In order to be able to change the averaging mode, this commit als=
o adds
> > > > > the new "oversampling_mode" and "oversampling_mode_available" cus=
tom
> > > > > attributes along with the according documentation file in
> > > > > Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no stand=
ard
> > > > > attributes correspond to this use case. =20
> > > >
> > > > This comes to the comment I stuck in the previous patch.
> > > >
> > > > To most people this is not a form of oversampling because the data =
rate
> > > > remains unchanged. It's a cheap low pass filter (boxcar) Google poi=
nted me at:
> > > > https://dsp.stackexchange.com/questions/9966/what-is-the-cut-off-fr=
equency-of-a-moving-average-filter
> > > >
> > > > in_voltage_low_pass_3db_frequency would be the most appropriate sta=
ndard
> > > > ABI for this if we do treat it as a low pass filter control.
> > > >
> > > > I'm not necessarily saying we don't want new ABI for this, but I wo=
uld
> > > > like to consider the pros and cons of just using the 3db frequency.
> > > >
> > > > So would that work for this part or am I missing something?
> > > > =20
> > >
> > > I like the idea. But from the link, it looks like the 3dB frequency
> > > depends on the sampling frequency which is unknown (e.g. could come
> > > from hrtimer trigger).
> > >
> > > Would it be reasonable to calculate the 3db frequency at the max
> > > sample rate that the chip allows and just use those numbers?
> > > =20
> > Ah. So looking at datasheet the normal average oversampling is
> > self clocked, but this version is not.
> >
> > So, I'll ask the dumb question.  What is this feature for?
> > We have to pump the SPI bus anyway why not just do the maths in
> > userspace?  Oversampling is normally about data rate reduction
> > with a bonus in precision obtained.
> >
> > Jonathan
> > =20
>=20
> I asked the apps engineers and the answer I got is that it a way to
> enable oversampling while still maintaining a high sample rate.

If I read it correctly (and based on how this is done on some other
devices) it's exactly the same as not enabling this mode and in
software adding up the last 8 readings (so software oversampling).
Data rate is the same and arguably the larger spi transfers that
might result from their solution are more expensive than doing the
sum on the CPU.

A long time back there was IIRC some discussion of implementing
this sort of filtering as a pluggable component between an IIO
device driver and the kfifo - idea being to reduce data being
passed to userspace - there would be no point in doing
this variant though as the data rate isn't reduced.  It would be
easy to do as a buffer consumer IIO device that just does maths
on incoming data before providing it's own kfifo, but no one
ever implemented it.

>=20
> Another thing to consider here is that we can only enable the extra
> resolution bits if oversampling is enabled (normal or rolling mode).
> The chip might not work right if we try to enable the extra bits
> without oversampling enabled.

I think the key question is where do those extra bits come from?=20
If this is conventional oversampling then we just sum up the readings
and divide by how many there are.
(A1 + A2 + A3 + A4 + A5 + A6 + A7) / 8
So sum plus shift right 3.  However you don't actually do the div 8
you just change the scale to reflect that your new LSB is 1/8th of
that before giving greater precision. This is giving 2 extra bits, so
it's slightly worse than the 3 we'd get doing it in software (trade
off to keep the SPI transfers smaller).  So they are either dropping the
LSB or just possibly dithering it.

So far I'm not seeing a strong reason to support this functionality.

>=20
> So my thinking is perhaps it is better to keep the rolling mode as
> oversampling rather than trying to call it a low pass filter. As you
> said, normal mode is about data rate reduction with bonus precision.
> Rolling average oversampling mode then would then just be for the
> bonus precision.

True if there actually is any. I took another close read through
the datasheet sections and the description aligns with my assumptions
above.

Jonathan



