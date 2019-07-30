Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8E79D3C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 02:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfG3ALP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 20:11:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbfG3ALO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 20:11:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U06smI010177;
        Tue, 30 Jul 2019 02:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=kmtJhg39ytw8DOy7V99t6V1qw0Odkg5seTL+XtoS/PE=;
 b=OwQSSz+eVfuyHj1g9VfleddSj2YFgNTBIcfAeBYjVJlonnxGXNk7x5wf8E/GYSeRgT/M
 EJUxLcOLdXM0yMV9K4pxMjFWduutQmnDiRhbFw9XlxaT1pX06DA7kWxAVfdQyZTL5C55
 bIt/xvFOv4KpZhkkjpheJSstSDdnmZDvawYHoPxr9daoRjlMXf/zPrWmyyK0MpiHl1Je
 ryr3ivuKLqie3s3AWdLB/J4cIVaFfOOEtqcI4GyUTSugO+lZcU4RVR3CzU7TSN8w+8OM
 QTnP+i14eq1bviHMZJbiDmUf1OvgEmSasnem4Xl1K6JzpKIKHxNonv1cJFujWtZ9h7gS nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0br9sfak-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 02:11:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A754531;
        Tue, 30 Jul 2019 00:11:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9117A260C;
        Tue, 30 Jul 2019 00:11:06 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul 2019 02:11:05
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/4] iio:magn: preenable/postenable/predisable fixup for ST magn buffer
Date:   Mon, 29 Jul 2019 17:03:04 -0700
Message-ID: <20190730000305.30958-4-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730000305.30958-1-denis.ciocca@st.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is trying to cleanup for good the buffers operation functions.
Let's rename the goto label using operation to perform and not
where it fails.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 9dba93539a99..8d06643a042d 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -31,40 +31,36 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	int err;
 
 	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
 				     GFP_DMA | GFP_KERNEL);
-	if (mdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (!mdata->buffer_data)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_magn_buffer_postenable_error;
+		goto st_magn_free_buffer;
 
 	return st_sensors_set_enable(indio_dev, true);
 
-st_magn_buffer_postenable_error:
+st_magn_free_buffer:
 	kfree(mdata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
-	if (err < 0)
-		goto st_magn_buffer_predisable_error;
 
-	err = iio_triggered_buffer_predisable(indio_dev);
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
 
-st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
 	return err;
 }
-- 
2.22.0

