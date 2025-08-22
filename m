Return-Path: <linux-iio+bounces-23144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FEB31975
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C6A170319
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8D302CCC;
	Fri, 22 Aug 2025 13:24:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A233009E5
	for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869055; cv=none; b=csYON6L2CNCQyl5CHda4/IWxc/+FqI9ME5mtx6U7X325eHXFQAS57+nNQIO2zk0Eox7vEOMwib2xTvU1SilfqCelvtNhYtfYbFUEMNXglBUq+cwpd1BsXG2d91a4B9T6wJJQj3qnOl2XgtjlLNVlXRKpBenQ7ozCZqIF/WjodwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869055; c=relaxed/simple;
	bh=fDAVcwzg8PfisaO/909uIAOlBgoscfFwm3+npFTrxTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ps1XFEOf+JpxxqyVSO2tOWsrd/Q2rRQEkLtu4DckTUX9UL+/oTSingkEatO6NC27g1mgpjlJqiEOaVicXeVYLNQ9A2ZT449Q+rp0FY8K6EY+Vq/cKOBzjDX9KyK2c6vAGmtQH1XUlGbW9EZPd3Sy5naWM4Eb3IDym+r3hzkA+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Date: Fri, 22 Aug 2025 09:23:52 -0400
Subject: [PATCH v8 3/5] iio: mcp9600: White space and fixed width cleanup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-upstream-changes-v8-3-40bb1739e3e2@watter.com>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
In-Reply-To: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 Andy Shevchenko <abdy@kernel.org>
X-Migadu-Flow: FLOW_OUT

Make tabs consistent for register definitions and also fix width
to byte size.

Signed-off-by: Ben Collins <bcollins@watter.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <abdy@kernel.org>
---
 drivers/iio/temperature/mcp9600.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 6e9108d5cf75f3b7a3c45ada1537c446c6853392..40906bb200ec92812a70c2dfb055793d94c7c060 100644
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


