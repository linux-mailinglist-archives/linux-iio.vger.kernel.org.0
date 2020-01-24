Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01B1490C0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 23:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAXWN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 17:13:58 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:33206 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgAXWN6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jan 2020 17:13:58 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 278BC251E0;
        Fri, 24 Jan 2020 23:04:12 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 1/7] iio: light: al3320a slightly improve code formatting
Date:   Fri, 24 Jan 2020 23:03:40 +0100
Message-Id: <20200124220346.2655336-1-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Modified to be in part with al3010 driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index a21aa99e74e4..613830b7df6e 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -38,6 +38,11 @@
 
 #define AL3320A_GAIN_SHIFT		1
 #define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
+#define AL3320A_GAIN_READ(g) \
+	(((g) & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT)
+#define AL3320A_GAIN_WRITE(g) \
+	(((g) << AL3320A_GAIN_SHIFT) & AL3320A_GAIN_MASK)
+
 
 /* chip params default values */
 #define AL3320A_DEFAULT_MEAN_TIME	4
@@ -90,7 +95,7 @@ static int al3320a_init(struct al3320a_data *data)
 		return ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
-					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
+					AL3320A_GAIN_WRITE(AL3320A_RANGE_3));
 	if (ret < 0)
 		return ret;
 
@@ -133,7 +138,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		ret = (ret & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT;
+		ret = AL3320A_GAIN_READ(ret);
 		*val = al3320a_scales[ret][0];
 		*val2 = al3320a_scales[ret][1];
 
@@ -152,11 +157,13 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(al3320a_scales); i++) {
-			if (val == al3320a_scales[i][0] &&
-			    val2 == al3320a_scales[i][1])
-				return i2c_smbus_write_byte_data(data->client,
-					AL3320A_REG_CONFIG_RANGE,
-					i << AL3320A_GAIN_SHIFT);
+			if (val != al3320a_scales[i][0] ||
+			    val2 != al3320a_scales[i][1])
+				continue;
+
+			return i2c_smbus_write_byte_data(data->client,
+						AL3320A_REG_CONFIG_RANGE,
+						AL3320A_GAIN_WRITE(i));
 		}
 		break;
 	}
-- 
2.25.0

