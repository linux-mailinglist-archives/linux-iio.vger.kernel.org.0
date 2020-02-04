Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74C71517EB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgBDJej (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:34:39 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:49326 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJei (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:34:38 -0500
Received: from localhost.localdomain (126.212-243-81.adsl-dyn.isp.belgacom.be [81.243.212.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2884525201;
        Tue,  4 Feb 2020 10:34:36 +0100 (CET)
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
Subject: [PATCH v4 5/7] iio: light: al3320a implement suspend support
Date:   Tue,  4 Feb 2020 10:30:36 +0100
Message-Id: <20200204093031.616409-6-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204093031.616409-1-david@ixit.cz>
References: <20200204093031.616409-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AL3320a is fairly simple chip, so for suspend is enough to disable and
later enable it again.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 89b935b4fe9e..affa4c6c199a 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -7,6 +7,9 @@
  * IIO driver for AL3320A (7-bit I2C slave address 0x1C).
  *
  * TODO: interrupt support, thresholds
+ * When the driver will get support for interrupt handling, then interrupt
+ * will need to be disabled before turning sensor OFF in order to avoid
+ * potential races with the interrupt handling.
  */
 
 #include <linux/bitfield.h>
@@ -78,13 +81,18 @@ static const struct attribute_group al3320a_attribute_group = {
 	.attrs = al3320a_attributes,
 };
 
+static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
+{
+	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
+	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
+}
+
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
 
-	/* power on */
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG,
-					AL3320A_CONFIG_ENABLE);
+	ret = al3320a_set_pwr(data->client, true);
+
 	if (ret < 0)
 		return ret;
 
@@ -203,10 +211,21 @@ static int al3320a_probe(struct i2c_client *client,
 
 static int al3320a_remove(struct i2c_client *client)
 {
-	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG,
-					 AL3320A_CONFIG_DISABLE);
+	return al3320a_set_pwr(client, false);
 }
 
+static int __maybe_unused al3320a_suspend(struct device *dev)
+{
+	return al3320a_set_pwr(to_i2c_client(dev), false);
+}
+
+static int __maybe_unused al3320a_resume(struct device *dev)
+{
+	return al3320a_set_pwr(to_i2c_client(dev), true);
+}
+
+SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, al3320a_resume);
+
 static const struct i2c_device_id al3320a_id[] = {
 	{"al3320a", 0},
 	{}
@@ -216,6 +235,7 @@ MODULE_DEVICE_TABLE(i2c, al3320a_id);
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
+		.pm = &al3320a_pm_ops,
 	},
 	.probe		= al3320a_probe,
 	.remove		= al3320a_remove,
-- 
2.25.0

