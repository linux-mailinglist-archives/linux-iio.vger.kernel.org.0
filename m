Return-Path: <linux-iio+bounces-263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93B7F44B7
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 12:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2210528150B
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A22556F;
	Wed, 22 Nov 2023 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vwdiwioZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8ED8;
	Wed, 22 Nov 2023 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700651493; x=1732187493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bqZy+15bGo0cAdv3T10s82WMPZ8WYesT6PFaGMF8gZQ=;
  b=vwdiwioZydBIWvwyyGiELvkWNuiTRl3OPS/tCKiaN184v4a2H6UHnZxg
   MIX0mMwJwYUYHy29D0/+ABKMlgigIvMeCy9YYde3bDIXykmn8ZgVa0kPJ
   kCLXnLhSyPO46FoaRozaH1LPnIommQWOtFDjJs4LtIzCRkVKtHJDt9PzD
   yHARgDmbntFu2r7FgPcja13euXuo23d+t4S26jawGMeNcxRZ2qj1dpKns
   F4XRe89hHjMkxWRBXQpcW7TF4ipGNEiuOLDFsUzp5O26+klcWzUGcm+ud
   LDi0jtSMS3m/G7Y0emfgUE5kvmgG/5ZHqm7Bb6Yu4+zYbQdELhY66WTuG
   A==;
X-CSE-ConnectionGUID: pzcGjbUNQWmjzz0egclpxw==
X-CSE-MsgGUID: AdC0IIYsSDao5AmsIV7zzw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="179248509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2023 04:11:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Nov 2023 04:11:10 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 22 Nov 2023 04:11:08 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v1] iio: adc: MCP3564: fix hardware identification logic
Date: Wed, 22 Nov 2023 13:11:06 +0200
Message-ID: <20231122111106.45288-1-marius.cristea@microchip.com>
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


