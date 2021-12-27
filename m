Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9228747FB04
	for <lists+linux-iio@lfdr.de>; Mon, 27 Dec 2021 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhL0IWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Dec 2021 03:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhL0IWq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Dec 2021 03:22:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067FC06173E
        for <linux-iio@vger.kernel.org>; Mon, 27 Dec 2021 00:22:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1lH0-0001OA-V4; Mon, 27 Dec 2021 09:22:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1lGl-006te2-Jp; Mon, 27 Dec 2021 09:22:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1lGk-00017S-Bv; Mon, 27 Dec 2021 09:22:10 +0100
Date:   Mon, 27 Dec 2021 09:22:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raymond Tan <raymond.tan@intel.com>,
        David Lechner <david@lechnology.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v1 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20211227082205.ktoeioa5bpxe23o7@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yas26lf3aqngi4bu"
Content-Disposition: inline
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--yas26lf3aqngi4bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I just noticed I had a few dirty changes in my working copy that need to
be squashed into these commits:

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 4315b14f239e..680c7ba943a4 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1084,7 +1084,8 @@ static struct counter_count quad8_counts[] =3D {
=20
 static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
-	struct quad8 *const priv =3D private;
+	struct counter_device *counter =3D private;
+	struct quad8 *const priv =3D counter_priv(counter);
 	const unsigned long base =3D priv->base;
 	unsigned long irq_status;
 	unsigned long channel;
@@ -1115,7 +1116,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *p=
rivate)
 			continue;
 		}
=20
-		counter_push_event(&priv->counter, event, channel);
+		counter_push_event(counter, event, channel);
 	}
=20
 	/* Clear pending interrupts on device */
@@ -1192,7 +1193,7 @@ static int quad8_probe(struct device *dev, unsigned i=
nt id)
 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
=20
 	err =3D devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
-			       counter->name, priv);
+			       counter->name, counter);
 	if (err)
 		return err;
=20
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index d73506436e58..c636183b1337 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -301,7 +301,7 @@ static int ftm_quaddec_probe(struct platform_device *pd=
ev)
=20
 	ret =3D devm_counter_add(&pdev->dev, counter);
 	if (ret)
-		return dev_err_probe(&pdev->dev, "Failed to add counter\n");
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
=20
 	return 0;
 }
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cn=
t.c
index 3f816454220e..9e99702470c2 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -215,7 +215,7 @@ static int interrupt_cnt_probe(struct platform_device *=
pdev)
=20
 	ret =3D devm_counter_add(dev, counter);
 	if (ret < 0)
-		return dev_err_probe(dev, err, "Failed to add counter\n");
+		return dev_err_probe(dev, ret, "Failed to add counter\n");
=20
 	return 0;
 }

Will fix these in a v2.=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yas26lf3aqngi4bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJd6kACgkQwfwUeK3K
7Annswf/cEWCIRh/HeIMHaRPRSvaSxh2rBxyfc3z0z7wQaJj03jBihwc/nn8qhgo
o6ZWNA5T2K7F52mZ6JvlWzfwjiT1QMkrD3TLKUuHtOsA1wczeP0sHoGjwxbVW1dS
P2liVl/ghnIWkIdScGSTF+8MFBSLT/SDA02qJjAGKnZyHAQKO8nL6Dqw2yDkLsNl
Uh6xNNSosj3BJzdc4N54Xx6Q3m+E1xYIaVqULaGJK6u0D38nJPMNo3fP1aC3+6/G
zX0gHXC3vwZqXoSke4Izi98+Xp/RA4e0srz0zsDe2TVHACPfwIMFrkyGaxSutBjQ
O3CwTUZG3KLaAvkX3THSjo+0tSX55g==
=DfAd
-----END PGP SIGNATURE-----

--yas26lf3aqngi4bu--
