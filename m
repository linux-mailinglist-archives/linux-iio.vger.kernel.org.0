Return-Path: <linux-iio+bounces-22772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B9B28451
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE8C5E171A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F9D321430;
	Fri, 15 Aug 2025 16:47:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE49318133
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276446; cv=none; b=jyOEUZ0VUk6+m40/z3P8aBJZ0glHE67Gr4g77RmC64GKzD/uV2XnQxWbToj+KZXdA0CDyK2mJUPgLWkRvZC7Yb2gVS/W9YJzfbe5K39YknWCblh57es9t6TtjwJOp6wAxt6MzYEyE1Nro30V89DjYzc2jvWOUB2FAzr5kDmyenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276446; c=relaxed/simple;
	bh=XK3DvObCm/cHrJ9SCiv00FHMKYRwA9K0Nf+eXF8ZWes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVZJigTshAm4+Gs212ooZR4yY7OCHQTLklcZshhsshL/OrMV5MzkmXJBmgxJ9ynnH35FStzHztSNAJ9oDLrCynKXjeNnzNmK7U4mtn0rEZSK0kzhAxi4TRW7RNJkvSrqmFPNvjlqtY+65Um0ZR+/COdaXkUoFwXINFWNKAo3ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: mcp9600: White space cleanup for tab alignment
Date: Fri, 15 Aug 2025 16:46:04 +0000
Message-ID: <20250815164627.22002-3-bcollins@watter.com>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Purely to align tabs for #defines.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/mcp9600.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 6e9108d5cf75f..40906bb200ec9 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -23,25 +23,25 @@
 #include <linux/iio/iio.h>
 
 /* MCP9600 registers */
-#define MCP9600_HOT_JUNCTION 0x0
-#define MCP9600_COLD_JUNCTION 0x2
-#define MCP9600_STATUS			0x4
+#define MCP9600_HOT_JUNCTION		0x00
+#define MCP9600_COLD_JUNCTION		0x02
+#define MCP9600_STATUS			0x04
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
-#define MCP9600_ALERT_CFG1		0x8
+#define MCP9600_ALERT_CFG1		0x08
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
 #define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
 #define MCP9600_ALERT_CFG_FALLING	BIT(3)
 #define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
-#define MCP9600_ALERT_HYSTERESIS1	0xc
+#define MCP9600_ALERT_HYSTERESIS1	0x0c
 #define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
 #define MCP9600_ALERT_LIMIT1		0x10
 #define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
 #define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
-#define MCP9600_DEVICE_ID 0x20
+#define MCP9600_DEVICE_ID		0x20
 
 /* MCP9600 device id value */
-#define MCP9600_DEVICE_ID_MCP9600 0x40
+#define MCP9600_DEVICE_ID_MCP9600	0x40
 
 #define MCP9600_ALERT_COUNT		4
 
-- 
2.50.1


