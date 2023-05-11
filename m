Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF96FEB98
	for <lists+linux-iio@lfdr.de>; Thu, 11 May 2023 08:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEKGP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 May 2023 02:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEKGP2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 May 2023 02:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F24EC7
        for <linux-iio@vger.kernel.org>; Wed, 10 May 2023 23:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzaG-0006Hq-Mz; Thu, 11 May 2023 08:15:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzaE-002fAN-OF; Thu, 11 May 2023 08:15:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwzaD-003KNe-Tx; Thu, 11 May 2023 08:15:21 +0200
Date:   Thu, 11 May 2023 08:15:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] iio: dac: mcp4725: Fix i2c_master_send() return value
 handling
Message-ID: <20230511061521.ri6gnymsasnrpde2@pengutronix.de>
References: <20230511004330.206942-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xq6znmo5hzzbpjqv"
Content-Disposition: inline
In-Reply-To: <20230511004330.206942-1-marex@denx.de>
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


--xq6znmo5hzzbpjqv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 02:43:30AM +0200, Marek Vasut wrote:
> The i2c_master_send() returns number of sent bytes on success,
> or negative on error. The suspend/resume callbacks expect zero
> on success and non-zero on error. Adapt the return value of the
> i2c_master_send() to the expectation of the suspend and resume
> callbacks, including proper validation of the return value.
>=20
> Fixes: cf35ad61aca2 ("iio: add mcp4725 I2C DAC driver")
> Signed-off-by: Marek Vasut <marex@denx.de>

Makes sense,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xq6znmo5hzzbpjqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRch/gACgkQj4D7WH0S
/k7LOAf+LlyabNFyDoOD3c6qwSwU59L0hIk/sW/1WxvbqYvzp/r+zh96HLIb3hWi
Xpg2twV6p1h2DRz+L/j7ETAKc74jS75DonuY3r8BP2f8pmVOPUzW/rrlFPmPV11Y
Mt34Q10oSMel85lTXdjLRTmT2bjdRXv1owB23bpnJPpDLobuo7+eSSIfxhk4/PnW
5z/7pMYfZPWtiUUEywvBZxktz5KY7yVMD8QGwbTH90CK9dBBFHbEVAmaqHKZC3yL
0Avx/bPLjsmEDdHnFIScN6uYydx8jtV+WNmnruf+nF72cAqHnu1PycgurimK2VpW
1bb9S3mLKCO4pmvs/IfIGJmzKWeppg==
=cmIM
-----END PGP SIGNATURE-----

--xq6znmo5hzzbpjqv--
