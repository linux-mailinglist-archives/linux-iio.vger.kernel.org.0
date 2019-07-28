Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6B780CF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfG1Rwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 13:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfG1Rwm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 13:52:42 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73A02075C;
        Sun, 28 Jul 2019 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564336360;
        bh=ZZe+81SreSVGPqP1Jj7PbXG/THnOdvbavPJEtJjxHuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7lAJtnbIdP4Orxh+gc8R6bzKvyJnnC7TL1jLtcnPUQG/wK2P1WZ743eXQSROwAu5
         MAg0353GwQ39WfiIMOwYhD2blXACxlzGSTNo87DSeZXFnh4eHkkVR22nvDm3oiOz+c
         c7j1zwfWCSaY9A9tMa1fK9UU9MlZjea9VNrSQM+I=
Date:   Sun, 28 Jul 2019 19:52:34 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190728175234.GA7652@lore-desk-wlan.lan>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
 <20190725053132.9589-5-martin.kepplinger@puri.sm>
 <20190727184844.307255a2@archlinux>
 <a2f6d5fe-04c6-f5d8-ad38-56b8fa033295@puri.sm>
 <20190728093414.5d3ca94d@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190728093414.5d3ca94d@archlinux>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 28 Jul 2019 08:04:51 +0200
> Martin Kepplinger <martin.kepplinger@puri.sm> wrote:
>=20
> > On 27.07.19 19:48, Jonathan Cameron wrote:
> > > On Thu, 25 Jul 2019 07:31:31 +0200
> > > Martin Kepplinger <martin.kepplinger@puri.sm> wrote:
> > >  =20
> > >> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (=
separately
> > >> supported in iio/magnetometer/st_magn*) are located on a separate i2=
c addresses
> > >> on the bus.
> > >>
> > >> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9=
ds1.pdf
> > >>
> > >> Treat it just like the LSM6* devices and, despite it's name, hook it=
 up
> > >> to the st_lsm6dsx driver, using it's basic functionality.
> > >>
> > >> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm> =20
> > > I'm a little confused on this hardware.
> > >=20
> > > How does buffered output work if these are independently clocked?
> > >=20
> > > I took a quick look at the datasheet, and 'suspect' the answer is that
> > > it runs at the gyro frequencies if both are enable. Is that right?
> > >  =20
> >=20
> > Thanks for reviewing, Jonathan,
> >=20
> > Correct. It says so in chapter 7.12. But that's a "problem" with all
> > these imu devices, not specific to this addition right?
> It's not a problem as such, but there is a related difference in this
> device to the others supported by this driver.
>=20
> The other parts seem to allow for independent data rate setting, with
> streaming to the buffer that isn't in 'lock step'.  I.e you can get
>=20
> Ax_1, Ay_1, Az_1, Gx_1, Gy_1, Gz_1, Gx_2, Gy_2, Gz_2, Ax_2, Ay_2, Az_2, G=
y_3...

correct

>=20
> That required us to split them up into two devices and means that, to fuse
> data from these two source, userspace has to do the harder job of
> aligning the two datasets.
>=20
> For this device, things are simpler in that you always a 'scan' that goes
> across both accelerometer and gyroscope channels.  That allows us to
> represent it as a single IIO device with a single buffer.
>=20
> I'm not seeing any reference in the lsm9ds1 to the pattern registers
> that are used to handle difference in frequency for the other
> parts by letting us know what is actually present in each data set
> in the fifo.
>=20
> Now, that doesn't meant we can't still handle them separately given
> we already do that for other parts.

what about reusing st_lsm6dsx_read_fifo() for lsm6ds0/lsm9ds1 but setting h=
w->sip to:
- hw->sip =3D 1 (acc_sip =3D 1, gyro_sip =3D 0) when just the acc is enabled
- hw->sip =3D 2 (acc_sip =3D 1, gyro_sip =3D 1) when both devices are enabl=
ed

I guess it is just a matter of adding a 'bool fixed_pattern' in
st_lsm6dsx_settings. What do you think?

Regards,
Lorenzo

>=20
> Anyhow, is my understanding correct?
>=20
> Jonathan
>=20
> >=20
> > Sidenote: I thought about renaming things to "lsm6ds0" here just because
> > of the name and because the registers are (almost) the same as for my
> > lsm9ds1. But I'm not a fan of blindly doing that without being able to
> > test. When the current patchset looks good to you, let's keep it that w=
ay.
> >=20
> >                             martin
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXT3g3wAKCRA6cBh0uS2t
rGupAQCt+nMZtGSwipK9+ymzax7tfEW+pxfeFjw/zMEAu1c1gwD/bN3E83uTG5Nf
SrhTtz0NnIlKgEyO09ceZtLisuQUXA0=
=BiVb
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
