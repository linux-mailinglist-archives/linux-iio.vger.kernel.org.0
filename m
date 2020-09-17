Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4626E02B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgIQP7x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 11:59:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30404 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbgIQP7q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 11:59:46 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HClZei001796;
        Thu, 17 Sep 2020 09:00:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5q56qjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:00:01 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08HCxxnv024628
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 09:00:00 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 06:00:05 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 06:00:05 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 06:00:05 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HCxsR3022978;
        Thu, 17 Sep 2020 08:59:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: split buffer sysfs creation to take buffer as primary arg
Date:   Thu, 17 Sep 2020 15:59:51 +0300
Message-ID: <20200917125951.861-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170099
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
primary argument. This change splits the main logic into a private function
that takes an IIO buffer as primary argument.

That way, the functions can be extended to configure the sysfs for multiple
buffers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a7d7e5143ed2..a4f6bb96d4f4 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1264,26 +1264,14 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
+					     struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount;
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
@@ -1367,19 +1355,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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
+	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
+}
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
 	bitmap_free(buffer->scan_mask);
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
 /**
  * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
  * @indio_dev: the iio device
-- 
2.17.1

