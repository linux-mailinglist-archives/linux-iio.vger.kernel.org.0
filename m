Return-Path: <linux-iio+bounces-23523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92FB3D237
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018643BEB6B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCA24DD15;
	Sun, 31 Aug 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2v8ln8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9A1E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637318; cv=none; b=JsEyZRWAROp9GbPUBoBfzKpvX5WJST9kO9NhSLeSezoYyymUTpOK27U38bHVYEmUxLCmYCBJRW7ki/+D8DQlolzFf0WwPAzcD9JLIIXJ05hypmdOk/G1+anuJ7vSLwg4+X7LT+xjcmV+zm8jBxM7Ptr57KSrOgK5EHOokR0wXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637318; c=relaxed/simple;
	bh=A6KH3tnbJ32iZ9qSoBpj0USvWI7Ya8Cb4rFNmqcKqqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU7a0UVM/4rfv5N7Yvu/CeOc5U9JH/T5+wJ8EGEkDWrF5hthyzR4deRLIGTjkMVlv+iEZ+BLdeUjZckshvC/hkPL7euwE7MbZ6et+iH8kpLnUkAMv21d4mTIfnVi0NJ6N4FpVuqXBH7wZ1A00zF/FfhyGxQzehm+YxbdF4cap08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2v8ln8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4348BC4CEF5;
	Sun, 31 Aug 2025 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637318;
	bh=A6KH3tnbJ32iZ9qSoBpj0USvWI7Ya8Cb4rFNmqcKqqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2v8ln8Q4eXe9a7BIyGprOZRxBx1dFGKuE0dBppi+kc0Mj4guxFlb2a3FUE5rAs4G
	 ZcLQFx1Iozfa15npPU9J2Nvkzd1M/7cVAM4pRMGDdimLouss5b8LRHH96WQhMqZs14
	 shIAE2t5HXrOnK+JaW+8zJhe1J/yl6tpWnC0/E+lkLVey6qOG2tUaWP0aXBOaWvJrF
	 vlKMQ538Yt758gr0U+RgVqZJhaF2Zn4Xzhrsk7eFMq8ibDlGuACWtrM+VneNOenNcv
	 Cm969kQXT1d6wXQcdFWgyyAaSoWmsts6PAv+jPrlo9QoytBDTdvbLJZOPZiu37xeiA
	 JIu8jVMnrbFEA==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 5/6] iio: test: Add KUnit tests for iio_multiply_value()
Date: Sun, 31 Aug 2025 12:48:24 +0200
Message-ID: <20250831104825.15097-6-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831104825.15097-1-hansg@kernel.org>
References: <20250831104825.15097-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit tests for iio_multiply_value().

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v5:
- s/kunit/KUnit/
- Add some missing includes

Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/test/Kconfig             |  12 ++
 drivers/iio/test/Makefile            |   1 +
 drivers/iio/test/iio-test-multiply.c | 212 +++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-multiply.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 7a181cac3cc9..6e65e929791c 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -41,3 +41,15 @@ config IIO_FORMAT_KUNIT_TEST
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
 	  If unsure, say N.
+
+config IIO_MULTIPLY_KUNIT_TEST
+	tristate "Test IIO multiply functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO multiply functions.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index e9a4cf1ff57f..0c846bc21acd 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) += iio-test-format.o
 obj-$(CONFIG_IIO_GTS_KUNIT_TEST) += iio-test-gts.o
+obj-$(CONFIG_IIO_MULTIPLY_KUNIT_TEST) += iio-test-multiply.o
 CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/iio-test-multiply.c b/drivers/iio/test/iio-test-multiply.c
new file mode 100644
index 000000000000..432e279ffe5b
--- /dev/null
+++ b/drivers/iio/test/iio-test-multiply.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO multiply functions
+ *
+ * Copyright (c) 2025 Hans de Goede <hans@hansg.org>
+ * Based on iio-test-format.c which is:
+ * Copyright (c) 2020 Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <kunit/test.h>
+#include <linux/iio/consumer.h>
+#include <linux/math64.h>
+#include <linux/types.h>
+
+static void __iio_test_iio_multiply_value_integer(struct kunit *test, s64 multiplier)
+{
+	int ret, result, val;
+
+	val = 42;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, multiplier * val);
+
+	val = -23;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, multiplier * val);
+
+	val = 0;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, multiplier * val);
+}
+
+static void iio_test_iio_multiply_value_integer(struct kunit *test)
+{
+	__iio_test_iio_multiply_value_integer(test, 20);
+	__iio_test_iio_multiply_value_integer(test, -20);
+}
+
+static void __iio_test_iio_multiply_value_fixedpoint(struct kunit *test, s64 multiplier)
+{
+	int ret, result, val, val2;
+
+	/* positive >= 1 (1.5) */
+	val = 1;
+	val2 = 500000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * 15, 10));
+
+	val = 1;
+	val2 = 500000000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * 15, 10));
+
+	/* positive < 1 (0.5) */
+	val = 0;
+	val2 = 500000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * 5, 10));
+
+	val = 0;
+	val2 = 500000000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * 5, 10));
+
+	/* negative <= -1 (-1.5) */
+	val = -1;
+	val2 = 500000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * -15, 10));
+
+	val = -1;
+	val2 = 500000000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * -15, 10));
+
+	/* negative > -1 (-0.5) */
+	val = 0;
+	val2 = -500000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * -5, 10));
+
+	val = 0;
+	val2 = -500000000;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * -5, 10));
+}
+
+static void iio_test_iio_multiply_value_fixedpoint(struct kunit *test)
+{
+	__iio_test_iio_multiply_value_fixedpoint(test, 20);
+	__iio_test_iio_multiply_value_fixedpoint(test, -20);
+}
+
+static void __iio_test_iio_multiply_value_fractional(struct kunit *test, s64 multiplier)
+{
+	int ret, result, val, val2;
+
+	/* positive < 1 (1/10)*/
+	val = 1;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * val, val2));
+
+	/* positive >= 1 (100/3)*/
+	val = 100;
+	val2 = 3;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * val, val2));
+
+	/* negative > -1 (-1/10) */
+	val = -1;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * val, val2));
+
+	/* negative <= -1 (-200/3)*/
+	val = -200;
+	val2 = 3;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * val, val2));
+
+	/* Zero (0/-10) */
+	val = 0;
+	val2 = -10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(multiplier * val, val2));
+}
+
+static void iio_test_iio_multiply_value_fractional(struct kunit *test)
+{
+	__iio_test_iio_multiply_value_fractional(test, 20);
+	__iio_test_iio_multiply_value_fractional(test, -20);
+}
+
+static void __iio_test_iio_multiply_value_fractional_log2(struct kunit *test, s64 multiplier)
+{
+	int ret, result, val, val2;
+
+	/* positive < 1 (123/1024) */
+	val = 123;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, (multiplier * val) >> val2);
+
+	/* positive >= 1 (1234567/1024) */
+	val = 1234567;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, (multiplier * val) >> val2);
+
+	/* negative > -1 (-123/1024) */
+	val = -123;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, (multiplier * val) >> val2);
+
+	/* negative <= -1 (-1234567/1024) */
+	val = -1234567;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, (multiplier * val) >> val2);
+
+	/* Zero (0/1024) */
+	val = 0;
+	val2 = 10;
+	ret = iio_multiply_value(&result, multiplier, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, (multiplier * val) >> val2);
+}
+
+static void iio_test_iio_multiply_value_fractional_log2(struct kunit *test)
+{
+	__iio_test_iio_multiply_value_fractional_log2(test, 20);
+	__iio_test_iio_multiply_value_fractional_log2(test, -20);
+}
+
+static struct kunit_case iio_multiply_test_cases[] = {
+		KUNIT_CASE(iio_test_iio_multiply_value_integer),
+		KUNIT_CASE(iio_test_iio_multiply_value_fixedpoint),
+		KUNIT_CASE(iio_test_iio_multiply_value_fractional),
+		KUNIT_CASE(iio_test_iio_multiply_value_fractional_log2),
+		{ }
+};
+
+static struct kunit_suite iio_multiply_test_suite = {
+	.name = "iio-multiply",
+	.test_cases = iio_multiply_test_cases,
+};
+kunit_test_suite(iio_multiply_test_suite);
+
+MODULE_AUTHOR("Hans de Goede <hans@hansg.org>");
+MODULE_DESCRIPTION("Test IIO multiply functions");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_UNIT_TEST");
-- 
2.51.0


