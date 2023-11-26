Return-Path: <linux-iio+bounces-402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BF7F9488
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F231C208C9
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C1DDD8;
	Sun, 26 Nov 2023 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCqUu2dF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C38C13
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 17:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36305C433C8;
	Sun, 26 Nov 2023 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701019156;
	bh=Hc0XtjIV2+pEzTvuPqxkkSiwVO4rqkQkLmDydqT5wbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCqUu2dFFj0kqIw2+vUkyftTbMLI1Yns0j6jXIdjSKpPBNSNZRE2eoZeMDFRZEDU1
	 I0WlY2swyXPMPAN9/2QK8Qq5ZYasOOrTdohcu+3qlltyAZEYtCjOOIRJoJbuowE/kw
	 WTa6olXc9v8WUQG4R6ZX6v12aA7wSHvHSOJBIKuLbd0TZakLMbtLQNr+RSjsDUsnDj
	 j4yyNnodNHxgwXMw2wluWqs6y8+uzCQQYZ+HOh7EwSRulcr2cIdnVmEzJfM6Id703u
	 G6jNQ0dtwOI0pYoKwXI+s4UpCxrBHnOjexIJIjgbvENpRWCdMiv/qHAVqzcwc73p2D
	 N0G2xTr8t61rg==
Date: Sun, 26 Nov 2023 17:19:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: triggered-buffer: prevent possible freeing of
 wrong buffer
Message-ID: <20231126171910.72124e81@jic23-huawei>
In-Reply-To: <CAMknhBEDp1baTDPrAfAv_gZ5o6LxNSt8bgS8wcGUmXdaCHq_Jw@mail.gmail.com>
References: <20231031210521.1661552-1-dlechner@baylibre.com>
	<3ea3d92db5c4c077a76b29dc5a89c4d491695752.camel@gmail.com>
	<CAMknhBEDp1baTDPrAfAv_gZ5o6LxNSt8bgS8wcGUmXdaCHq_Jw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Nov 2023 09:53:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Nov 2, 2023 at 3:59=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >
> > On Tue, 2023-10-31 at 16:05 -0500, David Lechner wrote: =20
> > > Commit ee708e6baacd ("iio: buffer: introduce support for attaching mo=
re
> > > IIO buffers") introduced support for multiple buffers per indio_dev b=
ut
> > > left indio_dev->buffer for a few legacy use cases.
> > >
> > > In the case of the triggered buffer, iio_triggered_buffer_cleanup()
> > > still assumes that indio_dev->buffer points to the buffer allocated by
> > > iio_triggered_buffer_setup_ext(). However, since
> > > iio_triggered_buffer_setup_ext() now calls iio_device_attach_buffer()
> > > to attach the buffer, indio_dev->buffer will only point to the buffer
> > > allocated by iio_device_attach_buffer() if it the first buffer attach=
ed.
> > >
> > > This adds a check to make sure that no other buffer has been attached
> > > yet to ensure that indio_dev->buffer will be assigned when
> > > iio_device_attach_buffer() is called.
> > >
> > > Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching mo=
re IIO
> > > buffers")
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >  drivers/iio/buffer/industrialio-triggered-buffer.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > index c7671b1f5ead..c06515987e7a 100644
> > > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > @@ -46,6 +46,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> > > *indio_dev,
> > >       struct iio_buffer *buffer;
> > >       int ret;
> > >
> > > +     /*
> > > +      * iio_triggered_buffer_cleanup() assumes that the buffer alloc=
ated
> > > here
> > > +      * is assigned to indio_dev->buffer but this is only the case i=
f this
> > > +      * function is the first caller to iio_device_attach_buffer(). =
If
> > > +      * indio_dev->buffer is already set then we can't proceed other=
wise
> > > the
> > > +      * cleanup function will try to free a buffer that was not allo=
cated
> > > here.
> > > +      */
> > > +     if (indio_dev->buffer)
> > > +             return -EADDRINUSE;
> > > + =20
> >
> > Hmmm, good catch! But I think this is just workarounding the real probl=
em =20
>=20
> Yes, I could have done a better job explaining my reason for this fix.
> It seemed like the simplest fix that could be easily backported to
> stable kernels. And then we can look at removing the legacy field
> completely in the future.
>=20
> > because like this, you can only have a triggered buffer by device. This=
 should
> > be fine as we don't really have any multi buffer user so far but ideall=
y it
> > should be possible.

So far multibufferred devices have always been for cases where triggers don=
't make
sense (devices with multiple hardware fifos that run out of step or where a=
 single
fifo is filled unevenly from different sensors, or big complex dma based de=
vices
where the trigger concept doesn't map at all.)

I agree that it sort of make sense to make the trigger per buffer, but in p=
ractice
I'm not sure on what sort of device will need it. Mind you, I guess you hit=
 this
in practice which rather implies something does!

> >
> > Long term we might want to think about moving 'pollfunc' to be a per bu=
ffer
> > thing. Not sure how much trouble that would be given that a trigger is =
also per
> > device and I don't know if it would make sense to have a trigger per bu=
ffer?!
> > Ideally, given the multi buffer concept, I would say it makes sense but=
 it might
> > be difficult to accomplish. So better to think about it only if there's=
 a real
> > usecase for it.
> >
> > On thing that I guess it could be done is to change the triggered API s=
o it
> > returns a buffer and so iio_triggered_buffer_cleanup() would also get a=
 pointer
> > to the buffer it allocated (similar to what DMA buffer's are doing). Bu=
t that's
> > indeed also bigger change... Bahh, I'm likely over complicating things =
for now. =20
>=20
> This sounds very much like the work I am doing on SPI Engine offload
> support - having a trigger associated with a buffer. So maybe
> something will come out of that. =C2=AF\_(=E3=83=84)_/=C2=AF

Ah. I guess if the trigger is being used to route things out of sight of so=
ftware that
might be a case where we do need multiple triggers per device...

Doesn't sound 'too' hard to make work and we'll end up with similar case to=
 buffers
where
iio_deviceX/current_trigger maps to the one for buffer0 so no ABI breakage,=
 just new
toys to play with.
>=20
> > Fell free to:
> >
> > Acked-by: Nuno Sa <nuno.sa@analog.com>
> >
> > =20
Applied with a note that we may revisit adding multiple triggers support in=
 future
but that is unlikely to be suitable for a backport as it's a new feature.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan



