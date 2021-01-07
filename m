Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AE2ECE82
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jan 2021 12:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbhAGLSM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jan 2021 06:18:12 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51396 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbhAGLSL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jan 2021 06:18:11 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107BEgnW009880;
        Thu, 7 Jan 2021 06:17:17 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wsv6h0ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 06:17:17 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 107BHGWq024814
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 7 Jan 2021 06:17:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 Jan 2021 06:17:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 7 Jan 2021 06:17:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 7 Jan 2021 06:17:15 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 107BHDpq015369;
        Thu, 7 Jan 2021 06:17:13 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v8] iio: Handle enumerated properties with gaps
Date:   Thu, 7 Jan 2021 13:20:49 +0200
Message-ID: <20210107112049.10815-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=965 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some enums might have gaps or reserved values in the middle of their value
range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
meaning, but 2 is a reserved value and can not be used.

Add support for such enums to the IIO enum helper functions. A reserved
values is marked by setting its entry in the items array to NULL rather
than the normal descriptive string value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v7 -> v8:
* https://lore.kernel.org/linux-iio/20210107084434.35283-1-alexandru.ardelean@analog.com/
* dropped patch 'lib/string.c: add __sysfs_match_string_with_gaps() helper'
* merged __sysfs_match_string_with_gaps into  drivers/iio/industrial-core.c 
  as iio_sysfs_match_string_with_gaps()

 drivers/iio/industrialio-core.c | 39 ++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e9ee9363fed0..db20e2ab437d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -169,6 +169,36 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 };
 
+/**
+ * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
+ * @array: array of strings
+ * @n: number of strings in the array
+ * @str: string to match with
+ *
+ * Returns index of @str in the @array or -EINVAL, similar to match_string().
+ * Uses sysfs_streq instead of strcmp for matching.
+ *
+ * This routine will look for a string in an array of strings.
+ * The search will continue until the element is found or the n-th element
+ * is reached, regardless of any NULL elements in the array.
+ */
+static int iio_sysfs_match_string_with_gaps(const char * const *array, size_t n,
+					    const char *str)
+{
+	const char *item;
+	int index;
+
+	for (index = 0; index < n; index++) {
+		item = array[index];
+		if (!item)
+			continue;
+		if (sysfs_streq(item, str))
+			return index;
+	}
+
+	return -EINVAL;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 /*
  * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
@@ -470,8 +500,11 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 	if (!e->num_items)
 		return 0;
 
-	for (i = 0; i < e->num_items; ++i)
+	for (i = 0; i < e->num_items; ++i) {
+		if (!e->items[i])
+			continue;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+	}
 
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
@@ -492,7 +525,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	i = e->get(indio_dev, chan);
 	if (i < 0)
 		return i;
-	else if (i >= e->num_items)
+	else if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
@@ -509,7 +542,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	if (!e->set)
 		return -EINVAL;
 
-	ret = __sysfs_match_string(e->items, e->num_items, buf);
+	ret = iio_sysfs_match_string_with_gaps(e->items, e->num_items, buf);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

