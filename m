Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A002B1A53
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfIMI66 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbfIMI66 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 04:58:58 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64A0E208C0;
        Fri, 13 Sep 2019 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568365137;
        bh=onsHx30SkL9bzSV0rxKsD/mA8jgT78lwjFcNB4h0bvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0XcbMS7xjuo+eikiP3vTql+WRh1gits1930/9XVZvjl/f7YsiZtlBlk58dZcQnTz
         R+HLz/a21UVHH7Glj3zHVmKQmMx0DbMU7BpFw6OW+vcAzJ/2VEaWk+EVDj0LvdfL8A
         G5RmhT6zATUixW8KsX9EVTJ5u1sg9nvNWpE415dQ=
Date:   Fri, 13 Sep 2019 10:58:51 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v7 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190913085851.GB2698@localhost.localdomain>
References: <20190912070614.1144169-1-sean@geanix.com>
 <20190912070614.1144169-4-sean@geanix.com>
 <6eb3a60f-0712-4ad7-fe3c-fd76a3ea135f@geanix.com>
 <20190913082701.GA2698@localhost.localdomain>
 <66e35f99-780b-7063-37ad-3fb656a6dffc@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <66e35f99-780b-7063-37ad-3fb656a6dffc@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 13/09/2019 10.27, Lorenzo Bianconi wrote:
> > >=20
> > >=20
> > > On 12/09/2019 09.06, Sean Nyekjaer wrote:
> > > > This add ways for the SoC to wake from accelerometer wake events.
> > > >=20
> > > > In the suspend function we skip disabling the sensor if wakeup-sour=
ce
> > > > and events are activated.
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > ---
> > > > Changes since v4:
> > > >    * More devices supports wakeup
> > > >=20
> > > > Changes since v5:
> > > >    * None
> > > >=20
> > > > Changes since v6:
> > > >    * None
> > > >=20
> > > >    drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
> > > >    1 file changed, 14 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 4198ba263d03..f79978a2870f 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int =
irq, int hw_id,
> > > >    			return err;
> > > >    	}
> > > > +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-s=
ource"))
> > > > +		device_init_wakeup(dev, true);
> > > > +
> > > >    	return 0;
> > > >    }
> > > >    EXPORT_SYMBOL(st_lsm6dsx_probe);
> > > > @@ -1876,6 +1879,12 @@ static int __maybe_unused st_lsm6dsx_suspend=
(struct device *dev)
> > > >    		if (!(hw->enable_mask & BIT(sensor->id)))
> > > >    			continue;
> > > > +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> > > > +			/* Enable wake from IRQ */
> > > > +			enable_irq_wake(hw->irq);
> > > > +			continue;
> >=20
> > I guess here we need even to check hw->event_enable, don't we?
> Good idea :)
>=20
> >=20
> > > > +		}
> > > > +
> > > >    		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
> > > >    		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
> > > >    		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> > > > @@ -1908,6 +1917,11 @@ static int __maybe_unused st_lsm6dsx_resume(=
struct device *dev)
> > > >    		if (!(hw->suspend_mask & BIT(sensor->id)))
> > > >    			continue;
> > > > +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> > > > +			disable_irq_wake(hw->irq);
> > > > +			continue;
> > > > +		}
> > > > +
> > > This section needs to move above:
> >=20
> > agree, and we probably do not need 'continue'. Moreover I guess we shou=
ld check
> > hw->event_enable even here, right?
>=20
> Correct we don't need the 'continue' here... The 'hw->suspend_mask' is not
> set as we skip it in the resume part.
> I'll add the 'hw->enable_event' check here as well.
>=20
> Is there more stuff that blocks this series from your point of view?

Actually I have not tested, just compiled. Looking at the code seems fine.

Regards,
Lorenzo

>=20
> /Sean

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXtaSAAKCRA6cBh0uS2t
rBjBAP9IDhb3BejqXJ5vqL2DIjnN9ORw9w8FI5JclGavNcuQNwD+P3+soTfVFwj8
pOxhihC5ypVJ6/MX6Dyf7zOdBhWZdww=
=D8b2
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
