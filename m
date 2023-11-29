Return-Path: <linux-iio+bounces-490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C07FD8C1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE068B20E49
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27257225D2;
	Wed, 29 Nov 2023 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Phxi3k2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A6DE;
	Wed, 29 Nov 2023 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701266203; x=1732802203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hei7pXJNKVP4qTlallaoc626BSGQdU10VHphmCZ1qaE=;
  b=Phxi3k2ujMog2Ek76+OslxHqMUmlr8/XuH0P4G6gebDiYPED733L5vwC
   ZUktuKTtYsHRagrFCx9X2nhYClv0uJKDRlgqknGQZffv5uk7MI45lKPcu
   2GOmxJWVgLkkPx+wWnXpfcxfOXgWfmJ1sm3rpaZqFc2f8XlmAo2jY7C4a
   +60qNxcg8hH39Yo98iE5SxCQgaho0le8t+cb4YaJgyf86uQb9hWlbl67C
   Xv6xF8zFJPBEf/dtAJgRP2A1FAj9Vy5lszQx4XeJTsdn4OA/K7EB9dNXF
   iUDRl4ur8TKzI+fu4bNJfBY32vBxEGGUtIF9/I4P52a29fIJ2WBNzwm2H
   g==;
X-CSE-ConnectionGUID: BHQX6+MwTYmhpSKF5vn9xQ==
X-CSE-MsgGUID: bOTPZ+PEQJm/gapsuwWiuQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="13258106"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 06:56:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Nov 2023 06:56:24 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Nov 2023 06:56:22 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v2] iio: adc: MCP3564: fix hardware identification logic
Date: Wed, 29 Nov 2023 15:56:19 +0200
Message-ID: <20231129135619.63475-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

In mcp3564_config() fix the hardware identification logic
based on the hardware ID registers. Second part of the code was
disabled by an logic error.
Fix a typo related to the "MODULE_DESCRIPTION".

Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 drivers/iio/adc/mcp3564.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e3f1de5fcc5a..e914a885a868 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1122,7 +1122,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	enum mcp3564_ids ids;
 	int ret = 0;
 	unsigned int tmp = 0x01;
-	bool err = true;
+	bool err = false;
 
 	/*
 	 * The address is set on a per-device basis by fuses in the factory,
@@ -1509,5 +1509,5 @@ static struct spi_driver mcp3564_driver = {
 module_spi_driver(mcp3564_driver);
 
 MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
-MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
+MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP356xR ADCs");
 MODULE_LICENSE("GPL v2");

base-commit: 6543f376ec8aa90a6c1ed44b765f4f0d6c3eb1db
-- 
2.34.1


