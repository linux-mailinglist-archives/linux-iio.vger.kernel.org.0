Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3493A2ECBD7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jan 2021 09:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAGIl6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jan 2021 03:41:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47726 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbhAGIl6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jan 2021 03:41:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1078TUDS014219;
        Thu, 7 Jan 2021 03:41:02 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wnkjh5te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 03:41:02 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1078f1tY021890
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 7 Jan 2021 03:41:01 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 Jan 2021 03:41:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 7 Jan 2021 03:40:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 7 Jan 2021 03:40:57 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1078es9h007259;
        Thu, 7 Jan 2021 03:40:55 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v7 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
Date:   Thu, 7 Jan 2021 10:44:33 +0200
Message-ID: <20210107084434.35283-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_04:2021-01-06,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070051
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

FWIW (from my side): I am not fully sure yet that implementing a
new helper is the best idea. It's also not a bad idea.
It's one of those "this could be useful for others as well later", but
right now we would have only one user (IIO) for this.

I'm also fine with just implementing it in IIO first, and the someone
else can move it to lib/string.c if needed.

For now, this patch serves mostly as a notifier, in case there is more
interest out there for something like this.
I might do a V8, with this implemented in IIO core, and then have it
there, until others would find it useful.

Changelog v6 -> v7:
* https://patchwork.kernel.org/project/linux-iio/patch/20201222131312.64957-1-alexandru.ardelean@analog.com/
* added standalone __sysfs_match_string_with_gaps() function

 include/linux/string.h |  1 +
 lib/string.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index 4288e0158d47..bb99313ad4c1 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -785,6 +785,42 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *str)
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
+ * until the first NULL element.
+ */
+int __sysfs_match_string_with_gaps(const char * const *array, ssize_t n,
+				   const char *str)
+{
+	const char *item;
+	int index;
+
+	for (index = 0; index < n; index++) {
+		item = array[index];
+		if (!item) {
+			if (n < 0)
+				break;
+			continue;
+		}
+		if (sysfs_streq(item, str))
+			return index;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(__sysfs_match_string_with_gaps);
+
 #ifndef __HAVE_ARCH_MEMSET
 /**
  * memset - Fill a region of memory with the given value
-- 
2.17.1

