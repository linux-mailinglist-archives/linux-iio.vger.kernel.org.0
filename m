Return-Path: <linux-iio+bounces-24432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95914B9F4AA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4254C2FE8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230A27703E;
	Thu, 25 Sep 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vC9Ze1R9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C201C3BE0
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803881; cv=none; b=q5Ee/kbeFEui0DryGGi95PPu/mXLkoHlpbds7waiIGS/3HHJut/SbehpXtyi7AB+zqemNK+ztiirhel7VYUJIzFwcHHcaomUCkNU91RDQpOQqucBDGGp5tSp3mFFbEkxR3lDlvs2yYEjYhNJfDHaMFkmmVD0Ldn7Le8na5JHf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803881; c=relaxed/simple;
	bh=AcCFw4xOZWaL2Vloup40NocEpyxl3c95QlY3hp+pNs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfjdNreEFAByO6D8nJ9+C7tYfAAxuZUfOftDOrWiKO0Ix3Zcszkfs0RXT1TpxnjM9prcJMAbRwf5m1Y8v71EMMHWPl+XHWVSyBoW7LoHhwPebSWxkHoOTMLeFAsG3oQDjIYG8O1412jWqoAE1PFWWC3DVW8qRUnH1ywbWi0BeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vC9Ze1R9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CB9EEC011DF;
	Thu, 25 Sep 2025 12:37:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A8B16062C;
	Thu, 25 Sep 2025 12:37:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2D41102F17E6;
	Thu, 25 Sep 2025 14:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=k7o/HfxDrKJe5p4M+ISv4mlYo5xYjk8Am9y+75H1iHk=;
	b=vC9Ze1R9g34l4uP2D5GiUidy255ekno2l8GpyvFwTuMOaRT91EAPmhn/ddt9NlcdKlC0cZ
	17mpk31MrdrBgroVzwUr2oXgPC4MO7YRQy4z1nqdYwwD4h+z60v5RBhmqJNsvQ4cEOr3FY
	XfTZolyXqB1MnEHn9ercWjR3NNwg5GeqU/xuEVkKK+X1UP2demaO/Nu4G9JrdDVyYRUNcx
	6k7mRF/odhAn8cQFPC9pPtwDXbUsjk/xC1dssvmNVuDoMp5wQ9qtQUU0B1r/pI42fmOe0M
	UzDBubfC2TynA2xinRd+l5VscGc7RC4QnT5EILJ5NkyoT1B8FPIEoCL8GKnAkA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Sep 2025 14:37:35 +0200
Subject: [PATCH v2 3/5] Add kunit tests for iio_divide_by_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-ltm8054-driver-v2-3-bb61a401a0dc@bootlin.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
In-Reply-To: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Add kunit tests for iio_divide_by_value(), these are similar to the
existing tests for iio_multiply_value(), but the operand values used differ
slightly.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/test/Kconfig           |  12 +++
 drivers/iio/test/Makefile          |   1 +
 drivers/iio/test/iio-test-divide.c | 212 +++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 6e65e929791ca247df9ac993fddbb4da557d5dfa..3aa1fc78966cf72554e069db75de1c6eff532850 100644
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
index 0c846bc21acda5a487b3a6977a8e9feaef20159a..16344eedc46a5ebb4d57468b3e549d8f65b85432 100644
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
index 0000000000000000000000000000000000000000..dd4f53bf7223750e2ac583b6e2392abb42fb045b
--- /dev/null
+++ b/drivers/iio/test/iio-test-divide.c
@@ -0,0 +1,212 @@
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
+	KUNIT_EXPECT_EQ(test, ret, -ERANGE);
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
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, -ERANGE);
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
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, -ERANGE);
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
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator << val2), val));
+
+	/* positive >= 1 (1234567/1024) */
+	val = 1234567;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator << val2), val));
+
+	/* negative > -1 (-123/1024) */
+	val = -123;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator << val2), val));
+
+	/* negative <= -1 (-1234567/1024) */
+	val = -1234567;
+	val2 = 10;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, val2);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+	KUNIT_EXPECT_EQ(test, result, div_s64((numerator << val2), val));
+
+	/* Zero */
+	val = 0;
+	ret = iio_divide_by_value(&result, numerator, IIO_VAL_FRACTIONAL_LOG2, val, 0);
+	KUNIT_EXPECT_EQ(test, ret, -ERANGE);
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
2.51.0


