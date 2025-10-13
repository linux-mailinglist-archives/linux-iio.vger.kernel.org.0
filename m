Return-Path: <linux-iio+bounces-25043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B1BD65FF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9B7188DC38
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9882E36F4;
	Mon, 13 Oct 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w9IDYxM3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB9134BD
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391237; cv=none; b=OtlI6+IvM5/5LXjnNLpId51/vYH+xSXa1P326JKHyuz8KXBEZySQNyMOQB3GhS719zvaDV3xjckc/m2Nz6TNmp1VI9l0e1XjYDN9Fo29iaWdVhNbIELUUC7xDCxjTm7PVpf2e477yBqgfHtnuY6LiRj1/9JmzeCPk9xMZvdfjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391237; c=relaxed/simple;
	bh=S+5UlcHEjrBWuJv6UsmXBiz2G9IdfwGhUo8ykHoxZRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CSqICTIixyvI3GlbJ2/n53RoL77wdIUxIoXJL3KSticd5iGt2L0w1UdK2GpwaIY+IsaGK0usSKDVJwAAfkbgE+u8hpcg1O1hsKIoLdbgLHvkHTjwVciyoxzPlhENhie3eo1G5r8bTtq4DLvbBbUvcZAlGeoBK8usB4iBA4j5wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w9IDYxM3; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3627a1979a0so3259097fac.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760391233; x=1760996033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW9QX+M1STMhGWj50E44m+hCJQ0pzaTa4Qn7Dm6RkUY=;
        b=w9IDYxM38dMuOT10Bdm9Cn8YBxJN9Dj2Hl77V3dy9I+/ENXtHfq3iiskAcgdUaH8V4
         ec8Z3jDZPWXs2OTbnj7xZk1L0aW3GJfZHGOORLPNKHeoFl5aFf8wUvDlF7P/Hyehqe8G
         SACx/e2tl87zpBCKnolPWGhRSHjtA6zS7HfkuAc0SCI0dVPbDtOWaizA9UxAQm9qwyPb
         gQ395m0xeWq9fB/Fji99iuFtZkD5aEMUVKtO8aNQHocmPxuvHLYh0tRlf3GvtLenFyAt
         k8Rh7uDq+e8+rp6k1+JylJ3HEU4+E/GHjHpU9va+N33pS9FgZ5nYeqGScsvbE+Peh0yL
         GC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760391233; x=1760996033;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW9QX+M1STMhGWj50E44m+hCJQ0pzaTa4Qn7Dm6RkUY=;
        b=sp8PuBiqEVydoNuOlKbFYFUKdyFPpA4QA+vCRsox8m6SOo5Vv3LDPxTc7X/320g+VJ
         A0wKy5Cen/eLXE0gYYsQQnYSbmsa/5xCkdSjTH1AZtgXW7dTM4u0da/dT2ivxrsbINIa
         gyX7DjbXYeK3UywA1Ve7gnq+bKG+rSUcCIW1t+AJSSlMCa4IV//V6cMW7XBSdzE3zoC+
         maxH7XJW98J1pixNyvrQyrAKW/uDeHmbF1+nOUY6EiD8/jTIecL+AAOdOWa1tBzS2owi
         vvywmco5kXRRIfOrWQIvkqquBf5uCZaXXA1j0+q3vtBeSaWGDuHr2Qk2eqyKDdR69iRi
         AWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZN+Mcb/rox4OtkkfggDUXMvxmkmHIl2+uLMAp5d08ZGzdYI8VJz0EYcPGxju48Qzx8xD0bhvTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHO2+2LdpO2xj3N5PeX6CRlt0k2CyzWHdBt35VnvOEAUuK5D97
	Qo+/4aKJeM3tH8adXQI0I7XRlnyLiCsGJVe1mexn02rrSMZBxinlwuA9VgIBzND9GmU=
X-Gm-Gg: ASbGncveddsLVYbMqRNYEa2ZzhhJPeKGh+RBn3LvwjfD5lcXVJ2tHn6oYpQ8Rux9xMZ
	rN9MjdMrAFwDuov9bUqhsLL0aWGVQ2Hh/xCPxHUberuiPHJDI4nfeSwxMzWw97l+Z4G+D5T9elb
	yhQnHo1bJuvMh2Wwvg6oOQCwwsNjXsOtVv1Jo4cnpVH2r8PCQ4M4+Ujxu/JJU+JP312gfltXIYX
	0ypZ9O1FvHNNSpGfbF0p9ZGOPWSL/Zo530hI2I5FQLG/5FvEMl9pkBBFF8qEpgSmhpF7jgbk8S2
	VzkNP6o+48aVYFt90HdYvoV+WqItjj74x/KCvWxIcyaIUoxKOkxjJR3h7ITRcYW/qqUQu4ETfGN
	0qHuAqRIjxE68Lvh6in1F58rL6wSaQ1niUMR7rIBbOK4YSQ==
X-Google-Smtp-Source: AGHT+IGpkPrBBYATqeDfySRA0sSXDVmAkWnG7OPAV+n75UM1ORhPMaGBH1JoStYGZGaemJfMqa34CA==
X-Received: by 2002:a05:6870:3233:b0:319:bcee:df41 with SMTP id 586e51a60fabf-3c0f81eb379mr12307392fac.32.1760391233100;
        Mon, 13 Oct 2025 14:33:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9bbe:7008:41b0:ed6e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm3927676fac.20.2025.10.13.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:33:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Oct 2025 16:33:43 -0500
Subject: [PATCH] iio: test: fixed-point: new kunit test
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADZw7WgC/xWNwQqDMBAFf0X23IVESbH9ldKDmte6FDaSjW1B/
 HfjcWCY2ciQBUb3ZqOMr5gkreAvDU3zoG+wxMrUujZ45x2LJC6wYvySPyIvSbSw4sefVaVwGFz
 sMPpbfw1UK0vGKZ6Hx3PfD+tW4KFxAAAA
X-Change-ID: 20251010-iio-tests-fixed-point-new-kunit-5a0d3eb19865
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5245; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=S+5UlcHEjrBWuJv6UsmXBiz2G9IdfwGhUo8ykHoxZRg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7XA4VugKvnWZr4GhOB/sTmHYgLcH+oGWz+U66
 5TDllZMgi6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO1wOAAKCRDCzCAB/wGP
 wANIB/wKj9RIo9Lat7YTU71Z/8xS7cGismxmPzr+48um2+ur5rxJmJP2FnkjNfyobHBX9hFXTtU
 7ZxiUAbJWC9llbhzmo5v9MkerS1eqQyQo6cwfHhuVdm1sVAQE3Im0MsEQPYcSifG2yMQb6pjBcD
 vR/r8ogyiinSPumaSEqPxKI0sJGsJe6fxrOq5VLJe/VqC5Kag1GDg61faMy1uvnXOoozZwMaA1d
 9BaadTdKS+3hd1V053jCnM0Uqc4DsYheUypTdJi67EYGiZNKPfgeHGGWRWoVpSRCh3ta+SmHvm0
 4arWflFQ8jLOxngmIaE9OStkje7tr6Dnf+rjcWefPRnlpFYo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a kunit test for iio_str_to_fixpoint(). This function has an
unintuitive API so this is helpful to see how to use it and shows the
various edge cases.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
When reviewing [1], I noticed that iio_str_to_fixpoint() has an odd API
which lead me to find the bug in [2]. To make sure I was understanding
the API correctly, I wrote a KUnit test for it. So here it is.

[1]: https://lore.kernel.org/linux-iio/20251009173609.992452-3-flavra@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com/
---
Discussion unrelated to the patch:

I'm also a little tempted to introduce a new function that is a bit
easier to use. Many callers of iio_str_to_fixpoint_s64() are doing
something like int_part * 1000 + fract_part and ignoring the possibility
of negative values which require special handling.

static int iio_str_to_fixpoint_s64(const char *str, u32 decimal_places, s64 *value)
{
	int int_part, fract_part;
	int ret;

	ret = iio_str_to_fixpoint(str, int_pow(10, decimal_places - 1),
				  &int_part, &fract_part);
	if (ret)
		return ret;

	*value = (s64)int_part * int_pow(10, decimal_places) +
		 (int_part < 0 ? -1 : 1) * fract_part;

	return 0;
}
---
 drivers/iio/test/Kconfig                | 13 ++++++++
 drivers/iio/test/Makefile               |  1 +
 drivers/iio/test/iio-test-fixed-point.c | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 6e65e929791ca247df9ac993fddbb4da557d5dfa..d210067ea59199d342b15bf373e724d0aa2c55a0 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,19 @@
 #
 
 # Keep in alphabetical order
+
+config IIO_FIXED_POINT_KUNIT_TEST
+	tristate "Test IIO fixedpoint functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build unit tests for the IIO fixed-point code.
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
index 0c846bc21acda5a487b3a6977a8e9feaef20159a..a580e78b0fe00adc65f8f9df80023d6d738d11f7 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -4,6 +4,7 @@
 #
 
 # Keep in alphabetical order
+obj-$(CONFIG_IIO_FIXED_POINT_KUNIT_TEST) += iio-test-fixed-point.o
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) += iio-test-format.o
 obj-$(CONFIG_IIO_GTS_KUNIT_TEST) += iio-test-gts.o
diff --git a/drivers/iio/test/iio-test-fixed-point.c b/drivers/iio/test/iio-test-fixed-point.c
new file mode 100644
index 0000000000000000000000000000000000000000..edfed5434af2391a31d206fda2be0455a9e5e443
--- /dev/null
+++ b/drivers/iio/test/iio-test-fixed-point.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unit tests for IIO fixed-point functions
+ *
+ * Copyright (c) 2025 BayLibre, SAS
+ */
+
+#include <kunit/test.h>
+#include <linux/iio/iio.h>
+#include <linux/math.h>
+#include <linux/types.h>
+
+static void iio_test_iio_str_to_fixed_point(struct kunit *test)
+{
+	int int_part, fract_part;
+	int ret;
+
+	/* Positive value > 1 */
+	ret = iio_str_to_fixpoint("1.234", 100, &int_part, &fract_part);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, 1234);
+
+	/* Truncates rather than rounding closest. */
+	ret = iio_str_to_fixpoint("1.234567", 100, &int_part, &fract_part);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, 1234);
+
+	/* Positive value < 1 */
+	ret = iio_str_to_fixpoint("0.001", 100, &int_part, &fract_part);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, 1);
+
+	/* Negative value > -1 */
+	ret = iio_str_to_fixpoint("-0.001", 100, &int_part, &fract_part);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, -1);
+
+	/* Negative value < -1 */
+	ret = iio_str_to_fixpoint("-1.001", 100, &int_part, &fract_part);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/* The fractional part is subtracted rather than added in this case! */
+	KUNIT_EXPECT_EQ(test, int_part * 1000 - fract_part, -1001);
+}
+
+static const struct kunit_case iio_fixed_point_test_cases[] = {
+	KUNIT_CASE(iio_test_iio_str_to_fixed_point),
+	{ }
+};
+
+static struct kunit_suite iio_fixed_point_test_suite = {
+	.name = "iio-fixed-point",
+	.test_cases = iio_fixed_point_test_cases,
+};
+kunit_test_suite(iio_fixed_point_test_suite);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("Test IIO fixed-point functions");
+MODULE_LICENSE("GPL");

---
base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
change-id: 20251010-iio-tests-fixed-point-new-kunit-5a0d3eb19865

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


