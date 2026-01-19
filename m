Return-Path: <linux-iio+bounces-28015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E3D3B9D0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 824DF30827FE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB92C11E1;
	Mon, 19 Jan 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hribfq3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4822FAC12
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857713; cv=none; b=UNmbhaMW9r9ObHKOJJCXbF9uC6mVcVACm1XvOZLyMUiHIhQp0aBJ/j6/ydGaUWBe0bqUHrTKjcs8IEyIPqLNXNsuc4vDW2N2cgXvlBpM4jeobYxSAaAwhmdw4fgYXL2RevfxQFW7jcD1kjnpcsesE0AONXDVC6q45u7syJA96Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857713; c=relaxed/simple;
	bh=FdSO5wpQATGLHDpytquCGXO+KI/DQ8qJRt5u4ewqpJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBpzO8n0xzdLrwMP8v/jCRQwy0/43ruVWyKaKqFG04r3u4C6mDNQxRKYlu+CleomBAydn7RuzMaIbfQZ6TTwdtwwOF5LVcPiNyaKGykXbucrdlh9GMNwzETecnIt1mdIT1SHQsdC+dc9dYraZYkBKgVK7KaqZbJwb4yf/Q8mO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hribfq3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7115C19422;
	Mon, 19 Jan 2026 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857712;
	bh=FdSO5wpQATGLHDpytquCGXO+KI/DQ8qJRt5u4ewqpJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hribfq3wlxMvAW0Hu3MIxLvx1JvBcmnHo1Nw51OAxVk2QSDzu1BTO+e3fm6QrH+5N
	 Efe5SnLIvK3S9la5LjnOQXoThIwJACpXohiuD+3FNJAd0aZAkyryj9o/8Y1EwhkvNJ
	 YveUcUeOFtnjni6J77qDvhH4XBeoHyzL6Pjmk6RYMbY36PNLxa/MyxenrLNmXzpvtO
	 mO7alyeGx38ayDuDzcnvbx3aHNn3wpocjBCId3OCgSEObeuSq2/oeBKy/pXDN+ESxz
	 QQGPKetZwIxgQAGSeHrVA570N9EzApkF6lvKoten+FRuRpcMRXNr2r2iSA/XJCc6p5
	 KHIlTglLXi2KA==
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
Subject: [PATCH 06/11] iio: adc: max11410: Improve relevance of includes
Date: Mon, 19 Jan 2026 21:21:05 +0000
Message-ID: <20260119212110.726941-7-jic23@kernel.org>
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

Drop kernel.h in favor of more specific headers and add other headers that
were previously only indirectly included. Also add a forwards definition
of struct regulator as it is only used as an opaque pointer type in this
file.

Justification for new headers from iwyu:
  #include <linux/array_size.h>        // for ARRAY_SIZE
  #include <linux/bitops.h>            // for BIT, GENMASK, __clear_bit
  #include <linux/cleanup.h>           // for guard
  #include <linux/compiler.h>          // for __aligned
  #include <linux/completion.h>        // for complete, init_completion
  #include <linux/iio/iio.h>           // for iio_chan_spec, iio_chan_info...
  #include <linux/iopoll.h>            // for read_poll_timeout
  #include <linux/jiffies.h>           // for msecs_to_jiffies
  #include <linux/kstrtox.h>           // for kstrtobool
  #include <linux/log2.h>              // for order_base_2
  #include <linux/math.h>              // for DIV_ROUND_CLOSEST
  #include <linux/minmax.h>            // for clamp_val, __cmp_op_max
  #include <linux/mod_devicetable.h>   // for of_device_id, spi_device_id
  #include <linux/mutex.h>             // for class_mutex_constructor, mut...
  #include <linux/property.h>          // for fwnode_property_read_u32
  #include <linux/stddef.h>            // for NULL, true
  #include <linux/sysfs.h>             // for sysfs_emit, attribute_group
  #include <linux/types.h>             // for u32, u8, bool, ssize_t, alig...
  struct regulator;

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 drivers/iio/adc/max11410.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 511b2f14dfaf..c8a9718c4e4b 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -4,20 +4,36 @@
  *
  * Copyright 2022 Analog Devices Inc.
  */
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/kstrtox.h>
+#include <linux/log2.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
-
+#include <linux/stddef.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
@@ -130,6 +146,8 @@ struct max11410_channel_config {
 	bool buffered_vrefn;
 };
 
+struct regulator;
+
 struct max11410_state {
 	struct spi_device *spi_dev;
 	struct iio_trigger *trig;
-- 
2.52.0


