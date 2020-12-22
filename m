Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF362E0A47
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgLVNKC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 08:10:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64154 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgLVNKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 08:10:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BMD6wp7018139;
        Tue, 22 Dec 2020 08:09:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35k0e12c3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 08:09:06 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BMD94Qr058536
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 08:09:05 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 22 Dec 2020 05:09:04 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 22 Dec 2020 05:09:03 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 22 Dec 2020 05:09:03 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BMD90Lv009831;
        Tue, 22 Dec 2020 08:09:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
Date:   Tue, 22 Dec 2020 15:13:11 +0200
Message-ID: <20201222131312.64957-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_06:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220096
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The original docstring of the __sysfs_match_string() and match_string()
helper, implied that -1 could be used to search through NULL terminated
arrays, and positive 'n' could be used to go through arrays that may have
NULL elements in the middle of the array.

This isn't true. Regardless of the value of 'n', the first NULL element in
the array will stop the search, even if the element may be after a NULL
element.

To allow for a behavior where we can use the __sysfs_match_string() to
search over arrays with NULL elements in the middle, the
__sysfs_match_string_with_gaps() helper is added.
If n > 0, the search will continue until the element is found or n is
reached.
If n < 0, the search will continue until the element is found or a NULL
character is found.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v5 -> v6
* https://lore.kernel.org/linux-iio/20201222095210.61897-1-alexandru.ardelean@analog.com/
* Fixed/updated comment; one sentence was stopping midway

 include/linux/string.h |  1 +
 lib/string.c           | 55 +++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..d7999e50dae1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -191,6 +191,7 @@ static inline int strtobool(const char *s, bool *res)
 
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
+int __sysfs_match_string_with_gaps(const char * const *array, ssize_t n, const char *s);
 
 /**
  * sysfs_match_string - matches given string in an array
diff --git a/lib/string.c b/lib/string.c
index 4288e0158d47..3dbd362f28a2 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -751,6 +751,26 @@ int match_string(const char * const *array, size_t n, const char *string)
 }
 EXPORT_SYMBOL(match_string);
 
+static int __sysfs_match_string_common(const char * const *array, ssize_t n,
+				       const char *str, bool gaps)
+{
+	const char *item;
+	int index;
+
+	for (index = 0; index < n; index++) {
+		item = array[index];
+		if (!item) {
+			if (gaps && n > 0)
+				continue;
+			break;
+		}
+		if (sysfs_streq(item, str))
+			return index;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * __sysfs_match_string - matches given string in an array
  * @array: array of strings
@@ -770,21 +790,32 @@ EXPORT_SYMBOL(match_string);
  */
 int __sysfs_match_string(const char * const *array, size_t n, const char *str)
 {
-	const char *item;
-	int index;
-
-	for (index = 0; index < n; index++) {
-		item = array[index];
-		if (!item)
-			break;
-		if (sysfs_streq(item, str))
-			return index;
-	}
-
-	return -EINVAL;
+	return __sysfs_match_string_common(array, n, str, false);
 }
 EXPORT_SYMBOL(__sysfs_match_string);
 
+/**
+ * __sysfs_match_string_with_gaps - matches given string in an array with gaps
+ * @array: array of strings
+ * @n: number of strings in the array or negative for NULL terminated arrays
+ * @str: string to match with
+ *
+ * Returns index of @str in the @array or -EINVAL, similar to match_string().
+ * Uses sysfs_streq instead of strcmp for matching.
+ *
+ * This routine will look for a string in an array of strings.
+ * If n > 0, then the search will continue until the element is found or
+ * the n-th element is reached, regardless of any NULL elements in the array.
+ * If n < 0, then the search will continue until the element is found or
+ * util the first NULL element.
+ */
+int __sysfs_match_string_with_gaps(const char * const *array, ssize_t n,
+				   const char *str)
+{
+	return __sysfs_match_string_common(array, n, str, true);
+}
+EXPORT_SYMBOL(__sysfs_match_string_with_gaps);
+
 #ifndef __HAVE_ARCH_MEMSET
 /**
  * memset - Fill a region of memory with the given value
-- 
2.17.1

