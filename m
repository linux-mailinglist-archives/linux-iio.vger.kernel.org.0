Return-Path: <linux-iio+bounces-16036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42395A4352E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 07:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B5176EB3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F670256C99;
	Tue, 25 Feb 2025 06:25:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE67256C77
	for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464748; cv=none; b=maMSfI79Fb/c6h/3/bjo7FE10L4qtNXhmOkFO1J+zHauEFdaDkx13fP1UctVBur55l5JpFtyEYuGR9fc8oANT4jJcC/YQiXcpYuEBiWZZgqU50yPnuAqnxpbMUEKPt+RwxUBLwB/3qJTRidHUS7uaDTyLdLorS9JwZE1o+mDomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464748; c=relaxed/simple;
	bh=sOERsQJpKNlU6Dc+GKJlbaSelDPRyxIXAbYpNT9cdFY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiQLGt2Drr4QXEa7Ur4KfQgUdY1ov72O1RRqjp6OdFqSR2Zi3F5EJ3bDMT/UpFP6WLA4P+9a/JYzsqPZ6+ssoNkU2/mqNoMOZf2I3SmqPySZpLbW3NkS+fZoikGUklkBLYo22vVc8yt40G3aVG/to3/8sCDaLxOQQ+yDiAPkJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z26vY5svZz6L53g;
	Tue, 25 Feb 2025 14:22:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AE86140B35;
	Tue, 25 Feb 2025 14:25:42 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 25 Feb
 2025 07:25:37 +0100
Date: Tue, 25 Feb 2025 06:25:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Mudit
 Sharma" <muditsharma.info@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>, "Angelo Dureghello"
	<adureghello@baylibre.com>, Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa
	<nuno.sa@analog.com>, =?ISO-8859-1?Q?Jo?= =?ISO-8859-1?Q?=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?= <joao.goncalves@toradex.com>, ChiYuan Huang
	<cy_huang@richtek.com>, "Ramona Alexandra Nechita"
	<ramona.nechita@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>, "David Lechner"
	<dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250225062532.0000475e@huawei.com>
In-Reply-To: <CAHp75Vf_XPSvTOH_zvfndghjy+bM_6hr=z2JAcE8AYh415SPWw@mail.gmail.com>
References: <20250209180624.701140-1-jic23@kernel.org>
	<20250209180624.701140-2-jic23@kernel.org>
	<Z7nyQgjZ36zkO8oD@surfacebook.localdomain>
	<20250222172357.05378fd4@jic23-huawei>
	<CAHp75Vf_XPSvTOH_zvfndghjy+bM_6hr=z2JAcE8AYh415SPWw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 22 Feb 2025 22:58:00 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Feb 22, 2025 at 7:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > On Sat, 22 Feb 2025 17:51:02 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > Sun, Feb 09, 2025 at 06:05:58PM +0000, Jonathan Cameron kirjoitti: =20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Initial thought was to do something similar to __cond_lock()
> > > >
> > > >     do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_d=
ev); 0; })
> > > > + Appropriate static inline iio_device_release_direct_mode()
> > > >
> > > > However with that, sparse generates false positives. E.g.
> > > >
> > > > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: cont=
ext imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
> > > >
> > > > So instead, this patch rethinks the return type and makes it more
> > > > 'conditional lock like' (which is part of what is going on under th=
e hood
> > > > anyway) and return a boolean - true for successfully acquired, fals=
e for
> > > > did not acquire.
> > > >
> > > > To allow a migration path given the rework is now non trivial, take=
 a leaf
> > > > out of the naming of the conditional guard we currently have for IIO
> > > > device direct mode and drop the _mode postfix from the new function=
s giving
> > > > iio_device_claim_direct() and iio_device_release_direct()
> > > >
> > > > Whilst the kernel supports __cond_acquires() upstream sparse does n=
ot
> > > > yet do so.  Hence rely on sparse expanding a static inline wrapper
> > > > to explicitly see whether __acquire() is called.
> > > >
> > > > Note that even with the solution here, sparse sometimes gives false
> > > > positives. However in the few cases seen they were complex code
> > > > structures that benefited from simplification anyway. =20
>=20
> ...
>=20
> > > > +/*
> > > > + * Helper functions that allow claim and release of direct mode
> > > > + * in a fashion that doesn't generate many false positives from sp=
arse.
> > > > + * Note this must remain static inline in the header so that sparse
> > > > + * can see the __acquire() marking. Revisit when sparse supports
> > > > + * __cond_acquires()
> > > > + */
> > > > +static inline bool iio_device_claim_direct(struct iio_dev *indio_d=
ev)
> > > > +{
> > > > +   int ret =3D iio_device_claim_direct_mode(indio_dev);
> > > > +
> > > > +   if (ret)
> > > > +           return false;
> > > > +
> > > > +   __acquire(iio_dev);
> > > > +
> > > > +   return true; =20
> > >
> > > While I understand the intention, I dislike the function return boole=
an and
> > > hide the actual error code, it calls user to misuse and replace boole=
an false
> > > by arbitrary error codes.
> > >
> > > Can we rather return an error code, please?
> > > (as a side effect it reduces the churn in the followup changes)
> > > =20
> > Hi Andy,
> >
> > I tried - see above.  It plays badly with sparse which is the whole poi=
nt of
> > this exercise. Note that iio_device_claim_direct_mode() only ever retur=
ns one
> > error code -EBUSY. So reality is it's a boolean and this is a lot close
> > to mutex_trylock() than anything else hence the switch to a boolean ret=
urn. =20
>=20
> Hmm... You mean that the following (still as a macro)
>=20
> static inline int ...
> {
>   int ret;
>   ...
>   if (ret)
>     return ret;
>=20
>   __acquire_lock(...);
>   return 0;
> }
>=20
> triggers the sparse warning?

Doing it in the ternary form of the same thing did trigger issues on fairly
simple cases. I don't recall if I tried this precise combination. The motiv=
ation
for this form originally being the __cond_acquires() markings (See later).
However, I 'think' based on other false positives including the smaller
set that required refactors to avoid triggering in this series, is that
sparse isn't coping well with more complex control flows.  So if we
assign a local integer variable and then check it, it seems to loose
track of what is going on in more cases than if we can do

	if (!trylock())
		return;

I'm not sure on what is going wrong.  However it seems sparse is effectively
unmaintained at the moment so even if we could rectify things without the
code upstream it gets us nowhere.  Hence my motivation to make this 'look
like' existing stuff sparse is checking. The nearest being trylock.
It makes me have more warm fuzzy feelings to be the same style of code
as the other cases using the same infrastructure, than doing something new.

Ideally sparse will eventually wake up again and we can have the __cond_acq=
uires()
markings that we had in v1 and not have to have the implementation in the
header. That currently requires trylock type boolean returns.

So overall I think this direction makes sense.  Also can't complain that it
saves 1 line of code for every instance and removes false pretense that
this thing returned a useful error code.

Jonathan
>=20
> > At the end of the full series (not yet posted) is a patch that gets rid
> > of their being any pretence this isn't a yes / no question and can
> > return other error values. This intermediate step does leave it looking
> > more confusing.
> >
> > Churn wise if we'd been able to do keep the error return and make sparse
> > work I could have just applied this to the original functions and made
> > no changes at all to the vast majority of drivers.  Sadly that wasn't
> > to be. End result of ending up with a trylock type approach is cleaner
> > and more compact even if it's not what we have gotten used to for this
> > particular function. =20
>=20
> > > > +} =20
>=20


