Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2614F94B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 19:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgBASBd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 13:01:33 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:54026 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBASBc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 13:01:32 -0500
Received: from localhost.localdomain (silversquare.silversquare.eu [185.174.184.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 44DD325203;
        Sat,  1 Feb 2020 19:01:30 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 5/7] iio: light: al3010 implement suspend support
Date:   Sat,  1 Feb 2020 19:00:22 +0100
Message-Id: <20200201180024.328700-6-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201180024.328700-1-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AL3010 is fairly simple chip, so for suspend is enough to disable and
later enable it again.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 4b951c087c83..202f25b595c8 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -8,6 +8,9 @@
  * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
  *
  * TODO: interrupt support, thresholds
+ * When the driver will get support for interrupt handling, then interrupt
+ * will need to be disabled before turning sensor OFF in order to avoid
+ * potential races with the interrupt handling.
  */
 
 #include <linux/i2c.h>
@@ -71,13 +74,18 @@ static const struct attribute_group al3010_attribute_group = {
 	.attrs = al3010_attributes,
 };
 
+static int al3010_set_pwr(struct i2c_client *client, bool pwr)
+{
+	u8 val = pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
+	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
+}
+
 static int al3010_init(struct al3010_data *data)
 {
 	int ret;
 
-	/* power on */
-	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM,
-					AL3010_CONFIG_ENABLE);
+	ret = al3010_set_pwr(data->client, true);
+
 	if (ret < 0)
 		return ret;
 
@@ -185,10 +193,21 @@ static int al3010_probe(struct i2c_client *client,
 
 static int al3010_remove(struct i2c_client *client)
 {
-	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM,
-					 AL3010_CONFIG_DISABLE);
+	return al3010_set_pwr(client, false);
 }
 
+static int __maybe_unused al3010_suspend(struct device *dev)
+{
+	return al3010_set_pwr(to_i2c_client(dev), false);
+}
+
+static int __maybe_unused al3010_resume(struct device *dev)
+{
+	return al3010_set_pwr(to_i2c_client(dev), true);
+}
+
+SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
+
 static const struct i2c_device_id al3010_id[] = {
 	{"al3010", 0},
 	{}
@@ -205,6 +224,7 @@ static struct i2c_driver al3010_driver = {
 	.driver = {
 		.name = AL3010_DRV_NAME,
 		.of_match_table = al3010_of_match,
+		.pm = &al3010_pm_ops,
 	},
 	.probe		= al3010_probe,
 	.remove		= al3010_remove,
-- 
2.25.0

