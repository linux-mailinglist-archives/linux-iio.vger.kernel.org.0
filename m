Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D15300993
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbhAVQ4A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 11:56:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55924 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbhAVQXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 11:23:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MG0n1B025802;
        Fri, 22 Jan 2021 11:22:40 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbtndj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:22:40 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10MGMckX058199
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 11:22:38 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 22 Jan 2021
 11:22:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 11:22:37 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MGMOCu016711;
        Fri, 22 Jan 2021 11:22:36 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 08/12][RESEND] iio: buffer: add helper to get the IIO device to which a buffer belongs
Date:   Fri, 22 Jan 2021 18:25:25 +0200
Message-ID: <20210122162529.84978-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122162529.84978-1-alexandru.ardelean@analog.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=886
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is useful for drivers that may have a reference to an IIO buffer, to
be able to get a reference back to the IIO device.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 14 ++++++++++++++
 include/linux/iio/buffer.h        |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 8470921cf2fa..a2dd30567072 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1778,6 +1778,20 @@ void iio_buffer_put(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
+/**
+ * iio_buffer_get_iio_dev - Get the IIO device to which this buffer belongs to
+ * @buffer: The buffer for which to retrieve the IIO device
+ *
+ * This function retrieves the IIO device to which this IIO buffer is attached
+ * to. Given that an IIO device may have multiple IIO buffers, it's useful
+ * for some drivers to obtain a reference back to the IIO device.
+ */
+struct iio_dev *iio_buffer_get_iio_dev(struct iio_buffer *buffer)
+{
+	return buffer->indio_dev;
+}
+EXPORT_SYMBOL_GPL(iio_buffer_get_iio_dev);
+
 /**
  * iio_device_attach_buffer - Attach a buffer to a IIO device
  * @indio_dev: The device the buffer should be attached to
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 8febc23f5f26..b27d8c81f32c 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,6 +11,8 @@
 
 struct iio_buffer;
 
+struct iio_dev *iio_buffer_get_iio_dev(struct iio_buffer *buffer);
+
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 /**
-- 
2.17.1

