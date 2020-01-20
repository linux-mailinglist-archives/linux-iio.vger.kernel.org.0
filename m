Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1DB142D2B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgATOVK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 09:21:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51754 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgATOVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 09:21:09 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEExTK027063;
        Mon, 20 Jan 2020 09:21:07 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbctvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 09:21:07 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00KEL5RD040647
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jan 2020 09:21:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 20 Jan
 2020 06:21:04 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jan 2020 09:21:03 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00KEKwic024435;
        Mon, 20 Jan 2020 09:21:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/4] iio: imu: adis: Refactor adis_initial_startup
Date:   Mon, 20 Jan 2020 16:20:49 +0200
Message-ID: <20200120142051.28533-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120142051.28533-1-alexandru.ardelean@analog.com>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001200123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

All the ADIS devices perform, at the beginning, a self test to make sure
the device is in a sane state. Furthermore, some drivers also do a call
to `adis_reset()` before the test which is also a good practice. This
patch unifies all those operation so that, there's no need for code
duplication. Furthermore, the rst pin is also checked to make sure the
device is not in HW reset. On top of this, some drivers also read the
device product id and compare it with the device being probed to make
sure the correct device is being handled. This can also be passed to the
library by introducing a variable holding the PROD_ID register of the
device.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/Kconfig      |  1 +
 drivers/iio/imu/adis.c       | 63 ++++++++++++++++++++++++++----------
 include/linux/iio/imu/adis.h | 15 ++++++++-
 3 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 60bb1029e759..63036cf473c7 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -85,6 +85,7 @@ endmenu
 
 config IIO_ADIS_LIB
 	tristate
+	depends on GPIOLIB
 	help
 	  A set of IO helper functions for the Analog Devices ADIS* device family.
 
diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index d02b1911b0f2..1eca5271380e 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -365,36 +366,64 @@ static int adis_self_test(struct adis *adis)
 }
 
 /**
- * adis_inital_startup() - Performs device self-test
+ * __adis_initial_startup() - Device initial setup
  * @adis: The adis device
  *
+ * This functions makes sure the device is not in reset, via rst pin.
+ * Furthermore it performs a SW reset (only in the case we are not coming from
+ * reset already) and a self test. It also compares the product id with the
+ * device id if the prod_id_reg variable is set.
+ *
  * Returns 0 if the device is operational, a negative error code otherwise.
  *
  * This function should be called early on in the device initialization sequence
  * to ensure that the device is in a sane and known state and that it is usable.
  */
-int adis_initial_startup(struct adis *adis)
+int __adis_initial_startup(struct adis *adis)
 {
 	int ret;
-
-	mutex_lock(&adis->state_lock);
+	struct gpio_desc *gpio;
+	const struct adis_timeout *timeouts = adis->data->timeouts;
+	const char *iio_name = spi_get_device_id(adis->spi)->name;
+	u16 prod_id, dev_id;
+
+	/* check if the device has rst pin low */
+	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(gpio)) {
+		return PTR_ERR(gpio);
+	} else if (gpio && gpiod_get_value_cansleep(gpio)) {
+		/* bring device out of reset */
+		gpiod_set_value_cansleep(gpio, 0);
+		msleep(timeouts->reset_ms);
+	} else {
+		ret = __adis_reset(adis);
+		if (ret)
+			return ret;
+	}
 
 	ret = adis_self_test(adis);
-	if (ret) {
-		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
-		__adis_reset(adis);
-		ret = adis_self_test(adis);
-		if (ret) {
-			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
-			goto out_unlock;
-		}
-	}
+	if (ret)
+		return ret;
 
-out_unlock:
-	mutex_unlock(&adis->state_lock);
-	return ret;
+	if (!adis->data->prod_id_reg)
+		return 0;
+
+	ret = adis_read_reg_16(adis, adis->data->prod_id_reg, &prod_id);
+	if (ret)
+		return ret;
+
+	ret = sscanf(iio_name, "adis%hu\n", &dev_id);
+	if (ret != 1)
+		return -EINVAL;
+
+	if (prod_id != dev_id)
+		dev_warn(&adis->spi->dev,
+			 "Device ID(%u) and product ID(%u) do not match.",
+			 dev_id, prod_id);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(adis_initial_startup);
+EXPORT_SYMBOL_GPL(__adis_initial_startup);
 
 /**
  * adis_single_conversion() - Performs a single sample conversion
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index d21a013d1122..c43e7922ab32 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -41,6 +41,7 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @prod_id_reg: Register address of the PROD_ID register
  * @self_test_reg: Register address to request self test command
  * @status_error_msgs: Array of error messgaes
  * @status_error_mask:
@@ -54,6 +55,7 @@ struct adis_data {
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
 	unsigned int diag_stat_reg;
+	unsigned int prod_id_reg;
 
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
@@ -299,6 +301,7 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 
 int adis_enable_irq(struct adis *adis, bool enable);
 int __adis_check_status(struct adis *adis);
+int __adis_initial_startup(struct adis *adis);
 
 static inline int adis_check_status(struct adis *adis)
 {
@@ -311,7 +314,17 @@ static inline int adis_check_status(struct adis *adis)
 	return ret;
 }
 
-int adis_initial_startup(struct adis *adis);
+/* locked version of __adis_initial_startup() */
+static inline int adis_initial_startup(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_initial_startup(adis);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
 
 int adis_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int error_mask,
-- 
2.20.1

