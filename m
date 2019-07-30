Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD74679D3A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfG3ALJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 20:11:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22604 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbfG3ALJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 20:11:09 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U06x7h010217;
        Tue, 30 Jul 2019 02:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=6kvxeuBqh48iRzxAoiCa1EnnxeXN69Yrw0ZP/LgjKWw=;
 b=Wn5lMI7xKDWKlabsLg+zSO2mE5vn0YoBmNv0nuR1HdccWfzplXhzQi+kYT5C+kdUUYYg
 uYh2CAngDktQmMcE/ccWkLnd+gRAFR/VAEL+RxZbKy9pW2FiDzZLRs6kUt0PIlAsjMw6
 8KpfbKSTXWIEePI3EWXu+77bBcAB0gXOcMWxSa/Uf5B/Hl0U4qEpGbgG0Jkx4ZCIWT0n
 n9WoWSGaJti8+ygZos3+AaPIiBV8wExad0STEZnls91xcL5AZAYYnffs8kmtS/Zz6xjk
 V0C/HdFjLchXtJIfyCVJVSG75FtVtIzZ7o7qQ5RZq15JzO8HYDx3D5/ouHsmIMlXqqTu GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0br9sf9q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 02:11:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66BE431;
        Tue, 30 Jul 2019 00:11:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A7DC260C;
        Tue, 30 Jul 2019 00:11:01 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul 2019 02:11:00
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/4] iio:accel: preenable/postenable/predisable fixup for ST accel buffer
Date:   Mon, 29 Jul 2019 17:03:02 -0700
Message-ID: <20190730000305.30958-2-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730000305.30958-1-denis.ciocca@st.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is trying to cleanup for good the buffers operation functions.
There is no need of using preenable, all can be done into
postenable.
Let's also rename the goto label using operation to perform and not
where it fails.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_buffer.c | 37 ++++++++++-------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 05f9aea431e2..81f89da125aa 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -29,56 +29,46 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
 
-static int st_accel_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return st_sensors_set_enable(indio_dev, true);
-}
-
 static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
+	int err;
 
 	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
 				     GFP_DMA | GFP_KERNEL);
-	if (adata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (!adata->buffer_data)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_accel_buffer_postenable_error;
+		goto st_accel_free_buffer;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					(u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_sensors_set_axis_enable_error;
+		goto st_accel_buffer_predisable;
 
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 
-st_sensors_set_axis_enable_error:
+st_accel_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_accel_buffer_postenable_error:
+st_accel_free_buffer:
 	kfree(adata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err, err2;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-
-	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
-	if (err < 0)
-		goto st_accel_buffer_predisable_error;
+	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto st_accel_buffer_predisable_error;
+		goto st_accel_buffer_predisable;
+
+	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 
-st_accel_buffer_predisable_error:
+st_accel_buffer_predisable:
 	err2 = iio_triggered_buffer_predisable(indio_dev);
 	if (!err)
 		err = err2;
@@ -88,7 +78,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
-	.preenable = &st_accel_buffer_preenable,
 	.postenable = &st_accel_buffer_postenable,
 	.predisable = &st_accel_buffer_predisable,
 };
-- 
2.22.0

