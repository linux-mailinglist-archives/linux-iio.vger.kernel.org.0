Return-Path: <linux-iio+bounces-28020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B3D3B9E8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B4F30B0979
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E52FC011;
	Mon, 19 Jan 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6fbeEZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34782E8B9F
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857736; cv=none; b=jMn+BWxrYMdPK/La9Vu8GHtADABMJpL6g26TWtsfa3Rjp39aM/evPDc3aq5QL7cLxJf4/jz670K9xDiKpSRZl1iTX+fyv99kO8iFrYay3MeTecHxCctWnA63TmS0K9ycQvYQKyPn1Wb5VXN507RWdTPaPY+roc8XsZidEwo3U6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857736; c=relaxed/simple;
	bh=FQP3fQCOeGJI6rRlF8TZyHFJ8pX5So03MY79KVm4yDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu+weYd5T4J6I4j9ExeYm29/oSEb2uQVIiPBUK0t+tOUSLHLk0pNBfXFh09ZmvwYyvyfbRsJcVkChiZRNnqxpwRtPLD5MmrGuWujbLOxI8/vJ4FLka1QUwc+qeYuqpVUD38z/nnsOFUS+AC0u3PnFvgTRHGZPsaPWBONJs7j/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6fbeEZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA5C116C6;
	Mon, 19 Jan 2026 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857735;
	bh=FQP3fQCOeGJI6rRlF8TZyHFJ8pX5So03MY79KVm4yDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6fbeEZsg9ZBJHoGVGjz8nU9Adf/HGqWkYODYYlAUJ03OtCpyAWHDKoLqVXGlz59B
	 UvG61OzYYDDDzS6EX0mUQZN+lsimat/RXMaGFHA5I3ujBbvdSpEIgk8s9FRSjszIV4
	 Mcqp00Daq8ebOGBy8VEkPfJM2U86naLrrfRERsaT4rbMkrcIz+5LfD1nA5eF+opJo/
	 jrZcUmz/u7Lfgwc8CXXT/f/6q5KuAxz1UboI4uxGa9guckJBnSBgGnH4nF0OvkbAsP
	 dMvNTyehMecUs7UaJt1+h3y9LOWt8hAgYB6ZlDAJ39K2gJE7s2/oItaz238qnEA4ll
	 4MrhkuGPYeWmA==
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
Subject: [PATCH 11/11] iio: adc: ad7192: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:10 +0000
Message-ID: <20260119212110.726941-12-jic23@kernel.org>
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

Drop unused:
  #include <linux/iio/buffer.h>  // lines 29-29
  #include <linux/iio/trigger.h>  // lines 30-30
  #include <linux/iio/trigger_consumer.h>  // lines 31-31
  #include <linux/iio/triggered_buffer.h>  // lines 32-32
  #include <linux/sched.h>  // lines 20-20
  #include <linux/slab.h>  // lines 15-15

Replace kernel.h with more specific headers and add missing headers.

Justification from iwyu for added headers:
  #include <linux/array_size.h>          // for ARRAY_SIZE
  #include <linux/bitmap.h>              // for for_each_set_bit
  #include <linux/bits.h>                // for BIT, GENMASK
  #include <linux/compiler.h>            // for inline
  #include <linux/container_of.h>        // for container_of
  #include <linux/kstrtox.h>             // for kstrtobool
  #include <linux/limits.h>              // for U32_MAX
  #include <linux/math.h>                // for DIV_ROUND_CLOSEST, DIV_ROU...
  #include <linux/math64.h>              // for do_div
  #include <linux/minmax.h>              // for in_range
  #include <linux/mutex.h>               // for class_mutex_constructor
  #include <linux/stddef.h>              // for true, NULL, false
  #include <linux/types.h>               // for bool, u32, u8, ssize_t

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>
---
 drivers/iio/adc/ad7192.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 6b48581d7606..24e1fa796829 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -5,31 +5,37 @@
  * Copyright 2011-2015 Analog Devices Inc.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/compiler.h>
+#include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
 /* Registers */
-- 
2.52.0


