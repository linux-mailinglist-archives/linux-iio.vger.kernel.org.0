Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B118227CE35
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgI2Mzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:55:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58556 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729447AbgI2Mzt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:55:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TCtC9j007687;
        Tue, 29 Sep 2020 08:55:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg63558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 08:55:43 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TCtgE4003367
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 08:55:42 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 05:55:34 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 05:55:30 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 05:55:34 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TCtIuS024384;
        Tue, 29 Sep 2020 08:55:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 5/9] iio: accel: bmc150: use iio_triggered_buffer_setup_ext()
Date:   Tue, 29 Sep 2020 15:59:45 +0300
Message-ID: <20200929125949.69934-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929125949.69934-1-alexandru.ardelean@analog.com>
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290113
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change switches to the new iio_triggered_buffer_setup_ext()
function and removes the iio_buffer_set_attrs() call, for assigning the
HW FIFO attributes to the buffer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..c641ee552038 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1558,6 +1558,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported)
 {
+	const struct attribute **fifo_attrs;
 	struct bmc150_accel_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1590,10 +1591,19 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
-	ret = iio_triggered_buffer_setup(indio_dev,
-					 &iio_pollfunc_store_time,
-					 bmc150_accel_trigger_handler,
-					 &bmc150_accel_buffer_ops);
+	if (block_supported) {
+		indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+		indio_dev->info = &bmc150_accel_info_fifo;
+		fifo_attrs = bmc150_accel_fifo_attributes;
+	} else {
+		fifo_attrs = NULL;
+	}
+
+	ret = iio_triggered_buffer_setup_ext(indio_dev,
+					     &iio_pollfunc_store_time,
+					     bmc150_accel_trigger_handler,
+					     &bmc150_accel_buffer_ops,
+					     fifo_attrs);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
 		return ret;
@@ -1628,13 +1638,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		ret = bmc150_accel_triggers_setup(indio_dev, data);
 		if (ret)
 			goto err_buffer_cleanup;
-
-		if (block_supported) {
-			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
-			indio_dev->info = &bmc150_accel_info_fifo;
-			iio_buffer_set_attrs(indio_dev->buffer,
-					     bmc150_accel_fifo_attributes);
-		}
 	}
 
 	ret = pm_runtime_set_active(dev);
-- 
2.17.1

