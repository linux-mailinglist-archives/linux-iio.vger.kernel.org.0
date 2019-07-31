Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92017D050
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfGaVxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41753 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbfGaVxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:53:12 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLq97h016081;
        Wed, 31 Jul 2019 23:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=2FZ7C50rEs7CbDlj6YokX6ynUj5Qt+oTcPuDxTUEtVM=;
 b=GTZ8ebp2QgfwuDp5+ZlJgfJ0BamgW6u9OwhfW80D+FBFZybUfKXuDsL5jXLOxexE/3sA
 nHjWuPgYfWyP58ubH5L3xJzJEqAdiying4MtytplFg0OzNVs2uvj2CDdvWtZlTHnpTSo
 ELbGLFp0RKidxqyWwRqf2sTP/pyQ9A3ChYg06BJdyyXdZXujiXB5UzudFdgbtlCXj5CK
 01Sld4p9zdmJp+cSP1fK1MdCt4ILypzwA5Yyph+IpCN7PFufvaoXBesueP0q+K64havz
 BMOrXWBkXhCQHxzwUOVPEUad6+6AC6R/7OvSDb/f9k5cSGbYU090UBfNF7BX2tywK2lN Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwtcy5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:53:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B13638;
        Wed, 31 Jul 2019 21:53:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 915B2777ED;
        Wed, 31 Jul 2019 23:53:04 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:53:03
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 4/5] iio:magn: do not allocate/de-allocate buffer here but link setup_ops to st_sensors_buffer
Date:   Wed, 31 Jul 2019 14:52:49 -0700
Message-ID: <20190731215250.16403-5-denis.ciocca@st.com>
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

Setup buffer_setup_ops pre/post enable/disable to use
st_sensor_buffers functions for memory allocation/de-allocation.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 658d627dad8e..592972f6450e 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -31,17 +31,11 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int err;
 
-	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!mdata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_magn_free_buffer;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -51,14 +45,11 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 
 st_magn_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_magn_free_buffer:
-	kfree(mdata->buffer_data);
 	return err;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -67,13 +58,14 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(mdata->buffer_data);
 	return err;
 }
 
 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
+	.preenable = &st_sensors_buffer_preenable,
 	.postenable = &st_magn_buffer_postenable,
 	.predisable = &st_magn_buffer_predisable,
+	.postdisable = &st_sensors_buffer_postdisable,
 };
 
 int st_magn_allocate_ring(struct iio_dev *indio_dev)
-- 
2.22.0

