Return-Path: <linux-iio+bounces-24974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A718BD0647
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17AA1892926
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C828726A;
	Sun, 12 Oct 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdESWMMo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E81DE4CD;
	Sun, 12 Oct 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760283309; cv=none; b=RnUh6bqw0DdBmMlNHG5aGamVCdQEL/7qvy3AFgeFfBk0zci4KXieOAKhhf6DMssZUXZ0pWfn3eyOvYxo5BcFZPlAK9EI1SBg73f05FAqtNCiKSqf3Q2FFspyQaIsH6uUJj2HHtZ5sSvZWJ5LmpBdZi3U+h0khO2z4jfmTcqU/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760283309; c=relaxed/simple;
	bh=jkzRyD0M+rX8FkE1Fy5xESx0UidGLH1V50DYjgtANNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSvFmhQDK17NhGS1tcT/y87NFbn6NYjoG701aUQBe17i+uvbfx8jyu9y451vltGeKVWMo0XRkYYK6gjf/+Me2HCfdzpXqjs4yrVB/T0IhzSxryloDWDGmeFB9XNPm0m0ysZj4wxfe2363IeqbBDhGcOROEVRIbTn53iOsbbG114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdESWMMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC8C4CEE7;
	Sun, 12 Oct 2025 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760283307;
	bh=jkzRyD0M+rX8FkE1Fy5xESx0UidGLH1V50DYjgtANNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mdESWMMoARpIYYflnu8I1//THTR6vxdrHpz0FtVoQXx+gP8wAJHxaRXX/bvOe7uQT
	 moAcepFjJVXu98lrCJhAmLl8mH4sdp7wFH0abEGndyXEwkT4x9T/zMvcHknaRyhnxy
	 YAU26S9UKvjpz3VRMXB1QuAq6KZ5N10eWogef5A0w7cM9Eb4nQYkHEF+XEcGVqCdKl
	 eI4QABqT8c7kXmANlPvgBvCiH2V7RLRRtB4qsiQUdoxI71bBWaOB5i4urkVbK6LUNi
	 6tm80LVW7ea/2y0DdJGmaiWtK3Ah2bc8wZHX/Dn4pVH3ZJ5Sj+TScoW4g4ebG+nqiI
	 B2a8q45G2xTGQ==
Date: Sun, 12 Oct 2025 16:34:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
Message-ID: <20251012163459.4fa71c50@jic23-huawei>
In-Reply-To: <b49f3216d1ba1925f19d78b5f6c38126b7473d76.camel@gmail.com>
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
	<7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
	<2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
	<118c3551-df86-4c23-b385-6f75d9bd5388@baylibre.com>
	<b49f3216d1ba1925f19d78b5f6c38126b7473d76.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Oct 2025 09:25:19 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-10-06 at 11:44 -0500, David Lechner wrote:
> > On 10/6/25 11:25 AM, Nuno S=C3=A1 wrote: =20
> > > On Mon, 2025-10-06 at 11:18 -0500, David Lechner wrote: =20
> > > > On 10/6/25 11:06 AM, Nuno S=C3=A1 via B4 Relay wrote: =20
> > > > > This series fixes an issue with DMABUF support in the IIO subsyst=
em
> > > > > where
> > > > > the wrong DMA device could be used for buffer mapping operations.=
 This
> > > > > becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale whe=
re
> > > > > memory
> > > > > can be mapped above the 32-bit address range.
> > > > >=20
> > > > > Problem:
> > > > > --------
> > > > > The current IIO DMABUF implementation assumes it can use the pare=
nt
> > > > > device
> > > > > of the IIO device for DMA operations. However, this device may no=
t have
> > > > > the appropriate DMA mask configuration for accessing high memory
> > > > > addresses.
> > > > > On systems where memory is mapped above 32-bits, this leads to th=
e use
> > > > > of
> > > > > bounce buffers through swiotlb, significantly impacting performan=
ce.
> > > > >=20
> > > > > Solution:
> > > > > ---------
> > > > > This series introduces a new .get_dma_dev() callback in the buffer
> > > > > access
> > > > > functions that allows buffer implementations to specify the corre=
ct DMA
> > > > > device that should be used for DMABUF operations. The DMA buffer
> > > > > infrastructure implements this callback to return the device that
> > > > > actually
> > > > > owns the DMA channel, ensuring proper memory mapping without boun=
ce
> > > > > buffers.
> > > > >=20
> > > > > Changes:
> > > > > --------
> > > > > 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and upd=
ate
> > > > > core
> > > > > =C2=A0=C2=A0 DMABUF code to use it when available
> > > > > 2. Implement the callback in the DMA buffer infrastructure
> > > > > 3. Wire up the callback in the dmaengine buffer implementation
> > > > >=20
> > > > > This ensures that DMABUF operations use the device with the corre=
ct DMA
> > > > > configuration, eliminating unnecessary bounce buffer usage and im=
proving
> > > > > performance on high-memory systems.
> > > > >=20
> > > > > (AI generated cover. I would not be this formal but I guess is not
> > > > > that bad :))
> > > > >=20
> > > > > ---
> > > > > Changes in v2:
> > > > > - Dropped Fixes tags on the first two patches and Cc stable them =
instead
> > > > > =C2=A0 (as prerequisites for the third patch).=20
> > > > > - Link to v1:
> > > > > https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-=
v1-0-c1c9945029d0@analog.com =20
> > > >=20
> > > > Did you not care for my other suggestions in v1? =20
> > >=20
> > > Completely missed them, sorry! I kind of stop reading in the stable s=
tuff.

On that 'stable' stuff I'm very unclear on the logic for +CC a dependency to
stable@vger.kernel.org =20

The +CC is IIUC the thing that gets a patch queued rather than the fixes
tag and if you don't provide a fixes tag assumption is that it goes back as=
 far
as it can be applied.   That concerns me as they could therefore get pushed
back further than the thing dependent on them.
Ah well. I guess they do some magic stuff on series though as the
stable-rules.rst calls out the case you have here.

So applied as is but I marked the final patch for stable. Would have have
been a weird situation if I decided not to do that for some reason.

Applied to the fixes-togreg branch of iio.git.  That has a weird mid merge =
window
base at the moment so I'll rebase on rc1 once available and push out at tha=
t point.

Jonathan



> > > I'm
> > > ok with the helper function. For the clarification I feel it's redund=
ant.
> > > The =20
> >=20
> > I was thinking extra clarification could be helpful for someone new to =
the IIO
> > subsystem. But it would be quite rare to add a new buffer implementation
> > anyway.
> > So probably not too many people would actually ever read it. :-) =20
>=20
> I mean, it does not harm. If you want to add it, I'll hack it (as I feel =
it
> should be a separate patch also covering the other .ops related to DMA bu=
ffers).
>=20
> >  =20
> > > field is called .get_dma_dev() and the description "called to get the=
 DMA
> > > channel associated with this buffer" already implies is for DMA buffe=
r. Same
> > > as
> > > ops like .enqueue_dmabuf().
> > >=20
> > > - Nuno S=C3=A1 =20
> >=20
> > I don't feel too strongly about either change, so either way,
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> >  =20
>=20
> Thx!
>=20
> - Nuno S=C3=A1


