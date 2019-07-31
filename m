Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED5B7D042
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfGaVtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:49:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42335 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbfGaVtZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:49:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLkoPj011524;
        Wed, 31 Jul 2019 23:49:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=cfn8HlHd0WgUI2hSvHD6je19PsAkK19GP8azP3cAHuA=;
 b=kpi4NRalpeZRH7/41dX/vS75NCmj0fAaqRrcJQw+iTiw69jt2hIfAA/Sj9Z+bSIbjzcj
 +mnbIVoZYwiRfCEpKg4jwD1Pn9L4Pay4BU7TJ5WWCztcQmF9sN5L6ruczYHdcEtrQsNX
 PaXx+Lnl04HhyP99K7HrjoJKNjkuevkOcflw36TlFIcLH1Rh3wyYidnNAdnTMS8KuS+D
 oRwcre6zStIRbrNzRaYaFONsaFPe3cBW+yriNobFkPyTz4n2BCpSbM7cJW/h2iT4Dki9
 sxTlP4jfdpinrdvKxh0jegNh60ejir7QBT5UG7MiN6XQ37ht0lij334NznHs4PQXrGoQ 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwtcgv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:49:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8FD9631;
        Wed, 31 Jul 2019 21:49:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8856F777E2;
        Wed, 31 Jul 2019 23:49:15 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:49:14
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 1/4] iio:accel: preenable/postenable/predisable fixup for ST accel buffer
Date:   Wed, 31 Jul 2019 14:48:57 -0700
Message-ID: <20190731214900.15380-2-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731214900.15380-1-denis.ciocca@st.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
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
 drivers/iio/accel/st_accel_buffer.c | 45 +++++++++++++----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 05f9aea431e2..59dcef02ec19 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -29,56 +29,52 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
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
-					(u8)indio_dev->active_scan_mask[0]);
+					 (u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_sensors_set_axis_enable_error;
+		goto st_accel_buffer_predisable;
 
-	return err;
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_accel_buffer_enable_all_axis;
+
+	return 0;
 
-st_sensors_set_axis_enable_error:
+st_accel_buffer_enable_all_axis:
+	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
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
@@ -88,7 +84,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
-	.preenable = &st_accel_buffer_preenable,
 	.postenable = &st_accel_buffer_postenable,
 	.predisable = &st_accel_buffer_predisable,
 };
-- 
2.22.0

