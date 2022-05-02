Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C31516B5B
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358770AbiEBHlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 03:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358360AbiEBHlb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 03:41:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B9EB87C
        for <linux-iio@vger.kernel.org>; Mon,  2 May 2022 00:38:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlQd3-0000eo-4I; Mon, 02 May 2022 09:37:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlQd3-006UPG-MU; Mon, 02 May 2022 09:37:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlQd1-0070zb-G7; Mon, 02 May 2022 09:37:55 +0200
Date:   Mon, 2 May 2022 09:37:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/9] iio:light:stk3310: Remove duplicated error reporting
 in .remove()
Message-ID: <20220502073755.rku3yv6il5efew2x@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
 <20220430081607.15078-9-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6g6zfbmn6h6mnga3"
Content-Disposition: inline
In-Reply-To: <20220430081607.15078-9-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6g6zfbmn6h6mnga3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Apr 30, 2022 at 10:16:06AM +0200, Uwe Kleine-K=F6nig wrote:
> Returning an error value in an i2c remove callback results in an error
> message being emitted by the i2c core, but otherwise it doesn't make a
> difference. The device goes away anyhow and the devm cleanups are
> called.
>=20
> As stk3310_set_state() already emits an error message on failure and the
> additional error message by the i2c core doesn't add any useful
> information, change the return value to zero to suppress this message.
>=20
> This patch is a preparation for making i2c remove callbacks return void.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iio/light/stk3310.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 1d02dfbc29d1..95a98af08b8a 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -627,9 +627,12 @@ static int stk3310_probe(struct i2c_client *client,
>  static int stk3310_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	int ret;
> =20
>  	iio_device_unregister(indio_dev);
> -	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> +	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> +
> +	return 0;
>  }

I just found a fixup in my tree that drops the

	+	int ret;

that I failed to squash in before sending.

Jonathan: Tell me if you want to fixup yourself when you apply, or if
you prefer a v2. If the latter, only for this patch or the whole series?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6g6zfbmn6h6mnga3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJvilAACgkQwfwUeK3K
7AnC9gf8DIKhRYOCPzeQxrXVKDBeDev+kQ6Orgk/xjrNftapc2brBmObqvwNMouZ
tiJRSEmAnRY/UOhz7wBPyjPFL7IeZ6MLwQpYn4est/r3b6y92q8e0IperQN6RQ+q
J73hXqXCw2mZpfBoyvossVBLUHUfFP2xld9U9s9XjUb0g3u30FN3eUv4IlkoqpPc
5FlC0y0w04glf4a+p3X+6rsRf3QjTWVqt/fHLwyBZ8xMle7uAsS/l1dlSCnIwiRR
5GGsCRGC2kW7bjmezdKmEPY003vpj8UFX1mGwhEMh0o7p6yrcKJaLzY2A48b9Jk5
95zXGGFhKE7+YEUzXO4EtEgQZhEfZg==
=x1N0
-----END PGP SIGNATURE-----

--6g6zfbmn6h6mnga3--
