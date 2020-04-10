Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338111A447D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJJfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 05:35:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54948 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgDJJfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 05:35:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03A9Yncg031470;
        Fri, 10 Apr 2020 05:35:26 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091nb0pu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 05:35:26 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03A9ZPGV027798
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 10 Apr 2020 05:35:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 10 Apr
 2020 05:35:24 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 10 Apr 2020 05:35:23 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03A9ZK1G018489;
        Fri, 10 Apr 2020 05:35:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RFC] iio: buffer: remove 'scan_el_attrs' attribute group from buffer struct
Date:   Fri, 10 Apr 2020 12:36:07 +0300
Message-ID: <20200410093607.74516-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_03:2020-04-07,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=2
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This field doesn't seem used. It seems that only 'buffer->attrs' was ever
used to extend sysfs attributes for an IIO buffer.

Moving forward, it may not make sense to keep it. This patch removes the
field and it's initialization code.

Since we want to rework IIO buffer, to be able to add more buffers per IIO
device, we will merge [somehow] the 'buffer' & 'scan_elements' groups, and
we will continue to add the attributes to the 'buffer' group.

Removing it here, will also make the rework here a bit smaller, since
this code will not be present.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

I have no idea whether removing this is acceptable or not.
If it is acceptable, then this can be applied.
I am a bit vague on how this was ever used, of if it was ever used, but
it looks like dead code.


 drivers/iio/industrialio-buffer.c | 8 --------
 include/linux/iio/buffer_impl.h   | 6 ------
 2 files changed, 14 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e6fa1a4e135d..221157136af6 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1283,11 +1283,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
 
-	if (buffer->scan_el_attrs != NULL) {
-		attr = buffer->scan_el_attrs->attrs;
-		while (*attr++ != NULL)
-			attrcount_orig++;
-	}
 	attrcount = attrcount_orig;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
 	channels = indio_dev->channels;
@@ -1325,9 +1320,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
 	}
-	if (buffer->scan_el_attrs)
-		memcpy(buffer->scan_el_group.attrs, buffer->scan_el_attrs,
-		       sizeof(buffer->scan_el_group.attrs[0])*attrcount_orig);
 	attrn = attrcount_orig;
 
 	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 1e7edf6bed96..a63dc07b7350 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -94,12 +94,6 @@ struct iio_buffer {
 	unsigned int watermark;
 
 	/* private: */
-	/*
-	 * @scan_el_attrs: Control of scan elements if that scan mode
-	 * control method is used.
-	 */
-	struct attribute_group *scan_el_attrs;
-
 	/* @scan_timestamp: Does the scan mode include a timestamp. */
 	bool scan_timestamp;
 
-- 
2.17.1

