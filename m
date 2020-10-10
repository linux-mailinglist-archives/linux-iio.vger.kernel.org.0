Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6751028A265
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbgJJW5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbgJJTw1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5B522269;
        Sat, 10 Oct 2020 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602336193;
        bh=tsItA3pElC//qPODcXqOgY+/byplFVyOP8JJ7uQOeV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+n2DE/uLh+3p/+8c+RIZe4V2dRKPD4uJaxbSZV9k44sZGWRIUdnQYr1CJHfGzo4S
         LTe5ctoybBRJl/ckKo5cPqYxCbZ+lo3fIgC6IP+k3s7NFVYEztsla7VzU41ipTPHXO
         +SUdyA+Bke2ydalJD8Al+Z9pbQwumPj40x9YxHCs=
Date:   Sat, 10 Oct 2020 14:23:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20201010142307.72a15451@archlinux>
In-Reply-To: <1672856.66Rh2xUnMN@n95hx1g2>
References: <20200813075358.13310-1-lars@metafoo.de>
        <5007153.c9bsiqU2ZW@n95hx1g2>
        <20200921105703.000048b3@Huawei.com>
        <1672856.66Rh2xUnMN@n95hx1g2>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Oct 2020 16:10:09 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Hi Jonathan,

Lars-Peter's patch! But I'm sure he'll do an updated version to deal
with the point you make below.

@Lars no great hurry as this isn't going to make the merge window
anyway so we have a couple of weeks. Will have to hit after rc1 and
get backported as relevant.

Thanks,

Jonathan

>=20
> On Monday, 21 September 2020, 11:57:03 CEST, Jonathan Cameron wrote:
> > On Mon, 21 Sep 2020 09:17:26 +0200
> >
> > Christian Eggers <ceggers@arri.de> wrote: =20
> > > Tested together with
> > >
> > > - iio: Fix: Do not poll the driver again if try_reenable() callback
> > > returns non 0. and
> > > - iio:trigger: rename try_reenable() to reenable() plus return void
> > >
> > > on latest mainline (without PREEMPT_RT). The original WARN_ONCE() in
> > > kernel/irq/handle.c:159 was not raised anymore. But even without the
> > > current patches, this warning is not shown (as this problem only appl=
ies
> > > to -RT).
> > >
> > > Currently I haven't ported a RT kernel > 5.4 for my board, so I cannot
> > > check with current RT. On 5.4. there the patches seem not to work ful=
ly
> > > as kernel/timer/hrtimer.c is not up to date enough.
> > >
> > > Sorry for being not very helpful... =20
> >
> > Thanks for at least trying! =20
>=20
> I've just ported my BSP to v5.9-rc7-rt10. It looks like your patch misses=
 one
> additional change in iio_trig_hrtimer_set_state():
>=20
> -               hrtimer_start(&trig_info->timer, trig_info->period,
> -                             HRTIMER_MODE_REL);
> +               hrtimer_start(&trig_info->timer, trig_info->period,
> +                             HRTIMER_MODE_REL_HARD);
>=20
> Without this, WARN_ON_ONCE() in kernel/time/hrtimer.c:1133 will be hit:
>=20
> WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard);
>=20
> So the mode HRTIMER_MODE_REL_HARD is required for hrtimer_init() (will be
> stored in timer->is_hard) and for hrtimer_start().
>=20
> Best regards
> Christian
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

