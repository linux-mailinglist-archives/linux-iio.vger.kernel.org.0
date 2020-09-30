Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8C27E8D3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgI3MsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 08:48:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3076 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgI3MsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 08:48:08 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UCPN7O031014;
        Wed, 30 Sep 2020 08:48:03 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg67cv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:48:03 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08UCm1F6048052
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Sep 2020 08:48:02 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 30 Sep
 2020 05:47:53 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 30 Sep 2020 05:47:53 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08UClolp023959;
        Wed, 30 Sep 2020 08:47:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 4/4] iio: adc: at91_adc: remove platform data and move defs in driver file
Date:   Wed, 30 Sep 2020 15:52:16 +0300
Message-ID: <20200930125216.90424-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930125216.90424-1-alexandru.ardelean@analog.com>
References: <20200930125216.90424-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_07:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=2 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AT91 ADC driver no longer uses the 'at91_add_device_adc' platform data
type. This is no longer used (at least in mainline drivers).

This change removes the platform-data initialization from the driver, since
it is mostly dead code now.

Some definitions [from the platform data at91_adc.h include] have been to
be moved in the driver, since they are needed in the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91_adc.c             | 51 ++++++++++----------------
 include/linux/platform_data/at91_adc.h | 49 -------------------------
 2 files changed, 20 insertions(+), 80 deletions(-)
 delete mode 100644 include/linux/platform_data/at91_adc.h

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 473bffe84fbd..d0e56b1b5949 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -22,8 +22,6 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 
-#include <linux/platform_data/at91_adc.h>
-
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
@@ -153,6 +151,25 @@
 #define TOUCH_SHTIM                    0xa
 #define TOUCH_SCTIM_US		10		/* 10us for the Touchscreen Switches Closure Time */
 
+enum atmel_adc_ts_type {
+	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
+	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
+	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
+};
+
+/**
+ * struct at91_adc_trigger - description of triggers
+ * @name:		name of the trigger advertised to the user
+ * @value:		value to set in the ADC's trigger setup register
+			to enable the trigger
+ * @is_external:	Does the trigger rely on an external pin?
+ */
+struct at91_adc_trigger {
+	const char	*name;
+	u8		value;
+	bool		is_external;
+};
+
 /**
  * struct at91_adc_reg_desc - Various informations relative to registers
  * @channel_base:	Base offset for the channel data registers
@@ -957,30 +974,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 	return ret;
 }
 
-static int at91_adc_probe_pdata(struct at91_adc_state *st,
-				struct platform_device *pdev)
-{
-	struct at91_adc_data *pdata = pdev->dev.platform_data;
-
-	if (!pdata)
-		return -EINVAL;
-
-	st->caps = (struct at91_adc_caps *)
-			platform_get_device_id(pdev)->driver_data;
-
-	st->use_external = pdata->use_external_triggers;
-	st->vref_mv = pdata->vref;
-	st->channels_mask = pdata->channels_used;
-	st->num_channels = st->caps->num_channels;
-	st->startup_time = pdata->startup_time;
-	st->trigger_number = pdata->trigger_number;
-	st->trigger_list = pdata->trigger_list;
-	st->registers = &st->caps->registers;
-	st->touchscreen_type = pdata->touchscreen_type;
-
-	return 0;
-}
-
 static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 };
@@ -1157,11 +1150,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(idev);
 
-	if (pdev->dev.of_node)
-		ret = at91_adc_probe_dt(idev, pdev);
-	else
-		ret = at91_adc_probe_pdata(st, pdev);
-
+	ret = at91_adc_probe_dt(idev, pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "No platform data available.\n");
 		return -EINVAL;
diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
deleted file mode 100644
index f20eaeb827ce..000000000000
--- a/include/linux/platform_data/at91_adc.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Free Electrons
- */
-
-#ifndef _AT91_ADC_H_
-#define _AT91_ADC_H_
-
-enum atmel_adc_ts_type {
-	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
-	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
-	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
-};
-
-/**
- * struct at91_adc_trigger - description of triggers
- * @name:		name of the trigger advertised to the user
- * @value:		value to set in the ADC's trigger setup register
-			to enable the trigger
- * @is_external:	Does the trigger rely on an external pin?
- */
-struct at91_adc_trigger {
-	const char	*name;
-	u8		value;
-	bool		is_external;
-};
-
-/**
- * struct at91_adc_data - platform data for ADC driver
- * @channels_used:		channels in use on the board as a bitmask
- * @startup_time:		startup time of the ADC in microseconds
- * @trigger_list:		Triggers available in the ADC
- * @trigger_number:		Number of triggers available in the ADC
- * @use_external_triggers:	does the board has external triggers availables
- * @vref:			Reference voltage for the ADC in millivolts
- * @touchscreen_type:		If a touchscreen is connected, its type (4 or 5 wires)
- */
-struct at91_adc_data {
-	unsigned long			channels_used;
-	u8				startup_time;
-	struct at91_adc_trigger		*trigger_list;
-	u8				trigger_number;
-	bool				use_external_triggers;
-	u16				vref;
-	enum atmel_adc_ts_type		touchscreen_type;
-};
-
-extern void __init at91_add_device_adc(struct at91_adc_data *data);
-#endif
-- 
2.17.1

