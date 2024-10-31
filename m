Return-Path: <linux-iio+bounces-11669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D19B74A9
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4759B23C0D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62D14830C;
	Thu, 31 Oct 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H73hIorU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A81465BE
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356655; cv=none; b=TFrqcaVv7MN1u2PMX6Ixn5AjC1yeEHfudeqHQ2dHVHOXxFcyIXekkz6XO9xOca9C6AMrEkqA1jz2TK8UuqXt796EPEiuy7IBiCbOJeXXXJ6UlKNk1vhCu9qpqUb4APvi13rTYDEH0typ2J8yvyuC5Z03NU6fn6Bq4aiNXPs3Q+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356655; c=relaxed/simple;
	bh=DAJjafoBtgzWBE1nm++io8fFp2wJtvd5aZdMMfafdsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNemN83KY62139wkf7vKe7Buy6n877I+65Cs60khKdLQNo3OnJnjO97qwgX0pIsx4bvLtOyhSQKLw/uPopvbZOH94jJkKj5i4pMi85OtkwzurS/JzGp7PguPEOHfcEufnjPvzRQy6kvNU7WlrlR9zMAI/W20Ek3JBTsVWUIEKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H73hIorU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso79392466b.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730356650; x=1730961450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs8yvl4MTuk4fwElSbU9+lgw3REsbSMewB+Ci4unvrU=;
        b=H73hIorUpD09mVg3O8wGhhsqo030eqVgpnpSMq7pcBjRkiFiTePjcYPD66vxFOC5Ql
         bSfBmXqhQLDLMP3ENUwB3iDQiyjL0jS5IM9q7AyhTbrGwpM4GNh4V/1x5DXVKt6mn9W/
         8rfu+nQB51JWH21aBfobDHDorcajV1rpNJq1OMH55NZRbqE0uOCWfK73so/PCd9CdxYH
         g6DKTbFw4vgzVep2y91hWZ8ZU5BSxgJiNWN7bv0k2H0liQ5FQasY4a1HBwDkRq23u6oy
         xBI1Uhyib0S8e/c5Q92XYvZwipfM3mVLt4G0jzBF1UwAwuoAatuO53pUcCPxUU3Seinc
         RhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356650; x=1730961450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs8yvl4MTuk4fwElSbU9+lgw3REsbSMewB+Ci4unvrU=;
        b=ij0s7GqjvqtWD/VEgZuH27/PT1OURSNukYzvWQ+9ICJVoO/7xh5xOV7N+4Rm/GeVvc
         gVb5U7/qa00wwcuFIRzG3hU2j6Yo+LnIoUk3+n9YIAur8vjsKuRrASSfObZ+8q2qdHNq
         iQOmz4PUinFtqVuoFoiTFbH4u9bCi+xAcM/AVX3eSxynGKiN8WJM9VerTxnP1Q3KYqyH
         tZhABPOkyNTBAC4s9S5uUURQ9e5YWVSgkl/ZGmCAucgriXEu+VGSFGDG2wOBT3qA1Y11
         zyJpiptH78B0k0W7iV+obc9Jf/oAUQcJA+NKp0VcyLdAHGGABIWblXZH5RRZS+yHW3n/
         GyOQ==
X-Gm-Message-State: AOJu0YzXvy7LTqEUk3r9DrUNTo1piBMSrIGxOP55fMVrfhYfB48qPMsY
	7gdNHJ1U7ei8uOLcjuS5qyFvEnxyP6xaiAWvZYd3e/Mmk5ArctEhEUcNcPQCc1pLvyPLORfmRoW
	S
X-Google-Smtp-Source: AGHT+IFVYgSaQxSbztSAo/su/4vp07Gu+FOOpUA12ViIW1SenBKNmJDk6M+cUzAPAm1MQhB/YBUxWQ==
X-Received: by 2002:a17:907:971d:b0:a9a:13f8:60b9 with SMTP id a640c23a62f3a-a9de5fc7847mr1838525366b.36.1730356650197;
        Wed, 30 Oct 2024 23:37:30 -0700 (PDT)
Received: from localhost.localdomain ([81.196.132.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5649405dsm33386366b.10.2024.10.30.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:37:29 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	bartosz.golaszewski@linaro.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 2/2] lib: util_macros_kunit: add kunit test for util_macros.h
Date: Thu, 31 Oct 2024 08:37:07 +0200
Message-ID: <20241031063707.795842-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241031063707.795842-1-aardelean@baylibre.com>
References: <20241031063707.795842-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug was found in the find_closest() (find_closest_descending() is also
affected after some testing), where for certain values with small
progressions of 1, 2 & 3, the rounding (done by averaging 2 values) causes
an incorrect index to be returned.

The bug is described in more detail in the commit which fixes the bug.
This commit adds a kunit test to validate that the fix works correctly.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 lib/Kconfig.debug       |  17 ++++
 lib/Makefile            |   1 +
 lib/util_macros_kunit.c | 168 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 lib/util_macros_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..caf10cf2084c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2629,6 +2629,23 @@ config CHECKSUM_KUNIT
 
 	  If unsure, say N.
 
+config UTIL_MACROS_KUNIT
+	tristate "KUnit test util_macros.h functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the util_macros.h function at boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config HASH_KUNIT_TEST
 	tristate "KUnit Test for integer hash functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..444fe05caed9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
+obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/util_macros_kunit.c b/lib/util_macros_kunit.c
new file mode 100644
index 000000000000..33ff8b526410
--- /dev/null
+++ b/lib/util_macros_kunit.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for bitfield helpers.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/util_macros.h>
+
+#define FIND_CLOSEST_RANGE_CHECK(val_from, val_to, array, exp_idx)	\
+{									\
+	int i;								\
+	for (i = val_from; i <= val_to; i++) {				\
+		int found = find_closest(i, array, ARRAY_SIZE(array));	\
+		KUNIT_ASSERT_EQ(ctx, exp_idx, found);			\
+	}								\
+}
+
+static void test_find_closest(struct kunit *ctx)
+{
+	/* This will test a few arrays that are found in drivers */
+	static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
+	static const unsigned int ad7616_oversampling_avail[] = {
+		1, 2, 4, 8, 16, 32, 64, 128,
+	};
+	static u32 wd_timeout_table[] = { 2, 4, 6, 8, 16, 32, 48, 64 };
+	static int array_prog3a[] = { 1, 4, 7, 10 };
+	static int array_prog3b[] = { 2, 5, 8, 11 };
+	static int array_prog4a[] = { 1, 5, 9, 13 };
+	static int array_prog4b[] = { 2, 6, 10, 14 };
+
+	FIND_CLOSEST_RANGE_CHECK(-10, 2, ina226_avg_tab, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 10, ina226_avg_tab, 1);
+	FIND_CLOSEST_RANGE_CHECK(11, 40, ina226_avg_tab, 2);
+	FIND_CLOSEST_RANGE_CHECK(41, 96, ina226_avg_tab, 3);
+	FIND_CLOSEST_RANGE_CHECK(97, 192, ina226_avg_tab, 4);
+	FIND_CLOSEST_RANGE_CHECK(193, 384, ina226_avg_tab, 5);
+	FIND_CLOSEST_RANGE_CHECK(385, 768, ina226_avg_tab, 6);
+	FIND_CLOSEST_RANGE_CHECK(769, 2048, ina226_avg_tab, 7);
+
+	/* The array that found the bug that caused this kunit to exist */
+	FIND_CLOSEST_RANGE_CHECK(-10, 1, ad7616_oversampling_avail, 0);
+	FIND_CLOSEST_RANGE_CHECK(2, 3, ad7616_oversampling_avail, 1);
+	FIND_CLOSEST_RANGE_CHECK(4, 6, ad7616_oversampling_avail, 2);
+	FIND_CLOSEST_RANGE_CHECK(7, 12, ad7616_oversampling_avail, 3);
+	FIND_CLOSEST_RANGE_CHECK(13, 24, ad7616_oversampling_avail, 4);
+	FIND_CLOSEST_RANGE_CHECK(25, 48, ad7616_oversampling_avail, 5);
+	FIND_CLOSEST_RANGE_CHECK(49, 96, ad7616_oversampling_avail, 6);
+	FIND_CLOSEST_RANGE_CHECK(97, 256, ad7616_oversampling_avail, 7);
+
+	FIND_CLOSEST_RANGE_CHECK(0, 3, wd_timeout_table, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 5, wd_timeout_table, 1);
+	FIND_CLOSEST_RANGE_CHECK(6, 7, wd_timeout_table, 2);
+	FIND_CLOSEST_RANGE_CHECK(8, 12, wd_timeout_table, 3);
+	FIND_CLOSEST_RANGE_CHECK(13, 24, wd_timeout_table, 4);
+	FIND_CLOSEST_RANGE_CHECK(25, 40, wd_timeout_table, 5);
+	FIND_CLOSEST_RANGE_CHECK(41, 56, wd_timeout_table, 6);
+	FIND_CLOSEST_RANGE_CHECK(57, 128, wd_timeout_table, 7);
+
+	FIND_CLOSEST_RANGE_CHECK(-1, 2, array_prog3a, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 5, array_prog3a, 1);
+	FIND_CLOSEST_RANGE_CHECK(6, 8, array_prog3a, 2);
+	FIND_CLOSEST_RANGE_CHECK(9, 20, array_prog3a, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-1, 3, array_prog3b, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 6, array_prog3b, 1);
+	FIND_CLOSEST_RANGE_CHECK(7, 9, array_prog3b, 2);
+	FIND_CLOSEST_RANGE_CHECK(10, 20, array_prog3b, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-1, 3, array_prog4a, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 7, array_prog4a, 1);
+	FIND_CLOSEST_RANGE_CHECK(8, 11, array_prog4a, 2);
+	FIND_CLOSEST_RANGE_CHECK(12, 20, array_prog4a, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-1, 4, array_prog4b, 0);
+	FIND_CLOSEST_RANGE_CHECK(5, 8, array_prog4b, 1);
+	FIND_CLOSEST_RANGE_CHECK(9, 12, array_prog4b, 2);
+	FIND_CLOSEST_RANGE_CHECK(13, 20, array_prog4b, 3);
+}
+
+#define FIND_CLOSEST_DESC_RANGE_CHECK(val_from, val_to, array, exp_idx)	\
+{									\
+	int i;								\
+	for (i = val_from; i <= val_to; i++) {				\
+		int found = find_closest_descending(i, array,		\
+						ARRAY_SIZE(array));	\
+		KUNIT_ASSERT_EQ(ctx, exp_idx, found);			\
+	}								\
+}
+
+static void test_find_closest_descending(struct kunit *ctx)
+{
+	/* Same arrays as 'test_find_closest' but reversed */
+	static const int ina226_avg_tab[] = { 1024, 512, 256, 128, 64, 16, 4, 1 };
+	static const unsigned int ad7616_oversampling_avail[] = {
+		128, 64, 32, 16, 8, 4, 2, 1
+	};
+	static u32 wd_timeout_table[] = { 64, 48, 32, 16, 8, 6, 4, 2 };
+	static int array_prog3a[] = { 10, 7, 4, 1 };
+	static int array_prog3b[] = { 11, 8, 5, 2 };
+	static int array_prog4a[] = { 13, 9, 5, 1 };
+	static int array_prog4b[] = { 14, 10, 6, 2 };
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-10, 2, ina226_avg_tab, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 10, ina226_avg_tab, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(11, 40, ina226_avg_tab, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(41, 96, ina226_avg_tab, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(97, 192, ina226_avg_tab, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(193, 384, ina226_avg_tab, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(385, 768, ina226_avg_tab, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(769, 2048, ina226_avg_tab, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-10, 1, ad7616_oversampling_avail, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(2, 3, ad7616_oversampling_avail, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 6, ad7616_oversampling_avail, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(7, 12, ad7616_oversampling_avail, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(13, 24, ad7616_oversampling_avail, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(25, 48, ad7616_oversampling_avail, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(49, 96, ad7616_oversampling_avail, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(97, 256, ad7616_oversampling_avail, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(0, 3, wd_timeout_table, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 5, wd_timeout_table, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 7, wd_timeout_table, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(8, 12, wd_timeout_table, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(13, 24, wd_timeout_table, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(25, 40, wd_timeout_table, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(41, 56, wd_timeout_table, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(57, 128, wd_timeout_table, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-1, 2, array_prog3a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 5, array_prog3a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 8, array_prog3a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(9, 20, array_prog3a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-1, 3, array_prog3b, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 6, array_prog3b, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(7, 9, array_prog3b, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(10, 20, array_prog3b, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-1, 3, array_prog4a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 7, array_prog4a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(8, 11, array_prog4a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(12, 20, array_prog4a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-1, 4, array_prog4b, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(5, 8, array_prog4b, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(9, 12, array_prog4b, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(13, 20, array_prog4b, 0);
+}
+
+static struct kunit_case __refdata util_macros_test_cases[] = {
+	KUNIT_CASE(test_find_closest),
+	KUNIT_CASE(test_find_closest_descending),
+	{}
+};
+
+static struct kunit_suite util_macros_test_suite = {
+	.name = "util_macros.h",
+	.test_cases = util_macros_test_cases,
+};
+
+kunit_test_suites(&util_macros_test_suite);
+
+MODULE_AUTHOR("Alexandru Ardelean <aardelean@baylibre.com>");
+MODULE_DESCRIPTION("Test cases for util_macros.h helpers");
+MODULE_LICENSE("GPL");
-- 
2.46.1


