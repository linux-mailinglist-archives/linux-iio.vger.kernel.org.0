Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AA47F3D7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhLYQfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLYQfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:35:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B5C061401
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:35:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n1A0U-00028k-Gn; Sat, 25 Dec 2021 17:34:54 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-b4ef-4811-d475-81e0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b4ef:4811:d475:81e0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 941E46CB20E;
        Sat, 25 Dec 2021 16:34:52 +0000 (UTC)
Date:   Sat, 25 Dec 2021 17:34:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v1 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211225163451.iwwn7u7bku4r4nk4@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
 <20211225161056.682797-14-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2ny3jxmfdnwwyyc"
Content-Disposition: inline
In-Reply-To: <20211225161056.682797-14-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--h2ny3jxmfdnwwyyc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.12.2021 17:10:46, Uwe Kleine-K=C3=B6nig wrote:
> The current implementation gets device lifetime tracking wrong. The
> problem is that allocation of struct counter_device is controlled by the
> individual drivers but this structure contains a struct device that
> might have to live longer than a driver is bound. As a result a command
> sequence like:
>=20
> 	{ sleep 5; echo bang; } > /dev/counter0 &
> 	sleep 1;
> 	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-coun=
ter/unbind
>=20
> can keep a reference to the struct device and unbinding results in
> freeing the memory occupied by this device resulting in an oops.
>=20
> This commit provides two new functions (plus some helpers):
>  - counter_alloc() to allocate a struct counter_device that is
>    automatically freed once the embedded struct device is released
>  - counter_add() to register such a device.
>=20
> Note that this commit doesn't fix any issues, all drivers have to be
> converted to these new functions to correct the lifetime problems.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/counter/counter-core.c | 149 ++++++++++++++++++++++++++++++++-
>  include/linux/counter.h        |  15 ++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 00c41f28c101..17a93e6c018a 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
> =20
> @@ -24,6 +25,11 @@
>  /* Provides a unique ID for each counter device */
>  static DEFINE_IDA(counter_ida);
> =20
> +struct counter_device_allochelper {
> +	struct counter_device counter;
> +	unsigned long privdata[0];
> +};

Is this a use case for DECLARE_FLEX_ARRAY()?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h2ny3jxmfdnwwyyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHHSCgACgkQqclaivrt
76m9Sgf/SmijATNN8YczoqCVkgUjairDuRzTj19kbGKukAuHgca7LLV7iAjVbamE
4O7Ukt2oDRRvknrNBmYSHbSzYVPTua39iuoiMl4DWQSppiarPjEED5TwvejkaI/U
wckssd9mW66QlyvIUuWIjUgTAkpNqjp9iYpupcIcE620RZGnUsQs3TrcnefhFJQL
HT/zDTrbQn/jeB27TMo2/8RqUcihyBPFUqMMJFflLQwXfFgZLs4c8AAL217XXUD5
SIuV5qJxdOPbEtiNHCl68VE01xdTdCB1ttLsiBWgziHa6TtwZduGhvjMGBSBdzst
g7wPizUXXXImNddjBDDjEIKlR0JXiA==
=pk3X
-----END PGP SIGNATURE-----

--h2ny3jxmfdnwwyyc--
