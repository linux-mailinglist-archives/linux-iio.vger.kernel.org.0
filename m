Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAB97D04F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfGaVxH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28116 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbfGaVxH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:53:07 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLqV4X016197;
        Wed, 31 Jul 2019 23:52:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=Mfj69tr2pDDSjxNqSpPWtwDMc4TWU5VoO/ch6jGhS98=;
 b=YZtgFn1u+Fx7A6mu8qDVBqTKDXNSBFT2yiGQjpj6qcmLG8IbxwjIfME+E0spsqP1aQSf
 VGdguhr/7NifxBue+CQ5fnWXp1+pP05uFKFtANyo8gdnhabyEVDbrDcOAdGMY+aTu4YO
 9V/5OGePXFWcju3sjy2IL418dI5lCtyMJ0FyrrUEraTRf5iqu/1KVv/SL5sGoW29ubNm
 Q/m7yk0om7pTt5a2RJ3v1xhTvD8oDjd6eEqrTjUP4DgKhD2K7V4+tz0NSf/c681x0ksp
 hCam1f8AGip879AUNi7a68ZnkRIc/5++R2qPQxz/IXZ6ZsoevxIAJRiIrB8ZLJzOfXlu Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwtcxu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:52:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A35131;
        Wed, 31 Jul 2019 21:52:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42FF4777EB;
        Wed, 31 Jul 2019 23:52:59 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:52:58
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/5] iio:accel: do not allocate/de-allocate buffer here but link setup_ops to st_sensors_buffer
Date:   Wed, 31 Jul 2019 14:52:47 -0700
Message-ID: <20190731215250.16403-3-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731215250.16403-1-denis.ciocca@st.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG1NODE1.st.com
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
 drivers/iio/accel/st_accel_buffer.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 59dcef02ec19..fc1ba52152ab 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -31,17 +31,11 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
 	int err;
 
-	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!adata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_accel_free_buffer;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					 (u8)indio_dev->active_scan_mask[0]);
@@ -58,14 +52,11 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 st_accel_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_accel_free_buffer:
-	kfree(adata->buffer_data);
 	return err;
 }
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -79,13 +70,14 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(adata->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
+	.preenable = &st_sensors_buffer_preenable,
 	.postenable = &st_accel_buffer_postenable,
 	.predisable = &st_accel_buffer_predisable,
+	.postdisable = &st_sensors_buffer_postdisable,
 };
 
 int st_accel_allocate_ring(struct iio_dev *indio_dev)
-- 
2.22.0

