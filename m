Return-Path: <linux-iio+bounces-28017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C246D3B9D2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D8FC3082ECA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47522FFF82;
	Mon, 19 Jan 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjnPxnLr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEA2FC009
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857722; cv=none; b=nzrykOdXQ6Wc9i5Zgwb22+2t7EVfqQnEn1Vy+dJKH3sNd8GmewGDdI+Il3OT4c4Qzf/5ZyFGgObM+UXb6+6w4Et4kVgSwdyCMa6Bg6f3/XYfEwmNqrERzw3wr3EL6KJpWjv8IWcRs6/TdcnVWCOEb6XH2AnHbLcRMcZWsIkh9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857722; c=relaxed/simple;
	bh=d12t4z97iDhXKaRjUPouj4Z0ea+Ht3U8SBAHNSxm3fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjjvj05ERCZ8t2dKcSXl1iz9WUkRXwenDKYjMqicx/E4RY0e6Ns8F7rGKuT9Jwu6FGxmQz+pxvsy9TdP1QhgzeI6vn18/tGrYBz5FBdrekbWJknui0ItWM0Aj5D4j4EVkOVYooc6LfYht3D0GulpBjLsZWUsEjFn1fjthe48TdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjnPxnLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE49C116C6;
	Mon, 19 Jan 2026 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857722;
	bh=d12t4z97iDhXKaRjUPouj4Z0ea+Ht3U8SBAHNSxm3fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjnPxnLrk2zUox8R0g15J2P1P/LW7qeMrRyyzzIGUd81TKrCSKDd+GDNGTjyrhqjN
	 qOSog8/JYTk4icx/ny2VewqI7a+Z5UQ4vIKh8ObBkZaE/WytlPTHNs9ljoVZg1Dl/W
	 XQHuwUAfP1X62IJRjTKTRd+dsSVhirxpNu/9JFjBIlayFncrBsOWN9HWIQw5229F1b
	 o7U/nIDmxaDl+LkMDq5VmZpWdOU8X9gKkilNLimbfBvzdPX4nulkHt/jR1hjDVGGQ/
	 vZghZXRTvrTxqEcmkroHfUXMt+Uzj2BiBQL0l3jj2d97bau97dJDJkB45+G3zxqU7w
	 URToCvGOEW/PQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/11] iio: adc: ad7124: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:07 +0000
Message-ID: <20260119212110.726941-9-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119212110.726941-1-jic23@kernel.org>
References: <20260119212110.726941-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Drop unused linux/kfifo.h and linux/iio/sysfs.h.
Replace kernel.h with more specific headers and add other missing
headers that should be directly included to follow approximate include
what you use principles.

Justification for new headers from iwyu:
  #include <linux/array_size.h>          // for ARRAY_SIZE
  #include <linux/container_of.h>        // for container_of
  #include <linux/kstrtox.h>             // for kstrtobool
  #include <linux/limits.h>              // for U32_MAX
  #include <linux/math.h>                // for DIV_ROUND_CLOSEST, abs
  #include <linux/mutex.h>               // for class_mutex_constructor
  #include <linux/slab.h>                // for __free_kfree
  #include <linux/stddef.h>              // for true, NULL, false, struct_...
  #include <linux/types.h>               // for bool, u32, u8, size_t, ssi...

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5c1a8f886bcc..5d3be891fa7e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -5,30 +5,36 @@
  * Copyright 2018 Analog Devices Inc.
  * Copyright 2025 BayLibre, SAS
  */
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/container_of.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/kfifo.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sprintf.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
-#include <linux/iio/sysfs.h>
 
 /* AD7124 registers */
 #define AD7124_COMMS			0x00
-- 
2.52.0


