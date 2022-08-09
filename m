Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0F58D345
	for <lists+linux-iio@lfdr.de>; Tue,  9 Aug 2022 07:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiHIFh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 01:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHIFh4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 01:37:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425715FCA
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 22:37:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLHw8-0000ni-31; Tue, 09 Aug 2022 07:37:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLHvz-002e5J-Dy; Tue, 09 Aug 2022 07:37:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLHw0-00AVv6-UK; Tue, 09 Aug 2022 07:37:44 +0200
Date:   Tue, 9 Aug 2022 07:37:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 04/13] iio: adc: ingenic-adc: Benefit from
 devm_clk_get_prepared() to simplify
Message-ID: <20220809053740.wtjkzrjzujc6gdry@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-4-u.kleine-koenig@pengutronix.de>
 <CAHp75Vf=ab3AYn+9dys7vDOr7yBY0cdquE0bMVdZmSk31b5KKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="so4siwl76bqg2npx"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf=ab3AYn+9dys7vDOr7yBY0cdquE0bMVdZmSk31b5KKw@mail.gmail.com>
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


--so4siwl76bqg2npx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Aug 08, 2022 at 11:01:39PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 10:47 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Make use of devm_clk_get_prepared() to replace some code that effective=
ly
> > open codes this new function.
>=20
> Copy'n'paste typo in the Subject.

Good catch, thanks. I fixed it in my private tree, so it will be fixed
on resend. The Subject is now:

	iio: adc: ingenic-adc: Benefit from devm_clk_get_prepared() to simplify

Will wait a while for that though, maybe Jonathan will take
care when applying without me resending. I also adapted the subject of
this reply, I wonder if that does more good or more harm :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--so4siwl76bqg2npx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLx8qEACgkQwfwUeK3K
7AmhjAf+LI0z7B4hx7GLn8ISAZaNwJJDolhlHRErfoQfFnQSJ1CqpyMSsKFjk7n4
ivydB5pRXeLgPV9vJM9QfNjMRKYYZjFIxdtQIGluQn99XI8OeP+rOonAXT8bpyrN
ztYHF7m8wa25QjG1VZtI7AJQwKn5ZxmBSdKRHGZfijwUqOmhoEoh9wVv12d+Z0yE
SX/RbjWDnfYED1MmpLTQf795Bq7vBVbk5c1CofGIK3EWsQWRsxHE4WUGuc7+tIhh
qgXPWeVI12275dClx6Vh1HdvCnPD4yOwntRIQitl4dq0fl81ID8h1RsypmOZ9FI1
LDxWQVnQM9AHrQacwuF3y32Mw5HuAw==
=kOzz
-----END PGP SIGNATURE-----

--so4siwl76bqg2npx--
