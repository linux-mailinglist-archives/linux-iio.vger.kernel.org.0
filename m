Return-Path: <linux-iio+bounces-22267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2932B19F42
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E8A3AB45B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBA2517AC;
	Mon,  4 Aug 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xHZzyMq5"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC39248871;
	Mon,  4 Aug 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301795; cv=none; b=lRbFbyamKeHoxiUPQwmoXJ87kTPSS/fG+y5hkhVd2Y4QdCaxDNXGJJCx+TfHr37ntshMUKdmSNxg5G5oJYLsmwq56hbRpW+j0cZJ/uywLAyKmgOjS/dHT5RycjJ1RUqL1rEA0JZKZdVH9qkz0tZEN+i3wU2ar235AHKko2FELwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301795; c=relaxed/simple;
	bh=1TygnOgGAatMx8PiN8OA5sB+U38Od/216aX79kNIIjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg8HyHrudqzSZwbBVYhYtPdz8xz/yGfunuMT++RusTC1shg1/eirgDfaTCvLXfqYFhBVpQ2Qdz0F6irtg1t7sUiO4CKEG8ByBu2CcJgw6Q6IsPcbehGTFxWPLydv2IBawLrzeDcSxnZbT0u4ESsqLgGQsh6F+nrST1HDU/YubTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xHZzyMq5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301793; x=1785837793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1TygnOgGAatMx8PiN8OA5sB+U38Od/216aX79kNIIjg=;
  b=xHZzyMq5XCmCmIO4FZfOe71Xl9OJ6Q6p7rOTLw3c0ZkiE64q3ttBLJDI
   UWZnsraK1t9AYOE7IslbW+HO6q1xzM3FDiipaSXuJ3txZeGLaO23uC4VM
   /f6KUwgmaWyv/0S2Y5ebCpwZdy/D4UB4B90P1wOkgWOWr1gMqfkhx6+1+
   znzbVD9ymlH4LtT4NUkqYjEl/V4c+4iiUo5pp/0ZhPEKYY/X6+ow65Au2
   MBb2nD+XVTnm6UBZbTpt6MYi4gIacs3mAScnJfVnJL9SPzER0LrtskuG3
   spvbvYwomB77WMh/DsOu1no/uxJuVmHVQAx07gPMH3SPR+owFgbZDn9ZP
   w==;
X-CSE-ConnectionGUID: Liqowa5KRuKZ85yXFKRAhg==
X-CSE-MsgGUID: A2tQGFiYSiuHs+dCDtWHBg==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="50182875"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:02:47 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:41 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 03/15] dt-bindings: microchip-otpc: update dt node example
Date: Mon, 4 Aug 2025 15:32:07 +0530
Message-ID: <20250804100219.63325-4-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the example binding according to the new driver implementation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index cc25f2927682..e9059dce85ef 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -42,9 +42,8 @@ examples:
         reg = <0xe8c00000 0xec>;
         #address-cells = <1>;
         #size-cells = <1>;
-
-        temperature_calib: calib@1 {
-            reg = <OTP_PKT(1) 76>;
+        temperature_calib: calib@41435354 {
+            reg = <0x41435354 0x4c>;        /* Temp calib data packet TAG */
         };
     };
 
-- 
2.34.1


