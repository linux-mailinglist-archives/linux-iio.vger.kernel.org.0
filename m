Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE5B300E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfIONHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfIONHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:07:22 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4382077C;
        Sun, 15 Sep 2019 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552841;
        bh=DlHs0B8y034MlFvdrzVDhRYjdgV6dJR2LPqw2ZclefU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncpW4O5iHfzMWkGDn2SmjOsA+GTuLV5w722CKyEEd1aMtTeuSU2+ZoUkc+Q6diPCh
         gMMpYtxHMshhL62dPYPojcaORxGW3SCVYeVsNEsDa0qvC9osNpNhH6RN1YDCcvK3yQ
         GWawBkoCtcZUWlG2bQXDJaXKnR3cyl0jeRzYg0ns=
Date:   Sun, 15 Sep 2019 15:07:16 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 4/5] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190915130716.GC15634@lore-desk-wlan.lan>
References: <20190913090708.1442057-1-sean@geanix.com>
 <20190913090708.1442057-5-sean@geanix.com>
 <20190915133332.3762e860@archlinux>
 <20190915124840.GA15634@lore-desk-wlan.lan>
 <20190915140056.296f1e23@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20190915140056.296f1e23@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 15 Sep 2019 14:48:40 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Fri, 13 Sep 2019 11:07:07 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >  =20
> > > > The interrupt source can come from multiple sources,
> > > > fifo and wake interrupts.
> > > > Enter interrupt thread to check which interrupt that has fired.
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 810807c52d5f..80a94335175f 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1717,9 +1717,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiode=
v(struct st_lsm6dsx_hw *hw,
> > > > =20
> > > >  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > >  {
> > > > -	struct st_lsm6dsx_hw *hw =3D private;
> > > > -
> > > > -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> > > > +	return IRQ_WAKE_THREAD; =20
> > >=20
> > > I missed this before.  Isn't this the same as just not providing a to=
p half at all?
> > >=20
> > > I.e. Pass null to request_threaded_irq where this function was.
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan =20
> >=20
> > Right, for the moment we do not need it. It will be probably useful add=
ing
> > buffering support for sensors that do not support hw timestamping in FI=
FO
> > (e.g. LSM9DS1). I am fine both ways, so up to you.
> Scrap it for now. I suspect someone will have a script out there that will
> fire on this and generate a patch removing it.  Better to not waste peopl=
e's
> time!

ack :)
@Sean: can you please fix it in v9?

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > >  =20
> > > >  }
> > > > =20
> > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *privat=
e) =20
> > >  =20
>=20

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX43gQAKCRA6cBh0uS2t
rIKdAQCW34olvEi3KPFyoxdvdgQsQTEbHmgB/w6M0lbM5wbl4AEAjl1L199gbA03
pWxpab0wzH1fPbErAk5hVcZ4HP1kXQA=
=nEFU
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
