Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A627B1CC9F1
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgEJJzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 05:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgEJJy7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 05:54:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E678620820;
        Sun, 10 May 2020 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589104499;
        bh=WCYLSWELOl5503jWmGXNWKpfN+YMAYKt7Zqg+oA686U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dh+ow8ga68Axs1mr7S69RxJG+0bm4MW+IgzCSoEZ3voK8GCKVzIg37rwLqTfcdWW+
         lxx/+fwSR9DsHC4icAvHlOeAFyW9OtcZhuBBipHZHVHUrBc7EsvVwPRxoJ6Z8nE6EZ
         JDV2GC+YSDLs3krDtXmbakNKg9DvhC/5p96VQHuE=
Date:   Sun, 10 May 2020 10:54:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: sca3000: Remove an erroneous 'get_device()'
Message-ID: <20200510105454.505c5d1c@archlinux>
In-Reply-To: <20200508140221.0000018d@Huawei.com>
References: <20200506035206.192173-1-christophe.jaillet@wanadoo.fr>
        <CAHp75Vdi+ZYpQPHgoREQ6LTaUHTPmNkR7ULZaVNTJr7Bvh-q9Q@mail.gmail.com>
        <0a8cd600-2b21-2076-1355-8c97d7ceb709@wanadoo.fr>
        <20200508140221.0000018d@Huawei.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 14:02:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 6 May 2020 19:31:38 +0200
> Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>=20
> > Le 06/05/2020 =C3=A0 12:38, Andy Shevchenko a =C3=A9crit=C2=A0: =20
> > > On Wed, May 6, 2020 at 6:55 AM Christophe JAILLET
> > > <christophe.jaillet@wanadoo.fr> wrote:   =20
> > >> This looks really unusual to have a 'get_device()' hidden in a 'dev_=
err()'
> > >> call.
> > >> Remove it.
> > >>
> > >> While at it add a missing \n at the end of the message.
> > >>   =20
> > > It should have Fixes tag because it is a quite an issue (get_device()
> > > breaks reference counting with all problems we may expect).   =20
> >=20
> > Agreed and I usually do, but here, I've lost track when this driver has=
=20
> > gone out of staging.
> >=20
> > Based on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/drivers/iio/accel/sca3000.c
> > The issue was already there on 2016/10/23, but when I try to go one ste=
p=20
> > further:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/drivers/staging/iio/accel/sca3000.c?id=3D2ccf61442ff142d2dde7c47471c2798a=
4d78b0ad
> > ^^^^ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^
> > works but if I try to see the log for that:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/drivers/staging/iio/accel/sca3000.c
> > ^^^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^
> > is empty.
> >=20
> > Most of the time, when I do it like that it works just fine, but not on=
=20
> > this file. =20
>=20
> Oddity of the web interface. Edit the url to get a log form a commit
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/d=
rivers/staging/iio/accel/sca3000.c?id=3D2ccf61442ff142d2dde7c47471c2798a4d7=
8b0ad
>                                                                     ^^^
> Then for more fun you have to deal with another rename
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/staging/iio/accel/?id=3Dced5c03d360aeebaac6faa7dd8d6d0a77733ab16
>=20
> Next bit of log...
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/d=
rivers/staging/iio/accel/sca3000_ring.c?id=3Dced5c03d360aeebaac6faa7dd8d6d0=
a77733ab16=20
>=20
> It goes all the way..
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/staging/iio/accel/sca3000_core.c?id=3D574fb258d63658e4564c32c1940=
068a3bad666a0
>=20
> Fixes: 574fb258d636 ("Staging: IIO: VTI sca3000 series accelerometer driv=
er (spi)")
>=20
> Which was in the initial IIO patch set nearly 11 years ago in the merge w=
indow for 2.6.32.
>=20
> What can I say - I was young and just as capable of writing dumb bugs as =
I am today :)
>=20
> I'll get this queued up when I'm on the right computer...

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> >=20
> > Any other way to navigate in history of moved file would be appreciated.
> >=20
> > CJ
> >  =20
> > >   =20
> > >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > >> ---
> > >> This patch is purely speculative.
> > >> I've looked a bit arround and see no point for this get_device() but=
 other
> > >> eyes are welcomed :)
> > >> ---
> > >>   drivers/iio/accel/sca3000.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000=
.c
> > >> index 66d768d971e1..6e429072e44a 100644
> > >> --- a/drivers/iio/accel/sca3000.c
> > >> +++ b/drivers/iio/accel/sca3000.c
> > >> @@ -980,7 +980,7 @@ static int sca3000_read_data(struct sca3000_stat=
e *st,
> > >>          st->tx[0] =3D SCA3000_READ_REG(reg_address_high);
> > >>          ret =3D spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> > >>          if (ret) {
> > >> -               dev_err(get_device(&st->us->dev), "problem reading r=
egister");
> > >> +               dev_err(&st->us->dev, "problem reading register\n");
> > >>                  return ret;
> > >>          }
> > >>
> > >> --
> > >> 2.25.1
> > >>   =20
> > >   =20
>=20
>=20

