Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01D30AB45
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBAP2q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 10:28:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42974 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhBAOtb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2021 09:49:31 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111El91K014355;
        Mon, 1 Feb 2021 09:48:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbucuqae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:48:37 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 111EmaR2030273
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 1 Feb 2021 09:48:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 1 Feb 2021 09:48:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 1 Feb 2021 09:48:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 1 Feb 2021 09:48:35 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111EmNuB027350;
        Mon, 1 Feb 2021 09:48:32 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 05/11] iio: buffer: group attr count and attr alloc
Date:   Mon, 1 Feb 2021 16:50:59 +0200
Message-ID: <20210201145105.20459-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201145105.20459-1-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=727 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If we want to merge the attributes of the buffer/ and scan_elements/
directories, we'll need to count all attributes first, then (depending on
the attribute group) either allocate 2 attribute groups, or a single one.

This change moves the allocation of the buffer/ attributes closer to the
allocation of the scan_elements/ attributes to make grouping easier.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 71 ++++++++++++++++---------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cc846988fdb9..23f22be62cc7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1257,41 +1257,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	int ret, i, attrn, attrcount;
+	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
 	const struct iio_chan_spec *channels;
 
-	attrcount = 0;
+	buffer_attrcount = 0;
 	if (buffer->attrs) {
-		while (buffer->attrs[attrcount] != NULL)
-			attrcount++;
+		while (buffer->attrs[buffer_attrcount] != NULL)
+			buffer_attrcount++;
 	}
 
-	attr = kcalloc(attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
-		       sizeof(struct attribute *), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
-	if (!buffer->access->set_length)
-		attr[0] = &dev_attr_length_ro.attr;
-
-	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
-		attr[2] = &dev_attr_watermark_ro.attr;
-
-	if (buffer->attrs)
-		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
-		       sizeof(struct attribute *) * attrcount);
-
-	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
-
-	buffer->buffer_group.name = "buffer";
-	buffer->buffer_group.attrs = attr;
-
-	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
-	if (ret)
-		goto error_free_buffer_attrs;
-
-	attrcount = 0;
+	scan_el_attrcount = 0;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1304,7 +1279,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 							 &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
-			attrcount += ret;
+			scan_el_attrcount += ret;
 			if (channels[i].type == IIO_TIMESTAMP)
 				indio_dev->scan_index_timestamp =
 					channels[i].scan_index;
@@ -1319,9 +1294,37 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		}
 	}
 
+	attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
+		       sizeof(struct attribute *), GFP_KERNEL);
+	if (!attr) {
+		ret = -ENOMEM;
+		goto error_free_scan_mask;
+	}
+
+	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
+	if (!buffer->access->set_length)
+		attr[0] = &dev_attr_length_ro.attr;
+
+	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
+		attr[2] = &dev_attr_watermark_ro.attr;
+
+	if (buffer->attrs)
+		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
+		       sizeof(struct attribute *) * buffer_attrcount);
+
+	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
+	attr[buffer_attrcount] = NULL;
+
+	buffer->buffer_group.name = "buffer";
+	buffer->buffer_group.attrs = attr;
+
+	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
+	if (ret)
+		goto error_free_buffer_attrs;
+
 	buffer->scan_el_group.name = iio_scan_elements_group_name;
 
-	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
+	buffer->scan_el_group.attrs = kcalloc(scan_el_attrcount + 1,
 					      sizeof(buffer->scan_el_group.attrs[0]),
 					      GFP_KERNEL);
 	if (buffer->scan_el_group.attrs == NULL) {
@@ -1341,12 +1344,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
 error_free_scan_el_attrs:
 	kfree(buffer->scan_el_group.attrs);
+error_free_buffer_attrs:
+	kfree(buffer->buffer_group.attrs);
 error_free_scan_mask:
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-error_free_buffer_attrs:
-	kfree(buffer->buffer_group.attrs);
 
 	return ret;
 }
-- 
2.17.1

