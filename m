Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4465F2831
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJCFib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 01:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJCFia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 01:38:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C42326E6;
        Sun,  2 Oct 2022 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664775509; x=1696311509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BDnxmWv6n7bJ2KCeyvNjhHyOZxAS/6rcF6Ooa+BhmyM=;
  b=IHH2n3MGExYbnITLBiiU3WBrjRJ2jJKcoEohb5QMoMnMT2jCxoY34UfY
   A2PX7VpGu+2pehR8sNLSXL+QKd2ELYz9298c9gzbRdnTOZG5X5v+RHMFa
   hnC41Po1AtfI2NBeIWmKx9q4smxJNdW3U+wchFOZkPoO4KWir8zKGxaa7
   xxp9JWWfo4WNtF8uKB/m5S4eD8Ox/Dxq7RMomvBoIjJUwnVQt/JVb52eD
   ozrsaJp4rOAB5l3oiHGwuu3dP5XFKN1cQq1LNz4lDyCSIfF0b835H8G6N
   otDugNn2lA0//FFYREgjbfifDmXHsjsUKaKgE1v60Knh/3OB7zbYnCu4c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="282263707"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="282263707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 22:38:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="625639096"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="625639096"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 22:38:27 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v4] iio: pressure: mpl115: Implementing low power mode by shutdown gpio
Date:   Tue,  4 Oct 2022 11:08:01 +0530
Message-Id: <20221004053801.2774719-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MPL115 supports shutdown gpio which can be used to set the state
to low power mode. Power from all internal circuits and
registers is removed. This is done by pulling the SHDN pin to low.
This patch enables runtime PM on MPL115 to increase power savings.

According to spec., a wakeup time period of ~5 ms exists between
waking up and actually communicating with the device. This is
implemented using sleep delay.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v4:
1. Using runtime PM for low power mode and not forcing shutdown pin
2. Changing patch comment
3. Increasing autosuspend timeout to 2 sec to make the driver more
responsive to user

 drivers/iio/pressure/mpl115.c     | 61 ++++++++++++++++++++++++++++++-
 drivers/iio/pressure/mpl115.h     |  5 +++
 drivers/iio/pressure/mpl115_i2c.c |  1 +
 drivers/iio/pressure/mpl115_spi.c |  1 +
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 5bf5b9abe6f1..ec7527161844 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -4,12 +4,13 @@
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
- * TODO: shutdown pin
+ * TODO: synchronization with system suspend
  */
 
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include "mpl115.h"
 
@@ -27,6 +28,7 @@ struct mpl115_data {
 	s16 a0;
 	s16 b1, b2;
 	s16 c12;
+	struct gpio_desc *shutdown;
 	const struct mpl115_ops *ops;
 };
 
@@ -102,16 +104,24 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
+		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
 		if (ret < 0)
 			return ret;
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
+		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
 		if (ret < 0)
 			return ret;
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -605;
@@ -168,6 +178,8 @@ int mpl115_probe(struct device *dev, const char *name,
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(dev, indio_dev);
+
 	ret = data->ops->read(data->dev, MPL115_A0);
 	if (ret < 0)
 		return ret;
@@ -185,10 +193,58 @@ int mpl115_probe(struct device *dev, const char *name,
 		return ret;
 	data->c12 = ret;
 
+	data->shutdown = devm_gpiod_get_optional(dev, "shutdown",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(data->shutdown))
+		return dev_err_probe(dev, PTR_ERR(data->shutdown),
+				     "cannot get shutdown gpio\n");
+
+	if (data->shutdown) {
+		/* Enable runtime PM */
+		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+
+		/*
+		 * As the device takes 3 ms to come up with a fresh
+		 * reading after power-on and 5 ms to actually power-on,
+		 * do not shut it down unnecessarily. Set autosuspend to
+		 * 2000 ms.
+		 */
+		pm_runtime_set_autosuspend_delay(dev, 2000);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_put(dev);
+
+		dev_dbg(dev, "low-power mode enabled");
+	} else
+		dev_dbg(dev, "low-power mode disabled");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);
 
+static int mpl115_runtime_suspend(struct device *dev)
+{
+	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
+
+	gpiod_set_value(data->shutdown, 1);
+
+	return 0;
+}
+
+static int mpl115_runtime_resume(struct device *dev)
+{
+	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
+
+	gpiod_set_value(data->shutdown, 0);
+	usleep_range(5000, 6000);
+
+	return 0;
+}
+
+DEFINE_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops, mpl115_runtime_suspend,
+			  mpl115_runtime_resume, NULL);
+
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/mpl115.h b/drivers/iio/pressure/mpl115.h
index 57d55eb8e661..78a0068a17bb 100644
--- a/drivers/iio/pressure/mpl115.h
+++ b/drivers/iio/pressure/mpl115.h
@@ -6,6 +6,8 @@
  * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
  */
 
+#include <linux/pm_runtime.h>
+
 #ifndef _MPL115_H_
 #define _MPL115_H_
 
@@ -18,4 +20,7 @@ struct mpl115_ops {
 int mpl115_probe(struct device *dev, const char *name,
 			const struct mpl115_ops *ops);
 
+/*PM ops */
+extern const struct dev_pm_ops mpl115_dev_pm_ops;
+
 #endif
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index 099ab1c6832c..555bda1146fb 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -53,6 +53,7 @@ MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
 static struct i2c_driver mpl115_i2c_driver = {
 	.driver = {
 		.name	= "mpl115",
+		.pm = pm_ptr(&mpl115_dev_pm_ops),
 	},
 	.probe = mpl115_i2c_probe,
 	.id_table = mpl115_i2c_id,
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 7feec87e2704..58d218fd90dc 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -92,6 +92,7 @@ MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
 static struct spi_driver mpl115_spi_driver = {
 	.driver = {
 		.name   = "mpl115",
+		.pm = pm_ptr(&mpl115_dev_pm_ops),
 	},
 	.probe = mpl115_spi_probe,
 	.id_table = mpl115_spi_ids,
-- 
2.34.1

