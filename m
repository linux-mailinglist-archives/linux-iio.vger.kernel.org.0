Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885320C8CF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgF1Pwe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgF1Pwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 11:52:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10CC03E979
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 08:52:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZbY-0003HE-G8; Sun, 28 Jun 2020 17:52:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpZbU-0000eg-SY; Sun, 28 Jun 2020 17:52:24 +0200
Date:   Sun, 28 Jun 2020 17:52:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/23] iio:adc:ltc2496: Drop of_match_ptr and use
 mod_devicetable.h
Message-ID: <20200628155221.jujln4b24jlorpbk@pengutronix.de>
References: <20200628123654.32830-1-jic23@kernel.org>
 <20200628123654.32830-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wzedzoqqddpvr3d"
Content-Disposition: inline
In-Reply-To: <20200628123654.32830-8-jic23@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6wzedzoqqddpvr3d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Jonathan,

On Sun, Jun 28, 2020 at 01:36:38PM +0100, Jonathan Cameron wrote:
> @@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(of, ltc2496_of_match);
>  static struct spi_driver ltc2496_driver =3D {
>  	.driver =3D {
>  		.name =3D "ltc2496",
> -		.of_match_table =3D of_match_ptr(ltc2496_of_match),
> +		.of_match_table =3D ltc2496_of_match,

The usage of of_match_ptr would only make sense here if ltc2496_of_match
was defined conditionally. As this isn't the case:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6wzedzoqqddpvr3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl74vLIACgkQwfwUeK3K
7AnnxQf/VevfHTbILg33oxSQVV7U1cmbcruqEou6VEjMHGY0SVWFHLr/DdZTbT/k
GbKcTKlvzZsumTUpt8njLFBuJaYRjEI+/dtH1unwMNFl26HYBlAiCZ13W71cx8tH
qfAcyQNRufg+IXkoPYPVtn4xQGOYoE0XcjKYlXA4komfZLwu0og4zFqYBflaBRAj
+DiHPuHBTLC825ap+OJFFIwkAqCHGRKURaXtagUWLjNwSfV1AxvcFab1ZnfXhOkf
1KWtJiPnuN1Bev5cCaH6DXs01vUufciiU7qMfMel2GIKgGyCIjFcybsY+WvhZTDH
RFWggtD5Alb1QS4G0GbR39DjPtThoA==
=FQ9G
-----END PGP SIGNATURE-----

--6wzedzoqqddpvr3d--
