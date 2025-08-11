Return-Path: <linux-iio+bounces-22587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E276B2117F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9FB5045AB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14999296BD8;
	Mon, 11 Aug 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P50b1b/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DB296BB3
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927712; cv=none; b=jX+qrbRpf1Hs8VaUl/OtHBmJiQPHcH9U2NYi0tAunH3KIIp2CXXScxlQz6xwiWzNO8ilqynXCEfdTs+jKZvza86609XuSCfZHQPvvDtAy6au3sS/Ca70QCc4E9gcbjMlUneIOgrMTlKFG1rhpAMwhZDouOGCH4d1MYccD/9/vNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927712; c=relaxed/simple;
	bh=NTYFBzZaGaK+o/nHTcXR+jhLLlJs8FEk4VAAFHsrOec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTnXr2Q/4MGknu/uHj1WROlUbE/yDpTcWr+4nmrRKB636h5zONP5A5y2L/5MpyBrBZt5EfTa27gLlLh0uM1A9HI+jaE7pb9vOELwD+6tNDaz9eBp/yHaIZ+NrRbuT8l7L4B28539f9dreVLYKKz7A6EdcgHJe66esBv3waPq4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P50b1b/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7425C4CEF4;
	Mon, 11 Aug 2025 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927712;
	bh=NTYFBzZaGaK+o/nHTcXR+jhLLlJs8FEk4VAAFHsrOec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P50b1b/MEQ1e7bQPa0LFbsoJrV6XkcCIybhdcdrNnWZ/QTd1zi7MG2Tqy+UDaZR9w
	 Z+8FSwxeoNMsVf7F4qmq2hdieYde7M5vhhi2gZhWNeM28ulgdNVEPpAK2+7fKKriK+
	 B1iV7lQplONzK0NaXyYjWtAdbelwzTAfto9hCDSEHRdKj1uXPg3W5Ge+4GorHHe+k1
	 OOSnj51LTVT8ZdLXiU8thziBVpTacp7xOPc0GapkAh1SWAHIV7NNpIZc74DvtHApkv
	 Vc68Os3ikYMN88KqgiG0wH2CaQ773z1uqbuq5FMc/hIcNyL1bAH6f1IgSrz0UVGjsi
	 fCDoWDamgkTjg==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 5/6] iio: test: Add kunit tests for iio_multiply_value()
Date: Mon, 11 Aug 2025 17:54:52 +0200
Message-ID: <20250811155453.31525-6-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kunit tests for iio_multiply_value().

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/test/Kconfig             |  12 ++
 drivers/iio/test/Makefile            |   1 +
 drivers/iio/test/iio-test-multiply.c | 209 +++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
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
index 000000000000..41b5821ffcf5
--- /dev/null
+++ b/drivers/iio/test/iio-test-multiply.c
@@ -0,0 +1,209 @@
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
-- 
2.49.0


