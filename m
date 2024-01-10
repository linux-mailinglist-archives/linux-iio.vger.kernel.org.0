Return-Path: <linux-iio+bounces-1520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61075829615
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47411F25583
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C673D567;
	Wed, 10 Jan 2024 09:16:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C573C490;
	Wed, 10 Jan 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T92FD12DTz689J2;
	Wed, 10 Jan 2024 17:14:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AB6B140DFC;
	Wed, 10 Jan 2024 17:16:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 09:16:09 +0000
Date: Wed, 10 Jan 2024 09:16:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
Message-ID: <20240110091608.00003bfc@Huawei.com>
In-Reply-To: <8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-6-998e9148b692@analog.com>
	<20231221174437.5935a5c3@jic23-huawei>
	<f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
	<20231226155904.043fee13@jic23-huawei>
	<8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 09 Jan 2024 13:15:54 +0100
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-12-26 at 15:59 +0000, Jonathan Cameron wrote:
> >  =20
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0ret =3D devm_add_action_or_reset(dev, iio_b=
ackend_release, back);
> > > > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0link =3D device_link_add(dev, back->dev,
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER);
> > > > > +=A0=A0=A0=A0=A0=A0=A0if (!link)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_warn("%s: Could =
not link to supplier(%s)\n",
> > > > > dev_name(dev),
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0dev_name(back->dev));=A0  =20
> > > >=20
> > > > Why is that not an error and we try to carry on?=A0  =20
> > >=20
> > > I guess having the links are not really mandatory for the whole thing=
 to
> > > work (more
> > > like a nice to have). That's also how this is handled in another subs=
ystems
> > > so I
> > > figured it would be fine.
> > >=20
> > > But since you are speaking about this... After you pointing me to Bar=
tosz's
> > > talk and
> > > sawing it (as stuff like this is mentioned), I started to question th=
is. The
> > > goal
> > > with the above comment is that if you remove the backend, all the con=
sumers
> > > are
> > > automatically removed (unbound). Just not sure if that's what we alwa=
ys want
> > > (and we
> > > are already handling the situation where a backend goes away with -EN=
ODEV)
> > > as some
> > > frontends could still be useful without the backend (I guess that cou=
ld be
> > > plausible). I think for now we don't really have such usecases so the=
 links
> > > can make
> > > sense (and we can figure something like optionally creating these lin=
ks if
> > > we ever
> > > need too) but having your inputs on this will definitely be valuable.=
 =20
> >=20
> > I'm not keen on both trying to make everything tear down cleanly AND ma=
king
> > sure
> > it all works even if we don't. That just adds two code paths to test wh=
en
> > either
> > should be sufficient on its own.=A0 I don't really mind which.=A0 Barto=
sz's stuff =20
>=20
> Agreed...
>=20
> > is nice, but it may not be the right solution here.  =20
>=20
> There's pros and cons on both options...=A0
>=20
> For the device links the cons I see is that it depends on patch 3 for it =
to work
> (or some other approach if the one in that patch is not good) - not reall=
y a
> real con though :). The biggest concern is (possible) future uses where w=
e end
> up with cases where removing a backend is not really a "deal breaker". I =
could
> think of frontends that have multiple backends (one per data path) and re=
moving
> one backend would not tear the whole thing down (we would just have one n=
on
> functional data paths/port where the others are still ok).

I wouldn't waste time catering to such set ups.  If the whole thing gets
torn down because one element went away that should be fine.
To do anything else I'd want to see a real world use case.

>=20
> Olivier, for STM usecases, do we always need the backend? I mean, does it=
 make
> sense to always remove/unbind the frontend in case the backend is unbound?
>=20
> Maybe some of your usecases already "forces" us with a decision.=20
>=20
> The biggest pro I see is code simplicity. If we can assume the frontend c=
an
> never exist in case one of the backends is gone, we can:
>=20
>  * get rid of the sync mutex;
>  * get rid of the kref and bind the backend object lifetime to the backend
> device (using devm_kzalloc() instead of kzalloc + refcount.
>=20
> Basically, we would not need to care about syncing the backend existence =
with
> accessing it...
> To sum up, the device_links approach tends to be similar (not identical) =
to the
> previous approach using the component API.
>=20
> The biggest pro I see in Bartosz's stuff is flexibility. So it should jus=
t work
> in whatever future usecases we might have. I fear that going the device_l=
inks
> road we might end up needing this stuff anyways.

I'm keen on it if it simplifies code or becomes the dominant paradigm for s=
uch
things in the kernel (so becomes what people expect).  That isn't true yet
and I doubt it will be particularly soon.  If things head that way we can
revisit as it would enable things that currently we don't support - nothing
should break.

Jonathan


>=20
> Obviously, the biggest con is code complexity (not that bad though) as we=
 always
> need to properly sync any backend callback.
>=20
> - Nuno S=E1
> >  =20
>=20


