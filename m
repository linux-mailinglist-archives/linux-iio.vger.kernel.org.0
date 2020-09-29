Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81E27BD9D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgI2HKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 03:10:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10766 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbgI2HKM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 03:10:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T75AYU015998;
        Tue, 29 Sep 2020 03:10:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg625ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:10:08 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08T7A7D5038368
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 03:10:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 03:09:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 03:09:58 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08T79hUq013506;
        Tue, 29 Sep 2020 03:10:02 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 7/9] iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
Date:   Tue, 29 Sep 2020 10:09:06 +0300
Message-ID: <20200929070908.10456-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929070908.10456-1-alexandru.ardelean@analog.com>
References: <20200929070908.10456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change switches to the new devm_iio_triggered_buffer_setup_ext()
function and removes the iio_buffer_set_attrs() call, for assigning the
HW FIFO attributes to the buffer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c62cacc04672..1eafcf04ad69 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			if (ret)
 				return ret;
 		} else {
+			const struct attribute **fifo_attrs;
+
+			if (has_hw_fifo)
+				fifo_attrs = cros_ec_sensor_fifo_attributes;
+			else
+				fifo_attrs = NULL;
+
 			/*
 			 * The only way to get samples in buffer is to set a
 			 * software trigger (systrig, hrtimer).
 			 */
-			ret = devm_iio_triggered_buffer_setup(
+			ret = devm_iio_triggered_buffer_setup_ext(
 					dev, indio_dev, NULL, trigger_capture,
-					NULL);
+					NULL, fifo_attrs);
 			if (ret)
 				return ret;
-
-			if (has_hw_fifo)
-				iio_buffer_set_attrs(indio_dev->buffer,
-						     cros_ec_sensor_fifo_attributes);
 		}
 	}
 
-- 
2.17.1

