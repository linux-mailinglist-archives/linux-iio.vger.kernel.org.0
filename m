Return-Path: <linux-iio+bounces-23941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7DB51D6F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84021164726
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC785327A3E;
	Wed, 10 Sep 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPN3958I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179E19C566;
	Wed, 10 Sep 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521302; cv=none; b=VAQI3MrH5yu6XpMT+xiYv4pxmPoxvejxLEbV33IDROAFscAVs0tdvkhrQHLlJSalgWjOcNr1rZx+MQdznvEJ24Mkq6uFrCJ8AqKmPQwdo5gi/9715I8LNQmF7sSPTothdwYFK+t5SqYSoGDs/IKGrUI9rxyxrs9c6wb0h4AmoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521302; c=relaxed/simple;
	bh=eiAEzvpITo3PUWaDegwuNzuA84tOaKEbvkrkixgxBVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV8T+Y1LAtR7u/G7vWH4BdRCs1QlBN7DIWzDB6gMdwhIC9KdKrXzSaMhHhTS4fN/b8o2vHlQFXjIkEGR0cegkFZ5kdXuEwAJ3n7oCFVvsUp+fpSztZ2f4zfnbi0KZvRb+MrSf057tGu6HcjuZijJy4Ejy7SoggsNvKfnwWaRRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPN3958I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB13C4CEEB;
	Wed, 10 Sep 2025 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521301;
	bh=eiAEzvpITo3PUWaDegwuNzuA84tOaKEbvkrkixgxBVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPN3958I9TvikLOPtgYVoP473dPJ7IEB0ehAsUh9fuggzr+d/HXd7QGe7Z3a98Ia0
	 5+Q3nqzMDa0mq1mLhVYdX7xFyHJXgwzaY4gDStCUCHxA500VO6LACW5xvqExmEvTVU
	 Sr9yjuWRKpszxYgSbfv9ND0O7LP2W9G1Ttbj6Q6Pewsdyq8GcS1lVsRgaFZ14BsOUn
	 h6IC3xBy63cxGzFRHRko4ovLcarNra6aqRxpY5WZRxpdIFWfhe3KyEhodekhjaBp75
	 MDak62uRskqZi2yIuO40R2AuO1w42c38n5K6bPNlJI/j/sf8LmdzBx+RZDOkfpc2LZ
	 Uf41mos4IVt7w==
Date: Wed, 10 Sep 2025 17:21:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, David Lechner	
 <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250910172136.29a4c4ab@jic23-huawei>
In-Reply-To: <5c82294b3a672225542926dee9f5fd18716383c4.camel@gmail.com>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
	<20250903102756.1748596-3-daniel.lezcano@linaro.org>
	<eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
	<0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
	<a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
	<edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
	<6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
	<23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
	<e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
	<fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
	<c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
	<c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com>
	<222acc86-c405-4e05-ac8c-520ba81ef0a0@linaro.org>
	<5c82294b3a672225542926dee9f5fd18716383c4.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 12:57:19 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-09-09 at 18:22 +0200, Daniel Lezcano wrote:
> > On 09/09/2025 11:29, Nuno S=C3=A1 wrote: =20
> > > Hi *Daniel* (sorry for that :)),
> > >=20
> > > On Mon, 2025-09-08 at 08:58 -0500, David Lechner wrote: =20
> > > > On 9/8/25 7:16 AM, Daniel Lezcano wrote: =20
> > > > > On 05/09/2025 23:54, David Lechner wrote: =20
> > > > > > On 9/5/25 3:58 PM, Daniel Lezcano wrote: =20
> > > > > > > On 05/09/2025 17:25, David Lechner wrote: =20
> > > > > > > > On 9/5/25 4:44 AM, Daniel Lezcano wrote: =20
> > > > > > > > > On 04/09/2025 19:49, David Lechner wrote: =20
> > > > > > > > > > On 9/4/25 12:40 PM, Daniel Lezcano wrote: =20
> > > > > > >=20
> > > > > > > [ ... ] =20
> >=20
> > [ ... ]
> >  =20
> > > > Unfortunately, not really. Until the last few years, there wasn't r=
eally
> > > > any users of these APIs. I added
> > > > devm_iio_dmaengine_buffer_setup_with_handle()
> > > > for the SPI offloading work I did recently. The only reason it had =
to be
> > > > added is because we needed to get the DMA handle from a different
> > > > devicetree
> > > > node from the ADC's node. Since this device has dmas and dma-names =
in
> > > > the devicetree, then if devm_iio_dmaengine_buffer_setup[_ext]() doe=
sn't
> > > > work
> > > > with that, then it might have other problems (assumptions made for a
> > > > specific
> > > > use case) than just not calling dma_slave_config().
> > > >=20
> > > > I think maybe Nuno and certainly I are guilty of trying to offer you
> > > > advice
> > > > without looking deeply enough into what you already submitted. :-/
> > > >  =20
> > >=20
> > > Yes, I pretty much just asked for (at least) some discussion about th=
is and
> > > see
> > > if we could use what we already have in IIO.
> > >  =20
> > > > I see now that what you are doing with the DMA looks more like othe=
r SoC
> > > > ADCs
> > > > (AT91/STM32/AM335x) which is quite different from how the
> > > > iio_dmaengine_buffer
> > > > stuff works, e.g. cyclic vs. not. So unless you are interested in e=
volving =20
> > >=20
> > > Supporting cyclic should be fairly easy (Paul left it almost prepared=
 for
> > > it)
> > > and do I have some patches already. I'm just waiting on having someth=
ing
> > > accepted on the ADI DMA IP driver (dmaengine) before sending the IIO =
patches
> > > I
> > > already have.
> > >  =20
> > > > the iio_dmaengine_buffer code to be more general to handle this cas=
e as
> > > > well,
> > > > it might not be the right tool for the job currently. =20
> > >=20
> > > I think for the STM (IIRC) case they "open" coded it because the IIO =
DMA
> > > support
> > > we had at the time (if any) was more "rudimentary" - (no real zero co=
py
> > > interface with userspace for example). But yeah, it seems there are s=
ome
> > > gaps
> > > for your usecase so as David said, you would need to be interested in
> > > evolving
> > > the IIO DMA API to accommodate your needs. Again, if nicely integrate=
d you
> > > would
> > > gain some nice "improvements" in performance (not having to use the f=
ileio
> > > interface for reading the buffers) for "free".
> > >=20
> > > As for dma_slave_config(), you're right and we have no usecase needin=
g that
> > > setup and TBH, I did not looked or have any idea (atm) on how to do i=
t. That
> > > said, I'll be here to help and contribute if you decide to try and fo=
llow
> > > the
> > > IIO DMA buffer API. =20
> >=20
> > I would be glad to help improving the IIO DMA but I don't have enough=20
> > bandwidth ATM. I was hoping to get this driver merged for v6.18 which i=
s=20
> > the next LTS AFAICT. Is it something possible by taking into account al=
l=20
> > the comments without improving the DMA code ?
> >  =20
>=20
> No personal problem with that. But ultimately that is up to Jonathan :)

I'm fine with a device doing DMA that isn't using the DMA buffer interface.
That is, basically what you have here. The only risk is walking ourselves
into a corner of having to maintain compatibility if later on the zero
copy performance is needed.

We can solve that, but today I don't recall us having any devices
offering both interfaces.

>=20
> > Do you have a pointer to Paul's series and the patches you mentioned=20
> > above ? I can give a try when having some spare time
> >=20
> >  =20
>=20
> Here is the DMABUF work from Paul [1]. But I do not think this is of much=
 use
> for you (as an in kernel consumer) but it is still interesting :).
>=20
> My own patches are in here [2] but you have out of tree "noise" in there =
[2]. At
> ADI tree we had some legacy "high speed" implementation that we're still
> supporting (eventually it will go away and we will sync completely with t=
he
> upstream solution). I was hopping for this [3] to land first before sendi=
ng the
> IIO bits but I'm having some issues with lack of bandwidth (I guess) from=
 the
> DMA maintainer. They are not really dependent on each other so I might se=
nd the
> IIO stuff soon enough.
>=20
> One last comment about dma_slave_config(). That should be easy to go arou=
nd with
> devm_iio_dmaengine_buffer_setup_with_handle(). I mean, we canl do all the=
 DMA
> chan request in the consumer driver (which would allow to easily call
> dma_slave_config() when needed) and pass the DMA handle to IIO with the A=
PI
> David introduced. In the future, given enough users, we could introduce an
> helper in the IIO code and it would be easy to "convert" the driver. Now,=
 if you
> do need to do something special in the DMA termination callback, we would
> definitely need to add the mechanism for that. In the ADI tree we do have=
 a way
> for a custom DMA submit operation [4] but we never had a proper upstreama=
ble
> user for it :(
>=20
> Anyways, just some thoughts if you or someone else ever have the time for=
 this
> :)
>=20
>=20
> [1]: https://lore.kernel.org/linux-iio/20240620122726.41232-1-paul@crapou=
illou.net/
> [2]: https://github.com/analogdevicesinc/linux/commit/a1f64e5e7927d1d96da=
08245cce35ba9e08a5f52
> [3]: https://lore.kernel.org/dmaengine/20250811-dev-axi-dmac-fixes-v1-0-8=
d9895f6003f@analog.com/
> [4]: https://github.com/analogdevicesinc/linux/blob/main/drivers/iio/buff=
er/industrialio-buffer-dma.c#L1214
>=20
> - Nuno S=C3=A1


