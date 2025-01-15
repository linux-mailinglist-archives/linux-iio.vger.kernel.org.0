Return-Path: <linux-iio+bounces-14372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53987A1245F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89243A22BB
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143221E98F2;
	Wed, 15 Jan 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="12k9sSxd"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227152459D5;
	Wed, 15 Jan 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946309; cv=none; b=dFKBf3oQZcWPCzRN6PdHWBLTx6oW330q9+P5YR50hH/iyRD52W9tJHBGhDr8s5rLNHXlZAflEXHgUCMUCVng51Q6aul0sPEK3CNx3ckPOIPsWz2U4h8Q56xbQFK2sCg3CLUtSBgyXrJCQaK4WbQn+cuwkKxfzJ6OcVrB5/Pe14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946309; c=relaxed/simple;
	bh=aNgXKeNC7Iadv8yX34T15F7WOcDTzjR3+hl0/U4hBL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzBRKvG+zL3RQM4YDhfW9y0A1U7XYvZiQ9pThHAsQOHXqSH9doFXXoSiogL3+s+7Wl0Q7hTE6j9f4C/d83w+4kLw5HUrqapP3mWs8pw0o2Fbhwz0AcYvJLEX4NmQnMb5Y585xvkhdiB4Pbhw1e3YvQHQ1SdfrnLoYfeneeeOR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=12k9sSxd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736946308; x=1768482308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aNgXKeNC7Iadv8yX34T15F7WOcDTzjR3+hl0/U4hBL8=;
  b=12k9sSxd/q05V6tBHSvsco3l9aoN/iygP6Cf5tq+siUIVKNrxLM6MHqv
   UbpJWxZ5QJxfa9fEjwauM0CUnZ3vPevwEBxq0a78bONXioI4/Spz4hZP+
   QM4dSjPtRd2B2OSzVi6/k+jZztMVdE8MsF8BWxOabQvRkT2JUDl6THwND
   zSzTcZ6FoL7Im208UJIiRudqOFVk2MyxkfzO18Qr+1QXp4B8pR48CThdZ
   FD5XFNAT7Es4axjzHoTY/RfC/vybTbuqtV4PWcuUaVAQv4gR8cVwEXCRx
   72HdeLOFQPeg0vqxdxrvOxuSlnMVOdW1C5UKvg+gB7BsAu4p+6V5cbjJz
   A==;
X-CSE-ConnectionGUID: zJ4m94pvSeu0BwaW6UQOiA==
X-CSE-MsgGUID: qS3snjsiRUeuoWnEdyJrKg==
X-IronPort-AV: E=Sophos;i="6.13,206,1732604400"; 
   d="scan'208";a="204050158"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 06:05:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 Jan 2025 06:04:36 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 15 Jan 2025 06:04:33 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <andy.shevchenko@gmail.com>,
	<jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: pac1921: Move ACPI_FREE to cover all branches
Date: Wed, 15 Jan 2025 15:03:47 +0200
Message-ID: <20250115130347.10777-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This patch moves ACPI_FREE in pac1921_match_acpi_device
in order to cover all branches.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Fixes: 9fdf1d033316 ("iio: adc: pac1921: Add ACPI support to Microchip pac1921")
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

This patch ensures that status is freed before
exiting the function.

Differences related to previous versions:
v2:
- add Fixes tag.
- remove unnecessary blank line.

v1:
- initial version for review.

 drivers/iio/adc/pac1921.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 90f61c47b1c4..63f518215156 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1198,11 +1198,11 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
 
 	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
 			     GFP_KERNEL);
+	ACPI_FREE(status);
 	if (!label)
 		return -ENOMEM;
 
 	indio_dev->label = label;
-	ACPI_FREE(status);
 
 	return 0;
 }

base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
-- 
2.45.2


