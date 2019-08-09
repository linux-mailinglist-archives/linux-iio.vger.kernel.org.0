Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83E87EEC
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2019 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436977AbfHIQGi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Aug 2019 12:06:38 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:41474 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436958AbfHIQGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Aug 2019 12:06:38 -0400
Received: from dslb-188-096-144-190.188.096.pools.vodafone-ip.de ([188.96.144.190] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1hw7PU-0003zu-A6; Fri, 09 Aug 2019 18:06:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] iio: potentiometer: max5432: update the non-volatile position
Date:   Fri,  9 Aug 2019 18:06:17 +0200
Message-Id: <20190809160617.21035-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Keep track of the wiper position that was set by user space. Store the
current wiper position in the chip's non-volatile register when the
system is rebooted. This will be the initial position next time the
max5432 chip is powered.

Update the register in the i2c client's shutdown function. Unlike the
remove function, shutdown is called when the system is rebooted. It's
safe to send an i2c message in the shutdown function.

Skip the update if user space never changed the wiper position.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
The patch is against the testing branch in
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
It seems that this branch is not merged into linux-next.

 drivers/iio/potentiometer/max5432.c | 43 +++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
index 641b1821fdf6..73449078c89b 100644
--- a/drivers/iio/potentiometer/max5432.c
+++ b/drivers/iio/potentiometer/max5432.c
@@ -16,16 +16,33 @@
 
 /* All chip variants have 32 wiper positions. */
 #define MAX5432_MAX_POS 31
+/*
+ * Initial value when the wiper position is unknown.
+ * (The chip does not support reading the current position.)
+ */
+#define MAX5432_INVALID_POS (MAX5432_MAX_POS + 1)
 
 #define MAX5432_OHM_50K   (50  * 1000)
 #define MAX5432_OHM_100K  (100 * 1000)
 
 /* Update the volatile (currently active) setting. */
 #define MAX5432_CMD_VREG  0x11
+/*
+ * Update the non-volatile setting that's used to initialize the wiper
+ * at startup.
+ */
+#define MAX5432_CMD_NVREG 0x21
+
+/*
+ * Wiper position is in bits D7-D3 of the data byte.
+ * (D2-D0 are don't care bits.)
+ */
+#define WIPER_POS_DATA(pos) ((pos) << 3)
 
 struct max5432_data {
 	struct i2c_client *client;
 	unsigned long ohm;
+	u8 wiper_pos;
 };
 
 static const struct iio_chan_spec max5432_channels[] = {
@@ -63,7 +80,6 @@ static int max5432_write_raw(struct iio_dev *indio_dev,
 			int val, int val2, long mask)
 {
 	struct max5432_data *data = iio_priv(indio_dev);
-	u8 data_byte;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -74,10 +90,10 @@ static int max5432_write_raw(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	/* Wiper position is in bits D7-D3. (D2-D0 are don't care bits.) */
-	data_byte = val << 3;
+	data->wiper_pos = val;
+
 	return i2c_smbus_write_byte_data(data->client, chan->address,
-			data_byte);
+			WIPER_POS_DATA(data->wiper_pos));
 }
 
 static const struct iio_info max5432_info = {
@@ -101,6 +117,7 @@ static int max5432_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	data->ohm = (unsigned long)of_device_get_match_data(dev);
+	data->wiper_pos = MAX5432_INVALID_POS;
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &max5432_info;
@@ -111,6 +128,23 @@ static int max5432_probe(struct i2c_client *client,
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static void max5432_shutdown(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct max5432_data *data;
+
+	indio_dev = i2c_get_clientdata(client);
+	if (!indio_dev)
+		return;
+
+	data = iio_priv(indio_dev);
+	if (data->wiper_pos == MAX5432_INVALID_POS)
+		return;
+
+	i2c_smbus_write_byte_data(client, MAX5432_CMD_NVREG,
+			WIPER_POS_DATA(data->wiper_pos));
+}
+
 static const struct of_device_id max5432_dt_ids[] = {
 	{ .compatible = "maxim,max5432", .data = (void *)MAX5432_OHM_50K  },
 	{ .compatible = "maxim,max5433", .data = (void *)MAX5432_OHM_100K },
@@ -126,6 +160,7 @@ static struct i2c_driver max5432_driver = {
 		.of_match_table = of_match_ptr(max5432_dt_ids),
 	},
 	.probe = max5432_probe,
+	.shutdown = max5432_shutdown,
 };
 
 module_i2c_driver(max5432_driver);
-- 
2.11.0

