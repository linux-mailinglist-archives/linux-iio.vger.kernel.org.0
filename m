Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84C27BD9F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgI2HK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 03:10:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20980 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727605AbgI2HKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 03:10:18 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T75BkW016026;
        Tue, 29 Sep 2020 03:10:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg625e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:10:13 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08T7AC0j049619
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 03:10:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 03:10:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 03:10:04 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08T79hUs013506;
        Tue, 29 Sep 2020 03:10:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 9/9] iio: buffer: remove iio_buffer_set_attrs() helper
Date:   Tue, 29 Sep 2020 10:09:08 +0300
Message-ID: <20200929070908.10456-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929070908.10456-1-alexandru.ardelean@analog.com>
References: <20200929070908.10456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_buffer_set_attrs() is no longer used in the drivers, so it can be
removed now.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 12 ------------
 include/linux/iio/buffer.h        |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a4f6bb96d4f4..9663dec3dcf3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -210,18 +210,6 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
-/**
- * iio_buffer_set_attrs - Set buffer specific attributes
- * @buffer: The buffer for which we are setting attributes
- * @attrs: Pointer to a null terminated list of pointers to attributes
- */
-void iio_buffer_set_attrs(struct iio_buffer *buffer,
-			 const struct attribute **attrs)
-{
-	buffer->attrs = attrs;
-}
-EXPORT_SYMBOL_GPL(iio_buffer_set_attrs);
-
 static ssize_t iio_show_scan_index(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fbba4093f06c..8febc23f5f26 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,9 +11,6 @@
 
 struct iio_buffer;
 
-void iio_buffer_set_attrs(struct iio_buffer *buffer,
-			 const struct attribute **attrs);
-
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 /**
-- 
2.17.1

