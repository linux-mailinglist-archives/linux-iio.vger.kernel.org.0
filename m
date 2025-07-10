Return-Path: <linux-iio+bounces-21537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F45B0099E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C423AF0FC
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833F2F0C50;
	Thu, 10 Jul 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnhQe0pU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190FC21CC56
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167482; cv=none; b=BrqMeyPfSQRlBadQ0Ws7hzKHtejFh4hnaqQ3X04nKTLR7MqeBvhKijJdeP/T/k202nL/Re2LYLkKTfzZzssvlaMofXWU3KlkO4/kNRhLo3zDgKRSCY+sheO1rEhCFBRZnrF+Es42s/uXuRbiusoUO/IEdf2Qj5W1osKXZc5Odcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167482; c=relaxed/simple;
	bh=/wqJ1noMNLIvSflO+t7Fu11RF8Ng0xG8LO3LHP/l6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZxLXFRFoukfaRwXj0jh8juRjRLfk67fzRRIleiJtFjkP5U8XENVNyygung0D/7d9T8nJ+lxvQqhyOcc86jcHIx5mlCf/ZCzV+p5M6GCS7JZ+rpxmeDuCG6hVYf+9dIZXDs+ySx+FkZPYpbUbCNaQMjemUft65/6fVd0B4SGmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnhQe0pU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7630C4CEF6;
	Thu, 10 Jul 2025 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167480;
	bh=/wqJ1noMNLIvSflO+t7Fu11RF8Ng0xG8LO3LHP/l6JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnhQe0pUWzWhygyFGKKBnxvoKHL/Ot1EwZtaID+jvW+pRwaXHz7UXXg7PhFJ32XTG
	 GjEZEnmNvRYXU5b6YvWRsYfftFmhW59vG2TPkExkCQeP70zDMcpLRco1NT/j4a521T
	 xlURqI3n2mueMSNg0Y3bcvsgWU/EuX+BTBJhEh+DNLDL/iI0gVbrImmLTA5UIiW7Cz
	 kdpHHdlzW5/d6+BpqHOj1Ox5MxFDEMhZd9i/pNG+tcaMc9AHaBoQkaqCP8iPWTfLoV
	 gr0s7uZwzH/a0qoWGUobLLATNHF7SB7gVS7YzPGsnhloqU5M04A08kd3aMuE6YW+Bg
	 irhqizIaPZ2Bw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/7] iio: pressure: bmp280: Apply iwyu principles to includes.
Date: Thu, 10 Jul 2025 18:11:01 +0100
Message-ID: <20250710171107.443790-2-jic23@kernel.org>
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

The recent introduction of a warning on missing include of
linux/export.h when W=1 motivated revisiting the includes in affected
drivers.  In general IWYU principles avoid complex include paths that
make it hard to refactor headers.

- Move linux/unaligned.h entry to appropriate place.
- Drop comment on linux/irq.h as we don't generally keep a record
  in code of why includes are there.

Remove
- linux/device.h from bmp280-regmap.c as struct device forwards definition
  is enough.
- linux/module.h from bmp280-regmap.c as the module stuff is all in the
  other files.
Add all of:
- linux/array_size.h for ARRAY_SIZE()
- linux/device.h in the i2c and spi drivers
- linux/err.h for PTR_ERR() etc and also assume includes errno.h
- linux/export.h for EXPORT_SYMBOL*()
- linux/jiffies.h for msecs_to_jiffies
- linux/log2.h for ilog2()
- linux/math64.h for div64_s64
- linux/minmax.h for clamp_val()
- linux/mod_devicetable.h for spi_device_id etc
- linux/mutex.h for various mutex calls
- linux/pm.h for pm_ptr()
- linux/stddef.h for false / true
- linux/string.h for memcpy
- linux/string_choices.h for str_enable_disable
- linux/time.h for USEC_PER_MSEC
- linux/types.h for local bool definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
I'm not sure on whether we should bother with stddef.h or types.h
Looking for feedback on any others.
---
 drivers/iio/pressure/bmp280-core.c   | 17 +++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c    |  4 ++++
 drivers/iio/pressure/bmp280-regmap.c |  6 ++++--
 drivers/iio/pressure/bmp280-spi.c    |  6 ++++++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..e5d2de8cd5ef 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -30,23 +30,36 @@
 
 #define pr_fmt(fmt) "bmp280: " fmt
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h> /* For irq_get_irq_data() */
+#include <linux/irq.h>
+#include <linux/jiffies.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/random.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/stddef.h>
+#include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -54,7 +67,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/unaligned.h>
+#include <asm/byteorder.h>
 
 #include "bmp280.h"
 
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 8e459b6c97ff..6484341af710 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #include "bmp280.h"
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index b6a7b417c8cf..d34bf89afdda 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/device.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/regmap.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 #include "bmp280.h"
+struct device;
 
 static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
 {
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 3b90384f17d7..8ac68bfb8110 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -5,10 +5,16 @@
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
 #include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include "bmp280.h"
 
-- 
2.50.0


