Return-Path: <linux-iio+bounces-11921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57A9BCFC9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AC1F23485
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479745C18;
	Tue,  5 Nov 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aej72IgI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDD1D968A
	for <linux-iio@vger.kernel.org>; Tue,  5 Nov 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818471; cv=none; b=NcakA2G2qF+s3GtIxuwaFS9Mok+DCT5Xj1pMkI2OQrpZPvsn2QJLMK+9Nq52Smgcu5F6Cs6dGgGQeUx+QzbnzAEVm6bbS5PLq2Tm6eNnYFoS9QkzjbDW64jns+4rxYYlVprXPM436vGRUMhHy5S6ujMZyNz2+KV/TdaU9OoURr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818471; c=relaxed/simple;
	bh=eoVVbbAJom3xNVNHGYnviNx+dap4dvCgxW7u+rmkj14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/aiKiQO8Ct3pXmaiakJOlI73NSBqTvbvb2MUPMwYiClf8bCVR4jCka2XppjXvxG5tWbxI9CyVP+IUojK/gDTltlEEB2uz+2WK44fFjT22V764OUCV/CRIgQ2FMLRBjArz79MM4eseIKYGteEuZMJw0+3CTHF/qNHeoVlDDi7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aej72IgI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso6755878a12.0
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2024 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730818467; x=1731423267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kVoXgEHpJFKwcbBP/BPItkYZtO4aiIuCs/hlKNiqkQ=;
        b=aej72IgI/lou7Q1pslrsp5pPA4HbIzplmm9l4eqkx2ITQe4g33ipo4xGWYsqUTF2nM
         RNPKBi9p+61JqOGpcCRtR+OPx8kLip8mkgPv0SzCiAzlA86xFuXJ5wgYHJw7kKftYKmm
         +1m6FagXLdA3GD/3njwohdEGMWfv3M1E4Y8T9V12eWwgQw1zv8KbMXIUnBGczA/ZaG4z
         yAx66WeqIYnhp3gc6wiU6xvVahazhn76pdJNUDrBGK8g7Vo/1XEBo+G0tZDxWB4M5/Lo
         9DdqXChkRrCojcvbYBpcMWV/G/TNKVPDadgjUHU09WNpJRID23S2Bil5cPLYkrN0yJWD
         CVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818467; x=1731423267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kVoXgEHpJFKwcbBP/BPItkYZtO4aiIuCs/hlKNiqkQ=;
        b=nASDCrupPdUWMUavo7oxpmbYDs4IKUA2DS8Ddh+ZEEPc9CIEljCyOjz74DrPOdpdjm
         9KIoY20HPzvVgJnJs0X/kOs3bOS0RuEA1biXado66X20GOdQYyqltTv8tk0mKuVtB7VX
         F14nvbl9Ay0MWrJs61K4KaqdfkTAF3Jy4Z1dz9GlnfqRXeFoQeMc3jTHAEtkvEqe/jsM
         7TXWIK/vC+ybCxHQDejqSmBKb93MBPKszJb1SXSoICbJxmTH5IOlfZjAUUdHHVJbOlNA
         E2ZRZvNpBRjbjGcomdRpNldAJe0GzIQxQrJhK7lOVJGXe7bis3fUA5yKTXU7CJanDVQj
         dQRw==
X-Gm-Message-State: AOJu0Yx4wBmsAhp+jYiHTePjdu+/vxn+dFd13EnGSJ7dP0HbTd+fqTB9
	74Et0fTvrw7w9aO6v/z9Yl/N+ZshyPlVRYlhcEnSt7hsUgls3fPTGibxk+yNrU4x04IsaJH69qr
	SyQs=
X-Google-Smtp-Source: AGHT+IEPsvKZSAHOlvPpJS9NQDJPqs63JCuJvFpa3qIMr7rcwJWxKw4VuvojkzR2JuUnujI6NthsDA==
X-Received: by 2002:a05:6402:3508:b0:5ce:ce43:32f with SMTP id 4fb4d7f45d1cf-5cece4305a3mr9122648a12.35.1730818466101;
        Tue, 05 Nov 2024 06:54:26 -0800 (PST)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe40fsm1382398a12.62.2024.11.05.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:54:25 -0800 (PST)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	bartosz.golaszewski@linaro.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 2/2] lib: util_macros_kunit: add kunit test for util_macros.h
Date: Tue,  5 Nov 2024 16:54:06 +0200
Message-ID: <20241105145406.554365-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105145406.554365-1-aardelean@baylibre.com>
References: <20241105145406.554365-1-aardelean@baylibre.com>
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

This kunit test adds some of the arrays (from the driver-sphere) that seem
to produce issues with the 'find_closest()' macro. Specifically the one
from ad7606 driver (with which the bug was found) and from the ina2xx
drivers, which shows the quirk with 'find_closest()' with elements in a
array that have an interval of 3.

For the find_closest_descending() tests, the same arrays are used as for
the find_closest(), but in reverse; the idea is that
'find_closest_descending()' should return the sames indices as
'find_closest()' but in reverse.

For testing both macros, there are 4 special arrays created, one for
testing find_closest{_descending}() for arrays of progressions 1, 2, 3 and
4. The idea is to show that (for progressions of 1, 2 & 3) the fix works as
expected. When removing the fix, the issues should start to show up.

Then an extra array of negative and positive values is added. There are
currently no such arrays within drivers, but one could expect that these
macros behave correctly even for such arrays.

To run this kunit:
  ./tools/testing/kunit/kunit.py run "*util_macros*"

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20241031063707.795842-2-aardelean@baylibre.com/
* updated commit description with more info about this kunit
* added extra tests to show fix for arrays of progressions 1, 2, 3 and 4
  (i.e. { 1, 2, 3, 4 }, { 1, 3, 5, 7 }, { 1, 4, 7, 10 } &
  { 1, 5, 9, 13 } )
  - the arrays are also tested in reverse order
  - the arrays also use 'int' & 'u32' types (for the array & and search
    value) to see that the search works correctly).
* added test for array with mix of negative + positive numbers

 lib/Kconfig.debug       |  17 +++
 lib/Makefile            |   1 +
 lib/util_macros_kunit.c | 240 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
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
index 000000000000..94cc9f0de50a
--- /dev/null
+++ b/lib/util_macros_kunit.c
@@ -0,0 +1,240 @@
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
+#define FIND_CLOSEST_RANGE_CHECK(from, to, array, exp_idx)		\
+{									\
+	int i;								\
+	for (i = from; i <= to; i++) {					\
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
+	static int array_prog1a[] = { 1, 2, 3, 4, 5 };
+	static u32 array_prog1b[] = { 2, 3, 4, 5, 6 };
+	static int array_prog1mix[] = { -2, -1, 0, 1, 2 };
+	static int array_prog2a[] = { 1, 3, 5, 7 };
+	static u32 array_prog2b[] = { 2, 4, 6, 8 };
+	static int array_prog3a[] = { 1, 4, 7, 10 };
+	static u32 array_prog3b[] = { 2, 5, 8, 11 };
+	static int array_prog4a[] = { 1, 5, 9, 13 };
+	static u32 array_prog4b[] = { 2, 6, 10, 14 };
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 2, ina226_avg_tab, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 10, ina226_avg_tab, 1);
+	FIND_CLOSEST_RANGE_CHECK(11, 40, ina226_avg_tab, 2);
+	FIND_CLOSEST_RANGE_CHECK(41, 96, ina226_avg_tab, 3);
+	FIND_CLOSEST_RANGE_CHECK(97, 192, ina226_avg_tab, 4);
+	FIND_CLOSEST_RANGE_CHECK(193, 384, ina226_avg_tab, 5);
+	FIND_CLOSEST_RANGE_CHECK(385, 768, ina226_avg_tab, 6);
+	FIND_CLOSEST_RANGE_CHECK(769, 2048, ina226_avg_tab, 7);
+
+	/* The array that found the bug that caused this kunit to exist */
+	FIND_CLOSEST_RANGE_CHECK(-3, 1, ad7616_oversampling_avail, 0);
+	FIND_CLOSEST_RANGE_CHECK(2, 3, ad7616_oversampling_avail, 1);
+	FIND_CLOSEST_RANGE_CHECK(4, 6, ad7616_oversampling_avail, 2);
+	FIND_CLOSEST_RANGE_CHECK(7, 12, ad7616_oversampling_avail, 3);
+	FIND_CLOSEST_RANGE_CHECK(13, 24, ad7616_oversampling_avail, 4);
+	FIND_CLOSEST_RANGE_CHECK(25, 48, ad7616_oversampling_avail, 5);
+	FIND_CLOSEST_RANGE_CHECK(49, 96, ad7616_oversampling_avail, 6);
+	FIND_CLOSEST_RANGE_CHECK(97, 256, ad7616_oversampling_avail, 7);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 3, wd_timeout_table, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 5, wd_timeout_table, 1);
+	FIND_CLOSEST_RANGE_CHECK(6, 7, wd_timeout_table, 2);
+	FIND_CLOSEST_RANGE_CHECK(8, 12, wd_timeout_table, 3);
+	FIND_CLOSEST_RANGE_CHECK(13, 24, wd_timeout_table, 4);
+	FIND_CLOSEST_RANGE_CHECK(25, 40, wd_timeout_table, 5);
+	FIND_CLOSEST_RANGE_CHECK(41, 56, wd_timeout_table, 6);
+	FIND_CLOSEST_RANGE_CHECK(57, 128, wd_timeout_table, 7);
+
+	/* One could argue that find_closest() should not be used for monotonic
+	 * arrays (like 1,2,3,4,5), but even so, it should work as long as the
+	 * array is sorted ascending. */
+	FIND_CLOSEST_RANGE_CHECK(-3, 1, array_prog1a, 0);
+	FIND_CLOSEST_RANGE_CHECK(2, 2, array_prog1a, 1);
+	FIND_CLOSEST_RANGE_CHECK(3, 3, array_prog1a, 2);
+	FIND_CLOSEST_RANGE_CHECK(4, 4, array_prog1a, 3);
+	FIND_CLOSEST_RANGE_CHECK(5, 8, array_prog1a, 4);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 2, array_prog1b, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 3, array_prog1b, 1);
+	FIND_CLOSEST_RANGE_CHECK(4, 4, array_prog1b, 2);
+	FIND_CLOSEST_RANGE_CHECK(5, 5, array_prog1b, 3);
+	FIND_CLOSEST_RANGE_CHECK(6, 8, array_prog1b, 4);
+
+	FIND_CLOSEST_RANGE_CHECK(-4, -2, array_prog1mix, 0);
+	FIND_CLOSEST_RANGE_CHECK(-1, -1, array_prog1mix, 1);
+	FIND_CLOSEST_RANGE_CHECK(0, 0, array_prog1mix, 2);
+	FIND_CLOSEST_RANGE_CHECK(1, 1, array_prog1mix, 3);
+	FIND_CLOSEST_RANGE_CHECK(2, 5, array_prog1mix, 4);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 2, array_prog2a, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 4, array_prog2a, 1);
+	FIND_CLOSEST_RANGE_CHECK(5, 6, array_prog2a, 2);
+	FIND_CLOSEST_RANGE_CHECK(7, 10, array_prog2a, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 3, array_prog2b, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 5, array_prog2b, 1);
+	FIND_CLOSEST_RANGE_CHECK(6, 7, array_prog2b, 2);
+	FIND_CLOSEST_RANGE_CHECK(8, 10, array_prog2b, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 2, array_prog3a, 0);
+	FIND_CLOSEST_RANGE_CHECK(3, 5, array_prog3a, 1);
+	FIND_CLOSEST_RANGE_CHECK(6, 8, array_prog3a, 2);
+	FIND_CLOSEST_RANGE_CHECK(9, 20, array_prog3a, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 3, array_prog3b, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 6, array_prog3b, 1);
+	FIND_CLOSEST_RANGE_CHECK(7, 9, array_prog3b, 2);
+	FIND_CLOSEST_RANGE_CHECK(10, 20, array_prog3b, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 3, array_prog4a, 0);
+	FIND_CLOSEST_RANGE_CHECK(4, 7, array_prog4a, 1);
+	FIND_CLOSEST_RANGE_CHECK(8, 11, array_prog4a, 2);
+	FIND_CLOSEST_RANGE_CHECK(12, 20, array_prog4a, 3);
+
+	FIND_CLOSEST_RANGE_CHECK(-3, 4, array_prog4b, 0);
+	FIND_CLOSEST_RANGE_CHECK(5, 8, array_prog4b, 1);
+	FIND_CLOSEST_RANGE_CHECK(9, 12, array_prog4b, 2);
+	FIND_CLOSEST_RANGE_CHECK(13, 20, array_prog4b, 3);
+}
+
+#define FIND_CLOSEST_DESC_RANGE_CHECK(from, to, array, exp_idx)	\
+{									\
+	int i;								\
+	for (i = from; i <= to; i++) {					\
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
+	static int array_prog1a[] = { 5, 4, 3, 2, 1 };
+	static u32 array_prog1b[] = { 6, 5, 4, 3, 2 };
+	static int array_prog1mix[] = { 2, 1, 0, -1, -2 };
+	static int array_prog2a[] = { 7, 5, 3, 1 };
+	static u32 array_prog2b[] = { 8, 6, 4, 2 };
+	static int array_prog3a[] = { 10, 7, 4, 1 };
+	static u32 array_prog3b[] = { 11, 8, 5, 2 };
+	static int array_prog4a[] = { 13, 9, 5, 1 };
+	static u32 array_prog4b[] = { 14, 10, 6, 2 };
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 2, ina226_avg_tab, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 10, ina226_avg_tab, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(11, 40, ina226_avg_tab, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(41, 96, ina226_avg_tab, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(97, 192, ina226_avg_tab, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(193, 384, ina226_avg_tab, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(385, 768, ina226_avg_tab, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(769, 2048, ina226_avg_tab, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 1, ad7616_oversampling_avail, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(2, 3, ad7616_oversampling_avail, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 6, ad7616_oversampling_avail, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(7, 12, ad7616_oversampling_avail, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(13, 24, ad7616_oversampling_avail, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(25, 48, ad7616_oversampling_avail, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(49, 96, ad7616_oversampling_avail, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(97, 256, ad7616_oversampling_avail, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 3, wd_timeout_table, 7);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 5, wd_timeout_table, 6);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 7, wd_timeout_table, 5);
+	FIND_CLOSEST_DESC_RANGE_CHECK(8, 12, wd_timeout_table, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(13, 24, wd_timeout_table, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(25, 40, wd_timeout_table, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(41, 56, wd_timeout_table, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(57, 128, wd_timeout_table, 0);
+
+	/* One could argue that find_closest_descending() should not be used
+	 * for monotonic arrays (like 5,4,3,2,1), but even so, it should still
+	 * it should work as long as the array is sorted descending. */
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 1, array_prog1a, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(2, 2, array_prog1a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 3, array_prog1a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 4, array_prog1a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(5, 8, array_prog1a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 2, array_prog1b, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 3, array_prog1b, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 4, array_prog1b, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(5, 5, array_prog1b, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 8, array_prog1b, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-4, -2, array_prog1mix, 4);
+	FIND_CLOSEST_DESC_RANGE_CHECK(-1, -1, array_prog1mix, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(0, 0, array_prog1mix, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(1, 1, array_prog1mix, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(2, 5, array_prog1mix, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 2, array_prog2a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 4, array_prog2a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(5, 6, array_prog2a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(7, 10, array_prog2a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 3, array_prog2b, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 5, array_prog2b, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 7, array_prog2b, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(8, 10, array_prog2b, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 2, array_prog3a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(3, 5, array_prog3a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(6, 8, array_prog3a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(9, 20, array_prog3a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 3, array_prog3b, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 6, array_prog3b, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(7, 9, array_prog3b, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(10, 20, array_prog3b, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 3, array_prog4a, 3);
+	FIND_CLOSEST_DESC_RANGE_CHECK(4, 7, array_prog4a, 2);
+	FIND_CLOSEST_DESC_RANGE_CHECK(8, 11, array_prog4a, 1);
+	FIND_CLOSEST_DESC_RANGE_CHECK(12, 20, array_prog4a, 0);
+
+	FIND_CLOSEST_DESC_RANGE_CHECK(-3, 4, array_prog4b, 3);
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


