Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53627CE39
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgI2M4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:56:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6894 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729307AbgI2Mz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:55:57 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TClNnS004027;
        Tue, 29 Sep 2020 08:55:52 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4jyaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 08:55:52 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TCtoib003404
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 08:55:51 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 05:55:43 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 05:55:43 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TCtIuV024384;
        Tue, 29 Sep 2020 08:55:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 8/9] iio: hid-sensors: use iio_triggered_buffer_setup_ext()
Date:   Tue, 29 Sep 2020 15:59:48 +0300
Message-ID: <20200929125949.69934-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929125949.69934-1-alexandru.ardelean@analog.com>
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290112
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change switches to the new iio_triggered_buffer_setup_ext()
function and removes the iio_buffer_set_attrs() call, for assigning the
HW FIFO attributes to the buffer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../common/hid-sensors/hid-sensor-trigger.c   | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ff375790b7e8..064c32bec9c7 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -84,15 +84,6 @@ static const struct attribute *hid_sensor_fifo_attributes[] = {
 	NULL,
 };
 
-static void hid_sensor_setup_batch_mode(struct iio_dev *indio_dev,
-					struct hid_sensor_common *st)
-{
-	if (!hid_sensor_batch_mode_supported(st))
-		return;
-
-	iio_buffer_set_attrs(indio_dev->buffer, hid_sensor_fifo_attributes);
-}
-
 static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 	int state_val;
@@ -247,11 +238,18 @@ static const struct iio_trigger_ops hid_sensor_trigger_ops = {
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb)
 {
+	const struct attribute **fifo_attrs;
 	int ret;
 	struct iio_trigger *trig;
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 NULL, NULL);
+	if (hid_sensor_batch_mode_supported(attrb))
+		fifo_attrs = hid_sensor_fifo_attributes;
+	else
+		fifo_attrs = NULL;
+
+	ret = iio_triggered_buffer_setup_ext(indio_dev,
+					     &iio_pollfunc_store_time,
+					     NULL, NULL, fifo_attrs);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
 		return ret;
@@ -276,8 +274,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	attrb->trigger = trig;
 	indio_dev->trig = iio_trigger_get(trig);
 
-	hid_sensor_setup_batch_mode(indio_dev, attrb);
-
 	ret = pm_runtime_set_active(&indio_dev->dev);
 	if (ret)
 		goto error_unreg_trigger;
-- 
2.17.1

