Return-Path: <linux-iio+bounces-21538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44303B0099F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D213AFA10
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BD2F0C63;
	Thu, 10 Jul 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYJPAR4N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00F2F0C5D
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167484; cv=none; b=C0aa/h2m4JQ/fqbVCMd1IHU5c7btMOT2qSqZ7AOmTTgkumdBxKyGrgIf5GZuJHXm6lkIvu/7thcMw8mhszsLKmoXftp7U2uobUSg9Tq59No0VLHt1UJ9wGM+ta1Lj1nsd9aEoz3pmwMDjwj+9hamHlOMQf6Rqv+tXPGyhOsdpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167484; c=relaxed/simple;
	bh=YciJCzZOJzYFGbBr+jlTBzZOMkfuBseO48t1mFvzjBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxLMqC9KfxBFRSaj9eSG9O700QU8PazkgDKgH0/TtohRfOYTlvDY1GbKdrpn/AP0ak3GPNiZwEatT8ELIguJRtSqdjv6b0dNgpPyUY2i5LFnJb1msZ47QndUCmI3QJDpy2wBL3/Rj/02P5pR6itaL5xc0kNovSNIxA8frsblCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYJPAR4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452C1C4CEF4;
	Thu, 10 Jul 2025 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167484;
	bh=YciJCzZOJzYFGbBr+jlTBzZOMkfuBseO48t1mFvzjBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYJPAR4NQ/aRMi/8OxJTEqn1m6XvIU4WR6KbUX2+K+wFamOxE3F3bZT391iQos+y7
	 Rh90SJSl3vhx8NvkMoQ3m7TNZoBaK5D1aeiY3jmXVhg9nvmSXfTf37nYkHbfHWdmSy
	 uqYK+0bH016x8aKOqvRDT9nMfBVh6DeQd3L677yPqPLADznDeMZuzqHK5vJDhjZ259
	 BAgxPAVafHs06BMLVTC8xIfRmN+168rTQpUBgxy+aHa8YrN2QjmTzWQCVA3WeUlCyt
	 1ETszdoJlXyxHAd/Qlt2LQ1kUw/fMO62o+o5TLTmzIyiMgPFyhQ4fkhlsCJknh4gQo
	 guA9jpBfXKLNA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/7] iio: pressure: zpa2326: Apply iwyu principles to includes
Date: Thu, 10 Jul 2025 18:11:02 +0100
Message-ID: <20250710171107.443790-3-jic23@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710171107.443790-1-jic23@kernel.org>
References: <20250710171107.443790-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Motivated by the new warning when W=1 if linux/exports.h is not included
but the macros within it are used.  Given the includes need improving go
the whole way and apply include what you use principles to this driver.

Reasoning:
- First sort includes into alphabetical order, keeping the separate iio
  specific block and asm blocks as appropriate.
Drop:
- linux/kernel.h
Add:
- asm/byteorder.h for le16_to_cpup()
- linux/array_size.h for ARRAY_SIZE()
- linux/bitops.h for test_bit() (also BIT() etc in c files0
- linux/bits.h for BIT() in the header.
- linux/completion.h cof complete()
- linux/device.h for struct device
- linux/err.h for IS_ERR() and error codes.
- linux/export.h for EXPORT_SYMBOL*
- linux/jiffies.h for jiffies and HZ (in param.h)
- linux/pm.h for SET_RUNTIME_PM_OPS etc
  Note that the way this driver handles CONFIG_PM is messy but not topic
  for this series.
- linux/stddef.h for true / false etc
- linux/sysfs.h for struct attribute_group

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/zpa2326.c     | 20 ++++++++++++++++----
 drivers/iio/pressure/zpa2326.h     |  3 +++
 drivers/iio/pressure/zpa2326_i2c.c |  7 +++++--
 drivers/iio/pressure/zpa2326_spi.c |  6 +++++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 6eef37c0952d..34743ee0be07 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -51,20 +51,32 @@
  *   hardware samples averaging.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
-#include <linux/regulator/consumer.h>
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/stddef.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/unaligned.h>
+
+#include <asm/byteorder.h>
 #include "zpa2326.h"
 
 /* 200 ms should be enough for the longest conversion time in one-shot mode. */
diff --git a/drivers/iio/pressure/zpa2326.h b/drivers/iio/pressure/zpa2326.h
index 45bd7900975b..a1ab574241eb 100644
--- a/drivers/iio/pressure/zpa2326.h
+++ b/drivers/iio/pressure/zpa2326.h
@@ -10,6 +10,9 @@
 #ifndef _ZPA2326_H
 #define _ZPA2326_H
 
+#include <linux/bits.h>
+#include <linux/types.h>
+
 /* Register map. */
 #define ZPA2326_REF_P_XL_REG              (0x8)
 #define ZPA2326_REF_P_L_REG               (0x9)
diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index a6034bf05d97..ca05b84f420a 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -7,10 +7,13 @@
  * Author: Gregor Boirie <gregor.boirie@parrot.com>
  */
 
-#include <linux/module.h>
-#include <linux/regmap.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
 #include "zpa2326.h"
 
 /*
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index af756e2b0f31..14f8b2b809a0 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -7,10 +7,14 @@
  * Author: Gregor Boirie <gregor.boirie@parrot.com>
  */
 
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
-#include <linux/mod_devicetable.h>
 #include "zpa2326.h"
 
 /*
-- 
2.50.0


