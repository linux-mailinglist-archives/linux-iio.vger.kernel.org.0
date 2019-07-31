Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B817D045
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfGaVtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:49:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730619AbfGaVtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:49:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLkNDM001076;
        Wed, 31 Jul 2019 23:49:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=zvxA4NKedDEtkkb+xufW48JlyxDyEq/KX8ekUxsX0DU=;
 b=y15scCGqzeH/51hRlFmRGQeaU2Z4P9Lzuboy5d6iFp4aNDhXykJ9yq/Z/ogAZipURS8M
 t+DPPv7PAtqa4XoeFw0LbUWqCmZ9eYC7dBUGFl+GiNxTsy5U9Gv6EJnLotVJMpOMbf7+
 /rpT6KgjkFvXIeqguTYDiRbFlV8yMwVYrsEqnDCCUzK4/n7/5tKhI+G8bmCUFy5ak/4S
 HAQHvqRTtKDO25uRl0H/Gt4bykLDv/6ZeprDK7Bcjeo1DelYV8v4c/2xnspaIRDtsmed
 qStUX+AbWpNo/fAZci/jgHWF+C2T6zMrw7OVlwJstZyyhx8zz0pwunZsBzROfcrZeNk7 FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u2jp4hehk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:49:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA7D731;
        Wed, 31 Jul 2019 21:49:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3057777E2;
        Wed, 31 Jul 2019 23:49:23 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:49:22
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 4/4] iio:pressure: preenable/postenable/predisable fixup for ST press buffer
Date:   Wed, 31 Jul 2019 14:49:00 -0700
Message-ID: <20190731214900.15380-5-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731214900.15380-1-denis.ciocca@st.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG1NODE1.st.com
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
 drivers/iio/pressure/st_pressure_buffer.c | 38 ++++++++++-------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index f21b630abaa0..77cb2d862f19 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -29,53 +29,49 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
 
-static int st_press_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return st_sensors_set_enable(indio_dev, true);
-}
-
 static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
+	int err;
 
 	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
 					  GFP_DMA | GFP_KERNEL);
-	if (press_data->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (!press_data->buffer_data)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_press_buffer_postenable_error;
+		goto st_press_free_buffer;
 
-	return err;
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_press_buffer_predisable;
+
+	return 0;
 
-st_press_buffer_postenable_error:
+st_press_buffer_predisable:
+	iio_triggered_buffer_predisable(indio_dev);
+st_press_free_buffer:
 	kfree(press_data->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
-
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_press_buffer_predisable_error;
+	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
 
-st_press_buffer_predisable_error:
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
+
 	kfree(press_data->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
-	.preenable = &st_press_buffer_preenable,
 	.postenable = &st_press_buffer_postenable,
 	.predisable = &st_press_buffer_predisable,
 };
-- 
2.22.0

