Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17063C2216
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhGIKOK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGIKOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 06:14:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC18C0613DD
        for <linux-iio@vger.kernel.org>; Fri,  9 Jul 2021 03:11:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1nTb-0003gV-8y; Fri, 09 Jul 2021 12:11:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1nTa-0003oR-1U; Fri, 09 Jul 2021 12:11:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1nTa-0001MI-07; Fri, 09 Jul 2021 12:11:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after reading channels
Date:   Fri,  9 Jul 2021 12:11:10 +0200
Message-Id: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADS7950 requires that CS is deasserted after each SPI word. Before
commit e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
CPU usage") the driver used a message with one spi transfer per channel
where each but the last one had .cs_change set to enforce a CS toggle.
This was wrongly translated into a message with a single transfer and
.cs_change set which results in a CS toggle after each word but the
last which corrupts the first adc conversion of all readouts after the
first readout.

Fixes: e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ti-ads7950.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2383eacada87..a2b83f0bd526 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -568,7 +568,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->ring_xfer.tx_buf = &st->tx_buf[0];
 	st->ring_xfer.rx_buf = &st->rx_buf[0];
 	/* len will be set later */
-	st->ring_xfer.cs_change = true;
 
 	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
 
-- 
2.30.2

