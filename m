Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E0243A43E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhJYUTr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbhJYUTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 16:19:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57EC09F4C2
        for <linux-iio@vger.kernel.org>; Mon, 25 Oct 2021 12:50:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5z3-0006ms-I4; Mon, 25 Oct 2021 21:50:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5z1-0003Y0-On; Mon, 25 Oct 2021 21:50:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mf5z1-0002ij-Nx; Mon, 25 Oct 2021 21:50:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] iio: accel: mma7660: Warn about failure to put device in stand-by in .remove()
Date:   Mon, 25 Oct 2021 21:50:07 +0200
Message-Id: <20211025195007.84541-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=3Yflh9m2MXipexRjBHyLbivWt8k4yNvQ+U1X2WYrrqo=; m=Yv3os0F8ALSzbGLZY8o46hx4IPp26ELZ89s3b9KE7XA=; p=5abyQYaVUzO5WxbZsyAdj7T13c1g4oBRTS+Y0Kp6Klc=; g=0f1a4da5f5bf500bfcd82718d24907ad55ecbdbe
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF3CmwACgkQwfwUeK3K7AkYtQgAkky J8H0QryC/M4cRvypvPx0TS9sbc9TIuSikCj83w6Y0ZzrDzIG59pQ6gcl++nrK8U2puuIJGfFf36u7 Wlc1e2bV3qbjMnhgKoYT4vnWoltAL0Pd6d5UcSg2L43Gngranb5a7d8fQXnvDFHXM/HaoL0KV7UyO CFnfm6nFhuFjxgl8D9MW/JaMkHe/xd/SYYlfTAp5RO0DJ+/8jPG8ibSclRAysYrIDEEr9UIwewG+9 KwuL71I39AgCJqmCcSKSOqzTHDC3CmCF48UQA0Zao+rB8TOc/MYlUX//bGk2lVTf+HI/Dy+wOfsgF uWZueR2wvVgrjL5BE3rgkJsOMxPkgPA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Whan an i2c driver's remove function returns a non-zero error code
nothing happens apart from emitting a generic error message. Make this
error message more device specific and return zero instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/mma7660.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 47f5cd66e996..78c20618fdc3 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -210,10 +210,16 @@ static int mma7660_probe(struct i2c_client *client,
 static int mma7660_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 
-	return mma7660_set_mode(iio_priv(indio_dev), MMA7660_MODE_STANDBY);
+	ret = mma7660_set_mode(iio_priv(indio_dev), MMA7660_MODE_STANDBY);
+	if (ret)
+		dev_warn(&client->dev, "Failed to put device in stand-by mode (%pe), ignoring\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2

