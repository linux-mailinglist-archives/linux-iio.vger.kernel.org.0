Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1942CAFF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJMUes (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhJMUer (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 16:34:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E18C061746
        for <linux-iio@vger.kernel.org>; Wed, 13 Oct 2021 13:32:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvV-0007O8-Ry; Wed, 13 Oct 2021 22:32:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvV-0005o9-1c; Wed, 13 Oct 2021 22:32:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvR-0000Qp-Vu; Wed, 13 Oct 2021 22:32:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 11/15] iio: health: afe4403: Don't return an error in .remove()
Date:   Wed, 13 Oct 2021 22:32:19 +0200
Message-Id: <20211013203223.2694577-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
References: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=b1eSHdLXQo0fr8mn+X+4KScPcaHCO4/keggIi/1q4Ic=; m=AV9d33ugZ5xjfzJFnF52UDd172Pe7zg8wyV68iU6wAc=; p=b5y9nraNfWt6DVEWlyuPTWBy1gSmD0ltzSuPxuPfHRM=; g=08921c495ce67902629f6f91e3b0cfe0c908006a
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFnQgkACgkQwfwUeK3K7AnJ/wgAg8d i5wKOlUDgtEIfp2UcvRSsPKWNhz9w+ZOHo5eqXGg0Ruhp21Sy0y/H4V/ajFdttDhd1uMbjdPH9Xkk EeSbA8Zx2tc0qE1EyMEe4ykabQxtFTGJcEaHLkWQDGqIA+7/0pWA3uhAYjgik7I30QHbn7e0gGR47 Xgkp1y7IC63/WYznOJl6YTYzC3/fwvgcBYhAVb2KZox0RufBEAypfFxOhMJPhJxjxLtCJpq/+dcO0 WvG2QuHcRvTUUugBBUBOKmKb/wOxBusAzeh0Jd00XgvYzCFKacSYqojwGcLlhCq7VomhwGDFaCydX F7e+jmoFYi1w4iFeGySq1fDPW/fuAlw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only effect of returning an error in an spi .remove() callback is
that the spi core issues another warning message. Don't report the same
problem twice and return 0 unconditionally instead. Also degrade the log
level to warning, as nothing really bad is expected from a failure to
put the device in suspend mode.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/health/afe4403.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index d4921385aaf7..0c355063072c 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -589,10 +589,8 @@ static int afe4403_remove(struct spi_device *spi)
 		iio_trigger_unregister(afe->trig);
 
 	ret = regulator_disable(afe->regulator);
-	if (ret) {
-		dev_err(afe->dev, "Unable to disable regulator\n");
-		return ret;
-	}
+	if (ret)
+		dev_warn(afe->dev, "Unable to disable regulator\n");
 
 	return 0;
 }
-- 
2.30.2

