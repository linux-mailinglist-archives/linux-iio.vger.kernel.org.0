Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E327919AC43
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgDANAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 09:00:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49202 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732545AbgDANAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 09:00:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031CufLh009889;
        Wed, 1 Apr 2020 09:00:23 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g5cb63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:00:23 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 031D0L7J057278
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Apr 2020 09:00:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 1 Apr 2020
 09:00:20 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 1 Apr 2020 09:00:20 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 031D0Hmv023654;
        Wed, 1 Apr 2020 09:00:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <lorenzo.bianconi83@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: kfifo: add iio_device_attach_kfifo_buffer() helper
Date:   Wed, 1 Apr 2020 15:59:34 +0300
Message-ID: <20200401125936.6398-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=2 mlxlogscore=815 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the iio_device_attach_kfifo_buffer() helper/short-hand,
which groups the simple routine of allocating a kfifo buffers via
devm_iio_kfifo_allocate() and calling iio_device_attach_buffer().

The mode_flags parameter is required. The setup_ops parameter is optional.

This function will be a bit more useful when needing to define multiple
buffers per IIO device.

One requirement [that is more a recommendation] for this helper, is to call
it after 'indio_dev' has been populated.

Also, one consequence related to using this helper is that the resource
management of the buffer will be tied to 'indio_dev->dev'. Previously it
was open-coded, and each driver does it slightly differently. Most of them
tied it to the parent device, some of them to 'indio_dev->dev'.
This shouldn't be a problem, and may be a good idea when adding more
buffers per-device.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/kfifo_buf.c | 37 ++++++++++++++++++++++++++++++++++
 include/linux/iio/kfifo_buf.h  |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 3150f8ab984b..05b7c5fc6f1d 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -228,4 +228,41 @@ void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r)
 }
 EXPORT_SYMBOL(devm_iio_kfifo_free);
 
+/**
+ * iio_device_attach_kfifo_buffer - Allocate a kfifo buffer & attach it to an IIO device
+ * @indio_dev: The device the buffer should be attached to
+ * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
+ *		INDIO_BUFFER_TRIGGERED).
+ * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
+ *
+ * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
+ * attaches it to the IIO device via iio_device_attach_buffer().
+ * This is meant to be a bit of a short-hand/helper function as many driver
+ * seem to do this.
+ */
+int iio_device_attach_kfifo_buffer(struct iio_dev *indio_dev,
+				   int mode_flags,
+				   const struct iio_buffer_setup_ops *setup_ops)
+{
+	struct iio_buffer *buffer;
+
+	if (mode_flags)
+		mode_flags &= kfifo_access_funcs.modes;
+
+	if (!mode_flags)
+		return -EINVAL;
+
+	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	indio_dev->modes |= mode_flags;
+	indio_dev->setup_ops = setup_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_device_attach_kfifo_buffer);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 764659e01b68..2363a931be14 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -11,4 +11,8 @@ void iio_kfifo_free(struct iio_buffer *r);
 struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
 void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r);
 
+int iio_device_attach_kfifo_buffer(struct iio_dev *indio_dev,
+				   int mode_flags,
+				   const struct iio_buffer_setup_ops *setup_ops);
+
 #endif
-- 
2.17.1

