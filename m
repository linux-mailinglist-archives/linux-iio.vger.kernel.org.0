Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCD245709
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgHPJSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgHPJSt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:18:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8444B2067C;
        Sun, 16 Aug 2020 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597569529;
        bh=9a6w3KyO0awE4sodC5lUb5Pq0ywGpwzaZMqWwAtg0PA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8mZ8zCx/oKLRz9or6KrIx/B6sE4g/z26lkb7+NRAR9Tig8NdjsQ/iJePiZA4xEu6
         h7OwuZOC8L29o+776S/pCwlr/MlcUjbFZmp4tmOYZ0k/lhysVRuh4bu1yCwseg8CZJ
         JE2PCGnMjzvuk/dq/ruUI9fneF0eOohE+JjlcTb0=
Date:   Sun, 16 Aug 2020 10:18:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: documentation: light: Add as73211 sysfs
 documentation
Message-ID: <20200816101844.79e1c5c5@archlinux>
In-Reply-To: <2320252.sbR73lAtI7@n95hx1g2>
References: <20200808171443.114c8e05@archlinux>
        <4688751.agSyimv0uN@n95hx1g2>
        <20200810123540.sdzbtpgwkyqjg6ag@duo.ucw.cz>
        <2320252.sbR73lAtI7@n95hx1g2>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 15:24:39 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Hi Pavel,
>=20
> On Monday, 10 August 2020, 14:35:40 CEST, Pavel Machek wrote:
> > On Mon 2020-08-10 11:57:46, Christian Eggers wrote: =20
> > > On Monday, 10 August 2020, 11:00:54 CEST, Pavel Machek wrote: =20
> > > > Hi!
> > > > =20
> > > > > The driver for the as73211 light sensor provides the following no=
t yet
> > > > > documented sysfs entries:
> > > > > - in_intensity_(x|y|z)_raw
> > > > > - in_intensity_(x|y|z)_scale
> > > > > - in_intensity_sampling_frequency(_available)
> > > > > - in_intensity_hardwaregain(_available) =20
> > > >
> > > > Should that be hardware_gain ? =20
> > >
> > > drivers/iio/industrialio-core.c:
> > > [IIO_CHAN_INFO_HARDWAREGAIN] =3D "hardwaregain", =20
> >
> > Yep. Fix that before people start to really use it. =20
> it's too late! IIO_CHAN_INFO_HARDWAREGAIN was introduced back in 2012. My
> patch only adds "hardwaregain" in a new context (of "intensity").

Why do you think that is broken?

It was a deliberate decision to try and stop putting _'s into new
elements because it was making userspace parsing harder.  hardwaregain
is a single 'token' in that file name.

We are stuck with some older forms that predate that decision
and a few that are closely related to existing elements and hence
had to maintain the 'spacing'.  Those have to be special cased
in tokenizing code. We don't want to introduced any more though.

One or two may have snuck through when we weren't awake of course.

Jonathan

>=20
> > =20
>         Pavel
>=20
> regards
> Christian
>=20
>=20
>=20
>=20
> ________________________________
>  [http://assets.arri.com/media/sign/2020-04-03-E-mail-signature-Stellar2_=
V1.jpg] <https://microsites.arri.com/stellar/>
>=20
> Get all the latest information from www.arri.com<https://www.arri.com/>, =
Facebook<https://www.facebook.com/TeamARRI>, Twitter<https://twitter.com/AR=
RIChannel>, Instagram<https://instagram.com/arri> and YouTube<https://www.y=
outube.com/user/ARRIChannel>.
>=20
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Michael Neuh=C3=A4user; Stephan Schenk; Wa=
lter Trauninger; Markus Zeiler

