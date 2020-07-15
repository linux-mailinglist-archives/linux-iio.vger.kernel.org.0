Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAA22044D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 07:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGOFUb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 15 Jul 2020 01:20:31 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17761 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 01:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594789489; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IaFkgGxXvlW3PUWIovZ8kC2eC4LQV9m4UOipkD36LSO5ksfn2W/vztp652pLPsvPXMKyOa2VAcxVd9IA5256MnVAdEZuNfNOphYBVSv+CCi8xQp0IBGTrqCkynuHvBCVfBYysiFtlus0HW4d8iy/CeCPpWUL/wBqQU2WMXFrpMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1594789489; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JHQK/TFxR4kmZbwOzZ3pTnACnBOLvgj+GeovjsaAiDs=; 
        b=lsWbepM6xukpqXWeWmYTR8anCnprnOsdrlpOd0Rai2XY+f+R8sqWe+FExR5eTSo7v+ubL+UhsfQUMmxm8cXZpd/3aBKY14iA1QHCgFtSD75KYt4JAHdDInZ7Azrb4XQWiGFyZFLFUUzTe8VkwyWq9o3Yusa7/VsOS+qsql7GlVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-108-28-30-30.washdc.fios.verizon.net [108.28.30.30]) by mx.zohomail.com
        with SMTPS id 1594789486978164.27875216302493; Tue, 14 Jul 2020 22:04:46 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200715050226.9751-2-dan@dlrobertson.com>
Subject: [PATCH 1/1] iio: accel: bma400: add PM_SLEEP support
Date:   Wed, 15 Jul 2020 01:02:26 -0400
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715050226.9751-1-dan@dlrobertson.com>
References: <20200715050226.9751-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

 - Add system sleep ops if CONFIG_PM_SLEEP is set.
 - Add attribute for setting the power mode of the
   device.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 drivers/iio/accel/bma400.h      |   3 +
 drivers/iio/accel/bma400_core.c | 132 ++++++++++++++++++++++++--------
 drivers/iio/accel/bma400_i2c.c  |   1 +
 drivers/iio/accel/bma400_spi.c  |   1 +
 4 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 5ad10db9819f..e9dd9e918aac 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -10,6 +10,7 @@
 #define _BMA400_H_
 
 #include <linux/bits.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 /*
@@ -96,4 +97,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
 
 int bma400_remove(struct device *dev);
 
+extern const struct dev_pm_ops bma400_pm_ops;
+
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index cc77f89c048b..5af57b8e1fd7 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -147,36 +147,6 @@ bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
 	return &data->orientation;
 }
 
-static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
-	{ }
-};
-
-#define BMA400_ACC_CHANNEL(_axis) { \
-	.type = IIO_ACCEL, \
-	.modified = 1, \
-	.channel2 = IIO_MOD_##_axis, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
-		BIT(IIO_CHAN_INFO_SCALE) | \
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
-		BIT(IIO_CHAN_INFO_SCALE) | \
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
-	.ext_info = bma400_ext_info, \
-}
-
-static const struct iio_chan_spec bma400_channels[] = {
-	BMA400_ACC_CHANNEL(X),
-	BMA400_ACC_CHANNEL(Y),
-	BMA400_ACC_CHANNEL(Z),
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	},
-};
-
 static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
 {
 	unsigned int raw_temp;
@@ -542,6 +512,73 @@ static int bma400_set_power_mode(struct bma400_data *data,
 	return 0;
 }
 
+static const char * const bma400_power_modes[] = {
+	"sleep",
+	"low-power",
+	"normal"
+};
+
+int bma400_power_mode_enum_get(struct iio_dev *dev,
+			       const struct iio_chan_spec *chan)
+{
+	struct bma400_data *data = iio_priv(dev);
+
+	return data->power_mode;
+}
+
+int bma400_power_mode_enum_set(struct iio_dev *dev,
+			       const struct iio_chan_spec *chan,
+			       unsigned int mode)
+{
+	struct bma400_data *data = iio_priv(dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = bma400_set_power_mode(data, mode);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_enum bma400_power_mode_enum = {
+	.items = bma400_power_modes,
+	.num_items = ARRAY_SIZE(bma400_power_modes),
+	.get = bma400_power_mode_enum_get,
+	.set = bma400_power_mode_enum_set,
+};
+
+static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
+	IIO_ENUM("power_mode", true, &bma400_power_mode_enum),
+	IIO_ENUM_AVAILABLE("power_mode", &bma400_power_mode_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
+	{ }
+};
+
+#define BMA400_ACC_CHANNEL(_axis) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##_axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.ext_info = bma400_ext_info, \
+}
+
+static const struct iio_chan_spec bma400_channels[] = {
+	BMA400_ACC_CHANNEL(X),
+	BMA400_ACC_CHANNEL(Y),
+	BMA400_ACC_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	},
+};
+
 static void bma400_init_tables(void)
 {
 	int raw;
@@ -848,6 +885,41 @@ int bma400_remove(struct device *dev)
 }
 EXPORT_SYMBOL(bma400_remove);
 
+#ifdef CONFIG_PM_SLEEP
+static int bma400_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bma400_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+#endif
+
+const struct dev_pm_ops bma400_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	SET_SYSTEM_SLEEP_PM_OPS(bma400_suspend, bma400_resume)
+#endif
+};
+EXPORT_SYMBOL(bma400_pm_ops);
+
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index 9dcb7cc9996e..52a779d53629 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -48,6 +48,7 @@ static struct i2c_driver bma400_i2c_driver = {
 	.driver = {
 		.name = "bma400",
 		.of_match_table = bma400_of_i2c_match,
+		.pm = &bma400_pm_ops
 	},
 	.probe    = bma400_i2c_probe,
 	.remove   = bma400_i2c_remove,
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 7c2825904e08..358bd26ac4cd 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -108,6 +108,7 @@ static struct spi_driver bma400_spi_driver = {
 	.driver = {
 		.name = "bma400",
 		.of_match_table = bma400_of_spi_match,
+		.pm = &bma400_pm_ops
 	},
 	.probe    = bma400_spi_probe,
 	.remove   = bma400_spi_remove,

