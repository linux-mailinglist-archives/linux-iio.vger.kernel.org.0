Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05317D04E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfGaVxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727987AbfGaVxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:53:05 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLpu42005721;
        Wed, 31 Jul 2019 23:52:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=Ly3YJPVIY4xEVEoftD3Syia6lWrUfkDdvryFpEXMeoE=;
 b=h9e0mGr+6ebQzLG2QoStRPnOdHGDdZitwvGe6PYXuTLNMO47eHDmAYJpp7v5l4Odpiu2
 UHuk/CkHPsqqT11rYsz3W+ROZcQ9lJmF+pMur1hymHz3AjsUuuP1L1tZ9sTd5UgZNLzX
 XbzkW/EiXBJaFrD709BzGWtQxz0Mj4C0+ntvNF7hxtlY9tCCv2BiU0NfGjW182HArHC7
 O4CuK8oRxzfALxiCHOJnrq4wO6aDIetIqOREnLx1LejP5bgZT4MFtq7FOu+SO/5jCJVm
 9IJSWTmO+oHNscDnO59/Vc88d8hSpCdBwl9kLV1ZTb1CTBF++IY/315d3UELJ0GtvKMt /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u2jp4heyu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:52:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B102131;
        Wed, 31 Jul 2019 21:52:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7A38777EB;
        Wed, 31 Jul 2019 23:52:56 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:52:55
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/5] iio:common: introduce st_sensors_buffer_preenable/predisable functions
Date:   Wed, 31 Jul 2019 14:52:46 -0700
Message-ID: <20190731215250.16403-2-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731215250.16403-1-denis.ciocca@st.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is introducing preenable/postdisable in the common
st_sensors_buffer code in order to remove the memory allocation /
de-allocation from each single st driver.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 .../iio/common/st_sensors/st_sensors_buffer.c | 22 +++++++++++++++++++
 include/linux/iio/common/st_sensors.h         |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index eee30130ae23..9da1c8104883 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -81,6 +81,28 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 }
 EXPORT_SYMBOL(st_sensors_trigger_handler);
 
+int st_sensors_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	sdata->buffer_data = kmalloc(indio_dev->scan_bytes,
+				     GFP_DMA | GFP_KERNEL);
+	if (!sdata->buffer_data)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(st_sensors_buffer_preenable);
+
+int st_sensors_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	kfree(sdata->buffer_data);
+	return 0;
+}
+EXPORT_SYMBOL(st_sensors_buffer_postdisable);
+
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 28fc1f9fa7d5..c66ebb236a15 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -254,6 +254,8 @@ struct st_sensor_data {
 
 #ifdef CONFIG_IIO_BUFFER
 irqreturn_t st_sensors_trigger_handler(int irq, void *p);
+int st_sensors_buffer_preenable(struct iio_dev *indio_dev);
+int st_sensors_buffer_postdisable(struct iio_dev *indio_dev);
 #endif
 
 #ifdef CONFIG_IIO_TRIGGER
-- 
2.22.0

