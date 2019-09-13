Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC5B1999
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfIMI1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387479AbfIMI1J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 04:27:09 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AE32089F;
        Fri, 13 Sep 2019 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568363227;
        bh=LnotkSI0AstQJIozX+V1Hba8DDs4BDVWHW/cCMPlCDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVHlU49jRElwp70oXL4vjw+QdvUYYm2tIA+H8bWbZesHMWpak+/DMgpNFhf53wSVZ
         spQF4xlHagqJK4goYg87H+AwoeaOzHyhaBKEnozYG+pfUkvxgveFIoNk5H8UFbqblX
         Kdr7pPhvXqxfFo6P16bpsJaz6OF2vCcET1zFgggk=
Date:   Fri, 13 Sep 2019 10:27:01 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v7 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190913082701.GA2698@localhost.localdomain>
References: <20190912070614.1144169-1-sean@geanix.com>
 <20190912070614.1144169-4-sean@geanix.com>
 <6eb3a60f-0712-4ad7-fe3c-fd76a3ea135f@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <6eb3a60f-0712-4ad7-fe3c-fd76a3ea135f@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 12/09/2019 09.06, Sean Nyekjaer wrote:
> > This add ways for the SoC to wake from accelerometer wake events.
> >=20
> > In the suspend function we skip disabling the sensor if wakeup-source
> > and events are activated.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes since v4:
> >   * More devices supports wakeup
> >=20
> > Changes since v5:
> >   * None
> >=20
> > Changes since v6:
> >   * None
> >=20
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 4198ba263d03..f79978a2870f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id,
> >   			return err;
> >   	}
> > +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-sourc=
e"))
> > +		device_init_wakeup(dev, true);
> > +
> >   	return 0;
> >   }
> >   EXPORT_SYMBOL(st_lsm6dsx_probe);
> > @@ -1876,6 +1879,12 @@ static int __maybe_unused st_lsm6dsx_suspend(str=
uct device *dev)
> >   		if (!(hw->enable_mask & BIT(sensor->id)))
> >   			continue;
> > +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> > +			/* Enable wake from IRQ */
> > +			enable_irq_wake(hw->irq);
> > +			continue;

I guess here we need even to check hw->event_enable, don't we?

> > +		}
> > +
> >   		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
> >   		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
> >   		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> > @@ -1908,6 +1917,11 @@ static int __maybe_unused st_lsm6dsx_resume(stru=
ct device *dev)
> >   		if (!(hw->suspend_mask & BIT(sensor->id)))
> >   			continue;
> > +		if (device_may_wakeup(dev) && i =3D=3D ST_LSM6DSX_ID_ACC) {
> > +			disable_irq_wake(hw->irq);
> > +			continue;
> > +		}
> > +
> This section needs to move above:

agree, and we probably do not need 'continue'. Moreover I guess we should c=
heck
hw->event_enable even here, right?

> >   		if (!(hw->enable_mask & BIT(sensor->id)))
> In the current configuration it will never be reached in event only mode
>=20
> With the bug mentioned above fixed, have tested suspend/wake with and
> without FIFO enabled.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXtS0wAKCRA6cBh0uS2t
rDsuAP913IodsA7vHulrL1xrfjCn9VwhbO95pwXAZ4xQZr+RvAEAuR/UVgJ6903K
BRLn2zmO3z9IFYeFUByFFnj+8sh5VwU=
=Wv2b
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
