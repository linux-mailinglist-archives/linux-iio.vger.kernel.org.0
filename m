Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78024D4F41
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfJLLQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLLQX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:16:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6342221850;
        Sat, 12 Oct 2019 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570878982;
        bh=fzGB/GcvoyHKXTo+EYUUTMbCgJPsoD57RMGmwLxspLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DG1qyRs7alaj093fJZmEyMQ8qtAeX8p5s3HCAMg+cGRbbFOMVV9dVQiXtfIXuOrjw
         /+Gp2HaqGip99NXxYlP3MIbJ4OLvXn4lxLYOBtPthaTWAxNlWPWaijn+UqrGaycshN
         zDt8AHUqV91SLw65RzOAgw4ehD/BAOD55gyKqVIU=
Date:   Sat, 12 Oct 2019 12:16:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO new device support etc for the 5.5
 cycle.
Message-ID: <20191012121619.5c3e7453@archlinux>
In-Reply-To: <20191012105119.GA2074969@kroah.com>
References: <20191012102436.752a861d@archlinux>
        <20191012105119.GA2074969@kroah.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 12:51:19 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Oct 12, 2019 at 10:24:36AM +0100, Jonathan Cameron wrote:
> > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f=
9655:
> >=20
> >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0=
100)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/ii=
o-for-5.5a =20
>=20
> I'm getting build warnings in drivers/iio/imu/adis16400.c, is that to be
> expected?
>=20
> drivers/iio/imu/adis16400.c: In function =E2=80=98adis16334_get_freq=E2=
=80=99:
> drivers/iio/imu/adis16400.c:334:4: warning: =E2=80=98t=E2=80=99 may be us=
ed uninitialized in this function [-Wmaybe-uninitialized]
>   334 |  t >>=3D ADIS16334_RATE_DIV_SHIFT;
>       |    ^
> drivers/iio/imu/adis16400.c: In function =E2=80=98adis16400_get_freq=E2=
=80=99:
> drivers/iio/imu/adis16400.c:360:11: warning: =E2=80=98t=E2=80=99 may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
>   360 |  uint16_t t;
>       |           ^
>   CC [M]  drivers/iio/light/bh1750.o
> drivers/iio/imu/adis16400.c: In function =E2=80=98adis16400_read_raw=E2=
=80=99:
> drivers/iio/imu/adis16400.c:557:10: warning: =E2=80=98val16=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
>   557 |  int16_t val16;
>       |          ^~~~~
> drivers/iio/imu/adis16400.c: In function =E2=80=98adis16400_write_raw=E2=
=80=99:
> drivers/iio/imu/adis16400.c:424:14: warning: =E2=80=98val16=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
>   424 |       (val16 & ~0x07) | i);
>       |       ~~~~~~~^~~~~~~~
> drivers/iio/imu/adis16400.c:411:11: note: =E2=80=98val16=E2=80=99 was dec=
lared here
>   411 |  uint16_t val16;
>       |           ^~~~~
>=20
>=20
> Can you fix that up first?
>=20
> thanks,
>=20
> greg k-h
Hi Greg,

I got these as well, but as they weren't the result of anything done
in this series (seems to be GCC 8 getting fussier) I pointed them out
to Alex and he sent a fix.  Was about to queue it up for next series.
I'll tack it on here and send you a new pull in a few mins.

Thanks,

Jonathan
