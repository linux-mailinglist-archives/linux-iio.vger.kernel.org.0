Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099591CB121
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgEHNy6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42942 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgEHNyO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dqt4F016877;
        Fri, 8 May 2020 09:54:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2gcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:01 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds0eB038773
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 8 May 2020
 09:53:56 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:53:56 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwm030263;
        Fri, 8 May 2020 09:53:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 02/14] iio: hw_consumer: use new scanmask functions
Date:   Fri, 8 May 2020 16:53:36 +0300
Message-ID: <20200508135348.15229-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=2 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

This change moves the handling of the scanmasks to the new wrapper
functions that were added in a previous commit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index f2d27788f666..f1cc72520685 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -28,7 +28,6 @@ struct hw_consumer_buffer {
 	struct list_head head;
 	struct iio_dev *indio_dev;
 	struct iio_buffer buffer;
-	long scan_mask[];
 };
 
 static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
@@ -41,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
 {
 	struct hw_consumer_buffer *hw_buf =
 		iio_buffer_to_hw_consumer_buffer(buffer);
+
+	iio_buffer_free_scanmask(buffer);
 	kfree(hw_buf);
 }
 
@@ -52,26 +53,34 @@ static const struct iio_buffer_access_funcs iio_hw_buf_access = {
 static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
 {
-	size_t mask_size = BITS_TO_LONGS(indio_dev->masklength) * sizeof(long);
 	struct hw_consumer_buffer *buf;
+	int ret;
 
 	list_for_each_entry(buf, &hwc->buffers, head) {
 		if (buf->indio_dev == indio_dev)
 			return buf;
 	}
 
-	buf = kzalloc(sizeof(*buf) + mask_size, GFP_KERNEL);
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
 	buf->buffer.access = &iio_hw_buf_access;
 	buf->indio_dev = indio_dev;
-	buf->buffer.scan_mask = buf->scan_mask;
 
 	iio_buffer_init(&buf->buffer);
+
+	ret = iio_buffer_alloc_scanmask(&buf->buffer, indio_dev);
+	if (ret)
+		goto err_free_buf;
+
 	list_add_tail(&buf->head, &hwc->buffers);
 
 	return buf;
+
+err_free_buf:
+	kfree(buf);
+	return NULL;
 }
 
 /**
@@ -106,7 +115,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 			ret = -ENOMEM;
 			goto err_put_buffers;
 		}
-		set_bit(chan->channel->scan_index, buf->buffer.scan_mask);
+		iio_buffer_channel_enable(&buf->buffer, chan);
 		chan++;
 	}
 
-- 
2.17.1

