Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0477E318A70
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBKM0M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:26:12 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31820 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhBKMXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:53 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCMfVD016207;
        Thu, 11 Feb 2021 07:23:00 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qg8w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:23:00 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCMwTZ004279
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:22:59 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 11 Feb 2021
 04:22:57 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 11 Feb 2021 04:22:57 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWj011557;
        Thu, 11 Feb 2021 07:22:54 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 11/17] iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc
Date:   Thu, 11 Feb 2021 14:24:46 +0200
Message-ID: <20210211122452.78106-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_05:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=867
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The __iio_buffer_free_sysfs_and_mask() function will be used in
iio_buffer_alloc_sysfs_and_mask() when multiple buffers will be attached to
the IIO device.
This will need to be used to cleanup resources on each buffer, when the
buffers cleanup unwind will occur on the error path.

The move is done in this patch to make the patch that adds multiple buffers
per IIO device a bit cleaner.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a6148ed24e41..209b3a32bdbb 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1443,6 +1443,14 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	return ret;
 }
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
+	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.name);
+	kfree(buffer->buffer_group.attrs);
+	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
+}
+
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
@@ -1464,14 +1472,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
 }
 
-static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
-{
-	bitmap_free(buffer->scan_mask);
-	kfree(buffer->buffer_group.name);
-	kfree(buffer->buffer_group.attrs);
-	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
-}
-
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
-- 
2.17.1

