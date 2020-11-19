Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF1F2B8FBE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKSKCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 05:02:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63268 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbgKSKCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 05:02:43 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ9us2s004832;
        Thu, 19 Nov 2020 05:02:41 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19h5bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 05:02:41 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AJA2eUi025657
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 05:02:40 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 05:02:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 05:02:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 05:02:37 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJA2Ydc018635;
        Thu, 19 Nov 2020 05:02:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/4] iio: adc: ad7887: convert dual-channel mode to DT/ACPI
Date:   Thu, 19 Nov 2020 12:07:45 +0200
Message-ID: <20201119100748.57689-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the configuration of the dual-channel mode from the
old platform-data, to the device_property_present() function, which
supports both device-tree and ACPI configuration setups.

With this change the old platform_data include of the driver can be
removed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

I'm wondering if this changeset is what was in mind here:
 https://lore.kernel.org/linux-iio/CA+U=DsqF5tu8Be9KXeyCWD2uHvV688Nc3n=z_Xi2J6H6DFJPRQ@mail.gmail.com/T/#mbe72e4da3acea3899d0d35402ea81e52a9bc34e6
This driver could have been simplified/reduced a whole lot more, but I'm
not sure about it. It's a bit of patch-noise, and later

Changelog v1 -> v2:
* dropped patch 'iio: adc: ad7887: convert driver to full DT probing'
  not adding the device_get_match_data() logic anymore
* added patch 'iio: adc: ad7887: remove matching code from driver'
  hooking the chip info directly to AD7887
* added patch 'iio: adc: ad7887: add OF match table'
  this just adds an OF table for DT and ACPI

 drivers/iio/adc/ad7887.c             | 10 +++++-----
 include/linux/platform_data/ad7887.h | 21 ---------------------
 2 files changed, 5 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7887.h

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 4f6f0e0e03ee..06f684c053a0 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -23,8 +23,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/platform_data/ad7887.h>
-
 #define AD7887_REF_DIS		BIT(5)	/* on-chip reference disable */
 #define AD7887_DUAL		BIT(4)	/* dual-channel mode */
 #define AD7887_CH_AIN1		BIT(3)	/* convert on channel 1, DUAL=1 */
@@ -241,9 +239,9 @@ static void ad7887_reg_disable(void *data)
 
 static int ad7887_probe(struct spi_device *spi)
 {
-	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
 	struct iio_dev *indio_dev;
+	bool dual_mode;
 	uint8_t mode;
 	int ret;
 
@@ -286,7 +284,9 @@ static int ad7887_probe(struct spi_device *spi)
 	mode = AD7887_PM_MODE4;
 	if (!st->reg)
 		mode |= AD7887_REF_DIS;
-	if (pdata && pdata->en_dual)
+
+	dual_mode = device_property_present(&spi->dev, "adi,dual-channel-mode");
+	if (dual_mode)
 		mode |= AD7887_DUAL;
 
 	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
@@ -298,7 +298,7 @@ static int ad7887_probe(struct spi_device *spi)
 	spi_message_init(&st->msg[AD7887_CH0]);
 	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
 
-	if (pdata && pdata->en_dual) {
+	if (dual_mode) {
 		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
 
 		st->xfer[1].rx_buf = &st->data[0];
diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
deleted file mode 100644
index 9b4dca6ae70b..000000000000
--- a/include/linux/platform_data/ad7887.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * AD7887 SPI ADC driver
- *
- * Copyright 2010 Analog Devices Inc.
- */
-#ifndef IIO_ADC_AD7887_H_
-#define IIO_ADC_AD7887_H_
-
-/**
- * struct ad7887_platform_data - AD7887 ADC driver platform data
- * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
- *	second input channel, and Vref is internally connected to Vdd. If set to
- *	false the device is used in single channel mode and AIN1/Vref is used as
- *	VREF input.
- */
-struct ad7887_platform_data {
-	bool en_dual;
-};
-
-#endif /* IIO_ADC_AD7887_H_ */
-- 
2.17.1

