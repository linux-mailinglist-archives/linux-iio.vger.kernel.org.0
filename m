Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88C2D50DC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfJLQIU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 12:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfJLQGU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 12:06:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C7E20650;
        Sat, 12 Oct 2019 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570896379;
        bh=5ZRNuvyYZbSvMdUlPOs0RekrHjoIj10YHqGaDmsYao8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmiTN7aBhEAICTmOm9L4tOG7ompW4201qUZrXONFV5LRw5kxEFv7M1lBGhzYJwel+
         ckgxELqMgc5ll8KPOkOADDaMmaClfCOsw8QZDYRSwrlDW3kEL3DF57gsENxfPcKVT1
         ThaiViW/qnBQroY/ZUgRn6Ju4wBORt+NzhnZN0l4=
Date:   Sat, 12 Oct 2019 17:06:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PULL v2] First set of iio new device support etc for the 5.5
 cycle
Message-ID: <20191012170615.01546a96@archlinux>
In-Reply-To: <20191012152841.GB2142233@kroah.com>
References: <20191012121946.051b646f@archlinux>
        <20191012152744.GA2142233@kroah.com>
        <20191012152841.GB2142233@kroah.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 17:28:41 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Oct 12, 2019 at 05:27:44PM +0200, Greg KH wrote:
> > On Sat, Oct 12, 2019 at 12:19:46PM +0100, Jonathan Cameron wrote: =20
> > > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee76749=
9f9655:
> > >=20
> > >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 =
+0100)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/=
iio-for-5.5a-take2 =20
> >=20
> > Better, but I see this now:
> >=20
> > drivers/iio/imu/adis.c: In function =E2=80=98__adis_check_status=E2=80=
=99:
> > drivers/iio/imu/adis.c:295:9: warning: =E2=80=98status=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]
> >   295 |  status &=3D adis->data->status_error_mask;
> >       |         ^~
> >=20
> >=20
> > I'll take this, can you just send a follow-on patch for this? =20
>=20
> Also I see:
>=20
> drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_enable_irq=E2=
=80=99:
> drivers/iio/imu/adis16480.c:950:6: warning: =E2=80=98val=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]
>   950 |  val &=3D ~ADIS16480_DRDY_EN_MSK;
>       |      ^~
>   CC [M]  drivers/iio/magnetometer/hmc5843_i2c.o
> drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_write_raw=E2=
=80=99:
> drivers/iio/imu/adis16480.c:571:7: warning: =E2=80=98val=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]
>   571 |   val &=3D ~enable_mask;
>       |       ^~
> drivers/iio/imu/adis16480.c:557:11: note: =E2=80=98val=E2=80=99 was decla=
red here
>   557 |  uint16_t val;
>       |           ^~~
>=20
>=20
> So did you really fix anything here?
>=20
> I'll drop this pull again.
>=20
> What version of gcc are you using?  Might I suggest a newer one (i.e. a
> modern one?)

Ah. This is my mistake.  I did see all of these, but still thought we were
in the category of tidying up some compiler version caused issues.

The adis16400 came up in my local tests, so I previously pinged Alex on
basis it was something to do in a follow up. The other two showed up, but
again I still thought these were compiler version issues, particularly
as 0-day didn't highlight them (there were several other issues it
did highlight this week). Hence again I requested a follow up to tidy
it up.

Anyhow, did some digging.  The issue here was a 'fix' I put in to an initial
0-day issue in the inline functions that Alex added.  Note that one
appears to be compiler version dependent as it didn't turn up in my
local builds. There are now inline functions that check if (ret)
and don't set the value if ret is non 0.

Out in the drivers, the check is the more specific (unnecessarily)
if (ret < 0) and hence the compiler is concluded that there might be a path=
 to
val not being set.  Previously it was giving up figuring this out.
So reality is they are a false positive (sort of as in reality ret
is never positive) but the compiler has made a reasonable point
that it can't see that.

Never mind, I'll do a new pull request once fixes are in place.
Given there are two obvious ways of suppressing this and it's Alex's
driver I'll wait until he has time to take a look.

Sorry for wasting your time.

Jonathan
