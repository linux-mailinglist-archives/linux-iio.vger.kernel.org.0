Return-Path: <linux-iio+bounces-22884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA4B29773
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314F44E3C67
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CC26057F;
	Mon, 18 Aug 2025 03:51:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAC25C81B
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489075; cv=none; b=byuLaH8aahNLfQ4X72eBvCQlkxcZz6Oh6yOYmUTGTyZeo2r2GHDpu0XRuSYvSeglPLFbB4tgqdloBoL/Dl+ixyXLga0DgzhrBsUkWtLdIrplL736Mi0ix7q5ljFVSJHMgQqu5+cV/FqmvLkEyFgb8mtwAOD6bRhaxwMMB48JfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489075; c=relaxed/simple;
	bh=CyrpwmolcFtAHLh2gWJ+sztqI6U8uRkgOwenclMzxq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fm8WipCf70cpQxY6wyMMvhfttYEOwm5FiS0t9LrZhdGhkybB4hNnxagCUj3k+47f26eHVLZZkVKgNcyz1X+8kh0JHYEMgDAKmAAExXbuNkpmEFg5VZB8S1YmdN6Zkcq7zKJPeeUcrpCvKK0qGx79kCl6M74PCAbvTyi/0C2O4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
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
Subject: [PATCH v4 2/5] iio: mcp9600: White space and fixed width cleanup
Date: Sun, 17 Aug 2025 23:50:50 -0400
Message-Id: <20250818035053.32626-3-bcollins@watter.com>
In-Reply-To: <20250818035053.32626-1-bcollins@watter.com>
References: <20250818035053.32626-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make tabs consistent for register definitions and also fix width
to byte size.

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
2.39.5


