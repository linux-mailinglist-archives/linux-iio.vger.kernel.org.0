Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E33D071D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhGUC0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGUC03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53171C061574;
        Tue, 20 Jul 2021 20:07:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g8so1039177qtj.1;
        Tue, 20 Jul 2021 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=liDg9SkfmALL91hvXiez7VH6xJpgmfwbB3K9vi7H1kk=;
        b=bL3X7S86966naf1GN4VDdwDX6BRu20eKfjbTAsNcFwWnifmm7fnzAwq5HmoC2nAYAx
         mR8mwKvMrOh0IrzBhgOh3SZbLDyTlEwpVWjDCCgtKIoSLeQvWIDb8BasrqYfxCuyRqmj
         QpmNPMFJW4Mf3GbrwE2AnNUDyfrJCHDq15eH4m+IwO+7TFL95Fr0+dak9iwlHCsYF3gr
         9cZbNvdBZFBachLy0AogadvG31BHmhNVd4hNRe4x1EKGoHh98K8QEmb682kjYx0lptyR
         XRq4LGrhZ9349M0H1N66eTsy/58VdqO7hZ7R0U4mpcKVFvCSOvtaL7odXaor8NOaSLwd
         sNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=liDg9SkfmALL91hvXiez7VH6xJpgmfwbB3K9vi7H1kk=;
        b=KjXkXLz7V7FMo2ul4p1N/mZpx5ze1BlYhAGXXkgO/X0tr5nmS5sBdGeYDx4CQLeV0H
         OBLe3zHuLqcpNq7i/0ysW6JZeKE0IBmCsog4+IGIdDpZaJUKBF1TXgDlUGz4G1hc63tW
         KMKN5QCirg7EAKKGsXTXnKfdJJ1f/um9lg59ifLiHFcSKlX3Jxt6FmJXlY7wTCzEaIMP
         76dFytaqmp5kHWvv3Y4hS17qdvmwrBr5Bu/IJni7FipxPqndnaVLN/g7UdqzrfRG1BEQ
         cCrBvH1JTFAnszfr9IY577ljvdJLDkJIcvbD944QTxqYjwNclj2Pf44ClDzTlqNTyKlb
         DXtg==
X-Gm-Message-State: AOAM531MLj1V0NkRCF9rscvO4B9Tec4VK89RaKGUx8etGSGqSQJ/S2lB
        adpM7Xvj9ta0RyBiKD9IVNA=
X-Google-Smtp-Source: ABdhPJwkN3IM1maxb2DtiDocYGF9tirthSlzSllfdnuaPeQSKQWnk7ygxa8ABDw+ad9BkRHoETD2ww==
X-Received: by 2002:ac8:59c5:: with SMTP id f5mr28753959qtf.50.1626836826464;
        Tue, 20 Jul 2021 20:07:06 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:05 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 07/13] iio: test: add basic tests for the iio-rescale driver
Date:   Tue, 20 Jul 2021 23:06:07 -0400
Message-Id: <20210721030613.3105327-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
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
 drivers/iio/test/iio-test-rescale.c | 342 ++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-rescale.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 679a7794af20..4db74a4d7146 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,16 @@
 #
 
 # Keep in alphabetical order
+config IIO_RESCALE_KUNIT_TEST
+	bool "Test IIO rescale conversion functions"
+	depends on KUNIT=y
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
index 000000000000..ac1aee310ccd
--- /dev/null
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -0,0 +1,342 @@
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
+		.schan_val2 = 123456789,
+		.expected = "1256.012008560\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "-1256.012008560\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
+		.numerator = 1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
+		.schan_val2 = 123456789,
+		.expected = "16557.914267\n",
+	},
+	{
+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
+		.numerator = -1000000,
+		.denominator = 8060,
+		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
+		.schan_val = 10,
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

