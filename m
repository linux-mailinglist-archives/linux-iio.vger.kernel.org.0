Return-Path: <linux-iio+bounces-26053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE28C43D2E
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4942C3AA264
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C092E8B60;
	Sun,  9 Nov 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR6tU2QI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B32E7F38;
	Sun,  9 Nov 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690388; cv=none; b=cYZiQJJdAWwxw/81NRwzzs7o0eGiHuKoopTkzvMbRQAs4Clj3BswmoV0avPSTkcfVvrtPs4dXlFz27CJGDWGs5ogBQvvCvouKKjQ6eyDfkTSI+EZZGzGyES4CTRUMyr0ZkESFFHEcaamia/7K4F/aMMjmObOKmoIudAKhu9YlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690388; c=relaxed/simple;
	bh=ICdilM6Tvq5eSGzGER2PDBb0PKbbw/XDeg0FHl87JWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbUgcHnnNt0NUyCS9vWB1COB7ZH5RlIR1u2OZD7cA8JSyQMbR0ZhILw5AdzTl1xKuZWWzB92mecbhOLBTXP7YH7rPm3LcnIfWkU38DLd9cY8XQ6V/LgdT22iYnmi46A8au4SJSI+CjpngoyquR1XwcD0f05/v1/EKO+fsG3RopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR6tU2QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3997FC4CEFB;
	Sun,  9 Nov 2025 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762690388;
	bh=ICdilM6Tvq5eSGzGER2PDBb0PKbbw/XDeg0FHl87JWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XR6tU2QIT8x9b1wIZ1qNW5hW9CZZzUj7wx9oJUSBst1nQ/lcoGgBKbW/WbsuzVvUs
	 j0ta13sbG30AgTsK5rV3ERWmt93wL86KbpwWHnttnkas9Jsk8eiCefrPm8xHxVH7On
	 KEuu4Meef+oEMNp8Ht2e1/lnAHTXHGVU578a2Drxj1wFg8t66HOWLbxaiZAKEQ/IbY
	 qbuyFzLRrB1Ybq41wXXUvhd6Rx8q3JDs8OkYw4YhnCncHMtQSfb4vr9RvUmU2kECP7
	 eSR2BPwoBR3H/PMBbJO78qnUH7sxmvsHKx1Alf51w9IbQtTc2mZP/R4cTNCm9bYJRw
	 PP42ycMZvw6ug==
Date: Sun, 9 Nov 2025 12:12:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <20251109121259.4e4c1f3f@jic23-huawei>
In-Reply-To: <aQklBYl2drPil69Y@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
	<3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
	<20251027140423.61d96e88@jic23-huawei>
	<aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
	<ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
	<aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
	<1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
	<c365b17c-de18-4718-8d51-fa1d93236d90@baylibre.com>
	<aQklBYl2drPil69Y@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 18:56:21 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/03, David Lechner wrote:
> > On 11/3/25 8:30 AM, Nuno S=C3=A1 wrote: =20
> > > On Mon, 2025-11-03 at 10:22 -0300, Marcelo Schmitt wrote: =20
> > >> On 10/30, Nuno S=C3=A1 wrote: =20
> > >>> On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote: =20
> > >>>> On 10/27, Jonathan Cameron wrote: =20
> > >>>>> On Mon, 20 Oct 2025 16:15:39 -0300
> > >>>>> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> > >>>>> =20
> > >>>>>> AD4030 and similar devices can read common-mode voltage together=
 with
> > >>>>>> ADC sample data. When enabled, common-mode voltage data is provi=
ded in a
> > >>>>>> separate IIO channel since it measures something other than the =
primary
> > >>>>>> ADC input signal and requires separate scaling to convert to vol=
tage
> > >>>>>> units. The initial SPI offload support patch for AD4030 only pro=
vided
> > >>>>>> differential channels. Now, extend the AD4030 driver to also pro=
vide
> > >>>>>> common-mode IIO channels when setup with SPI offloading capabili=
ty.
> > >>>>>>
> > >>>>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >>>>>> ---
> > >>>>>> New patch.
> > >>>>>> I hope this works for ADCs with two channels. It's not clear if =
works as
> > >>>>>> expected with current HDL and single-channel ADCs (like ADAQ4216=
).
> > >>>>>>
> > >>>>>> The ad4630_fmc HDL project was designed for ADCs with two channe=
ls and
> > >>>>>> always streams two data channels to DMA (even when the ADC has o=
nly one
> > >>>>>> physical channel). Though, if the ADC has only one physical chan=
nel, the
> > >>>>>> data that would come from the second ADC channel comes in as noi=
se and
> > >>>>>> would have to be discarded. Because of that, when using single-c=
hannel
> > >>>>>> ADCs, the ADC driver would need to use a special DMA buffer to f=
ilter out
> > >>>>>> half of the data that reaches DMA memory. With that, the ADC sam=
ple data
> > >>>>>> could be delivered to user space without any noise being added t=
o the IIO
> > >>>>>> buffer. I have implemented a prototype of such specialized buffer
> > >>>>>> (industrialio-buffer-dmaengine-filtered), but it is awful and on=
ly worked
> > >>>>>> with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux t=
ree). Usual
> > >>>>>> differential channel data is also affected by the extra 0xFFFFFF=
FF data
> > >>>>>> pushed to DMA. Though, for the differential channel, it's easier=
 to see it
> > >>>>>> shall work for two-channel ADCs (the sine wave appears "filled" =
in
> > >>>>>> iio-oscilloscope).
> > >>>>>>
> > >>>>>> So, I sign this, but don't guarantee it to work. =20
> > >>>>>
> > >>>>> So what's the path to resolve this?=C2=A0 Waiting on HDL changes =
or not support
> > >>>>> those devices until we have a clean solution? =20
> > >>>>
> > >>>> Waiting for HDL to get updated I'd say. =20
> > >>>
> > >>> Agree. We kind of control the IP here so why should we do awful tri=
cks in
> > >>> SW right :)? At the very least I would expect hdl to be capable to =
discard the
> > >>> data in HW.
> > >>> =20
> > >>>> =20
> > >>>>>
> > >>>>> Also, just to check, is this only an issue with the additional st=
uff this
> > >>>>> patch adds or do we have a problem with SPI offload in general (+=
 this
> > >>>>> IP) and those single channel devices? =20
> > >>>>
> > >>>> IMO, one solution would be to update the HDL project for AD4630 an=
d similar ADCs
> > >>>> to not send data from channel 2 to DMA memory when single-channel =
ADCs are
> > >>>> connected. Another possibility would be to intercept and filter ou=
t the extra
> > >>>> data before pushing it to user space. My first attempt of doing th=
at didn't
> > >>>> work out with upstream kernel but I may revisit that. =20
> > >>>
> > >>> I'm also confused. Is this also an issue with the current series wi=
thout common mode?
> > >>>
> > >>> If I'm getting things right, one channel ADCs pretty much do not wo=
rk right now with
> > >>> spi offload? =20
> > >>
> > >> Yes, that's correct. It kind of works for single-channel ADCs, but h=
alf of the
> > >> data we see in user space is valid and the other half is not. For tw=
o-channel
> > >> ADCs, everything should be fine. =20
> > >=20
> > > To me that is something that does not work eheheh :). =20
> Well, yeah, I tend to agree with that =F0=9F=98=85
>=20
> > > I mean, going with all this trouble
> > > to sample as fast as we can just so we have to discard (or mask out) =
half of every sample
> > > in userspace (even though I can imagine we still get better performan=
ce vs non offload case). =20
> >=20
> > If we are getting extra data to userspace, then either we aren't creati=
ng the
> > SPI message correctly and telling the controller to read too much data =
or
> > the HDL is broken. =20
>=20
> The current patch set version (v6) only asks for the amount of ADC precis=
ion
> bits in each transfer when offloading messages. I can't see how that woul=
d work
> but okay, I'll test it with smaller xfer length.
>=20
> >  =20
> > >  =20
> > >> =20
> > >>>
> > >>> If the above is correct I would just not support it for 1 channel A=
DCs. =20
> > >>
> > >> Currently, it's just one part that is single-channel (AD4030). If pa=
tches 6 and
> > >> 7 were accepted, it would be 3 single-channel parts supported. I can=
 add an `if`
> > >> somewhere to check the number of channel, but it will eventually hav=
e to be
> > >> removed when HDL gets fixed. =20
> > >=20
> > > I would probably do the above or maybe we just need to push for an hd=
l fix or some
> > > final conclusion (like if they cannot fix it for some reason) and act=
 accordingly.
> > >  =20
> > >>
> > >> Or, if HDL can't be fixed, then we'll need the `if` now and somethin=
g else
> > >> latter to filter out extra data before pushing to IIO buffers as men=
tioned
> > >> above. Though, this scenario seems odd to me as I think the HDL woul=
dn't be 100%
> > >> compatible with single-channel AD4030-like parts. We would be writin=
g code to
> > >> support AD4030 _and_ a peculiar data stream from this specific HDL p=
roject?
> > >>
> > >> My suggestion is to apply all patches except patch 8. IMHO, SPI offl=
oad
> > >> single-channel ADC support is broken due to HDL IP data stream not b=
eing
> > >> compatible with single-channel parts. That's not a Linux driver issu=
e. =20
> > >=20
> > > Well, it's not a SW issue but we are driving the HW and we know it's =
broken so I
> > > don't see a point in having something that does not work. Given that =
this is so
> > > connected to the HDL part of it I'm not sure it's fine to ignore that=
 offload does
> > > not work for 1 channel parts.=20
> > >=20
> > > Anyways, it's odd to me but ultimately if Jonathan is fine with it, I=
 won't object :)
> > >=20
> > >=20
> > > - Nuno S=C3=A1 =20
> >=20
> > If single-channel parts currently don't work and two-channel parts need=
 [1] or
> > a hardware descrambler to work with a single data line, then it sounds =
like we
> > are blocked here until the HDL is improved or [1] is merged.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/20251014-spi-add-multi-bus-suppo=
rt-v1-0-2098c12d6f5f@baylibre.com/ =20
>=20
> Ack, I think so.

OK.  So let me know (send a new version) when we have something we can move=
 forwards with.

Looks to me like we should rule out single channel parts + spi offload for =
now.
I'll take a look at [1] later today.

Jonathan





