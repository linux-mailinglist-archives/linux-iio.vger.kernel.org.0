Return-Path: <linux-iio+bounces-28010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A75D3B9C3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A0953071544
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6142F9DA7;
	Mon, 19 Jan 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjORDT1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39E2FC86B
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857690; cv=none; b=m/hxwR7sR9fGX9JfCL9BXJMQSqt8WtPmY8SEZMtrO+iNzkes0PwazkffvKEup7biGZo1PNcdsth0FxxwCZ4S4a/560IBmhX1bXn5KFnRDyS7l1KnITRvkyBo8rNXPxybjsEewcnjIv4p7gSVrdkiTFWUgE80H+2dRhAFtrSXTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857690; c=relaxed/simple;
	bh=s3eCk50+DXZDkZTC4g+bYMVmxDkPXKdx9LrTCrown38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEe2i+n6yrDW5fsRDWklh0cWU7Lw4LOrqfp90ziI8IQ+AZ6/Tr7VuotAogLSEKivM7N4C/9u6NsfkSl6FCp2z7y6aC4VvWtm5WVKdaZzvYfVH4jU5ry9LnvxKHGKiNtl525zqqgGzKthZcm4BLWYXrfI7ki9Sx5AIlwEV5R0Tj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjORDT1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FD1C19422;
	Mon, 19 Jan 2026 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857689;
	bh=s3eCk50+DXZDkZTC4g+bYMVmxDkPXKdx9LrTCrown38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjORDT1LfYblwOU0N4fT9HoUeB27nsjefCBmY3A+zM9DD0D4wB8u30ADObeI0wkDx
	 5qqg9tDZxEOhE5aXwaXhongOusmuTWtDZ4JMsCOkIs+02h/Cr7v5GW5wA9716Xc0DE
	 Ce77P0Ls3Rm51ejRz+/v1LV5lTaa2XzAjy+aOuMdtdrtdNASYjVZcwJYuNx61/ktyP
	 NSen+KDDhWF3u2t0YOQiImVoWccLgBiWd7mR4hKefjlfEIhgoiRiNoeOtK4Of/RUJD
	 aPADVa+b6DCVm4KfakOc4IXmuPCMWHt2HL1bo0uqE2KUxPFAOJtjgLujYu+ZqWsmxR
	 x9yOXhz2qtDUQ==
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
Subject: [PATCH 01/11] iio: adc: ltc2471: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:00 +0000
Message-ID: <20260119212110.726941-2-jic23@kernel.org>
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

Based on output of iwyu drop unused iio/sysfs.h and replace kernel.h with
more appropriate includes. Add some other includes that were relying on
being indirectly included from other headers.

Justification for added includes:
  #include <asm/byteorder.h>          // for be16_to_cpu
  #include <linux/bits.h>             // for BIT
  #include <linux/dev_printk.h>       // for dev_err
  #include <linux/mod_devicetable.h>  // for i2c_device_id
  #include <linux/types.h>            // for __be16

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/adc/ltc2471.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index a579107fd5c9..d0ba1b3a6ca1 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -7,12 +7,16 @@
  * Author: Mike Looijmans <mike.looijmans@topic.nl>
  */
 
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+
+#include <asm/byteorder.h>
 
 enum ltc2471_chips {
 	ltc2471,
-- 
2.52.0


