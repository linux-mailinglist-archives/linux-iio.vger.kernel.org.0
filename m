Return-Path: <linux-iio+bounces-26423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C44C81249
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420564E56D2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C883128A1;
	Mon, 24 Nov 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WU8lT8+b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3D284689;
	Mon, 24 Nov 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995735; cv=none; b=CQLnWNBnHwbiQ+VyCbQtHPSNt9q5HFKhHNezX+59nTrWBaNgGMSY9sQwliM9amoTnDtfpRrd+9yQQNEWSVgYXSg/7O3WKn3VA+35MHAGIpQDmZCKLMC2Hv0gPIXiVJ5xPrdAV30/SaTCs1xCQTw0w1xTW2tH+19GUbC3hRi1n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995735; c=relaxed/simple;
	bh=bvJnokLaOrHe39FFL+BmrzEKu3k2XcOLXxMeVHRy9t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4YtVBwryE0yncqXZec4MtuNt+lePKVujKEJ0WV/AL0NY3HL71NYVOh1fhYOZMG42TfO5pCCHZg+ySvNOjSL9AgEKJVOMTcSR85m8e1qayiFfo+lG5wBU1c1O+UlGRgaMU9t5XKjb24VXyFxnqJqpoYASQx+6SkRhzwdvPOMZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WU8lT8+b; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C8F03C139B0;
	Mon, 24 Nov 2025 14:48:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69AD0606FC;
	Mon, 24 Nov 2025 14:48:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DDB810371DB3;
	Mon, 24 Nov 2025 15:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763995730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H63DS5Qyocea77wCyQDu0pCJbvkP2TzyMGYozs1+550=;
	b=WU8lT8+biSXxVPcwa76IzJS8QFSzKZZikNL/OXw8xQgNfCjx1JZEjYNHxU2bgzwFDm5Yjg
	V4hlG6ZCSiC6oA+BbSrQgKahbxVFHTBacYp3i5wM8xC2JJ472zEAv3tbapWYrDUMopLg4p
	L0B6YcMSYjh/y16av7a5cAeD33vGqz20ZrACeZr0y1jom+j61O7KTYHGv+frP+qTs345ba
	kt7o8rjDiHyLHKHVIgfraInWEuBbMcJl3Imb+/CQf6X8DlKTzh8eGkphUowtLWyUw6KRJ5
	TKFWQl9c9n474jxY2rdfV/q3UDEXKxYjQXFpezyy1RUa5uXQ+izRfFdVoLnazg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 15:48:08 +0100
Subject: [PATCH v4 4/6] iio: test: Add kunit tests for
 iio_divide_by_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-ltm8054-driver-v4-4-107a8a814abe@bootlin.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
In-Reply-To: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add kunit tests for iio_divide_by_value(), these are similar to the
existing tests for iio_multiply_value(), but the operand values used differ
slightly.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/test/Kconfig           |  12 ++
 drivers/iio/test/Makefile          |   1 +
 drivers/iio/test/iio-test-divide.c | 247 +++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 6e65e929791c..3aa1fc78966c 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,18 @@
 #
 
 # Keep in alphabetical order
+config IIO_DIVIDE_KUNIT_TEST
+	tristate "Test IIO division functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO division functions.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config IIO_GTS_KUNIT_TEST
 	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index 0c846bc21acd..16344eedc46a 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,6 +5,7 @@
 
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
+obj-$(CONFIG_IIO_DIVIDE_KUNIT_TEST) += iio-test-divide.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) += iio-test-format.o
 obj-$(CONFIG_IIO_GTS_KUNIT_TEST) += iio-test-gts.o
 obj-$(CONFIG_IIO_MULTIPLY_KUNIT_TEST) += iio-test-multiply.o
diff --git a/drivers/iio/test/iio-test-divide.c b/drivers/iio/test/iio-test-divide.c
new file mode 100644
index 000000000000..99d759bd9591
--- /dev/null
+++ b/drivers/iio/test/iio-test-divide.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO division functions
+ *
+ * Copyright (c) 2025 Bootlin
+ * Based on iio-test-multiply.c which is:
+ * Copyright (c) 2025 Hans de Goede <hans@hansg.org>
+ * Based on iio-test-format.c which is:
+ * Copyright (c) 2020 Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <kunit/test.h>
+#include <linux/iio/consumer.h>
+#include <linux/limits.h>
+#include <linux/units.h>
+
+static void __iio_test_iio_divide_by_integer(struct kunit *test, s64 numerator)
+{
+	int ret, result, val;
+
+	val = 42;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator, val));
+
+	val = -23;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator, val));
+
+	val = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EDOM);
+}
+
+static void iio_test_iio_divide_by_integer(struct kunit *test)
+{
+	__iio_test_iio_divide_by_integer(test, 2000);
+	__iio_test_iio_divide_by_integer(test, -2000);
+}
+
+static void __iio_test_iio_divide_by_fixedpoint(struct kunit *test, s64 numerator)
+{
+	int ret, result, val, val2;
+
+	/* positive >= 1 (1.5) */
+	val = 1;
+	val2 = 500000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * 10, 15));
+
+	val = 1;
+	val2 = 500000000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * 10, 15));
+
+	/* positive < 1 (0.5) */
+	val = 0;
+	val2 = 500000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * 10, 5));
+
+	val = 0;
+	val2 = 500000000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * 10, 5));
+
+	/* negative <= -1 (-1.5) */
+	val = -1;
+	val2 = 500000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * -10, 15));
+
+	val = -1;
+	val2 = 500000000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * -10, 15));
+
+	/* negative > -1 (-0.5) */
+	val = 0;
+	val2 = -500000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * -10, 5));
+
+	val = 0;
+	val2 = -500000000;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * -10, 5));
+
+	/* Zero */
+	val = 0;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, -EDOM);
+
+	val = 0;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, -EDOM);
+
+	/* Limits */
+	val = INT_MIN;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator, INT_MIN));
+
+	val = INT_MIN;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator, INT_MIN));
+
+	val = 0;
+	val2 = INT_MIN;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_MICRO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(MICRO * numerator, INT_MIN));
+
+	val = 0;
+	val2 = INT_MIN;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_INT_PLUS_NANO, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(NANO * numerator, INT_MIN));
+}
+
+static void iio_test_iio_divide_by_fixedpoint(struct kunit *test)
+{
+	__iio_test_iio_divide_by_fixedpoint(test, 2000);
+	__iio_test_iio_divide_by_fixedpoint(test, -2000);
+}
+
+static void __iio_test_iio_divide_by_fractional(struct kunit *test, s64 numerator)
+{
+	int ret, result, val, val2;
+
+	/* positive < 1 (1/10)*/
+	val = 1;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * val2, val));
+
+	/* positive >= 1 (100/3)*/
+	val = 100;
+	val2 = 3;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * val2, val));
+
+	/* negative > -1 (-1/10) */
+	val = -1;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * val2, val));
+
+	/* negative <= -1 (-200/3)*/
+	val = -200;
+	val2 = 3;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64(numerator * val2, val));
+
+	/* Zero */
+	val = 0;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, -EDOM);
+}
+
+static void iio_test_iio_divide_by_fractional(struct kunit *test)
+{
+	__iio_test_iio_divide_by_fractional(test, 2000);
+	__iio_test_iio_divide_by_fractional(test, -2000);
+}
+
+static void __iio_test_iio_divide_by_fractional_log2(struct kunit *test, s64 numerator)
+{
+	int ret, result, val, val2;
+
+	/* positive < 1 (123/1024) */
+	val = 123;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator * 1024), val));
+
+	/* positive >= 1 (1234567/1024) */
+	val = 1234567;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator * 1024), val));
+
+	/* negative > -1 (-123/1024) */
+	val = -123;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator * 1024), val));
+
+	/* negative <= -1 (-1234567/1024) */
+	val = -1234567;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator * 1024), val));
+
+	/* Zero */
+	val = 0;
+	val2 = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, -EDOM);
+}
+
+static void iio_test_iio_divide_by_fractional_log2(struct kunit *test)
+{
+	__iio_test_iio_divide_by_fractional_log2(test, 2000);
+	__iio_test_iio_divide_by_fractional_log2(test, -2000);
+}
+
+static struct kunit_case iio_divide_test_cases[] = {
+		KUNIT_CASE(iio_test_iio_divide_by_integer),
+		KUNIT_CASE(iio_test_iio_divide_by_fixedpoint),
+		KUNIT_CASE(iio_test_iio_divide_by_fractional),
+		KUNIT_CASE(iio_test_iio_divide_by_fractional_log2),
+		{ }
+};
+
+static struct kunit_suite iio_divide_test_suite = {
+	.name = "iio-divide",
+	.test_cases = iio_divide_test_cases,
+};
+
+kunit_test_suite(iio_divide_test_suite);
+
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.com>");
+MODULE_DESCRIPTION("Test IIO division functions");
+MODULE_LICENSE("GPL");

-- 
2.51.2


