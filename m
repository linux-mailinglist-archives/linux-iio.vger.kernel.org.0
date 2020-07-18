Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764E224D02
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGRQ3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgGRQ3l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:29:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E456E2080D;
        Sat, 18 Jul 2020 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595089781;
        bh=89r/vzFa0Z0afnvQgRK8zBvAGeUyQXap6+PdGNRqtME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CnYV7GR4c9p5VrrTGH/ciCt/4e4mLRDogf8kqvj17IpZfXJoYlwL4CHn78D8db225
         LqMHDhGz44GLZ/nkLMfHy9vc6oVaFUkxYzOJZhivpJCxKydTB0Veo3QvMiGv5/NUNR
         nCa5mnUjHU3uxRll29sG37n2Xc5CY+ul43mWkT1E=
Date:   Sat, 18 Jul 2020 17:29:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>
Cc:     linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
Message-ID: <20200718172937.59f24822@archlinux>
In-Reply-To: <20200714104441.nrnaauqunjst67ix@core.my.home>
References: <20200703194406.110855-1-megous@megous.com>
        <20200704172916.7a8a7359@archlinux>
        <20200714104441.nrnaauqunjst67ix@core.my.home>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jul 2020 12:44:41 +0200
Ond=C5=99ej Jirman <megous@megous.com> wrote:

> Hello Jonathan,
>=20
> On Sat, Jul 04, 2020 at 05:29:16PM +0100, Jonathan Cameron wrote:
> > On Fri,  3 Jul 2020 21:44:05 +0200
> > Ondrej Jirman <megous@megous.com> wrote:
> >  =20
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >=20
> > > The STK3311 chip has a variant called STK3311-X, which has a different
> > > chip id of 0x12.
> > >=20
> > > Add the chip id to the driver.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Ondrej Jirman <megous@megous.com> =20
> >=20
> > Given this is clearly not quite compatible with the stk3311 probably
> > best to also add a an id to the of id table.  Any idea what else
> > is different? =20
>=20
> I've looked at it more, and there's no stk3311 either. It always has
> some suffix, like -sa -9 -a -wv -x, .... So I don't think a new
> ID in the table is neccessary. The driver can differentiate based on
> chip id, in case it will ever become necessary.
>=20
Thanks for info.  In that case, applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> regards,
> 	o.
>=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  drivers/iio/light/stk3310.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> > > index 185c24a75ae6..1a8401d198a4 100644
> > > --- a/drivers/iio/light/stk3310.c
> > > +++ b/drivers/iio/light/stk3310.c
> > > @@ -37,6 +37,7 @@
> > > =20
> > >  #define STK3310_CHIP_ID_VAL			0x13
> > >  #define STK3311_CHIP_ID_VAL			0x1D
> > > +#define STK3311X_CHIP_ID_VAL			0x12
> > >  #define STK3335_CHIP_ID_VAL			0x51
> > >  #define STK3310_PSINT_EN			0x01
> > >  #define STK3310_PS_MAX_VAL			0xFFFF
> > > @@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
> > > =20
> > >  	if (chipid !=3D STK3310_CHIP_ID_VAL &&
> > >  	    chipid !=3D STK3311_CHIP_ID_VAL &&
> > > +	    chipid !=3D STK3311X_CHIP_ID_VAL &&
> > >  	    chipid !=3D STK3335_CHIP_ID_VAL) {
> > >  		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
> > >  		return -ENODEV; =20
> >  =20

