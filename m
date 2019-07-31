Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF797D051
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfGaVxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbfGaVxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:53:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLkVjF028223;
        Wed, 31 Jul 2019 23:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=pEu7VH3P1sxZGeveUOFHsvdCGDG2P//TjcsxxMlYQrw=;
 b=clKVN1gnJK5RVVyFyA8jBbGIv3u9ic9eXy23jaba8ZFz6AUU9yksAYSGffwUL3qqwOW9
 OgfG9YGzTbhPqNNc1GVSQStcrZVGlETPbY3bOgWUuaJVHVKJwRc78dgcGTY4K/Ff+poC
 lVMDXlsF8xpF+BGsD1/qOWSPNd4ELCNP7sjNkx6F0W1LJOeu226LWpPc/9BPv3N712iI
 EkMTvkDhpZS6qY1PyX9V8/Wfv36cn/uYOP4XQ5Vwxca/WI6RvSSVvexK+kfYoNQwID+Z
 UEw1YHD83a3r6gfj1DGbVT/eAz5nL1RzoLyIA8J39VhL0GBuXqPDCX+aT+8/dTUXDjNS 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yjhbr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:53:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C934331;
        Wed, 31 Jul 2019 21:53:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C11C1777EB;
        Wed, 31 Jul 2019 23:53:01 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:53:01
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/5] iio:gyro: do not allocate/de-allocate buffer here but link setup_ops to st_sensors_buffer
Date:   Wed, 31 Jul 2019 14:52:48 -0700
Message-ID: <20190731215250.16403-4-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731215250.16403-1-denis.ciocca@st.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Setup buffer_setup_ops pre/post enable/disable to use
st_sensor_buffers functions for memory allocation/de-allocation.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_buffer.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index c6ddfecc1fc3..48811457a943 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -31,17 +31,11 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	int err;
 
-	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!gdata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_gyro_free_buffer;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					 (u8)indio_dev->active_scan_mask[0]);
@@ -58,15 +52,12 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 st_gyro_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_gyro_free_buffer:
-	kfree(gdata->buffer_data);
 	return err;
 }
 
 static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 {
 	int err, err2;
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
@@ -79,13 +70,14 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(gdata->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
+	.preenable = &st_sensors_buffer_preenable,
 	.postenable = &st_gyro_buffer_postenable,
 	.predisable = &st_gyro_buffer_predisable,
+	.postdisable = &st_sensors_buffer_postdisable,
 };
 
 int st_gyro_allocate_ring(struct iio_dev *indio_dev)
-- 
2.22.0

