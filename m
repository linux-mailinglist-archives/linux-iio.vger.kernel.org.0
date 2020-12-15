Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93A82DB463
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 20:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgLOTTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 14:19:03 -0500
Received: from www381.your-server.de ([78.46.137.84]:43346 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgLOTS4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 14:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+i6jKHbv+WCAkeo5L/SdFzgfEAC2Ih97Ok3rQYWtbHE=; b=NIZiHvl9+Yk8LllBrD/AAEaj7q
        jCh6tiQd/htsK4jt/JjNB7U2Koz6n2kBTO8rGIqFJ3NRJvI5i7MM01Gh/9/AyBB2pXlumQdbjPCYP
        Tkp6Ew3r3mI1BZTPBSMsDBBl6Y+RcPauRcTGQ7GBp6ZgA0ghuFziRGuoM2AAPPfyPcfE30f/LrHYR
        6IGRkSbh+uD5yh5uAZJaI0vNcANbr40gyhh04HWv8nXCGKmAt+P59ODTLZ2J8RyVUUSSd6WtJNe/L
        /vedn5YdcSB0MDs9iEfVpl3ddqIKSffoH3MicK38IgroUHnM24/MJt4qXPXIZTdulHWcgZKvb+iNx
        8nIBZz7Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpFps-000E1m-My; Tue, 15 Dec 2020 20:18:12 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpFps-0002L1-Iq; Tue, 15 Dec 2020 20:18:12 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: Add basic unit test for iio_format_value()
Date:   Tue, 15 Dec 2020 20:17:43 +0100
Message-Id: <20201215191743.2725-3-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215191743.2725-1-lars@metafoo.de>
References: <20201215191743.2725-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core provides a function to do formatting of fixedpoint numbers.

In the past there have been some issues with the implementation of the
function where for example negative numbers were not handled correctly.

Introduce a basic unit test based on kunit that tests the function and
ensures that the generated output matches the expected output.

This gives us some confidence that future modifications to the function
implementation will not break ABI compatibility.

To run the unit tests follow the kunit documentation and add

  CONFIG_IIO=y
  CONFIG_IIO_TEST_FORMAT=y

to the .kunitconfig and run

  > ./tools/testing/kunit/kunit.py run
  Configuring KUnit Kernel ...
  Building KUnit Kernel ...
  Starting KUnit Kernel ...
  ============================================================
  ======== [PASSED] iio-format ========
  [PASSED] iio_test_iio_format_value_integer
  [PASSED] iio_test_iio_format_value_fixedpoint
  [PASSED] iio_test_iio_format_value_fractional
  [PASSED] iio_test_iio_format_value_fractional_log2
  [PASSED] iio_test_iio_format_value_multiple
  ============================================================
  Testing complete. 21 tests run. 0 failed. 0 crashed.
  Elapsed time: 8.242s total, 0.001s configuring, 3.865s building, 0.000s running

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/Kconfig                |   1 +
 drivers/iio/Makefile               |   1 +
 drivers/iio/test/Kconfig           |   9 ++
 drivers/iio/test/Makefile          |   7 +
 drivers/iio/test/iio-test-format.c | 198 +++++++++++++++++++++++++++++
 5 files changed, 216 insertions(+)
 create mode 100644 drivers/iio/test/Kconfig
 create mode 100644 drivers/iio/test/Makefile
 create mode 100644 drivers/iio/test/iio-test-format.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 267553386c71..b35e0c33b5e2 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -85,6 +85,7 @@ source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
+source "drivers/iio/test/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 1712011c0f4a..2561325aaa74 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -38,4 +38,5 @@ obj-y += pressure/
 obj-y += proximity/
 obj-y += resolver/
 obj-y += temperature/
+obj-y += test/
 obj-y += trigger/
diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
new file mode 100644
index 000000000000..679a7794af20
--- /dev/null
+++ b/drivers/iio/test/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Industrial I/O subsystem unit tests configuration
+#
+
+# Keep in alphabetical order
+config IIO_TEST_FORMAT
+        bool "Test IIO formatting functions"
+        depends on KUNIT=y
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
new file mode 100644
index 000000000000..f1099b495301
--- /dev/null
+++ b/drivers/iio/test/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the industrial I/O unit tests.
+#
+
+# Keep in alphabetical order
+obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
new file mode 100644
index 000000000000..55a0cfe9181d
--- /dev/null
+++ b/drivers/iio/test/iio-test-format.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO formatting functions
+ *
+ * Copyright (c) 2020 Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <kunit/test.h>
+#include <linux/iio/iio.h>
+
+#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
+		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
+		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
+	} while (0)
+
+static void iio_test_iio_format_value_integer(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int val;
+	int ret;
+
+	val = 42;
+	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
+
+	val = -23;
+	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-23\n");
+
+	val = 0;
+	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
+
+	val = INT_MAX;
+	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "2147483647\n");
+
+	val = INT_MIN;
+	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-2147483648\n");
+}
+
+static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int values[2];
+	int ret;
+
+	/* positive >= 1 */
+	values[0] = 1;
+	values[1] = 10;
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
+
+	/* positive < 1 */
+	values[0] = 0;
+	values[1] = 12;
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
+
+	/* negative <= -1 */
+	values[0] = -1;
+	values[1] = 10;
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
+
+	/* negative > -1 */
+	values[0] = 0;
+	values[1] = -123;
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
+
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
+}
+
+static void iio_test_iio_format_value_fractional(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int values[2];
+	int ret;
+
+	/* positive < 1 */
+	values[0] = 1;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
+
+	/* positive >= 1 */
+	values[0] = 100;
+	values[1] = 3;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
+
+	/* negative > -1 */
+	values[0] = -1;
+	values[1] = 1000000000;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
+
+	/* negative <= -1 */
+	values[0] = -200;
+	values[1] = 3;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
+
+	/* Zero */
+	values[0] = 0;
+	values[1] = -10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
+}
+
+static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int values[2];
+	int ret;
+
+	/* positive < 1 */
+	values[0] = 123;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
+
+	/* positive >= 1 */
+	values[0] = 1234567;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
+
+	/* negative > -1 */
+	values[0] = -123;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
+
+	/* negative <= -1 */
+	values[0] = -1234567;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
+
+	/* Zero */
+	values[0] = 0;
+	values[1] = 10;
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
+}
+
+static void iio_test_iio_format_value_multiple(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int values[] = {1, -2, 3, -4, 5};
+	int ret;
+
+	ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
+			       ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
+}
+
+static struct kunit_case iio_format_test_cases[] = {
+		KUNIT_CASE(iio_test_iio_format_value_integer),
+		KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
+		KUNIT_CASE(iio_test_iio_format_value_fractional),
+		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
+		KUNIT_CASE(iio_test_iio_format_value_multiple),
+		{}
+};
+
+static struct kunit_suite iio_format_test_suite = {
+	.name = "iio-format",
+	.test_cases = iio_format_test_cases,
+};
+kunit_test_suite(iio_format_test_suite);
-- 
2.20.1

