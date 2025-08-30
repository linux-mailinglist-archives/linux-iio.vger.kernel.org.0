Return-Path: <linux-iio+bounces-23459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E0B3CB7D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297131B23402
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A7254864;
	Sat, 30 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3eYLKvq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21124678A;
	Sat, 30 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565168; cv=none; b=t+nC2WPfPssVuY7b5z1O68uSYE+bOdnJ/0UnI/C+ED7pUdTRZ1oAQ3juaIImlg1vDNPg+3uyyqZz1F0okZwrWBd8Y4EhUJ4VmumQWKuF8W6tQcjNpCEKRDRtle+izL73L3X+S27Ng3VeYpq7S8C2EzXL0yDNmeGak0lMjAzpNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565168; c=relaxed/simple;
	bh=q56rFoYPw+uzDNUWok+0CsPw8mUdDiBASbtSklGHAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/q442dNBEBm3OLXI8IXdu9mGBBHq02501xYUk8KXBMOnii2snmy7h4ECboIzsVu4Bn0KaKqYb4W/UAv2Tb/kh1ksQ+5bnJPGYR4nu5ZYCPiXtiaN/4DFRcBh6Eiio009Lt/ZctAIN976pebLnTJiIgDFUuGkhb4BPvYPOS3tuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3eYLKvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88113C4CEEB;
	Sat, 30 Aug 2025 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756565168;
	bh=q56rFoYPw+uzDNUWok+0CsPw8mUdDiBASbtSklGHAdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p3eYLKvqiRzY2zJ8PkaBU9LgrUhcPCgRsOGvSa78jgCoiDUz/TZqKj9pFUw64+Z9k
	 +V76ZCYzoE9I3t7gqrm6HGcfx6Yz9Tcb7Bv2PYEUzkYwU9nV967OI2Chdwof3sk3Z+
	 sJYW22lMHO/r5QuOVWBvvVsBshplhCsg/1hSjS64mdISktcTh66jg9laKCikmdHfF3
	 S6+GNjz4BGCVcAzkbP2BzYUJ6hyOhVVGMljrZX6mnm9ZsySOKdVyd/pz1VdQqaTRza
	 w5wmUGWmoi/NUM1IAur4v3WmMaZEVCaYFVx3tUigjxStaSq1n7kLu8tmZt9Zxeo0Pi
	 KLzRxT3KXMQYw==
Date: Sat, 30 Aug 2025 15:45:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime
 setup
Message-ID: <20250830154559.427969c6@jic23-huawei>
In-Reply-To: <6utm3ywkymr3hretvru7xkdv7p7p3wtmd62blfyapmgagr3pzc@42oiakgdxmqp>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
	<20250808-icm42pmreg-v2-1-a480279e7721@geanix.com>
	<CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
	<20250809190609.4fef9df7@jic23-huawei>
	<CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com>
	<yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
	<6utm3ywkymr3hretvru7xkdv7p7p3wtmd62blfyapmgagr3pzc@42oiakgdxmqp>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Aug 2025 15:14:15 +0000
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Aug 11, 2025 at 02:21:26PM +0100, Sean Nyekjaer wrote:
> > On Sat, Aug 09, 2025 at 10:27:52PM +0100, Andy Shevchenko wrote: =20
> > > On Sat, Aug 9, 2025 at 8:06=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > > > On Fri, 8 Aug 2025 23:37:51 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > > > On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix=
.com> wrote: =20
> > >=20
> > > ...
> > >  =20
> > > > > > +       struct device *dev =3D regmap_get_device(st->map);
> > > > > >
> > > > > > +       if (!pm_runtime_status_suspended(dev))
> > > > > > +               regulator_disable(st->vddio_supply); =20
> > > > >
> > > > > I would rather use positive conditional as it seems to me more sc=
alable =20
> > > >
> > > > To potentially save time when Sean looks at this.  I don't follow. =
Do you mean
> > > > something like
> > > >         if (pm_runtime_status_suspended(dev))
> > > >                 return;
> > > >
> > > >         regulator_disable(st->vddio_supply);
> > > >
> > > > ? =20
> > >=20
> > > Yes.
> > >  =20
> > > > If so I'm not seeing why we'd want this to scale as it's a single u=
se
> > > > devm_set_action_or_reset() callback doing just one thing. =20
> > >=20
> > > While I agree in _this_ case, in general the check and return
> > > immediately is more scalable for reading purposes, e.g., indentation
> > > will be one level less. Also it won't require additional churn in
> > > adding {, i.e. changing conditional line just for that.
> > >  =20
> >=20
> > I like the return early if pm_runtime_status_suspended() is true.
> >=20
> > Andy, when doing reviews please keep the function name, as it's much
> > easier to add the changes.
> >=20
> > Jonathan, do we think checking pm_runtime_status_suspended() is a viable
> > option? Should we ask on the linux-pm list?

Perhaps +CC linux-pm and Rafael on one of the patches and see if any replie=
s.
> >=20
> > If it's ok; I will patch:
> > drivers/iio/adc/ti-ads1100.c
> > drivers/iio/pressure/bmp280-core.c
> > drivers/iio/pressure/icp10100.c =20
>=20
> Hi Jonathan,
>=20
> Did you see my question here?

Indeed not. Wise to poke!

> Just ignore this if you are vacationing...
>=20
> /Sean
>=20
>=20


