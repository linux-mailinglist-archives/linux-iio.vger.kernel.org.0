Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803682B69CC
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgKQQSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:18:53 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21050 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgKQQSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:18:53 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHFgZLL010561;
        Tue, 17 Nov 2020 11:18:41 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td199y7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:36 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIZ7O039786
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 11:18:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 11:18:34 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTQ032565;
        Tue, 17 Nov 2020 11:18:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 04/12] iio: buffer: add index to the first IIO buffer dir and symlink it back
Date:   Tue, 17 Nov 2020 18:23:32 +0200
Message-ID: <20201117162340.43924-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_04:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=2
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170115
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes it so that the first buffer directory is named 'buffer0'
and moves the 'scan_elements' under it.

For backwards compatibility these folders are symlinked back to the
original folders.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 8b31faf049a5..62c8bd6b67cd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1346,7 +1346,8 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
 }
 
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
-					     struct iio_dev *indio_dev)
+					     struct iio_dev *indio_dev,
+					     unsigned int idx)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
@@ -1378,7 +1379,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	buffer->buffer_attrs = attr;
 
 	ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
-				   &indio_dev->dev.kobj, "buffer");
+				   &indio_dev->dev.kobj, "buffer%u", idx);
 	if (ret)
 		goto error_buffer_free_attrs;
 
@@ -1423,7 +1424,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	}
 
 	ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
-				   &indio_dev->dev.kobj, "scan_elements");
+				   &buffer->buffer_dir, "scan_elements");
 	if (ret)
 		goto error_free_scan_attrs;
 
@@ -1454,11 +1455,13 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	return ret;
 }
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer);
+
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
-	int i;
+	int i, ret;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1472,7 +1475,29 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
+	ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&indio_dev->buffer->buffer_dir,
+				"buffer");
+	if (ret)
+		goto error_free_sysfs_and_mask;
+
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&indio_dev->buffer->scan_el_dir,
+				"scan_elements");
+	if (ret)
+		goto error_remove_buffer_dir_link;
+
+	return 0;
+
+error_remove_buffer_dir_link:
+	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
+error_free_sysfs_and_mask:
+	__iio_buffer_free_sysfs_and_mask(buffer);
+	return ret;
 }
 
 static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
@@ -1494,6 +1519,9 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
+	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
+	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
+
 	__iio_buffer_free_sysfs_and_mask(buffer);
 }
 
-- 
2.17.1

