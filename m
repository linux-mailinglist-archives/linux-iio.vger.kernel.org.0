Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330D655345
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiLWRcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiLWRcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:32:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1EFBC10
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 09:32:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8lty-0001rb-NJ; Fri, 23 Dec 2022 18:32:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8ltx-001Glq-PB; Fri, 23 Dec 2022 18:32:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p8ltx-007PMn-2D; Fri, 23 Dec 2022 18:32:09 +0100
Date:   Fri, 23 Dec 2022 18:32:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: light: max44009: Convert to i2c's .probe_new()
Message-ID: <20221223173205.7csw74ie3cfvwygf@pengutronix.de>
References: <20221222145429.614781-1-u.kleine-koenig@pengutronix.de>
 <20221223140415.36064aed@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jf3s2bkxl3yrdhlr"
Content-Disposition: inline
In-Reply-To: <20221223140415.36064aed@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jf3s2bkxl3yrdhlr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2022 at 02:04:15PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Dec 2022 15:54:29 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > The probe function doesn't make use of the i2c_device_id * parameter so
> > it can be trivially converted.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > since the series that mass converted drivers to probe_new this driver
> > was added with the old probe prototype. Fix is accordingly.
>=20
> Nope, this driver has been there since 2019.  It's the one that I failed
> to pick up your patch for originally.  I have it queued up for the coming
> cycle, but not pushed out for next yet because I want to rebase my tree
> on rc1 first.

Ah, ok. I care little about the details if the driver is fixed in the
end.

Best regards and thanks and merry chrismas (if you happen to celebrate
it)
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jf3s2bkxl3yrdhlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOl5hMACgkQwfwUeK3K
7Amo8Af7BQDbijOnPHnmYv0XTuNrkeN8c+s5GMraBQ7D5KaCGzvOYQ/oD/80XSqE
S7JttlqSYgU8+wkKbOC/skQjzXs/vhfYi45XQpmQA36JRwmm2asWGwr0X8fe0SSF
S6vNmBajkOxjfFg0O6UdmNhPIcVRcCkeCFS+pWEfcgKYuKZri3xgFIqWw4mVK/Vl
8pySzvpZUXhKHYw51jg5+7NYKu4EJLnprwFiXH+LH+sR+Uy88x5Yobbk6IEnf6Tj
Fexog0oU8b4iclnT4NNCDUxJN5161CPyh0TLdugdAvGiojN6JYV2CV6MiiW7fQmT
QdgpKRDqFgt18q8zFSyAwbI6Ml43+w==
=rqIs
-----END PGP SIGNATURE-----

--jf3s2bkxl3yrdhlr--
