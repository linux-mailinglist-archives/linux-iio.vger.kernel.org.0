Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31B21C9DA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGLOdL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 10:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgGLOdL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 10:33:11 -0400
Received: from localhost (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860F5206B6;
        Sun, 12 Jul 2020 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594564390;
        bh=RHeAD+VQq5yqZZfVRad34P61yzx/zYg344gSqO7SKHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0xJXNd6SSH5f8tG6yoc3LdbxzxE33wwezLmhqiZzAZ2ODrXk27SRvhRaF0I0+r46p
         4meuT7qDuiy1gb28hfxw4wKL7kKG7OFNP8SmL584VKKEVYTbOHrrX8KEQ6wDF3Qqfg
         JMfEK7gKpyDOF4bDsK7jHWRAoQC+1hx+TJl7xNCM=
Date:   Sun, 12 Jul 2020 16:33:04 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: reset hw ts after resume
Message-ID: <20200712143304.GA697824@localhost.localdomain>
References: <15dadc531c5b30819a72b289ccd5c25e04f73657.1594388801.git.lorenzo@kernel.org>
 <f639082c-91b9-c056-673d-2835ba05ac03@geanix.com>
 <20200712121000.46a93069@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20200712121000.46a93069@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 11 Jul 2020 13:49:37 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > On 10/07/2020 15.49, Lorenzo Bianconi wrote:
> > > Reset hw time sampling after the device resume in order to keep timing
> > > in sync
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> > Tested-by: Sean Nyekjaer <sean@geanix.com>
> Hi Lorenzo,

Hi Jonathan,

>=20
> Patch is fine, but I'd like a couple of changes to the description:
> 1. More detail!  For what we have here no one will have any real idea
> of whether an issue they are seeing is the same one or not.
> 2. Fixes tag / or something telling me why this shouldn't be back ported.

sure, I will fix them in v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> > > ---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
> > >   .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++----=
---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
> > >   3 files changed, 17 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx.h
> > > index b56df409ed0f..529970195b39 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > @@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx=
_sensor *sensor,
> > >   				u16 watermark);
> > >   int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool e=
nable);
> > >   int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> > > -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > > -			     enum st_lsm6dsx_fifo_mode fifo_mode);
> > > +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
> > >   int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> > >   int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
> > >   int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr,=
 u8 *val);
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index afd00daeefb2..7de10bd636ea 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st=
_lsm6dsx_hw *hw)
> > >   	return err;
> > >   }
> > >  =20
> > > -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > > -			     enum st_lsm6dsx_fifo_mode fifo_mode)
> > > +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > > +				    enum st_lsm6dsx_fifo_mode fifo_mode)
> > >   {
> > >   	unsigned int data;
> > >  =20
> > > @@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6=
dsx_hw *hw)
> > >   	return 0;
> > >   }
> > >  =20
> > > +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
> > > +{
> > > +	int err;
> > > +
> > > +	/* reset hw ts counter */
> > > +	err =3D st_lsm6dsx_reset_hw_ts(hw);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > > +}
> > > +
> > >   /*
> > >    * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGG=
ED_WORD_LEN
> > >    * in order to avoid a kmalloc for each bus access
> > > @@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sen=
sor *sensor, bool enable)
> > >   		goto out;
> > >  =20
> > >   	if (fifo_mask) {
> > > -		/* reset hw ts counter */
> > > -		err =3D st_lsm6dsx_reset_hw_ts(hw);
> > > -		if (err < 0)
> > > -			goto out;
> > > -
> > > -		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > > +		err =3D st_lsm6dsx_resume_fifo(hw);
> > >   		if (err < 0)
> > >   			goto out;
> > >   	}
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index c8ddeb3f48ff..346c24281d26 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -2457,7 +2457,7 @@ static int __maybe_unused st_lsm6dsx_resume(str=
uct device *dev)
> > >   	}
> > >  =20
> > >   	if (hw->fifo_mask)
> > > -		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > > +		err =3D st_lsm6dsx_resume_fifo(hw);
> > >  =20
> > >   	return err;
> > >   } =20
> >=20
>=20

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXwsfGQAKCRA6cBh0uS2t
rD2FAQDTyTHttROb9JDyipwc/u3rkYiQiVS6O1eSr2cmAj3YNQEA4b8sJGJUPmW2
Hh6bTrHRskNlkrMsXDR1EY3TOpIiHA8=
=pNpI
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
