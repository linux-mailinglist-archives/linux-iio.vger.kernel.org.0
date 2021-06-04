Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40439B539
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDIzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhFDIzQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 04:55:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F8C06174A
        for <linux-iio@vger.kernel.org>; Fri,  4 Jun 2021 01:53:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lp5Zw-0002PS-KZ; Fri, 04 Jun 2021 10:53:20 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lp5Zu-0004qb-OQ; Fri, 04 Jun 2021 10:53:18 +0200
Date:   Fri, 4 Jun 2021 10:53:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Li, Meng" <Meng.Li@windriver.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210604085318.dpgazzldn3g3xpq6@pengutronix.de>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
 <20210603172025.314b5ced@jic23-huawei>
 <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
 <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604092043.0b13f24a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybtonb6sthdhqszv"
Content-Disposition: inline
In-Reply-To: <20210604092043.0b13f24a@jic23-huawei>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ybtonb6sthdhqszv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 09:20:43AM +0100, Jonathan Cameron wrote:
> On Fri, 4 Jun 2021 06:43:20 +0000
> "Li, Meng" <Meng.Li@windriver.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Sent: Friday, June 4, 2021 2:13 PM
> > > To: Li, Meng <Meng.Li@windriver.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> > > Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after read=
ing the adc
> > > conversion value
> > >=20
> > > Hello,
> > >=20
> > > On Fri, Jun 04, 2021 at 02:16:39AM +0000, Li, Meng wrote: =20
> > > >
> > > > =20
> > > > > -----Original Message-----
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Friday, June 4, 2021 12:20 AM
> > > > > To: Li, Meng <Meng.Li@windriver.com>
> > > > > Cc: lars@metafoo.de; Michael.Hennerich@analog.com;
> > > > > pmeerw@pmeerw.net; u.kleine-koenig@pengutronix.de; linux-
> > > > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after
> > > > > reading the adc conversion value
> > > > >
> > > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > > >
> > > > > On Tue,  1 Jun 2021 17:28:05 +0800
> > > > > Meng.Li@windriver.com wrote:
> > > > > =20
> > > > > > From: Meng Li <Meng.Li@windriver.com>
> > > > > >
> > > > > > When read adc conversion value with below command:
> > > > > > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > > > > > There is an error reported as below:
> > > > > > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transf=
er
> > > > > > issue is introduced by commit 69548b7c2c4f ("iio:
> > > > > > adc: ltc2497: split protocol independent part in a separate mod=
ule").
> > > > > > When extract the common code into ltc2497-core.c, it change the
> > > > > > code logic of function ltc2497core_read(). With wrong reading
> > > > > > sequence, the action of enable adc channel is sent to chip again
> > > > > > during adc channel is in conversion status. In this way, there =
is
> > > > > > no ack from chip, and then cause i2c transfer failed.
> > > > > > In order to keep the code logic is the same with original ideal,
> > > > > > it is need to return direct after reading the adc conversion va=
lue. =20
> > >=20
> > > As background about the choice of the .result_and_measure callback:
> > > A difference between the ltc2497 (i2c) and ltc2496 (spi) is that for =
the latter
> > > reading the result of the last conversion and starting a new is a sin=
gle bus
> > > operation and the one cannot be done without the other.
> > >  =20
> > > > > > v2:
> > > > > > According to ltc2497 datasheet, the max value of conversion time
> > > > > > is
> > > > > > 149.9 ms. So, add 20% to the 150msecs so that there is enough t=
ime
> > > > > > for data conversion. =20
> > > > >
> > > > > Version change logs go below the --- as we don't want to preserve
> > > > > them forever in the git history.
> > > > >
> > > > > I may have lost track of the discussion, but I thought the idea w=
as
> > > > > that perhaps the longer time period would remove the need for the=
 early =20
> > > return? =20
> > > > > =20
> > > >
> > > > No!
> > > > I think the ret is essential. =20
> > >=20
> > > I'd like to understand why. Currently ltc2497core_read() looks as fol=
lows
> > > (simplified by dropping error handling, and unrolling the result_and_=
measure
> > > callback for the i2c case):
> > >=20
> > > 	ltc2497core_wait_conv()
> > >=20
> > > 	// result_and_measure(address, NULL)
> > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > >=20
> > > 	msleep_interruptible(LTC2497_CONVERSION_TIME_MS)
> > >=20
> > > 	// result_and_measure(address, val);
> > > 	i2c_master_recv(client, &buf, 3);
> > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > >=20
> > >=20
> > > With the early return you suggest to introduce with your patch you sa=
ve the
> > > last i2c_smbus_write_byte call. The data sheet indeed claims to start=
 a new
> > > conversion at the stop condition.
> > >=20
> > > So either the reading of the conversion result and programming of the
> > > (maybe) new address has to be done in a single i2c transfer, or we ha=
ve to do
> > > something like your patch.
> > >=20
> > > What I don't like about your approach is that it changes the semantic=
 of the
> > > callback to result_*or*_measure which is something the spi variant ca=
nnot
> > > implement. With the current use of the function this is fine, however=
 if at
> > > some time in the future we implement a bulk conversion shortcut this =
hurts.
> > >=20
> > > So I suggest to do:
> > >  =20
> > > ---->8---- =20
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Date: Fri, 4 Jun 2021 08:02:44 +0200
> > > Subject: [PATCH] iio: ltc2497: Fix reading conversion results
> > >=20
> > > After the result of the previous conversion is read the chip automati=
cally
> > > starts a new conversion and doesn't accept new i2c transfers until th=
is
> > > conversion is completed which makes the function return failure.
> > >=20
> > > So add an early return iff the programming of the new address isn't n=
eeded.
> > > Note this will not fix the problem in general, but all cases that are=
 currently
> > > used. Once this changes we get the failure back, but this can be addr=
essed
> > > when the need arises.
> > >=20
> > > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent p=
art in a
> > > separate module ")
> > > Reported-by: Meng Li <Meng.Li@windriver.com>
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > --- a/drivers/iio/adc/ltc2497.c
> > > +++ b/drivers/iio/adc/ltc2497.c
> > > @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct
> > > ltc2497core_driverdata *ddata,
> > >  		}
> > >=20
> > >  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > > +
> > > +		/*
> > > +		 * The part started a new conversion at the end of the above i2c
> > > +		 * transfer, so if the address didn't change since the last call
> > > +		 * everything is fine and we can return early.
> > > +		 * If not (which should only happen when some sort of bulk
> > > +		 * conversion is implemented) we have to program the new
> > > +		 * address. Note that this probably fails as the conversion that
> > > +		 * was triggered above is like not complete yet and the two
> > > +		 * operations have to be done in a single transfer.
> > > +		 */
>=20
> I'm a little confused by this comment.  It seems to say it will fail if we
> ever do have a different address?  That doesn't seem very helpful...

It's not a real problem in the sense that it triggers today. If you want
to read out (say) the channels 1, 5, 6 and 7, you could do:

	start conversion for channel 1
	wait for the conversion to complete
	read out conversion for channel 1 and start channel 5
	wait for the conversion to complete
	read out conversion for channel 5 and start channel 6
	wait for the conversion to complete
	read out conversion for channel 6 and start channel 7
	wait for the conversion to complete
	read out conversion for channel 7

With this procedure the step "read out conversion for channel X and
start channel Y" has to (and can) be done in a single transfer. But the
status quo is, that when these channels are to be read the following
happens:

	start conversion for channel 1
	wait for the conversion to complete
	read out conversion for channel 1 and (implicitly) start another conversio=
n for channel 1

	wait for the conversion to complete

	start conversion for channel 5
	wait for the conversion to complete
	read out conversion for channel 5 and (implicitly) start another conversio=
n for channel 5

	wait for the conversion to complete

	...

and ltc2497_result_and_measure is well suited to handle this.

So maybe reword the comment to:

	The part started a new conversion at the end of the above i2c
	transfer. With the current implementation of how reading is
	implemented in ltc2497core it never happens that this new
	conversion should be done for a different channel which would
	require writing a new channel address. (Actually writing such a
	new address requires more effort, either another delay must be
	added or the now two transfers must be combined into a single
	one.)

	So check the assumption that the channel really didn't change
	and then return early which does the right thing today.

?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ybtonb6sthdhqszv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC56fsACgkQwfwUeK3K
7AnS1Qf+IvKpChPXbYp9nBfonxn+JUUIGOs1kd4HUSRumMWuuXG+YfiM8/aOOAXr
eH+py8hsM9gbWhX6r0VAH0qDZlhK4OEJ2B0z9Rx/7bmfqlQj++Q9LnXZLgNslXE/
/TJd/nR/5Rv7XenBt7CXONdllFLlj12sBZQol+dTu20DqVia7FWj7nuGvWcqvnNM
T/auqZCglPBhjoUbJbgJq43JIXmoJP/Z/VgeSirCd8zUgCvDGuY1H+iZzoh0gSpd
fvsaO0dlzGSg4y9U5AtXoDKwGVr0hIDQ17J4MaVzD4UkYh9Jsw3FUA5oCCJ1fz/c
ay/9NgI4xOa7pvkBcRdE348Re2a+Ig==
=WbIH
-----END PGP SIGNATURE-----

--ybtonb6sthdhqszv--
