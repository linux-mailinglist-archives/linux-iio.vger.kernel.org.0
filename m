Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EFF68CC
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 12:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJLsc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 06:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfKJLsb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 06:48:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BD520869;
        Sun, 10 Nov 2019 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573386511;
        bh=3ZlcSdnSyJm9AAdYjI6QHnNMIOARCyjlNADNfdeTPT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WTHwi2TjhJZ0w8Yb/sgHLW7ravV3YzqjcMs16nU6bk2gklziWbYEja9ow3DuTXFvC
         3ywstnYdQbIpfp46s5Nho4l+Si0n56O2uqcA0oFnQUJDOoNTb0UKe3yHlcJvbKPPhh
         EPmMsigYc79vCTdDHegk06phWBP6B2JLr3fEwoww=
Date:   Sun, 10 Nov 2019 11:48:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: temperature: ltc2983: fix u32 read into a unsigned
 long long
Message-ID: <20191110114823.2bbe87b0@archlinux>
In-Reply-To: <dab9cfd93e6affa5d94f078154c3e181303bbf47.camel@analog.com>
References: <20191105202818.90065-1-colin.king@canonical.com>
        <dab9cfd93e6affa5d94f078154c3e181303bbf47.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 Nov 2019 14:19:52 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Tue, 2019-11-05 at 20:28 +0000, Colin King wrote:
> >=20
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Currently the read of temp using of_property_read_u32_index is
> > reading
> > a u32 value into a unsigned long long.  This relies on machine
> > endianness
> > to work correctly, so fix this by reading a u32 value and setting
> > temp
> > to this value.
> >=20
> > Addresses-Coverity: ("Reliance on integer endianness")
> > Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iio/temperature/ltc2983.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/temperature/ltc2983.c
> > b/drivers/iio/temperature/ltc2983.c
> > index ddf47023364b..d39c0d6b77f1 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -444,8 +444,10 @@ static struct ltc2983_custom_sensor
> > *__ltc2983_custom_sensor_new(
> >  			else
> >  				temp =3D __convert_to_raw(temp,
> > resolution);
> >  		} else {
> > -			of_property_read_u32_index(np, propname, index,
> > -						   (u32 *)&temp);
> > +			u32 t32;
> > +
> > +			of_property_read_u32_index(np, propname, index,
> > &t32);
> > +			temp =3D t32;
> >  		}
> > =20
> >  		for (j =3D 0; j < n_size; j++) =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20

A slight complexity around this one. I'm not sure I'll have time for a pull
before the merge window (as Greg will only take them to about 1 week before
that opens so we get some exposure in Linux next).

As a result I'll have to sit on this one until Linus comments on rc7, proba=
bly
later today.  Otherwise it'll be material for stable post release.

If I seem to have lost it give me a poke and we'll make sure it goes into=20
an early rc instead of at the merge window.

Thanks,

Jonathan

> Thanks,
> Nuno S=C3=A1

