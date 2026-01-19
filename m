Return-Path: <linux-iio+bounces-28016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4BD3B9E5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A29E313F123
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280102FC000;
	Mon, 19 Jan 2026 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFuFOt6/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5012F90DB
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857717; cv=none; b=JrDSBPoJJD8YVqU95s/W+ArrlQ8uG2CvSlja8qZdLIYP/Ng1r/cbpVcz0VJ/7rd2NBb53L6k8Ftqx77IjUg6A2s/0lDKPOvAxelxXbIL3TqjTeb+HTELhlu1NO8DlwkNz5StvLCwYwh8LYrly0sHDR8joIXs8NFInCiDea5YNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857717; c=relaxed/simple;
	bh=ZjFOqik0o6rQoT1UY2AskVPEAMalY/JsyzYKxddV3pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0VUc8VYcGLwGmDBPUs84nPFfyhAiX8jeEgXZic61Zze5OgOkHXsBUO2oupadtN9ErANjV4NRQ2Yrut2YtCWf0BE4VuqR0cO41M/BwhUtEyDLEw9bDysMyL1w/NkzUeatqCTiRjbv36fEA9qwhpqtzV2EKwxHK4Wx1K8NdjJyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFuFOt6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BDBC116C6;
	Mon, 19 Jan 2026 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857717;
	bh=ZjFOqik0o6rQoT1UY2AskVPEAMalY/JsyzYKxddV3pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFuFOt6/8M6scGeGq3XLrU7ip96InflaoFTb5aF7qy+pc9MoMHbBy5NSkCFkjl4pQ
	 5vlwtlgfMl/i2fIgni0fX8Vb4dHfcc01MmBFcN7LEKKTDGp0SyZJOPuvEhZEuGZVdg
	 4xX7BTDoYiJ+/mM5X1O4W+XSWuvRdDwkqDprs5EWDtfSJLKzhpWSkY1R6JFq+Z8jjE
	 eo/DMzWJM/kuyzyNVIbKta5L7GB/QttXyb93h/Fwlz7aqH2vS8wFFe+72HbkL3c3Lw
	 KPgp1EgHS0SOCOoCc1gY2D3OMeWzV1tBSWlEVS0mrVsnNfRurbPEUzRCTaq8YzRy9T
	 bkU1Hx431Lx6A==
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
Subject: [PATCH 07/11] iio: adc: ad4130: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:06 +0000
Message-ID: <20260119212110.726941-8-jic23@kernel.org>
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

Replace asm/div64.h with linux/math64.h and drop kernel.h in
favor of more specific includes.  Also add some others that should
be directly included to follow approximate include what you use.

Justification for new headers from iwyu with a couple of comments where
this deviates from recommendations.

  #include <linux/array_size.h>      // for ARRAY_SIZE
  #include <linux/bitmap.h>          // for for_each_set_bit
  #include <linux/build_bug.h>       // for static_assert
  #include <linux/compiler.h>        // for __aligned
  #include <linux/completion.h>      // for complete, init_completion, rei...
  #include <linux/container_of.h>    // for container_of

  #include <linux/init.h>            // for THIS_MODULE
Ignored this one as seems reasonable to assume module.h will always include
whereever that is!

  #include <linux/jiffies.h>         // for msecs_to_jiffies
  #include <linux/math.h>            // for rounddown
  #include <linux/math64.h>          // for div_u64, div_u64_rem, DIV64_U6...
  #include <linux/minmax.h>          // for __cmp_op_max
  #include <linux/mod_devicetable.h> // for of_device_id
  #include <linux/mutex.h>           // for class_mutex_constructor, class...
  #include <linux/of.h>              // for of_property_read_string, devic...
  #include <linux/stddef.h>          // for false, true, NULL
  #include <linux/string.h>          // for memcpy, memset
  #include <linux/stringify.h>       // for __stringify
  #include <linux/sysfs.h>           // for sysfs_emit
  #include <linux/types.h>           // for u32, bool, u64, u8, ssize_t

  struct fwnode_handle;
Ignored this last recomendation because I think property.h can reasonably
be expected to always include whereever this is.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/adc/ad4130.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5567ae5dee88..745efefb7f35 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -4,8 +4,14 @@
  * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
  */
 
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -15,16 +21,24 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
-#include <linux/units.h>
-
-#include <asm/div64.h>
+#include <linux/stddef.h>
+#include <linux/stringify.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-- 
2.52.0


