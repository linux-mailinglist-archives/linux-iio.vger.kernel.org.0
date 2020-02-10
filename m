Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD2157B4D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgBJN2p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9892 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731395AbgBJN2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:44 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADS3Nq029525;
        Mon, 10 Feb 2020 08:28:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmqt69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:43 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSfoU022091
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:41 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 05:28:40 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 05:28:40 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZp017670;
        Mon, 10 Feb 2020 08:28:37 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 6/9] iio: imu: adis: Refactor adis_initial_startup
Date:   Mon, 10 Feb 2020 15:26:03 +0200
Message-ID: <20200210132606.9315-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

All the ADIS devices perform, at the beginning, a self test to make sure
the device is in a sane state. Previously, the logic was that the self-test
was performed in adis_initial_startup() and if that failed a reset was done
and then a self-test was attempted again.

This change unifies the reset mechanism under the adis_initial_startup()
call. A HW reset will be done if  GPIO is configured, or a SW reset
otherwise. This should make sure that the chip is in a sane state for
self-test. Once the reset is done, the self-test operation will be
performed. If anything goes wrong with self-test, the driver should just
bail/error-out (i.e. no second attempt). The chip would likely not be a in
a sane state state if the self-test fails after a reset.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/Kconfig |  1 +
 drivers/iio/imu/adis.c  | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

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
index f7845a90f376..0bd6e32cf577 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -368,6 +369,10 @@ static int adis_self_test(struct adis *adis)
  * __adis_initial_startup() - Device initial setup
  * @adis: The adis device
  *
+ * The function performs a HW reset via a reset pin that should be specified
+ * via GPIOLIB. If no pin is configured a SW reset will be performed.
+ * The RST pin for the ADIS devices should be configured as ACTIVE_LOW.
+ *
  * Returns 0 if the device is operational, a negative error code otherwise.
  *
  * This function should be called early on in the device initialization sequence
@@ -375,18 +380,28 @@ static int adis_self_test(struct adis *adis)
  */
 int __adis_initial_startup(struct adis *adis)
 {
+	const struct adis_timeout *timeouts = adis->data->timeouts;
+	struct gpio_desc *gpio;
 	int ret;
 
-	ret = adis_self_test(adis);
-	if (ret) {
-		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
-		__adis_reset(adis);
-		ret = adis_self_test(adis);
+	/* check if the device has rst pin low */
+	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	if (gpio) {
+		gpiod_set_value_cansleep(gpio, 1);
+		msleep(10);
+		/* bring device out of reset */
+		gpiod_set_value_cansleep(gpio, 0);
+		msleep(timeouts->reset_ms);
+	} else {
+		ret = __adis_reset(adis);
 		if (ret)
-			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
+			return ret;
 	}
 
-	return ret;
+	return adis_self_test(adis);
 }
 EXPORT_SYMBOL_GPL(__adis_initial_startup);
 
-- 
2.20.1

