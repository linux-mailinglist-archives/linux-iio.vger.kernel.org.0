Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783D56B404
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jul 2022 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiGHIDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiGHIDE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 04:03:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E97E01F
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 01:03:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o9ix4-00010G-9D; Fri, 08 Jul 2022 10:03:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o9iwz-00572q-MP; Fri, 08 Jul 2022 10:03:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o9ix2-003kMf-It; Fri, 08 Jul 2022 10:03:00 +0200
Date:   Fri, 8 Jul 2022 10:02:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de, Thorsten Scherer <t.scherer@eckelmann.de>
Subject: ti-ads7950: selecting the adc input range
Message-ID: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxnvvyg2lm6hrqwl"
Content-Disposition: inline
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


--jxnvvyg2lm6hrqwl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the ADS7950 has a register bit (called TI_ADS7950_CR_RANGE_5V in the
driver) that selects the input range. Depending on that bit the input
range is either [0 .. V_{REF}] or [0 .. 2 * V_{REF}].

The driver currently defaults to setting that bit, so the range is the
big one.

On a machine here however I know the input is in the smaller range and
I'd like to benefit from the higher resolution of the small range. I
wonder how to make this tunable. Should that be done using a firmware
property? ("single-input-range" vs. "double-input-range"? Or input-range
=3D <1> vs. input-range =3D <2> which better matches the data sheet that
calls the two modes "Range 1 (0 to V_{REF})" and "Range 2 (0 to
2xV_{REF})") Or should this be made tunable via sysfs? (E.g. by writing
to the scale property? Or a separate property?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jxnvvyg2lm6hrqwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLH5K4ACgkQwfwUeK3K
7AlkiQf8CXL8pEUO9pJCd4auXuz/RbQeCs1ng05vS5Z0ZMykuZ1Xu+e8dGPhcJ1v
3HEPSlc6wURHaFLtbr9UdS90sQr30cNZJaXzoYgncX2utLZcVHJFb3vIhtj5oPIE
TE5QWU0kvPELbi46V4GmExuP//DBoPWeVXAUa8JdRI6qPMPXynrzvYLCGTX3cLx2
r2sVwAs/KqfDMQk+PtbhuKSRQLAdp0mcQ+hRCuLo8p9b+NvMGb9hzWiFCuBZqetn
j645bmLoT3moVSk97nozfIWRkgcWih3rtVnPUyEVGXmhC5ooevyK58PINLVC93m3
0oR3b7rJM8L3YStwzbvGBYm8tFfaPA==
=rSEQ
-----END PGP SIGNATURE-----

--jxnvvyg2lm6hrqwl--
