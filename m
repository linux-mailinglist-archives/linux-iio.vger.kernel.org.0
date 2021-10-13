Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CF42CB08
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJMUev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 16:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJMUeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 16:34:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A34FC061570
        for <linux-iio@vger.kernel.org>; Wed, 13 Oct 2021 13:32:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makva-0007VD-8M; Wed, 13 Oct 2021 22:32:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvZ-0005p2-ND; Wed, 13 Oct 2021 22:32:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1makvS-0000Qy-J1; Wed, 13 Oct 2021 22:32:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 14/15] iio: potentiometer: max5487: Don't return an error in .remove()
Date:   Wed, 13 Oct 2021 22:32:22 +0200
Message-Id: <20211013203223.2694577-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
References: <20211013203223.2694577-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=jVPTKwSeclxrMyKXVeMZkRtIkFfWUw7Cm5R85mYX66M=; m=Ny4oct9Jf0z6n4JOPr7OcxYVZiseb8hsZZJoorD1Eu4=; p=/kUxKTIpI1L/SWkpKRbIg3ubFOqQ+I22vGlaTfGNA1k=; g=abfe398bfb2ba7166fc6ee6ef91c0c08715fa870
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFnQhMACgkQwfwUeK3K7AmUBwf+PdU x0kpDjADPeA7Y68U6Gy2bApY1hOcgMp91lYji/AJJpFfBv+CBsIM7alBhW/Dleq0IuSYgV0ips4LW DNqiaaE1iEvYiO4UHvDNk5pM3OnXnfm6GTMeV7g2HFPzUIME1qGY5xMK+dvL8oKkkGE4q9U/dpufK T+ZTRrfYi9NWyI+TniMuDVvQuuCdo6IraM2w7qm7AGaRQXpqesIoVcisxBhdnJerHIMcPyI1/2z2q uT/jFQbrnpsgbEIcrE3k5lKi5zB8EOxWtfsWj+FT6YL+l35caUVjWJKmq0+AfexW51+tWvaq9kp5i LTI95+U8x3M4ShDrMpdsFSoJfz2wFhA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only effect of returning an error in an spi .remove() callback is
that the spi core issues a generic warning message. Instead emit a more
specific error message and return 0 to not report the same issue twice.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/potentiometer/max5487.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 1c0d46a96200..007c2bd324cb 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -115,11 +115,16 @@ static int max5487_spi_probe(struct spi_device *spi)
 static int max5487_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	int ret;
 
 	iio_device_unregister(indio_dev);
 
 	/* save both wiper regs to NV regs */
-	return max5487_write_cmd(spi, MAX5487_COPY_AB_TO_NV);
+	ret = max5487_write_cmd(spi, MAX5487_COPY_AB_TO_NV);
+	if (ret)
+		dev_warn(&spi->dev, "Failed to save wiper regs to NV regs\n");
+
+	return 0;
 }
 
 static const struct spi_device_id max5487_id[] = {
-- 
2.30.2

