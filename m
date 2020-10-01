Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5862800DF
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgJAOGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 10:06:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbgJAOGZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2020 10:06:25 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Dvgqo009714;
        Thu, 1 Oct 2020 10:06:24 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4u35f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 10:06:23 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 091E6Mgd002895
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 1 Oct 2020 10:06:22 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 1 Oct 2020 10:06:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 1 Oct 2020 10:06:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 1 Oct 2020 10:06:13 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 091E6J9X029035;
        Thu, 1 Oct 2020 10:06:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad7298: rework external ref setup & remove platform data
Date:   Thu, 1 Oct 2020 17:10:48 +0300
Message-ID: <20201001141048.69050-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_04:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change removes the old platform data for ad7298. It is only used to
provide whether to use an external regulator as a reference.

So, the logic is inverted a bit. The driver now tries to obtain a
regulator. If one is provided, then the external ref is used. The rest of
the logic should work as before.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7298.c             | 17 +++++++++--------
 include/linux/platform_data/ad7298.h | 19 -------------------
 2 files changed, 9 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/platform_data/ad7298.h

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 48d43cb0f932..fa1047f74a1f 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -23,8 +23,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/platform_data/ad7298.h>
-
 #define AD7298_WRITE	BIT(15) /* write to the control register */
 #define AD7298_REPEAT	BIT(14) /* repeated conversion enable */
 #define AD7298_CH(x)	BIT(13 - (x)) /* channel select */
@@ -283,7 +281,6 @@ static const struct iio_info ad7298_info = {
 
 static int ad7298_probe(struct spi_device *spi)
 {
-	struct ad7298_platform_data *pdata = spi->dev.platform_data;
 	struct ad7298_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -294,14 +291,18 @@ static int ad7298_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	if (pdata && pdata->ext_ref)
+	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(st->reg)) {
 		st->ext_ref = AD7298_EXTREF;
+	} else {
+		ret = PTR_ERR(st->reg);
+		if (ret != -ENODEV)
+			return ret;
 
-	if (st->ext_ref) {
-		st->reg = devm_regulator_get(&spi->dev, "vref");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
+		st->reg = NULL;
+	}
 
+	if (st->reg) {
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
diff --git a/include/linux/platform_data/ad7298.h b/include/linux/platform_data/ad7298.h
deleted file mode 100644
index 3e0ffe2d5d3d..000000000000
--- a/include/linux/platform_data/ad7298.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD7298 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-
-#ifndef __LINUX_PLATFORM_DATA_AD7298_H__
-#define __LINUX_PLATFORM_DATA_AD7298_H__
-
-/**
- * struct ad7298_platform_data - Platform data for the ad7298 ADC driver
- * @ext_ref: Whether to use an external reference voltage.
- **/
-struct ad7298_platform_data {
-	bool ext_ref;
-};
-
-#endif /* IIO_ADC_AD7298_H_ */
-- 
2.17.1

