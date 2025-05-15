Return-Path: <linux-iio+bounces-19526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D66AB801E
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D86917FFCA
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57983286D50;
	Thu, 15 May 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="KRYbtfwK"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean103.mxserver.ro (clean103.mxserver.ro [176.223.125.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F22874F6;
	Thu, 15 May 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.223.125.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297048; cv=none; b=XTqIKe4qnuIAai7EXUWnWAX/aiMmTf5nTSvqGIzRCBHOsFC5pMKKsdJVrj0HB9UGSFv/N6Xx4BOlV9iU/qYeICkayRz/HRWywq0OoFgE6KjMAukA5DgtNxyJKSgukSB9LIbEorUyvKhhO2fWvrgMQnOszehL8vSoDhNxKsxYCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297048; c=relaxed/simple;
	bh=59EvuJKTItg/MQf3XkZzL1WEDvsOtpA/YLaURewi72g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYPIwsCLWj0W6J99xTF6Qoo77EN0ru72AvIxq4SnyCHfNa3kKDROyygwLlpnKAKJOwkiqpPwCmnO35DcY+xYq/3CB35abvpCLezcO3uGwN7WkfgMJZgfG93r+LgxNa3daTF6og+OxUqYuSZroVo+4cDJ79hGs4aORIhE8n3TRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=KRYbtfwK; arc=none smtp.client-ip=176.223.125.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTmD-00H1kv-CP; Thu, 15 May 2025 04:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5qQNra+2Cp8u7mp46CFqnKOn4bpY4tOymWLSppXXVgQ=; b=KRYbtfwKrP5JWyHDZyJ+LsM4TM
	ko5g12ztP9SwDdjndz/buqYuuXqDtqQKnyiflgq1UFxBOSmPhitIHUzGy7mnvtCpjhWfUFb4HS/tJ
	42duJd6hAlw30bu+iN8P2nlho9hCXMaOZRAr2n5UDKEXPuNynFscveZyrfzzFXNsIFO/7gD3iA8ah
	6q5P4UCrT4W51CgWGbrMQt8l9K9UUD2b/O4TrMOVwzdr+cCYBeOKx827YWv6uPZdNtR9lu9Yeznpo
	xU4hKjixEQ3bnAo/kHGe6LBvh3j5b4IDagHVH4teVi4MqB7Pq1UaomwKl/5hiUEDLeyiDWHRT5TNA
	UTH0G8mA==;
Received: from [109.166.137.172] (port=55940 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm3-00000006qMV-1X5D;
	Thu, 15 May 2025 11:17:12 +0300
From: Alexandru Soponar <asoponar@taladin.ro>
To: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	baocheng.su@siemens.com,
	wim@linux-watchdog.org,
	tobias.schaffner@siemens.com,
	angelogioacchino.delregno@collabora.com,
	benedikt.niedermayr@siemens.com,
	matthias.bgg@gmail.com,
	aardelean@baylibre.com,
	contact@sopy.one,
	Alexandru Soponar <asoponar@taladin.ro>
Subject: [PATCH 16/16] lib: move find_closest() and find_closest_descending() to lib functions
Date: Thu, 15 May 2025 11:13:32 +0300
Message-ID: <20250515081332.151250-17-asoponar@taladin.ro>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515081332.151250-1-asoponar@taladin.ro>
References: <20250515081332.151250-1-asoponar@taladin.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SpamExperts-Domain: cloud347.c-f.ro
X-SpamExperts-Username: 185.236.86.218
Authentication-Results: mxserver.ro; auth=pass smtp.auth=185.236.86.218@cloud347.c-f.ro
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000242666053139)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT98ZpYtbjLMlHLIMLfKiMBSPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNbF0n38s4PnjIiWSgo0iehuSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUxLMkCVXN63lz38Up+2UgeFSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWxEWqfohU+1d2
 sh7IKZpXLgBCJ476nn5Gmr/PK603nEEgvmn7Dzq8wsrwxhZMoHvqxJYqN+GmyxwR+V15PgePOPPI
 vtB/lrJsWW29FRnUbXCk3//yGA2OaEkyEoP0Kl1YERWeKKG4PAQYNyavp7c49JwbmBalBK3QvTzZ
 aymz/kAx9sNOIdFDvUNZLdaRhCZaMx8xtwV1+Gg8ihl6LJV8o3nXKu/l5TM8iMLe4AKyoGlZj2VA
 3aW/vPi2AMAbWLs/EIKEbeDIxNYIJ7Ews1OEan6m+UeFXprlCOm3BAEbJtATHIdhc/Osc/lXM+l8
 06U7GxUAPGlXms+D1TI22+vIvtmOpB8mDzWv8vBwVi5XkC8ewLVRqANj6mzlzL3VH5WM/aCyI5/o
 yhoezeIJy3L+cB4hBppwR1r+Bof9KZqCMQkUV4VT4TerS/vbL3R5w07g
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

Move the utility macros find_closest() and find_closest_descending()
from inline macros to proper library functions in lib/.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 include/linux/find_closest.h | 13 +++++++
 include/linux/util_macros.h  | 61 +------------------------------
 lib/Makefile                 |  2 +-
 lib/find_closest.c           | 71 ++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 61 deletions(-)
 create mode 100644 include/linux/find_closest.h
 create mode 100644 lib/find_closest.c

diff --git a/include/linux/find_closest.h b/include/linux/find_closest.h
new file mode 100644
index 000000000000..28a5c4d0c768
--- /dev/null
+++ b/include/linux/find_closest.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Find closest element functions
+ */
+#ifndef _LINUX_FIND_CLOSEST_H_
+#define _LINUX_FIND_CLOSEST_H_
+
+#include <linux/types.h>
+
+unsigned int find_closest(int x, const int *a, unsigned int as);
+unsigned int find_closest_descending(int x, const int *a, unsigned int as);
+
+#endif /* _LINUX_FIND_CLOSEST_H_ */
diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 825487fb66fa..478d4821f2d1 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -3,66 +3,7 @@
 #define _LINUX_HELPER_MACROS_H_
 
 #include <linux/math.h>
-
-/**
- * find_closest - locate the closest element in a sorted array
- * @x: The reference value.
- * @a: The array in which to look for the closest element. Must be sorted
- *  in ascending order.
- * @as: Size of 'a'.
- *
- * Returns the index of the element closest to 'x'.
- * Note: If using an array of negative numbers (or mixed positive numbers),
- *       then be sure that 'x' is of a signed-type to get good results.
- */
-#define find_closest(x, a, as)						\
-({									\
-	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-	long __fc_mid_x, __fc_x = (x);					\
-	long __fc_left, __fc_right;					\
-	typeof(*a) const *__fc_a = (a);					\
-	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
-		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;	\
-		if (__fc_x <= __fc_mid_x) {				\
-			__fc_left = __fc_x - __fc_a[__fc_i];		\
-			__fc_right = __fc_a[__fc_i + 1] - __fc_x;	\
-			if (__fc_right < __fc_left)			\
-				__fc_i++;				\
-			break;						\
-		}							\
-	}								\
-	(__fc_i);							\
-})
-
-/**
- * find_closest_descending - locate the closest element in a sorted array
- * @x: The reference value.
- * @a: The array in which to look for the closest element. Must be sorted
- *  in descending order.
- * @as: Size of 'a'.
- *
- * Similar to find_closest() but 'a' is expected to be sorted in descending
- * order. The iteration is done in reverse order, so that the comparison
- * of '__fc_right' & '__fc_left' also works for unsigned numbers.
- */
-#define find_closest_descending(x, a, as)				\
-({									\
-	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-	long __fc_mid_x, __fc_x = (x);					\
-	long __fc_left, __fc_right;					\
-	typeof(*a) const *__fc_a = (a);					\
-	for (__fc_i = __fc_as; __fc_i >= 1; __fc_i--) {			\
-		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i - 1]) / 2;	\
-		if (__fc_x <= __fc_mid_x) {				\
-			__fc_left = __fc_x - __fc_a[__fc_i];		\
-			__fc_right = __fc_a[__fc_i - 1] - __fc_x;	\
-			if (__fc_right < __fc_left)			\
-				__fc_i--;				\
-			break;						\
-		}							\
-	}								\
-	(__fc_i);							\
-})
+#include <linux/find_closest.h>
 
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
diff --git a/lib/Makefile b/lib/Makefile
index f1c6e9d76a7c..e8e738c9ced8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,7 +35,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o iomem_copy.o
+	 buildid.o objpool.o iomem_copy.o find_closest.o
 
 lib-$(CONFIG_UNION_FIND) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
diff --git a/lib/find_closest.c b/lib/find_closest.c
new file mode 100644
index 000000000000..d481625cae9d
--- /dev/null
+++ b/lib/find_closest.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Find closest element functions
+ *
+ * Based on previous util_macros.h implementation
+ */
+
+#include <linux/find_closest.h>
+#include <linux/module.h>
+
+/**
+ * find_closest - locate the closest element in a sorted array
+ * @x: The reference value.
+ * @a: The array in which to look for the closest element. Must be sorted
+ *  in ascending order.
+ * @as: Size of 'a'.
+ *
+ * Returns the index of the element closest to 'x'.
+ */
+unsigned int find_closest(int x, const int *a, unsigned int as)
+{
+	unsigned int array_size = as - 1;
+	int mid_x, left, right;
+	unsigned int i;
+
+	for (i = 0; i < array_size; i++) {
+		mid_x = (a[i] + a[i + 1]) / 2;
+		if (x <= mid_x) {
+			left = x - a[i];
+			right = a[i + 1] - x;
+			if (right < left)
+				i++;
+			break;
+		}
+	}
+
+	return i;
+}
+EXPORT_SYMBOL_GPL(find_closest);
+
+/**
+ * find_closest_descending - locate the closest element in a sorted array
+ * @x: The reference value.
+ * @a: The array in which to look for the closest element. Must be sorted
+ *  in descending order.
+ * @as: Size of 'a'.
+ *
+ * Similar to find_closest() but 'a' is expected to be sorted in descending
+ * order. The iteration is done in reverse order, so that the comparison
+ * of 'right' & 'left' also works for unsigned numbers.
+ */
+unsigned int find_closest_descending(int x, const int *a, unsigned int as)
+{
+	unsigned int array_size = as - 1;
+	int mid_x, left, right;
+	unsigned int i;
+
+	for (i = array_size; i >= 1; i--) {
+		mid_x = (a[i] + a[i - 1]) / 2;
+		if (x <= mid_x) {
+			left = x - a[i];
+			right = a[i - 1] - x;
+			if (right < left)
+				i--;
+			break;
+		}
+	}
+
+	return i;
+}
+EXPORT_SYMBOL_GPL(find_closest_descending);
-- 
2.49.0


