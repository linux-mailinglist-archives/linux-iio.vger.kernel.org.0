Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54339B605
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDJek (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFDJej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 05:34:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F55C06174A
        for <linux-iio@vger.kernel.org>; Fri,  4 Jun 2021 02:32:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lp6C5-0001Kh-JB; Fri, 04 Jun 2021 11:32:45 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lp6C3-0007hY-Rn; Fri, 04 Jun 2021 11:32:43 +0200
Date:   Fri, 4 Jun 2021 11:32:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210604093243.fxyia23i5eq4y5c7@pengutronix.de>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
 <20210603172025.314b5ced@jic23-huawei>
 <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
 <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604092043.0b13f24a@jic23-huawei>
 <20210604085318.dpgazzldn3g3xpq6@pengutronix.de>
 <PH0PR11MB51916BF5C390C90F66385E8BF13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c42if2bszfropvgv"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB51916BF5C390C90F66385E8BF13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--c42if2bszfropvgv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 09:04:48AM +0000, Li, Meng wrote:
> > On Fri, Jun 04, 2021 at 09:20:43AM +0100, Jonathan Cameron wrote:
> > > On Fri, 4 Jun 2021 06:43:20 +0000
> > > "Li, Meng" <Meng.Li@windriver.com> wrote:
> > > > > On Fri, Jun 04, 2021 at 02:16:39AM +0000, Li, Meng wrote:
> > > > > > I think the ret is essential.
> > > > >
> > > > > I'd like to understand why. Currently ltc2497core_read() looks as
> > > > > follows (simplified by dropping error handling, and unrolling the
> > > > > result_and_measure callback for the i2c case):
> > > > >
> > > > > 	ltc2497core_wait_conv()
> > > > >
> > > > > 	// result_and_measure(address, NULL)
> > > > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > > > >
> > > > > 	msleep_interruptible(LTC2497_CONVERSION_TIME_MS)
> > > > >
> > > > > 	// result_and_measure(address, val);
> > > > > 	i2c_master_recv(client, &buf, 3);
> > > > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > > > >
> > > > >
> > > > > With the early return you suggest to introduce with your patch you
> > > > > save the last i2c_smbus_write_byte call. The data sheet indeed
> > > > > claims to start a new conversion at the stop condition.
> > > > >
> > > > > So either the reading of the conversion result and programming of
> > > > > the
> > > > > (maybe) new address has to be done in a single i2c transfer, or we
> > > > > have to do something like your patch.
> > > > >
> > > > > What I don't like about your approach is that it changes the
> > > > > semantic of the callback to result_*or*_measure which is something
> > > > > the spi variant cannot implement. With the current use of the
> > > > > function this is fine, however if at some time in the future we
> > > > > implement a bulk conversion shortcut this hurts.
> > > > >
> > > > > So I suggest to do:
> > > > >
> > > > > ---->8----
> > > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > Date: Fri, 4 Jun 2021 08:02:44 +0200
> > > > > Subject: [PATCH] iio: ltc2497: Fix reading conversion results
> > > > >
> > > > > After the result of the previous conversion is read the chip
> > > > > automatically starts a new conversion and doesn't accept new i2c
> > > > > transfers until this conversion is completed which makes the func=
tion return failure.
> > > > >
> > > > > So add an early return iff the programming of the new address isn=
't needed.
> > > > > Note this will not fix the problem in general, but all cases that
> > > > > are currently used. Once this changes we get the failure back, but
> > > > > this can be addressed when the need arises.
> > > > >
> > > > > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol
> > > > > independent part in a separate module ")
> > > > > Reported-by: Meng Li <Meng.Li@windriver.com>
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > >  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > > > --- a/drivers/iio/adc/ltc2497.c
> > > > > +++ b/drivers/iio/adc/ltc2497.c
> > > > > @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct
> > > > > ltc2497core_driverdata *ddata,
> > > > >  		}
> > > > >
> > > > >  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > > > > +
> > > > > +		/*
> > > > > +		 * The part started a new conversion at the end of the above i=
2c
> > > > > +		 * transfer, so if the address didn't change since the last ca=
ll
> > > > > +		 * everything is fine and we can return early.
> > > > > +		 * If not (which should only happen when some sort of bulk
> > > > > +		 * conversion is implemented) we have to program the new
> > > > > +		 * address. Note that this probably fails as the conversion th=
at
> > > > > +		 * was triggered above is like not complete yet and the two
> > > > > +		 * operations have to be done in a single transfer.
> > > > > +		 */
> > >
> > > I'm a little confused by this comment.  It seems to say it will fail
> > > if we ever do have a different address?  That doesn't seem very helpf=
ul...
> >=20
> > It's not a real problem in the sense that it triggers today. If you wan=
t to read
> > out (say) the channels 1, 5, 6 and 7, you could do:
> >=20
> > 	start conversion for channel 1
> > 	wait for the conversion to complete
> > 	read out conversion for channel 1 and start channel 5
> > 	wait for the conversion to complete
> > 	read out conversion for channel 5 and start channel 6
> > 	wait for the conversion to complete
> > 	read out conversion for channel 6 and start channel 7
> > 	wait for the conversion to complete
> > 	read out conversion for channel 7
>=20
> Have you tested above case on real hardware? Or only a inference based on=
 data sheet?

I never had the ltc2497 in my hands, but the customer I created my
patches for uses the ltc2496 (i.e. its spi variant) and did the above
=66rom userspace using spidev.

And I'm confident enough to claim that if your patch fixes your problem,
then mine does it, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c42if2bszfropvgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC58zgACgkQwfwUeK3K
7AnOHwf9Es9JsTXq2i/pJgOPRnr++pzADnsjeRmV2lzoJKkqUvVB5VwNtaACW0OM
Dr2xQFz0L56idPZhh2J+DhRdUWWjnLInpYdbU63fVSvs1C9gwJiJU1cox1PmaJdS
tDM10Y8vxLovZhWfI6gA8TTB2dUAuL3PO+bul7OUBlQU/gQRtijR9vd8mGnoOImi
5QS9R8QoR+fKSGa9guHInGd4+Jbu+Ds4ZNWOFBe4klQrSkqf6vqUnhY2YwAuQiB+
K/htT5j3a2b8SuQEYgbbE4D5/DTpx1DovlDKVVKsrDCSGUsNmYPEMJ8zfVttykh1
7yG6W6VGAvNmq7eixnvDEOPiTR1c9Q==
=0bOL
-----END PGP SIGNATURE-----

--c42if2bszfropvgv--
