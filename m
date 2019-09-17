Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4473EB5284
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfIQQJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 12:09:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfIQQJj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 12:09:39 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2i-0007j8-FY; Tue, 17 Sep 2019 18:09:28 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2g-0004VR-J1; Tue, 17 Sep 2019 18:09:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     michael.hennerich@analog.com, lars@metafoo.de,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Date:   Tue, 17 Sep 2019 18:09:24 +0200
Message-Id: <20190917160925.9791-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917160925.9791-1-m.felsch@pengutronix.de>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Factor out the configuration register update to reuse it during pm
resume operation.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/iio/adc/ad799x.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f658012baad8..af5a2de9c22f 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -167,6 +167,21 @@ static int ad799x_read_config(struct ad799x_state *st)
 	}
 }
 
+static int ad799x_update_config(struct ad799x_state *st, u16 config)
+{
+	int ret;
+
+	ret = ad799x_write_config(st, config);
+	if (ret < 0)
+		return ret;
+	ret = ad799x_read_config(st);
+	if (ret < 0)
+		return ret;
+	st->config = ret;
+
+	return 0;
+}
+
 /**
  * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
@@ -808,13 +823,9 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	ret = ad799x_write_config(st, st->chip_config->default_config);
-	if (ret < 0)
-		goto error_disable_vref;
-	ret = ad799x_read_config(st);
-	if (ret < 0)
+	ret = ad799x_update_config(st, st->chip_config->default_config);
+	if (ret)
 		goto error_disable_vref;
-	st->config = ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
-- 
2.20.1

