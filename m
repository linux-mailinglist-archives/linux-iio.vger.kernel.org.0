Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684C1D5543
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfJMIJ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 04:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfJMIJ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 04:09:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21512067B;
        Sun, 13 Oct 2019 08:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570954194;
        bh=FS1CQdso4mtzjmiBeLl9pnn0FZ2kEczaLJC+kd5LmPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rwUroo06rITX0o2xz6Sq06WT9ZGVUIeHXR8sTF6P3AL401NxEN6W85JWOCczq2YOM
         A1/ixcOWo+2m/GJKiCKXYC3WYvj7wx1OsTlGHrP7sSovtSz5hWkmFzUN09itzKmjVs
         JaGhmy2pGhzRY+XoKQcF2B//VQn5Pndc3cEv9Oi4=
Date:   Sun, 13 Oct 2019 09:09:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PULL v2] First set of iio new device support etc for the 5.5
 cycle
Message-ID: <20191013090950.1ac16994@archlinux>
In-Reply-To: <CA+U=DspmQcUZU3q-ntJEVaqtkkK=gk0GCCu06ntYf_kvnpnLZw@mail.gmail.com>
References: <20191012121946.051b646f@archlinux>
        <20191012152744.GA2142233@kroah.com>
        <20191012152841.GB2142233@kroah.com>
        <20191012170615.01546a96@archlinux>
        <CA+U=DspmQcUZU3q-ntJEVaqtkkK=gk0GCCu06ntYf_kvnpnLZw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 21:41:45 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, Oct 12, 2019 at 7:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 12 Oct 2019 17:28:41 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > =20
> > > On Sat, Oct 12, 2019 at 05:27:44PM +0200, Greg KH wrote: =20
> > > > On Sat, Oct 12, 2019 at 12:19:46PM +0100, Jonathan Cameron wrote: =
=20
> > > > > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee7=
67499f9655:
> > > > >
> > > > >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34=
:49 +0100)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git t=
ags/iio-for-5.5a-take2 =20
> > > >
> > > > Better, but I see this now:
> > > >
> > > > drivers/iio/imu/adis.c: In function =E2=80=98__adis_check_status=E2=
=80=99:
> > > > drivers/iio/imu/adis.c:295:9: warning: =E2=80=98status=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >   295 |  status &=3D adis->data->status_error_mask;
> > > >       |         ^~
> > > >
> > > >
> > > > I'll take this, can you just send a follow-on patch for this? =20
> > >
> > > Also I see:
> > >
> > > drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_enable_ir=
q=E2=80=99:
> > > drivers/iio/imu/adis16480.c:950:6: warning: =E2=80=98val=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   950 |  val &=3D ~ADIS16480_DRDY_EN_MSK;
> > >       |      ^~
> > >   CC [M]  drivers/iio/magnetometer/hmc5843_i2c.o
> > > drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_write_raw=
=E2=80=99:
> > > drivers/iio/imu/adis16480.c:571:7: warning: =E2=80=98val=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   571 |   val &=3D ~enable_mask;
> > >       |       ^~
> > > drivers/iio/imu/adis16480.c:557:11: note: =E2=80=98val=E2=80=99 was d=
eclared here
> > >   557 |  uint16_t val;
> > >       |           ^~~
> > >
> > >
> > > So did you really fix anything here?
> > >
> > > I'll drop this pull again.
> > >
> > > What version of gcc are you using?  Might I suggest a newer one (i.e.=
 a
> > > modern one?) =20
> >
> > Ah. This is my mistake.  I did see all of these, but still thought we w=
ere
> > in the category of tidying up some compiler version caused issues.
> >
> > The adis16400 came up in my local tests, so I previously pinged Alex on
> > basis it was something to do in a follow up. The other two showed up, b=
ut
> > again I still thought these were compiler version issues, particularly
> > as 0-day didn't highlight them (there were several other issues it
> > did highlight this week). Hence again I requested a follow up to tidy
> > it up.
> >
> > Anyhow, did some digging.  The issue here was a 'fix' I put in to an in=
itial
> > 0-day issue in the inline functions that Alex added.  Note that one
> > appears to be compiler version dependent as it didn't turn up in my
> > local builds. There are now inline functions that check if (ret)
> > and don't set the value if ret is non 0.
> >
> > Out in the drivers, the check is the more specific (unnecessarily)
> > if (ret < 0) and hence the compiler is concluded that there might be a =
path to
> > val not being set.  Previously it was giving up figuring this out.
> > So reality is they are a false positive (sort of as in reality ret
> > is never positive) but the compiler has made a reasonable point
> > that it can't see that.
> >
> > Never mind, I'll do a new pull request once fixes are in place.
> > Given there are two obvious ways of suppressing this and it's Alex's
> > driver I'll wait until he has time to take a look.
> >
> > Sorry for wasting your time.
> > =20
>=20
> If it helps, let's drop the ADIS patches for this round, and I can
> take a closer look as well.

Makes sense.   As I had queued a few other changes you sent
later on top of this series, I'll drop those for now as well
rather than trying to work out which ones have dependencies on this and
which don't.

So I'll drop all of:

iio: gyro: adis16260: replace mlock with ADIS lib's state_lock
iio: imu: adis: add a note better explaining state_lock
iio: imu: adis: update `adis_data` struct doc-string
iio: imu: adis: add doc-string for `adis` struct
iio: imu: adis16400: fix compiler warnings

+ original series
iio: imu: adis16480: use state lock for filter freq set=09
iio: gyro: adis16136: rework locks using ADIS library's state lock
iio: imu: adis16400: rework locks using ADIS library's state lock
iio: imu: adis: group single conversion under a single state lock
iio: imu: adis: protect initial startup routine with state lock
iio: imu: adis: create an unlocked version of adis_reset()
iio: imu: adis: create an unlocked version of adis_check_status()
iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq()
iio: imu: adis: add unlocked read/write function versions
iio: imu: adis: rename txrx_lock -> state_lock

If you could do me a single series with those as well that would
be great.

Thanks for sorting this out,

Jonathan

> The cleanup does seem to have revealed a few gaps in our CI in
> relation to upstreaming things.
>=20
> We use Travis-CI for our stuff and stuff is public:
> https://travis-ci.org/analogdevicesinc/linux
>=20
> So, if anyone sees anything we should do better, I'm open to
> improvements/suggestions.
> I am in the process of adding sparse-builds, maybe some build
> hardening is next (stronger compile/build flags), adding our patches
> on top of a newer kernel (that's partially done).
> That should help us catch things a bit earlier.
>=20
> Sorry for the noise from my side as-well.
> Alex
>=20
>=20
> > Jonathan =20

