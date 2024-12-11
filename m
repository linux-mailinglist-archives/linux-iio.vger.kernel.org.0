Return-Path: <linux-iio+bounces-13340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209F9ED618
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2EF1653A3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3520A5DD;
	Wed, 11 Dec 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8kTmkzJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10332594B7;
	Wed, 11 Dec 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943339; cv=none; b=XIAz+9dxDuh/J6DcnBftkuJF023t6ElbULn71dSJCwPrM+qz9DKTsV8pvd85TN5QsoembdcRW5XFaKKVuadMAddVolGk+yPU2Ofgjmsr4u3/8H4f4fN0maGb2v4q0CwpD81u5WD1zLTWv5c+zmiyfi+gJBM4beUr640LZz7F6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943339; c=relaxed/simple;
	bh=J2jRrAud14RereDlpOYXUQ9nuI89TwVV1bsZj25HWTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbzoPCNPFcm70zR/w/KPKpoHE9IOHvL+hes7+7kzmNfBHP777x+fp+LGWweeWHGOQWDR6cN+cIHnXYpehW7uPOeT0scuwXv83bH/uPvgbJ8/IWfqbdkbq6B9kUq+mCZIFq0YRLqK19WmybVxydQtZ8aNNWg3wF8iyCT5N+LIpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8kTmkzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEBAC4CED2;
	Wed, 11 Dec 2024 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943339;
	bh=J2jRrAud14RereDlpOYXUQ9nuI89TwVV1bsZj25HWTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8kTmkzJH4GLWX9qrhW2FSJoOyxUigG59kSrgz63rKzMgqwEItghFeMbpVxnd6P0D
	 JJbB/ACOF8TXC0WJxCFHDiv6gQVm3Tb2BDz3o8A1LzNzApdFR/hencQGbIPTbwUB5n
	 xdXXrkS+0k2ygzkWqoKWBTeB+ezeUhDymOX+t+ePuLY6X2fyZ3d9pDht+iojgV7lpj
	 uPmkzEzr+daeNGr3DJ//naZA+W6r9qUkFQtBFfHiIn5zo4oYpljhG1HzBNjUQVhJ18
	 S2v8xOKg6zmwFKxnV6dkyVIRWUcovlW9rUrBubqS5QxUHrJ5JG57R8JGWKiFuOSwhK
	 4Aw1SYE0l+mig==
Date: Wed, 11 Dec 2024 18:55:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 03/10] iio: accel: adxl345: measure right-justified
Message-ID: <20241211185530.16abfb25@jic23-huawei>
In-Reply-To: <CAFXKEHbPmFc8DNZW=Ww39j+XkAfLOyFY2qgvz+uEUaBYri_3hA@mail.gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-4-l.rubusch@gmail.com>
	<20241208133458.4a8428b7@jic23-huawei>
	<CAFXKEHbPmFc8DNZW=Ww39j+XkAfLOyFY2qgvz+uEUaBYri_3hA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 23:18:45 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Dear IIO-ML, Hi Jonathan!
>=20
> On Sun, Dec 8, 2024 at 2:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu,  5 Dec 2024 17:13:36 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Make measurements right-justified, since it is the default for the
> > > driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> > > the data becomes right-judstified. This was the original setting, the=
re
> > > is no reason to change it to left-justified, where right-justified
> > > simplifies working on the registers.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > I'm still confused by this one.  Does this change affect the data output
> > to userspace?  If seems like it definitely should. If it does we have
> > an ABI regression somewhere. Is it currently broken and wasn't at some
> > earlier stage, or is this the patch breaking things? =20
>=20
> No, it should not affect the userspace.
>=20
> This setting opens the mask for regmap/update bits to allow for
> changing the data format.
> My point is rather, does it actually makes sense to allow to change
> the data format, since
> the driver will use just one format. The bit was never applied, it's
> just the mask here.
Ah.  Got it.

>=20
> May I ask you, if you could also could give me a brief feedback to the
> three questions in
> the cover letter to this series?
Reading cover letters? Never! :)
Thanks for the heads up. I tend to skip straight past them unless
I am looking for something specific... oops.

>=20
> I would really appreciate, since I'm still unsure if I actually
> verified everything correctly.
> From what I did about this bit, I removed and set the justified bit in
> STREAM and in
> BYPASSED mode (current mode), without any difference in the results in
> iio_info or
> iio_readdev. The numbers look generally odd to me, though. And, I'd
> rather like to ask
> to still wait with applying the patches, if this is ok for you? But,
> perhaps with the answers
> of the cover letter items, it could become clearer to me. I'm still
> about to measure and
> verify against the old and the input driver results as comparison.

I'd use the tools/iio tooling. It pretty prints channel data.  I suspect
there are tools in the set you are using that do that but I'm not the
person to ask.

Jonathan

>=20
> Best,
> L
>=20
>=20
> > If it worked and currently doesn't send a fix.  If this changes a previ=
ously
> > working ABI then drop this patch.  Alternative being to fix up the scale
> > handling to incorporate this justification change.
> >
> > Jonathan
> > =20
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 88df9547bd6..98ff37271f1 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap,
> > >       struct iio_dev *indio_dev;
> > >       u32 regval;
> > >       unsigned int data_format_mask =3D (ADXL345_DATA_FORMAT_RANGE |
> > > -                                      ADXL345_DATA_FORMAT_JUSTIFY |
> > >                                        ADXL345_DATA_FORMAT_FULL_RES |
> > >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > >       int ret; =20
> > =20


