Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B21517E5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDJd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:33:57 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:49286 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgBDJd5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:33:57 -0500
Received: from localhost.localdomain (126.212-243-81.adsl-dyn.isp.belgacom.be [81.243.212.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D1EBC251ED;
        Tue,  4 Feb 2020 10:33:54 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org
Subject: [PATCH v4 3/7] iio: light: al3320a slightly improve code formatting
Date:   Tue,  4 Feb 2020 10:30:32 +0100
Message-Id: <20200204093031.616409-4-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204093031.616409-1-david@ixit.cz>
References: <20200204093031.616409-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- modified to be in part with al3010 driver
- cleanup using bitfield, no functionality change intended

Signed-off-by: David Heidelberg <david@ixit.cz>

v4
 - use GENMASK() and bitfields
 - sort headers
 - drop init.h unused header

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index a21aa99e74e4..89b935b4fe9e 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -9,9 +9,9 @@
  * TODO: interrupt support, thresholds
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -36,8 +36,7 @@
 #define AL3320A_CONFIG_DISABLE		0x00
 #define AL3320A_CONFIG_ENABLE		0x01
 
-#define AL3320A_GAIN_SHIFT		1
-#define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
+#define AL3320A_GAIN_MASK		GENMASK(2, 1)
 
 /* chip params default values */
 #define AL3320A_DEFAULT_MEAN_TIME	4
@@ -90,7 +89,8 @@ static int al3320a_init(struct al3320a_data *data)
 		return ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
-					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
+					FIELD_PREP(AL3320A_GAIN_MASK,
+						   AL3320A_RANGE_3));
 	if (ret < 0)
 		return ret;
 
@@ -133,7 +133,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		ret = (ret & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT;
+		ret = FIELD_GET(AL3320A_GAIN_MASK, ret)
 		*val = al3320a_scales[ret][0];
 		*val2 = al3320a_scales[ret][1];
 
@@ -152,11 +152,13 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(al3320a_scales); i++) {
-			if (val == al3320a_scales[i][0] &&
-			    val2 == al3320a_scales[i][1])
-				return i2c_smbus_write_byte_data(data->client,
+			if (val != al3320a_scales[i][0] ||
+			    val2 != al3320a_scales[i][1])
+				continue;
+
+			return i2c_smbus_write_byte_data(data->client,
 					AL3320A_REG_CONFIG_RANGE,
-					i << AL3320A_GAIN_SHIFT);
+					FIELD_PREP(AL3320A_GAIN_MASK, i));
 		}
 		break;
 	}
-- 
2.25.0

