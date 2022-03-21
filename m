Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0F4E217F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbiCUHnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344992AbiCUHns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 03:43:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D901BA
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 00:42:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nWCfx-0000nF-Eb; Mon, 21 Mar 2022 08:42:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nWCfq-0022R3-5b; Mon, 21 Mar 2022 08:41:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nWCfq-00AdDS-F3; Mon, 21 Mar 2022 08:41:54 +0100
Date:   Mon, 21 Mar 2022 08:41:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        =?utf-8?B?QW5kcsOp?= Gustavo Nakagomi Lopez <andregnl@usp.br>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
        kernel@pengutronix.de, Nuno Sa <nuno.sa@analog.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 04/16] iio: Make use of devm_clk_get_enabled()
Message-ID: <20220321074154.rktt7e54q774puwj@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
 <20220314141643.22184-5-u.kleine-koenig@pengutronix.de>
 <20220319182240.30456776@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wcabes6ykcuxzxg"
Content-Disposition: inline
In-Reply-To: <20220319182240.30456776@jic23-huawei>
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


--2wcabes6ykcuxzxg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Mar 19, 2022 at 06:22:40PM +0000, Jonathan Cameron wrote:
> On Mon, 14 Mar 2022 15:16:31 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Several drivers manually register a devm handler to disable their clk.
> > Convert them to devm_clk_get_enabled().
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> If this does get picked up, can who ever does it please provide
> an immutable branch. With some many drivers cleaned up, it's very
> likely to cause some merge fun somewhere otherwise.

That would be good, indeed. If only the first two patches go in via clk
tree, it would however also be OK for me if the other patches go in only
after the clk changes are in an -rc1. I can care about rebasing if need
be.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2wcabes6ykcuxzxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmI4LD8ACgkQwfwUeK3K
7Ane0ggAk/OC6FOfjgI2+mE4uiT6x6FG5DbQE8wP1WYf0HuOn9J6UyZ+y4p23iYj
xPFUAJ6Nv9m4QowowoLoZLxOnXRzFjI6H8QZSpVkewX/KZiaIfZDgMjuyEugGwWS
UlJTnD3DlE5Zt7jgJ7JMzelwvvaU4z9kXoLLf5gxS5gQGYJXKHxYbrtIZ8QLdC1S
VyL2FQijmMxSTGOKm6Pkhm0vs/NKvDmbUFsUoXgFR64L1jPE3svr4b2tfu371UlY
Z7Q7X1eD9BsU1CJ453EMfPFEA2s6t41ugfzPPeGKaqZCcRZ1HJehJpcICOdjE5p4
UDIA81iXqHaabp8UqT921GZZOCBSCA==
=ip33
-----END PGP SIGNATURE-----

--2wcabes6ykcuxzxg--
