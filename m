Return-Path: <linux-iio+bounces-18592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8757A9A55D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227421B82E3E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD321ADBA;
	Thu, 24 Apr 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e7qrCW0+"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2C218AC7;
	Thu, 24 Apr 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482159; cv=none; b=AX0OVxywWeVLCrE83r2tmxahHur5hBvKEh7mBz58fBKv7+2lasy+XnjArUpRWJPRcoMJ30434k4ST3M+6Y6CsQlkUCRnulTo2mNBX29LPdlZZx3Rft3R296xwbpVXp2h5mYsBbRqHyaJXuN1DmZO0C89WbMqOCsoWNgL1/Z/emE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482159; c=relaxed/simple;
	bh=yYFzfcjodjsPyIwDbrK08y/kZInkd8p6kN31M6oYBs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E98Ekw2Q7KWEQ9mFncuSvv9pu3yyL9kPc/7mEIrd4cOnooDtlbVeKb9QXBzFv5Kp+EzyPGmgb+yjyVQPfNsMhgfjTABmmGnnlVOkdUH7YpYH0zx3ve9qyRFb8vvXeZ+xlN88C/UUVRdW7rQsvZU4Kfq0wlAZcsW2Gjp4+l4cC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e7qrCW0+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745482157; x=1777018157;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yYFzfcjodjsPyIwDbrK08y/kZInkd8p6kN31M6oYBs0=;
  b=e7qrCW0+OzIbcujHt48tSq5NHeEeVH9HS3zi70XQA5n7wWMbOJCCvnaf
   FgwxMDr0NQBF2b4dMHDeTpiLIklAbHA5/WB5ZScZpACDTOUZKMYOAoQ0W
   6eL+0PyE8WNOVjCGzpA6rxubAZ5ZgFdwDI8/6yyUNmunGC2jNF4zQS+Er
   k/6s5/ysTQE8W/mVesp10KdPTq0C/JUgkhiQ/PskoAmno74d58xUcH/8W
   q6eQVxLo1YSSM3rlHByxiCQwjciLqwtwVJUQdhr8b26CA8L6g5cGFRwKV
   GNJdomSUAhj9SMw8wyxo/tkA26hbNCzhOqEP06eehiCaIFgBK6PZrQ8VP
   w==;
X-CSE-ConnectionGUID: YoMONp9cSnibtW5FCExXWQ==
X-CSE-MsgGUID: qc/OFvpzTSSGALLCmEblvQ==
X-IronPort-AV: E=Sophos;i="6.15,235,1739862000"; 
   d="scan'208";a="45417227"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2025 01:09:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Apr 2025 01:08:49 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Apr 2025 01:08:47 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Date: Thu, 24 Apr 2025 11:06:33 +0300
Subject: [PATCH] iio: adc: PAC1934: fix typo in documentation link
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250424-pac1934-doc_link-v1-1-9832445cb270@microchip.com>
X-B4-Tracking: v=1; b=H4sIAAjxCWgC/x3MTQqAIBBA4avErBN0NPq5SkSYTjUUFgoRRHdPW
 n6L9x5IFJkSdMUDkS5OfIQMVRbgVhsWEuyzASVW0iCK0zrVaiP84cadwya0q301ecIGCXJ2Rpr
 5/pf98L4fHyuhZWIAAAA=
X-Change-ID: 20250422-pac1934-doc_link-3c7d5bde282e
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Matteo Martelli
	<matteomartelli3@gmail.com>, Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=yYFzfcjodjsPyIwDbrK08y/kZInkd8p6kN31M6oYBs0=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDI4PzYbb73v2eBwcoJ2cu5PV9frcw/btct1uDElKf4sb
 bN/vrO+o5SFQYyLQVZMkWXFWz+1qrUfLiuJZerAzGFlAhnCwMUpABNZ/Jrhn9VahiOFrdbJf6ZN
 WKovsber9+52t71+YrekIp88b/8W8YKRoclRKKwqakpB4/M+h/wnn8+IfErW8GNenXB+cZq27WY
 fHgA=
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

Fix a typo,(PAC1934 -> PAC193X), into the link from an application note
related to the ACPI device definition.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Reported-by: Matteo Martelli <matteomartelli3@gmail.com>
Closes: https://patch.msgid.link/172794015844.2520.11909797050797595912@njaxe.localdomain
Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
Fix a typo,(PAC1934 -> PAC193X), into the link from an application note
related to the ACPI device definition.
---
 drivers/iio/adc/pac1934.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 20802b7f49ea84c00dd6e8c717d956cb20448f4a..09fe88eb3fb04578137403a020d9befaa75610a6 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1081,7 +1081,7 @@ static int pac1934_chip_identify(struct pac1934_chip_info *info)
 
 /*
  * documentation related to the ACPI device definition
- * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
  */
 static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 					     struct pac1934_chip_info *info)

---
base-commit: 3159d40a2ca0ae14e69e1cae8b12f04c933d0445
change-id: 20250422-pac1934-doc_link-3c7d5bde282e

Best regards,
-- 
Marius Cristea <marius.cristea@microchip.com>


