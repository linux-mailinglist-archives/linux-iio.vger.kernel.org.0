Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03C1CB11B
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEHNys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52062 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbgEHNyU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dqt4G016877;
        Fri, 8 May 2020 09:54:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2gcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:08 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds6Za038800
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:07 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 06:54:05 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 06:53:32 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 06:54:04 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwt030263;
        Fri, 8 May 2020 09:54:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 09/14] iio: buffer: split buffer sysfs creation to take buffer as primary arg
Date:   Fri, 8 May 2020 16:53:43 +0300
Message-ID: <20200508135348.15229-10-alexandru.ardelean@analog.com>
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

Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
primary argument. This change converts to take an IIO buffer as a primary
argument.

That will allow the functions to get called for multiple buffers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e7a847e7b103..6b1b5d5387bd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1312,26 +1312,14 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 {
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
 	const struct iio_chan_spec *channels;
 
-	channels = indio_dev->channels;
-	if (channels) {
-		int ml = indio_dev->masklength;
-
-		for (i = 0; i < indio_dev->num_channels; i++)
-			ml = max(ml, channels[i].scan_index + 1);
-		indio_dev->masklength = ml;
-	}
-
-	if (!buffer)
-		return 0;
-
 	attrcount = 0;
 	if (buffer->attrs) {
 		while (buffer->attrs[attrcount] != NULL)
@@ -1411,19 +1399,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return ret;
 }
 
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
+	const struct iio_chan_spec *channels;
+	int i;
+
+	channels = indio_dev->channels;
+	if (channels) {
+		int ml = indio_dev->masklength;
+
+		for (i = 0; i < indio_dev->num_channels; i++)
+			ml = max(ml, channels[i].scan_index + 1);
+		indio_dev->masklength = ml;
+	}
 
 	if (!buffer)
-		return;
+		return 0;
+
+	return __iio_buffer_alloc_sysfs_and_mask(buffer);
+}
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
 	iio_buffer_free_scanmask(buffer);
 	kfree(buffer->buffer_group.attrs);
 	kfree(buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
+void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
+		return;
+
+	__iio_buffer_free_sysfs_and_mask(buffer);
+}
+
 static const struct file_operations iio_buffer_fileops = {
 	.read = iio_buffer_read_outer,
 	.release = iio_buffer_chrdev_release,
-- 
2.17.1

