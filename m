Return-Path: <linux-iio+bounces-22269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53FB19F50
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E467A72DF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD12505BA;
	Mon,  4 Aug 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kxyhckFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1E252917;
	Mon,  4 Aug 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301797; cv=none; b=oY/+iOaCbe7UK6QfegUITJSbG55L4h4kAZou7Q/YwBtRSzVlmkO5adVa4NJQsmO6UxtYWim03IzyI6mgFUPDvEEXCpnqLW1joFod975PIgaULhGuBxjtjjVNvzWwiFaojZr7fqR6EHBKSnH0l28T00Vum8In5CDnetxAe5z3r8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301797; c=relaxed/simple;
	bh=uuIRyOEdnRLBFCKPdTmHEOMyyB5YLO4QgF/4XXDW/LU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwCTLEV/MWLWiK+NSuyEubvsSTiZcBE+A4yis4EO9mmpNzXTI1AmvAEvXAtw4iyV42QzPbecemWmwTpL6yIDk+yr7cllkEp0ioVDQIHy3PhqEBLdnJymnZfhgyHeZFYJU3V4h/JHypUZG1g+VF5srrU0PpFXDqsuch0BDtavv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kxyhckFG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301795; x=1785837795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uuIRyOEdnRLBFCKPdTmHEOMyyB5YLO4QgF/4XXDW/LU=;
  b=kxyhckFGqMCEShbPlxeenpcHPNfdEogKke5eGMtrLalW8QHXgXCGy8N/
   ZR6WPOXCIHJyS74jgXkFSBpYFkD/k1odugn3gVKcqUplhYzMjofe1+xMW
   tE//p7M4qwmYoMhr8ArMUuTlSGZhFGkMAb2Vao/8//bygT+HHbkLlIYFr
   4NBk89uTYVXkUhq3Pz9rUW1vFzx4P6M5dtggYF+/ChY3RxZEcXrXgbdH3
   frnGNVSAa3EeqbA2Kyn06PDxF2hQVjUe/5OfZPBXClr7DxYjalNEndHlh
   27Rm986Yu2Erd31+Aek0BZ8f9i2Mk/YR3pf3J8cdWSxmA/sC2XWU6GpfK
   g==;
X-CSE-ConnectionGUID: QrHuXWrSRt6GNRSNglLzJg==
X-CSE-MsgGUID: VL8QDnfmR6Kw70ZIcKKS6A==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44245503"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:03:00 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:54 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 05/15] ARM: dts: microchip: sama7g5: add packet tag as offset for calib
Date: Mon, 4 Aug 2025 15:32:09 +0530
Message-ID: <20250804100219.63325-6-varshini.rajendran@microchip.com>
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

Add packet tag as offset to access temperature calibration data from otp
memory for sama7g5.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 17bcdcf0cf4a..62f946f3f894 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -1023,8 +1023,8 @@ otpc: efuse@e8c00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			temperature_calib: calib@1 {
-				reg = <OTP_PKT(1) 76>;
+			temperature_calib: calib@41435354 {
+				reg = <0x41435354 0x4c>;	/* Temp calib data packet TAG */
 			};
 		};
 
-- 
2.34.1


