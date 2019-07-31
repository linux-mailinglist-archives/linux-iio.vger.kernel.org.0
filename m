Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67E57D052
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfGaVxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14426 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727987AbfGaVxO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:53:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLlVoj017013;
        Wed, 31 Jul 2019 23:53:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=c2R5PGscM6eXuYCQbXpNI5k/P+egYypUIzMikfSs97w=;
 b=fyaSUND6ylSJJPDDjvRMgYpNtGyOsX72VNJ6L7B2KIhM6gX6KUhf5x4FI74CTAQgBf3H
 8LWsYT0Pljv5fL6JmR2/q42mHtin+EDUnug1NkdH5Dh7apPiK2SYqqx0ufXIWRC7eGf8
 PUy7jdy+vonazow03x90IwWiug0Y6aj1zccvrA65ys3BUTWt74gRvUk0o9UDXSI9Tlu/
 ueso3YaM4L4Ql2DcA+j/OacrOPaD2qJrRJJ2Rftpl5xmXOTQmg2tFFt2OKV9kRQdEfzZ
 Y+RwUK7HEcP5Q40dOCA0EVWrOqSWPBnnnUkxwJ7IbmjwvAejHF169EvarGuK+FMyj72j oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0bra6m4f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:53:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D29C31;
        Wed, 31 Jul 2019 21:53:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25AFC777EB;
        Wed, 31 Jul 2019 23:53:07 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:53:06
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 5/5] iio:pressure: do not allocate/de-allocate buffer here but link setup_ops to st_sensors_buffer
Date:   Wed, 31 Jul 2019 14:52:50 -0700
Message-ID: <20190731215250.16403-6-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731215250.16403-1-denis.ciocca@st.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG1NODE1.st.com
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
 drivers/iio/pressure/st_pressure_buffer.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 77cb2d862f19..4306541953d0 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -31,17 +31,11 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
 	int err;
 
-	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
-					  GFP_DMA | GFP_KERNEL);
-	if (!press_data->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_press_free_buffer;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -51,14 +45,11 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 
 st_press_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_press_free_buffer:
-	kfree(press_data->buffer_data);
 	return err;
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -67,13 +58,14 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(press_data->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
+	.preenable = &st_sensors_buffer_preenable,
 	.postenable = &st_press_buffer_postenable,
 	.predisable = &st_press_buffer_predisable,
+	.postdisable = &st_sensors_buffer_postdisable,
 };
 
 int st_press_allocate_ring(struct iio_dev *indio_dev)
-- 
2.22.0

