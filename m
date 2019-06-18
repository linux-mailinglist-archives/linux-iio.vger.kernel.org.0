Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1B4ABCA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfFRU1w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 16:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRU1w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 16:27:52 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB4420863;
        Tue, 18 Jun 2019 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560889671;
        bh=+cL7SVb0rmOw7XLdHu9bfvtv7E7zIjZYCbi9exmLLFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUdf9y6w+vDXbLjhTScMe2DahY0y1uLKWJP2JYbzWBoUcbLu1VzBij1Te2ZRwIvPY
         RSptGQHTnz3xHV9aBKmVKMtK5dXsxLwx1egNvpkBmIYSnruAeQrOadQf7Wvd8rtnn5
         3flurS/3g9wxLPX5tRwf/2rx9ON1uduAjwlnDlOI=
Date:   Tue, 18 Jun 2019 22:27:46 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20190618202745.GC930@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-4-sean@geanix.com>
 <20190618155122.GC20044@localhost.localdomain>
 <d7bcc9a5-37ae-d65a-7841-4468d49bb8bd@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <d7bcc9a5-37ae-d65a-7841-4468d49bb8bd@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, Sean Nyekjaer wrote:
>=20
>=20
> On 18/06/2019 17.51, Lorenzo Bianconi wrote:
> > > this add ways for the SoC to wake from accelerometer wake events.
> > >=20
> > > In the suspend function we skip disabling the sensor if wakeup-source
> > > and events are activated.
> > >=20
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 351c46f01662..59a34894e495 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1076,6 +1076,10 @@ int st_lsm6dsx_probe(struct device *dev, int i=
rq, int hw_id, const char *name,
> > >   			return err;
> > >   	}
> > > +	if (dev->of_node)
> > > +		if (of_property_read_bool(dev->of_node, "wakeup-source"))
> > > +			device_init_wakeup(dev, true);
> > > +
> > >   	return 0;
> > >   }
> > >   EXPORT_SYMBOL(st_lsm6dsx_probe);
> > > @@ -1088,6 +1092,12 @@ static int __maybe_unused st_lsm6dsx_suspend(s=
truct device *dev)
> > >   	int i, err =3D 0;
> > >   	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > > +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {
> > > +			/* Enable wake from IRQ */
> > > +			enable_irq_wake(hw->irq);
> > > +			continue;
> >=20
> > This is breaking buffering mode
>=20
> Hmm, what is missing? :-)
> We need the accelerometer to continue to run in suspend, but skip writing=
 to
> the internal fifo.

I think we should keep the accel enabled, but we need to put the FIFO in by=
pas
mode

>=20
> >=20
> > > +		}
> > > +
> > >   		sensor =3D iio_priv(hw->iio_devs[i]);
> > >   		if (!(hw->enable_mask & BIT(sensor->id)))
> > >   			continue;
> > > @@ -1112,6 +1122,11 @@ static int __maybe_unused st_lsm6dsx_resume(st=
ruct device *dev)
> > >   	int i, err =3D 0;
> > >   	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > > +		if (device_may_wakeup(dev) && (i =3D=3D ST_LSM6DSX_ID_ACC)) {
> > > +			disable_irq_wake(hw->irq);
> >=20
> > same here
> >=20
> > > +			continue;
> > > +		}
> > > +
> > >   		sensor =3D iio_priv(hw->iio_devs[i]);
> > >   		if (!(hw->enable_mask & BIT(sensor->id)))
> > >   			continue;
> > > --=20
> > > 2.22.0
> > >=20

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQlJPQAKCRA6cBh0uS2t
rCovAQCWJc1LR8fVYoMEqFXCIkX3raXMKp5e07ACZ04GuMx7iAD/efG+oZTV2R7p
OO0BQQA67w+y5rni1rqUQycxm8fWlwY=
=ynAy
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
