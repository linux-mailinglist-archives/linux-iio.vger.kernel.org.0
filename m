Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94861CB10F
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEHNyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52286 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728353AbgEHNyU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:20 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dib8J031165;
        Fri, 8 May 2020 09:54:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2j64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:08 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds7aP040856
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:07 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 06:54:06 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 06:54:05 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwu030263;
        Fri, 8 May 2020 09:54:04 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 10/14] iio: buffer: remove attrcount_orig var from sysfs creation
Date:   Fri, 8 May 2020 16:53:44 +0300
Message-ID: <20200508135348.15229-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=2
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The variable no longer does anything.
It's around because of some older code that required it to keep track of
certain attribute numbers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 6b1b5d5387bd..efebf74a05af 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1317,7 +1317,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 	struct iio_dev *indio_dev = buffer->indio_dev;
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	int ret, i, attrn, attrcount, attrcount_orig = 0;
+	int ret, i, attrn, attrcount;
 	const struct iio_chan_spec *channels;
 
 	attrcount = 0;
@@ -1349,7 +1349,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
 
-	attrcount = attrcount_orig;
+	attrcount = 0;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1382,7 +1382,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
 	}
-	attrn = attrcount_orig;
+	attrn = 0;
 
 	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
 		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-- 
2.17.1

