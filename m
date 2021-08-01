Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189463DCD61
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhHATkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhHATk3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EAC06175F;
        Sun,  1 Aug 2021 12:40:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cg4so2893866qvb.5;
        Sun, 01 Aug 2021 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Yrod4zWvzjowEkPDcqfhN1HMp0hOcbRDJShGJNFTJM=;
        b=JSPwF6UllFYFfQ0ij9zBWHs7B/rphrIrvyxz4HwxK0hTnMOXFoH2D4IiQ1TXaRMtzZ
         Gq7q4wDMuwWJ5SGDjc0uLdduS7Z9uBKqf9KZ/DRJN63hvfbRNJH96N+xldjGbw1YOdFT
         7yDZmRG+pNeNfqf5AtLopFj2oGZdNJiWGolXjtDxWzMgXYNg0JxNzYkxaLcCtDCCinmf
         bgu9p6iM1/rffIAEF9NlZwsTU8eMgTk7t0c/PknWEuP3h6h0H8cDsqrdoiTfJEgQlswD
         bnFQMM3eQK2t89UOkTT67DfMWt+t8VzWa7aomPBVNxJY5B/WtGSXM3cWWfG65hsskzgw
         puAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Yrod4zWvzjowEkPDcqfhN1HMp0hOcbRDJShGJNFTJM=;
        b=j6p2Qfs4tiE3JFqUrNpsyU0Lf0Heo5SErDitEqdz86EftyGZDyOBCj+3r30Hl2VdVi
         O8Q8tKGd0IZz+Kjl+buMh4Jla+yDocwt4i75znbTvEE2a8JmECZ37Hpk+Y1/Lwd0S7XR
         IKAUy0mR/IAUoE6yrZ5ZT6WDy/Cf2VsMlWqu4SthcTfL/72Cz6JV2SQL3WVwLfDOgrGK
         D2L43Utx8kOXXQLvNgGv+CQwo8pkcHHpuFt9uJb0V8HsHXn9aLWTXH1mPx8SAc9iSe3n
         evUmsJopxWJLB2A7EZ8N9iFaJaow1W2mg87+fAAi0st5LlqA7zbrqIGOd9GKwxPcaNaa
         GnIw==
X-Gm-Message-State: AOAM530YQzrhPN3LSjA/w4X2pTOThKcA+TrAF0+agcg2OLTOxhxD1TJF
        17v4NQM0kVT8A5upbv7GCE00tndqjNT1GA==
X-Google-Smtp-Source: ABdhPJzQOs03a/4j6sFYEQDQAUOkV9xm1Qel6LglZd4uxxGCBOPRiok51Q6xC4rsNn9JG4L4CwUXIw==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr13257288qvv.9.1627846819528;
        Sun, 01 Aug 2021 12:40:19 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:19 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 09/13] iio: test: add basic tests for the iio-rescale driver
Date:   Sun,  1 Aug 2021 15:39:56 -0400
Message-Id: <20210801194000.3646303-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The iio-rescale driver supports various combinations of scale types and
offsets. These can often result in large integer multiplications. Make
sure these calculations are done right by adding a set of kunit test
cases that build on top of iio-test-format.

To run these tests, add the following to .kunitconfig
	$ cat .kunitconfig
	CONFIG_IIO=y
	CONFIG_IIO_RESCALE_KUNIT_TEST=y
	CONFIG_KUNIT=y

Then run:
	$ ./tools/testing/kunit/kunit.py run --kunitconfig .kunitconfig

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/test/Kconfig            |  10 +
 drivers/iio/test/Makefile           |   1 +
 drivers/iio/test/iio-test-rescale.c | 483 ++++++++++++++++++++++++++++
 3 files changed, 494 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-rescale.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 679a7794af20..872ed4ed140a 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,16 @@
 #
 
 # Keep in alphabetical order
+config IIO_RESCALE_KUNIT_TEST
+	bool "Test IIO rescale conversion functions"
+	depends on KUNIT && !IIO_RESCALE
+	default KUNIT_ALL_TESTS
+	help
+	  If you want to run tests on the iio-rescale code say Y here.
+
+	  This takes advantage of ARCH=um to run tests and should be used by
+	  developers to tests their changes to the rescaling logic.
+
 config IIO_TEST_FORMAT
         bool "Test IIO formatting functions"
         depends on KUNIT=y
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b495301..908963ca0b2f 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -4,4 +4,5 @@
 #
 
 # Keep in alphabetical order
+obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
 obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
new file mode 100644
index 000000000000..9008fb223d9d
--- /dev/null
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kunit tests for IIO rescale conversions
+ *
+ * Copyright (c) 2021 Liam Beguin <liambeguin@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/gcd.h>
+#include <linux/iio/afe/rescale.h>
+#include <linux/iio/iio.h>
+#include <linux/overflow.h>
+
+struct rescale_tc_data {
+	const char *name;
+
+	const s32 numerator;
+	const s32 denominator;
+	const s32 offset;
+
+	const int schan_val;
+	const int schan_val2;
+	const int schan_off;
+	const int schan_scale_type;
+
+	const char *expected;
+	const char *expected_off;
+};
+
+const struct rescale_tc_data scale_cases[] = {
+	/*
+	 * Typical use cases
+	 */
+	{
+		.name = "typical IIO_VAL_INT, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 42,
+		.expected = "5210.918114143\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 42,
+		.expected = "-5210.918114143\n",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 42,
+		.schan_val2 = 20,
+		.expected = "260.545905707\n",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 42,
+		.schan_val2 = 20,
+		.expected = "-260.545905707\n",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
+		.numerator = 42,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "0.049528301\n",
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
+		.numerator = -42,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "-0.049528301\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456,
+		.expected = "1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 1234,
+		.expected = "1240.847890\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 1234,
+		.expected = "-1240.847890\n",
+	},
+	/*
+	 * INT_PLUS_{MICRO,NANO} positive/negative corner cases
+	 */
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, both negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, 3 negative",
+		.numerator = -1000000,
+		.denominator = -8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456,
+		.expected = "-1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, 4 negative",
+		.numerator = -1000000,
+		.denominator = -8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = -123456,
+		.expected = "-1240.710106203\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative, *val = 0",
+		.numerator = 1,
+		.denominator = -10,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 0,
+		.schan_val2 = 123456789,
+		.expected = "-0.012345678\n",
+	},
+	/*
+	 * INT_PLUS_{MICRO,NANO} decimal part overflow
+	 */
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "1256.012008560\n",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "-1256.012008560\n",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 123456789,
+		.expected = "-1256.012008560\n",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "16557.914267\n",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "-16557.914267\n",
+	},
+	{
+		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = -10,
+		.schan_val2 = 123456789,
+		.expected = "-16557.914267\n",
+	},
+	/*
+	 * 32-bit overflow conditions
+	 */
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 0x7FFFFFFF,
+		.schan_val2 = 1,
+		.expected = "214748364.700000000\n",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 0x7FFFFFFF,
+		.schan_val2 = 1,
+		.expected = "-214748364.700000000\n",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, positive",
+		.numerator = 0x7FFFFFFF,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 4096,
+		.schan_val2 = 16,
+		.expected = "2532409.961084905\n",
+	},
+	{
+		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, negative",
+		.numerator = 0x7FFFFFFF,
+		.denominator = 53,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = -4096,
+		.schan_val2 = 16,
+		.expected = "-2532409.961084905\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "1.214748364\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "-1.214748364\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative schan",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = -10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "-1.214748364\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "215.748364\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "-215.748364\n",
+	},
+	{
+		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
+		.numerator = 2,
+		.denominator = 20,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = -10,
+		.schan_val2 = 0x7fffffff,
+		.expected = "-215.748364\n",
+	},
+};
+
+const struct rescale_tc_data offset_cases[] = {
+	/*
+	 * Typical use cases
+	 */
+	{
+		.name = "typical IIO_VAL_INT, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 123,
+		.schan_val2 = 0,
+		.schan_off = 14,
+		.expected_off = "24\n", /* 23.872 */
+	},
+	{
+		.name = "typical IIO_VAL_INT, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_INT,
+		.schan_val = 12,
+		.schan_val2 = 0,
+		.schan_off = 14,
+		.expected_off = "-88\n", /* -88.83333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 12,
+		.schan_val2 = 34,
+		.schan_off = 14,
+		.expected_off = "3510\n", /* 3510.333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL,
+		.schan_val = 12,
+		.schan_val2 = 34,
+		.schan_off = 14,
+		.expected_off = "-3482\n", /* -3482.333333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 12,
+		.schan_val2 = 16,
+		.schan_off = 14,
+		.expected_off = "6739299\n", /* 6739299.333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
+		.schan_val = 12,
+		.schan_val2 = 16,
+		.schan_off = 14,
+		.expected_off = "-6739271\n", /* -6739271.333333333 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "135\n", /* 135.8951219647469 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
+		.offset = -1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "-107\n", /* -107.89512196474689 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
+		.offset = 1234,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "23\n", /* 23.246438560723952 */
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
+		.offset = -12345,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.schan_off = 14,
+		.expected_off = "-78\n", /* -78.50185091745313 */
+	},
+};
+
+static void case_to_desc(const struct rescale_tc_data *t, char *desc)
+{
+	strcpy(desc, t->name);
+}
+
+KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);
+KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
+
+static void iio_rescale_test_scale(struct kunit *test)
+{
+	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	struct rescale rescale;
+	int values[2];
+	int ret;
+
+	rescale.numerator = t->numerator;
+	rescale.denominator = t->denominator;
+	rescale.offset = t->offset;
+	values[0] = t->schan_val;
+	values[1] = t->schan_val2;
+
+	ret = rescale_process_scale(&rescale, t->schan_scale_type,
+				&values[0], &values[1]);
+
+	ret = iio_format_value(buf, ret, 2, values);
+
+	KUNIT_EXPECT_EQ(test, (int)strlen(buf), ret);
+	KUNIT_EXPECT_STREQ(test, buf, t->expected);
+}
+
+static void iio_rescale_test_offset(struct kunit *test)
+{
+	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	struct rescale rescale;
+	int values[2];
+	int ret;
+
+	rescale.numerator = t->numerator;
+	rescale.denominator = t->denominator;
+	rescale.offset = t->offset;
+	values[0] = t->schan_val;
+	values[1] = t->schan_val2;
+
+	ret = rescale_process_offset(&rescale, t->schan_scale_type,
+				     t->schan_val, t->schan_val2, t->schan_off,
+				     &values[0], &values[1]);
+
+	ret = iio_format_value(buf, ret, 2, values);
+
+	KUNIT_EXPECT_EQ(test, (int)strlen(buf), ret);
+	KUNIT_EXPECT_STREQ(test, buf, t->expected_off);
+}
+
+static struct kunit_case iio_rescale_test_cases[] = {
+	KUNIT_CASE_PARAM(iio_rescale_test_scale, iio_rescale_scale_gen_params),
+	KUNIT_CASE_PARAM(iio_rescale_test_offset, iio_rescale_offset_gen_params),
+	{}
+};
+
+static struct kunit_suite iio_rescale_test_suite = {
+	.name = "iio-rescale",
+	.test_cases = iio_rescale_test_cases,
+};
+kunit_test_suite(iio_rescale_test_suite);
-- 
2.30.1.489.g328c10930387

