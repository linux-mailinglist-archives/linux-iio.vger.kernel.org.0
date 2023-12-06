Return-Path: <linux-iio+bounces-669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEF80763E
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EA71C20BD4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752025E0C6;
	Wed,  6 Dec 2023 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGV6V4mJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE333DB80;
	Wed,  6 Dec 2023 17:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA0DC433C7;
	Wed,  6 Dec 2023 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701882931;
	bh=TWZ1PvW7WsY9XY5jYN+qaVdqjJkgESCw9MviqH1sYBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGV6V4mJFQX2x3YGSlq+x1KYAj6S4+h6e5vo7bjpEbX1F6AlgsWjSm+LJxZcm37G+
	 kLrI5g7wRdBb02GY0lOAuxnW+OsWrTar5jDylsFMTvKBRjlLLYMI9+SdWq1wz6B/HA
	 zT1S/kNthQtmnvqPz/3TE/mrlT+vnat8ZTOuQCJ8OOyCFt/OzdlWxCLXnIvfGnB/nu
	 T4w1gxDa++qDnAPQ9gIInnmLSDvQp382+3rMoSrxeaTeP3e+jiQ1byPsKebBINY8+y
	 HXRIoU0V9IkVIAUhxhgEvdaFOfqMeVRIchZeMgjQ4QHwu2MCUx92ETbG4V4Hx0fSz8
	 s/yP5yW/w56kw==
Date: Wed, 6 Dec 2023 17:15:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 03/12] iio: add the IIO backend framework
Message-ID: <20231206171521.4133569a@jic23-huawei>
In-Reply-To: <bba767835e775909c6b8a3334cceeb419afef4ca.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
	<20231204153855.71c9926f@jic23-huawei>
	<bba767835e775909c6b8a3334cceeb419afef4ca.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 06 Dec 2023 13:05:53 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-12-04 at 15:38 +0000, Jonathan Cameron wrote:
> > On Tue, 21 Nov 2023 11:20:16 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > This is a Framework to handle complex IIO aggregate devices.
> > >=20
> > > The typical architecture is to have one device as the frontend device=
 which
> > > can be "linked" against one or multiple backend devices. All the IIO =
and
> > > userspace interface is expected to be registers/managed by the fronte=
nd
> > > device which will callback into the backends when needed (to get/set
> > > some configuration that it does not directly control). =20
> >=20
> > As this is first place backend / frontend terminology used (I think), m=
ake
> > sure to give an example so people understand what sorts of IP / devices=
 thes
> > might be.
> >  =20
> > >=20
> > > The basic framework interface is pretty simple:
> > > =C2=A0- Backends should register themselves with @devm_iio_backend_re=
gister()
> > > =C2=A0- Frontend devices should get backends with @devm_iio_backend_g=
et()
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > Looks good to me in general.=C2=A0 I'll need to have a really close rea=
d though
> > before we merge this as there may be sticky corners! (hopefully not)
> >=20
> >=20
> > ...
> >  =20
> > > +static LIST_HEAD(iio_back_list);
> > > +static DEFINE_MUTEX(iio_back_lock);
> > > +
> > > +/*
> > > + * Helper macros to properly call backend ops. The main point for th=
ese macros
> > > + * is to properly lock the backend mutex on every call plus checking=
 if the
> > > + * backend device is still around (by looking at the *ops pointer). =
=20
> > If just checking if it is around rather thank looking for a bug, then
> > I'd suggest a lighter choice than WARN_ON_x=20
> >  =20
>=20
> Arguably, in here, removing a backend is the user doing something serious=
ly wrong so
> I see the splat with good eyes :D.
>=20
> That said, I'm fine in turning this into a pr_warn_once()...
>=20
> > Btw, there were some interesting discussions on lifetimes and consumer =
/ provider
> > models at plumbers. I think https://www.youtube.com/watch?v=3DbHaMMnIH6=
AM=C2=A0will be
> > the video.=C2=A0=C2=A0 Suggested the approach of not refcounting but in=
stead allowing for
> > a deliberate removal of access similar to your check on ops here (and t=
he one
> > we do in core IIO for similar purposes).=C2=A0 Sounded interesting but =
I've not
> > explored what it would really mean to switch to that model yet. =20
>=20
> Yes, interesting talk indeed. I have been following this issue for some t=
ime now.
> That's why I tried to be careful in the backend stuff (so we don't explod=
e if a
> backend is gone) even though is a much more simpler approach. But the tal=
k mentions
> three solutions and we kind of have both option C (the pointer stuff) and=
 option A
> (consumer removed on provicer unbind)
> in here. option A is being given through device links with the AUTO_REMOV=
E_CONSUMER
> flag.
>=20
> And the talk actually left me thinking on that (as it's discussed in ther=
e. In our
> simpler case (ADI ones), it does make sense to remove the consumer if the=
 provider is
> not there. But if we think in more advanced usecases (or maybe already in=
 the STM
> usecase) where we have a backend per data path. Does it make sense to com=
pletely
> "kill" the consumer if we remove one of the data paths? Starting to think=
 it
> doesn't...

There is a reasonably argument that partial tear down isn't a common case. =
So
may not be worth worrying about.

J
>=20
> - Nuno S=C3=A1
>=20


