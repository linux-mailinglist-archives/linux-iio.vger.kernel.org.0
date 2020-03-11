Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38706181239
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 08:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgCKHn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 03:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgCKHn3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 03:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA698AEAC;
        Wed, 11 Mar 2020 07:43:27 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: core: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:43:24 +0100
Message-Id: <20200311074325.7922-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311074325.7922-1-tiwai@suse.de>
References: <20200311074325.7922-1-tiwai@suse.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/iio/industrialio-core.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 65ff0d067018..197006b5d5c2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -559,46 +559,46 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 
 	switch (type) {
 	case IIO_VAL_INT:
-		return snprintf(buf, len, "%d", vals[0]);
+		return scnprintf(buf, len, "%d", vals[0]);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
 		scale_db = true;
 		/* fall through */
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (vals[1] < 0)
-			return snprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
+			return scnprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
 					-vals[1], scale_db ? " dB" : "");
 		else
-			return snprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
+			return scnprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
 					scale_db ? " dB" : "");
 	case IIO_VAL_INT_PLUS_NANO:
 		if (vals[1] < 0)
-			return snprintf(buf, len, "-%d.%09u", abs(vals[0]),
+			return scnprintf(buf, len, "-%d.%09u", abs(vals[0]),
 					-vals[1]);
 		else
-			return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
+			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
 	case IIO_VAL_FRACTIONAL:
 		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
 		int l = 0;
 
 		for (i = 0; i < size; ++i) {
-			l += snprintf(&buf[l], len - l, "%d ", vals[i]);
+			l += scnprintf(&buf[l], len - l, "%d ", vals[i]);
 			if (l >= len)
 				break;
 		}
 		return l;
 	}
 	case IIO_VAL_CHAR:
-		return snprintf(buf, len, "%c", (char)vals[0]);
+		return scnprintf(buf, len, "%c", (char)vals[0]);
 	default:
 		return 0;
 	}
@@ -669,10 +669,10 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 			if (i < length - 1)
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						" ");
 			else
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						"\n");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
@@ -685,10 +685,10 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 			if (i < length / 2 - 1)
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						" ");
 			else
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						"\n");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
@@ -712,10 +712,10 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 			if (i < 2)
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						" ");
 			else
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						"]\n");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
@@ -728,10 +728,10 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
 			if (i < 2)
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						" ");
 			else
-				len += snprintf(buf + len, PAGE_SIZE - len,
+				len += scnprintf(buf + len, PAGE_SIZE - len,
 						"]\n");
 			if (len >= PAGE_SIZE)
 				return -EFBIG;
-- 
2.16.4

