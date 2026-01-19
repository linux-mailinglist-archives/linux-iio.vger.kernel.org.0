Return-Path: <linux-iio+bounces-28013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65ED3B999
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D9A5300A53B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111630FC18;
	Mon, 19 Jan 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azbqQFwm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FB3090F5
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857704; cv=none; b=KSy05SXx+mUq5yA2D6T8k+boI06etlPn828PvYcLmwrYPx2+QSZRfL3p3Oex7keIRu28KOncBeqx4L7rSIEeGWUPyX59/CvWA8LIQEa6aG6ycpyYFojl2PD8SXxmJ52VJ9SIfiSqDkEHwnsAT8cKdXjryDPtqBApt9H59hibqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857704; c=relaxed/simple;
	bh=nMfrjRZOAiBpPn+QojOpjVIOdjTq9jf6GfD5ViWXeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myhPDY/8/xOY7S+dhDOwUGyC0rMbE5I732Sdj59sEVacHSwya2O5iSkV0amMjvIajR09E45U98W6u217lRA6EPeFZBcWFWu5UDwYhTELPOyrqSDXQP4sArv0p4HVJ2a9pzwRJoxpcvJe8jVkmc14ktSSehmZaDmWUGFDpDhgdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azbqQFwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143A0C19425;
	Mon, 19 Jan 2026 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857703;
	bh=nMfrjRZOAiBpPn+QojOpjVIOdjTq9jf6GfD5ViWXeOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azbqQFwm/G2RKmymPg4Av1TlIE8aZr3beCMIr9hsCbiBhAJ7UoE5fsNIWAyfZc72G
	 BFN6LrVsFtxm9GIBvnkQjb6olx1Ec/KQDe8/XorAYsjuSZOCJzEGWX2k8eJ92EIwFW
	 zzysDbzBBIUMJbGv0Vdq7H/Oz8oXbVNSdBreeIN7Dsgt9dE/bwPCWOoLX2VF/AFP68
	 /59hJ1fJj7IVdOcNCbnGHmjyhWRfvq5IodiMpN6r1pG233oCNKPRxBHxeLZ0P2v6zt
	 P/3hJpVym/oEoA34HiXcTIjdVpwdh6u8x8kfqBF6filxYj3wokkWpE0Czbcr8+51eP
	 u406dTIK/mCfA==
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
Subject: [PATCH 04/11] iio: adc: max1027: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:03 +0000
Message-ID: <20260119212110.726941-5-jic23@kernel.org>
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

Drop kernel.h in favor of more specific headers and add includes that were
previously relying on other headers including them.

Whether to include device.h or the relevant sub headers is non obvious.
In this case, there is an access to struct device for
spi->dev.driver->name which is used to name the irq.

The justification from iwyu for the additional includes is:
  #include <asm/byteorder.h>           // for be16_to_cpu
  #include <linux/array_size.h>        // for ARRAY_SIZE
  #include <linux/bitops.h>            // for BIT, GENMASK, fls, hweight32
  #include <linux/cleanup.h>           // for guard
  #include <linux/compiler.h>          // for __aligned
  #include <linux/completion.h>        // for complete, init_completion
  #include <linux/device.h>            // for dev_err, dev_name, devm_kmal. ..
  #include <linux/errno.h>             // for ENOMEM, EINVAL, EBUSY, ETIME...
  #include <linux/interrupt.h>         // for devm_request_irq, irqreturn
  #include <linux/jiffies.h>           // for msecs_to_jiffies
  #include <linux/minmax.h>            // for __cmp_op_max
  #include <linux/mutex.h>             // for class_mutex_constructor, cla...
  #include <linux/stddef.h>            // for NULL, false
  #include <linux/types.h>             // for u8, bool, __be16

stddef.h not directly included as few drivers do this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 913665b52cea..22d90efc9ab6 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -12,11 +12,23 @@
   * Partial support for max1027 and similar chips.
   */
 
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -24,6 +36,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <asm/byteorder.h>
+
 #define MAX1027_CONV_REG  BIT(7)
 #define MAX1027_SETUP_REG BIT(6)
 #define MAX1027_AVG_REG   BIT(5)
-- 
2.52.0


