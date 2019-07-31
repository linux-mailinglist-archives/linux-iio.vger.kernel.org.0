Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97C17D043
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfGaVt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:49:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54342 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbfGaVt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:49:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLkhgD028289;
        Wed, 31 Jul 2019 23:49:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=JhkB9vGe+qnbdYfQ7ucEQOrMJMNUlaMbY+CwkHANuIc=;
 b=NmzppMwZozDhh3leM/R8xYaiivV1wo9gfxh3PmXBCdOBcDC/EDy3Ij98r9wM5AD6CgiT
 bEHnrED06Mc0fb4H8hZO1XYH2mzf6qoPIu7HX9yE/ektNfv9sl7C9GfRU2fMKFKmlSYw
 5lgim76lceVeBvs5F0kRdDnrbHYjZERu50Bh2lmdyV+NCh5Lb6NorTLI6hsaoB5t1r2P
 wPuHkACyAYkir6DyF72TgMPJY58v2txDLLLY+/cFpOqEm/XUWyxzBokleY7Y5bT7Gyi/
 J/MkzgTf/qGt0YKymZLTsCPerEkHyVHNRUswjkdUX94EivFozoOOEuDkczSsPlgED+mc zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yjgwp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:49:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5503D31;
        Wed, 31 Jul 2019 21:49:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D386777E2;
        Wed, 31 Jul 2019 23:49:18 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:49:17
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 2/4] iio:gyro: preenable/postenable/predisable fixup for ST gyro buffer
Date:   Wed, 31 Jul 2019 14:48:58 -0700
Message-ID: <20190731214900.15380-3-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731214900.15380-1-denis.ciocca@st.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
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
 drivers/iio/gyro/st_gyro_buffer.c | 49 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 21360681d4dd..c6ddfecc1fc3 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -29,62 +29,61 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
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
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0)
+		goto st_gyro_free_buffer;
 
 	err = st_sensors_set_axis_enable(indio_dev,
-					(u8)indio_dev->active_scan_mask[0]);
+					 (u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_gyro_buffer_postenable_error;
+		goto st_gyro_buffer_predisable;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
+	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
-		goto st_gyro_buffer_postenable_error;
+		goto st_gyro_buffer_enable_all_axis;
 
-	return err;
+	return 0;
 
-st_gyro_buffer_postenable_error:
+st_gyro_buffer_enable_all_axis:
+	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
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

