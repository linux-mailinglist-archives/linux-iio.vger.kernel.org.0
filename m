Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6579D3B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfG3ALK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 20:11:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22600 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728406AbfG3ALK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 20:11:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U074fn010239;
        Tue, 30 Jul 2019 02:11:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=YgA+Z47nykJeZngYkImyUvSnckPrpfYh6rVAul7UNgA=;
 b=zBK36dj4fX99Kcfkmvioub8aTC4UZ0nqYIzUyLdJvnNaHKMO7BRP/Yn7GJmRUKcaW7/I
 qYCR+Jxcmx0Nkbco3VqGXjYN0SuWPF+B0vg7zK4XLqzW2eMDqR9c7wTfNn0e0uIqA/iF
 B4VGToG8Mp4MU+4/Nq0bBGZv+whuK3JjMHaoKHIoIZv/ZXmsoeCwf2jSQ3zjV85VUfRv
 Dh/XIvFUr3SgNYZwjhYMLRW9M+mWtDp/Vf8+/tz6qFVyGrku5Q4LmSggzwsGH8jsYQ96
 kPaQcaceLI+wQ0/VTWJMQnaEz0/fZslwSYwJg0jmYIe6pBFfwYG3viQ6w3hsJYvlLB09 og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0br9sfa9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 02:11:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1155D31;
        Tue, 30 Jul 2019 00:11:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E675D260C;
        Tue, 30 Jul 2019 00:11:03 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul 2019 02:11:03
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/4] iio:gyro: preenable/postenable/predisable fixup for ST gyro buffer
Date:   Mon, 29 Jul 2019 17:03:03 -0700
Message-ID: <20190730000305.30958-3-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730000305.30958-1-denis.ciocca@st.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is trying to cleanup for good the buffers operation functions.
There is no need of using preenable, all can be done into
postenable. Let's also use logical sequence of operations as
already done in accel driver.
Finally also rename the goto label using operation to perform and not
where it fails.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_buffer.c | 45 +++++++++++++------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 21360681d4dd..be9f1fec2b5d 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -29,62 +29,55 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
 
-static int st_gyro_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return st_sensors_set_enable(indio_dev, true);
-}
-
 static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
+	int err;
 
 	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
 				     GFP_DMA | GFP_KERNEL);
-	if (gdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (!gdata->buffer_data)
+		return -ENOMEM;
 
-	err = st_sensors_set_axis_enable(indio_dev,
-					(u8)indio_dev->active_scan_mask[0]);
+	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_gyro_buffer_postenable_error;
+		goto st_gyro_free_buffer;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
+	err = st_sensors_set_axis_enable(indio_dev,
+					 (u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_gyro_buffer_postenable_error;
+		goto st_gyro_buffer_predisable;
 
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 
-st_gyro_buffer_postenable_error:
+st_gyro_buffer_predisable:
+	iio_triggered_buffer_predisable(indio_dev);
+st_gyro_free_buffer:
 	kfree(gdata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
 static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
+	int err, err2;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
+	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto st_gyro_buffer_predisable_error;
+		goto st_gyro_buffer_predisable;
 
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-	if (err < 0)
-		goto st_gyro_buffer_predisable_error;
 
-	err = st_sensors_set_enable(indio_dev, false);
+st_gyro_buffer_predisable:
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
 
-st_gyro_buffer_predisable_error:
 	kfree(gdata->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
-	.preenable = &st_gyro_buffer_preenable,
 	.postenable = &st_gyro_buffer_postenable,
 	.predisable = &st_gyro_buffer_predisable,
 };
-- 
2.22.0

