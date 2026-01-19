Return-Path: <linux-iio+bounces-28019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA0D3B99E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1230300AADF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1EC2FBE1F;
	Mon, 19 Jan 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chr+nY0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E3C2FB99D
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857731; cv=none; b=UrK3qJ9pM1S9o8V9c2m1rC5wgFhw6SXHyhfdxZ0rwTJpvXm+66RA5w1fXrtLzVtgSU9iw+HooL240K7mlKlIq0NBPRJ/1DzMcRbW+lm+gnBTex4UdioJzQX0os4NO5v/bOz/zJu1r0MYW68AsTYzQS9TTe1kDw7zx1n1MKoTaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857731; c=relaxed/simple;
	bh=7Mgkgaa5NIOMZ7w+Hcwht/DGKrK/hqUHZQsJGR9aXu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6WnwC+ZDXf4PIGvKMhgU3RsJnt/saNg3ftPV9n/YR4CwkyFcdej8Y/4iOF7Mo3GZne3U3XEHjL0cdDR7RFj0jUWpQCbJzD/QMh2T4cNjmeJQDGLf0BMgtN6o3ctD8SN4BHEZSxtTSYvNnXzItdoKiUsX98jcd1jdkBjSK7r9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chr+nY0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C46C19424;
	Mon, 19 Jan 2026 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857731;
	bh=7Mgkgaa5NIOMZ7w+Hcwht/DGKrK/hqUHZQsJGR9aXu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chr+nY0qtbrpJDzWI9DIh6HV2RuoQqUF0GauDv6OhbhV91Q1ozqzWq74F0zyiN3BF
	 4nyGf88O+BUwg08tgW8SFNSYP/y1F5A6Nx9l8R5+iDiFNWziqTdYX8Kxn3IawgMHfm
	 gSsIMfyYzaKvOdVRtKk5WA/DsMW0i1Izc24iv+xrp8DW9KPwCyTunhhTxJPK6zoWBM
	 w2zJOG22QmhTQwzuxHdpscLDfB5gPZr1OIaNcvkAFxRJVSFhKpgUIy1XktfDjMOujU
	 PakA6BdaLlxAMpgDg3Ae+arzdxMTpN5zZdFGHHcu6ldCTy2EUk8BWvZR/Oeao1ulBf
	 8LE8JGwMTSpyw==
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
Subject: [PATCH 10/11] iio: adc: ad7192: Put headers in alphabetical order
Date: Mon, 19 Jan 2026 21:21:09 +0000
Message-ID: <20260119212110.726941-11-jic23@kernel.org>
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

Precusor to cleaning them up that makes it easier to see what
is being done.  Leave the iio/ ones alone as many of those will be
dropped.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>
---
 drivers/iio/adc/ad7192.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 530e1d307860..6b48581d7606 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -5,23 +5,23 @@
  * Copyright 2011-2015 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
-- 
2.52.0


