Return-Path: <linux-iio+bounces-12691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60C9D9CCB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2502C1681B4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AC1DACBF;
	Tue, 26 Nov 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDk1Edz2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6480C02;
	Tue, 26 Nov 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643099; cv=none; b=A6MPKUimjrOa/uY/QQRiSOHNMRcfKohmU+y2xZMRCtqmzpsQHhDUT4pLYC1kBqAX8/3c1Mbg3MXbd+diuYzMyWs5cVLRHbVyhERl/M7FfHj81mza0sZ8obKgS6yZM4u+tg1OhI3wQgTP+n4wQV07KkF9j80kVDqH26IHjnViepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643099; c=relaxed/simple;
	bh=ZRjQTN090pSjajN8dRrfrXBdguDng5VtE1Oo8OqMlAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwZqzwTK3zgl+YBsLK2fa2rm3qhsCM6Pcl0mewSSf1dfYT4jjBHB+dWTmzYQwbeXeVutMboZA7cTL7a06D2gA7xMDzK3xydeCaHlJgG85kyfXu4TtICg6VU+R8WZcR9r8mXHNCeLodz85S16xTBMgIJKBtkHj+0iWNrwJpZ/m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDk1Edz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDB6C4CECF;
	Tue, 26 Nov 2024 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643099;
	bh=ZRjQTN090pSjajN8dRrfrXBdguDng5VtE1Oo8OqMlAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDk1Edz2zLxRR0ZRr0nLRoIyDDX/RebryZblI/FHRba27n8C66+A514PozXhGX5zI
	 u0YNfZCLcjuxQ2rBy+aQM6N2N0c53Mnmp6WAeeH6/wnSfcw0Ne8sw/nyZcAgPC8cRg
	 8A3O0RugZguwu0OS8rFgMKD4bL486hqBWCDtgGLVONYsiVr0oQUT5fnLLL80QdFpt6
	 7rKM40vVGwDP/21JTteYenuPAENDtsMVRUvJqZugyWlZUuww1rb7fzVg5fmtmUtFC1
	 l5gKrt2kNXDj2bbbCoAo0AvMwT8s25hA6s0rDD77I0X/CbPSju4qpJstyWc0l80mbw
	 blOGCkySb+hIg==
Date: Tue, 26 Nov 2024 17:44:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 05/22] iio: accel: adxl345: measure right-justified
Message-ID: <20241126174451.51580219@jic23-huawei>
In-Reply-To: <CAFXKEHZdp7cSnE8fj8y9ek0x6zev3Up918B-Ox=WS0bv9KhviA@mail.gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-6-l.rubusch@gmail.com>
	<20241124180733.2925eaa7@jic23-huawei>
	<CAFXKEHZdp7cSnE8fj8y9ek0x6zev3Up918B-Ox=WS0bv9KhviA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Nov 2024 14:51:19 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Dear IIO Mailing-List, Hi Jonathan!
>=20
> Thank you so much for the review. As you probably saw, most (all?) of
> my commits have a huge invisible question mark attached. Most of my
> questions you answered clearly. On particular topics I'd like to get
> back, though. Generally I will try to apply the requested changes to
> best of my understanding.
>=20
> On Sun, Nov 24, 2024 at 7:07=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 17 Nov 2024 18:26:34 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Make measurements right-justified, since it is the default for the
> > > driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> > > the data becomes right-judstified. This was the original setting, the=
re
> > > is no reason to change it to left-justified, where right-justified
> > > simplifies working on the registers. =20
> >
> > Surely this can't be changed independent of other changes as it will
> > change the format of the data we are processing?
> >
> > Each change must stand on it's own so that I can apply up to any
> > point in your patch set and have everything continue to work. =20
>=20
> This is probably not quite clear. Originally the driver was
> right-justified. One of my last commits
> (f68ebfe1501bf1110eebf5e968c4d9186cba8706) changed the driver to work
> with left-justified measurements. So, I feel changing the orginal
> behavior is wrong, and here I try to re-establish the original driver
> behavior.
>=20
> When looking at the datasheet right-justified data seems to be easier
> to handle, but I don't have any personal preference.
Ok.  I'm still a little confused. Can userspace see any result from either
the earlier patch or this one?

Jonathan

>=20
> Lothar
>=20
> [...]
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 2b62e79248..926e397678 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -184,8 +184,13 @@ int adxl345_core_probe(struct device *dev, struc=
t regmap *regmap,
> > >       struct adxl34x_state *st;
> > >       struct iio_dev *indio_dev;
> > >       u32 regval;
> > > +
> > > +     /* NB: ADXL345_DATA_FORMAT_JUSTIFY or 0: =20
> >         /*
> >          * NB: AD...
> >
> > is the multiline comment style all IIO drivers use (and most of the ker=
nel
> > except for networking.
> > =20
> > > +      * do right-justified: 0, then adjust resolution according to 1=
0-bit
> > > +      * through 13-bit in channel - this is the default behavior, an=
d can
> > > +      * be modified here by oring ADXL345_DATA_FORMAT_JUSTIFY
> > > +      */
> > >       unsigned int data_format_mask =3D (ADXL345_DATA_FORMAT_RANGE |
> > > -                                      ADXL345_DATA_FORMAT_JUSTIFY |
> > >                                        ADXL345_DATA_FORMAT_FULL_RES |
> > >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > >       int ret; =20
> > =20


