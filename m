Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5910C79D3D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 02:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfG3ALQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 20:11:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25172 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728406AbfG3ALQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 20:11:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U074fo010239;
        Tue, 30 Jul 2019 02:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=IXP1Nf32uMSQTte7apZ0rjwGna1PRwG0sK55r0BMTu4=;
 b=VWdN9puaI7D9h2D+WkJfU4ajSpGcxdM0wPM+jhF+CthEdO2CW/B9Qwu8Vza8WsQ25yVd
 JnsGRTlLFL5RBWWy5efnQJoDzPnGmYVqz4HHUDkGINoZachCqWE08EQpCzWRGmUtmUsx
 Pycw37nt1gqFZERPojwIEJf19XLJJ7xV9sfnr7smYoqrNFvcUKT01EAHFQxwhPnnxKJT
 o50Em42Izvnk08nXMAj9cwFMCHy2iLc+0UuERRNdlujzFs0IJ4PD3ASRIyV3UNOHXDmr
 tKQ+Bb+LgGKuqsCYECfLS4F3K9yKFNm8TjAu4O+nv5N8oYtxD18HGWJ6L2eRAUADDW1Q +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0br9sfb3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 02:11:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46FF631;
        Tue, 30 Jul 2019 00:11:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 29860260C;
        Tue, 30 Jul 2019 00:11:09 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul 2019 02:11:08
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup for ST press buffer
Date:   Mon, 29 Jul 2019 17:03:05 -0700
Message-ID: <20190730000305.30958-5-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730000305.30958-1-denis.ciocca@st.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG1NODE1.st.com
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
 drivers/iio/pressure/st_pressure_buffer.c | 32 ++++++++---------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index f21b630abaa0..54823cfcfab5 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -29,53 +29,43 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
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
+	return st_sensors_set_enable(indio_dev, true);
 
-st_press_buffer_postenable_error:
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

