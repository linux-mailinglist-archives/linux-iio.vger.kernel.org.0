Return-Path: <linux-iio+bounces-28011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8CD3B9EC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369853135BE0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E173002B6;
	Mon, 19 Jan 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgB4rz/W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AB2FF154
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857695; cv=none; b=CgGFcTzk2gmGFIcmwP6g5yClQOc7C1myNfMilm0Hw05Gteo8L/HqMP11PnCSGHq6pglcEWESg73Kna2X4PWPn+geS4z3421R4jow50JUHaqhGlsIMmYRMRuXsH+XK/Phl1M5BpN0Ok8tePb07lQJn/DgJnC5+qEtzbw0GHiSLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857695; c=relaxed/simple;
	bh=J/dUZsVwlHcCMTscO7bVoET6nNcSEkzxIpms9ZIkOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9lSXrA4+auaHAQvHhInUc8LJA2cC9wqNrt1Zz08ynFHFgWWsU6EjjWVApEpr9w2TBvaFY0R9TpoS3tUjhpFsrKk7oIOYLaMPDCCQ8XmDc/GQLTHgr3JpDu6urLPIwt3Ai9bfvKbjHrKpenah73BT9Gj/E5hUkOxelQ5eHlvq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgB4rz/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E737C116C6;
	Mon, 19 Jan 2026 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857694;
	bh=J/dUZsVwlHcCMTscO7bVoET6nNcSEkzxIpms9ZIkOCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgB4rz/Wjxeris68HIJWpncMlShoIaT31QvoAFlCBd041/MJqCqKgFl6DJRRdWjqA
	 hyvQzdBjxhty75BZg546Wqds8g8CmZ8EeqYIUE/thzoajgSCc5icj6uvGi8tM7CxI9
	 UUyAMotEcM/US17md72+gSW1KxlS2l6m+s9SDKUA5D3004KtfhY0cfQoCdKRoAOWEq
	 61HZJ84XM4R/ogiTk9cjis1gCHEmXDFmaAWjryl0Ic+BwoNSmLSTG+R0VbZztzyC1K
	 mDryIk6/l5UK5iOaodybFneIAGlqxqFfGPM8egpglbYs1EuGtcME/wll8+e2cNAPk4
	 Z/XiWbqNaAT/g==
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
Subject: [PATCH 02/11] iio: adc: ltc2309: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:01 +0000
Message-ID: <20260119212110.726941-3-jic23@kernel.org>
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

Based on output of iwyu, drop kernel.h in favor of more specific includes
+ add some others that are only indirectly included from other headers.

Justification for additions:
  #include <asm/byteorder.h>         // for be16_to_cpu
  #include <linux/array_size.h>      // for ARRAY_SIZE
  #include <linux/bits.h>            // for BIT, GENMASK
  #include <linux/dev_printk.h>      // for dev_err, dev_err_probe
  #include <linux/err.h>             // for ERR_PTR, EINVAL, ENODEV, ENOMEM
  #include <linux/mod_devicetable.h> // for i2c_device_id, of_device_id
  #include <linux/types.h>           // for __be16, u8

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..2838e0a9858c 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -7,13 +7,20 @@
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
 
 #define LTC2309_ADC_RESOLUTION	12
 #define LTC2309_INTERNAL_REF_MV 4096
-- 
2.52.0


