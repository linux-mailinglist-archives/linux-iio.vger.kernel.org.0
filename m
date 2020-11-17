Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDC2B69D0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgKQQS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:18:56 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23600 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgKQQSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:18:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGEV7d001204;
        Tue, 17 Nov 2020 11:18:42 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybjdgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:42 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIeJv039803
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 11:18:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 11:18:39 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTU032565;
        Tue, 17 Nov 2020 11:18:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 08/12] iio: buffer: add helper to get the IIO device to which a buffer belongs
Date:   Tue, 17 Nov 2020 18:23:36 +0200
Message-ID: <20201117162340.43924-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=787
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
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
index 8b4b7baf21da..342e5432f7d9 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1736,6 +1736,20 @@ void iio_buffer_put(struct iio_buffer *buffer)
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

