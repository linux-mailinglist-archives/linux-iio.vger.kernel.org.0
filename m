Return-Path: <linux-iio+bounces-14281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B6A0B812
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54801884585
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872E1A28D;
	Mon, 13 Jan 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DjicuXBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598B17758;
	Mon, 13 Jan 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774723; cv=none; b=ag3A/2xjCGGw8urHkuAybE7mXaZ4Vr1Dtm6RLDKyoWN/y22JWCOsr+NC23kWB2s+d6ZfOGZtOOhIG/ddGRc2kwkoX33wfoWz/SK/WNNVB+Tl9ETQz5n87fZUu6V/dXr4XxTjLNH8D19OyCcPnkGH2ZlfkUPrH/IelaXJYnRKtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774723; c=relaxed/simple;
	bh=xnQLwSHcvF6j1mimtvTF/7QRDlE230ubJEUxZwuK6ms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BAm9WiTr/+xxo+NEAkmSMgUi+wAuWj0RgDOxq8NBy7xYOpu9Wl+95PfFK9a2+NZjLcqjkR3XpIfuxcgG9pN8X02xKkqOIuWksTPN+x4xyZlLg+PNeHv7ozmrS+Uy3UTXD6+3x6yB4YHmHPZ13Xmg16zLN/MD+9RWPBqa7Npw4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DjicuXBN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736774722; x=1768310722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xnQLwSHcvF6j1mimtvTF/7QRDlE230ubJEUxZwuK6ms=;
  b=DjicuXBN8ELdzDoIetRCYX2KSFUOk6tBj9e1+f4hDIb47aAP45cP6KY+
   3T9KgEhv4fYd4sUGLVJu7obJqeJIw3YUIab7NU+2f++OmHl6sEOV2pEs6
   ujYDuFygnxZKCqyYjsgUru7ecZ6Ee3BFc5a3kp2m6HIWkatiaPLnH8+Ys
   74fmwTcKlmfqJV9IoNuZLGkvufmjBZqu3X9B92PcQwIdQRL7MzvAexnie
   /E0C7cUbkyf3xZvhDBZD5EHvSmUudinuCgHmBQ0MCOJfrmsUO+Z74nhMX
   /TENhy9P822VtU5Z6kTv2/3iRFWK7T7Yrp5aEVv/mw+IIIH62TCXfCxdo
   g==;
X-CSE-ConnectionGUID: LcF2qxNfTySqveYfUQjaNw==
X-CSE-MsgGUID: OikX8WsLSE2LPyMR9qHgtQ==
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36896072"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 06:25:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 06:25:04 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 Jan 2025 06:25:02 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <andy.shevchenko@gmail.com>,
	<jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] iio: adc: pac1921: Move ACPI_FREE to cover all branches
Date: Mon, 13 Jan 2025 15:22:14 +0200
Message-ID: <20250113132214.36276-1-victor.duicu@microchip.com>
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
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 drivers/iio/adc/pac1921.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This patch ensures that status is freed before
exiting the function.

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 90f61c47b1c4..6b67e387b3c0 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1198,11 +1198,12 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
 
 	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
 			     GFP_KERNEL);
+	ACPI_FREE(status);
+
 	if (!label)
 		return -ENOMEM;
 
 	indio_dev->label = label;
-	ACPI_FREE(status);
 
 	return 0;
 }

base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
-- 
2.45.2


