Return-Path: <linux-iio+bounces-22671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D31B24D2A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A80C1885B4D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8891FF7B3;
	Wed, 13 Aug 2025 15:17:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152B1FCFE7
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098223; cv=none; b=HrQyoDPbwTXr6rGKwHfpkH5n2KN8r3cwKl2ZcuQH7oNYakc4P7Iz9rDDs9XN/6dABqSiK/pOliS5NSyhQpm1wN9sHJm9vxL+4CJF54/75Xm4uydv2Gj6CKnYWukdCeHTJt15QoFGLldz2ONdFZwfIIfKp208jFLon+kPeyTBXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098223; c=relaxed/simple;
	bh=LrU1HXlWYSGlX5/KXl/fR1v6tXQMiHM71bAN8ddqq2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxtQv1ao8K+s65N/5IsYa+HVPp6c8QeQSLf1cCE1p6J6SRRbBxFJmCGVbIw6xSmXsbVeNoUVB9Wy+t8a7sKecnnfjhEu6ssaGoZGTOsFm7JKp9YeFlVbw2+TMnbUhyfrm03WCd9IchpXTyuIEoWYw0lg/WIB1etpz2NXuI44H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
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
Subject: [PATCH v2 2/5] iio: mcp9600: White space cleanup for tab alignment
Date: Wed, 13 Aug 2025 15:15:52 +0000
Message-ID: <20250813151614.12098-3-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-1-bcollins@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
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
 drivers/iio/temperature/mcp9600.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 6e9108d5cf75f..d53703c089031 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -23,8 +23,8 @@
 #include <linux/iio/iio.h>
 
 /* MCP9600 registers */
-#define MCP9600_HOT_JUNCTION 0x0
-#define MCP9600_COLD_JUNCTION 0x2
+#define MCP9600_HOT_JUNCTION		0x0
+#define MCP9600_COLD_JUNCTION		0x2
 #define MCP9600_STATUS			0x4
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
 #define MCP9600_ALERT_CFG1		0x8
@@ -38,10 +38,10 @@
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


