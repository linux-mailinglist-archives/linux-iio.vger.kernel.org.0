Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E73F5D88
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHXL5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:57:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2731 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXL5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806209; x=1661342209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiPgHlTu29YpILohxH7nnDUefzSZI6Vn6zEWq8Ur+jA=;
  b=whJIOZ55MSptxp0Z3Q9O0rGZT1jZ0UUOq37QlXG4qPsrOYFBGrG8kpvv
   jW1oB/WeFgr/lIaLcJVUdpxh/rJuSai4/OYj8JnDIDH5o10DotSGzY+iJ
   Lbis7m9Ci/ukjSdZHEx/pZtFshuoLf+OzRWo2/ydykoX5Yq0f00TPy/xH
   j0n4SrPZMAPNSNrKTTMFhm+Z9NMM5SEhv4AoVMyp4CTsozZneRCcGjeMl
   bzBxWNmnKeF/URIS9OO11Ei8RJMJEwy+HtsBB/Dm1LbB2x5a2ctU5vCiH
   7umxGBGzJeJTMLlR9wCtLCVXlNToXRlg2PyeTBJcbN2iEEwhAiaVmh7UU
   Q==;
IronPort-SDR: 9kxtXKnj0u89pfKf0LvW5pbmemu4qyYCwZ3YdaFc1yRYl/NbGhy7uHoIuZWKmQVepeIMuvPxDy
 rxhpbx3oXsYSVf70joiAZvPpwZuTMXrwLXJQ4D6Y8OKfOYuSZLU8xG5Twn7qlEhF6vnGhQ34oY
 fy2oJ86a1kHaQruYhTGXiWyrEhOK+w9jJ76hqyOkJWGRSrlfvs+Of0SC6LvzH7cRYZF5bZ6bWu
 Z3frrDoKsJ2g41hWcX82yhhvKr8saOQ2PTKDsOgrlVeNjuDviidLJswv0dzvgKmJzAbTH6rz9L
 drVaKCGKSGJsIQkOA9LayGEv
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="66906623"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:56:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:56:48 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:56:45 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 09/10] ARM: dts: at91: sama7g5: add node for the ADC
Date:   Tue, 24 Aug 2021 14:54:40 +0300
Message-ID: <20210824115441.681253-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add node for the ADC controller in sama7g5 SoC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index f9ad5365862f..de960519c72a 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -137,6 +137,22 @@ ps_wdt: watchdog@e001d180 {
 			clocks = <&clk32k 0>;
 		};
 
+		adc: adc@e1000000 {
+			compatible = "microchip,sama7g5-adc";
+			reg = <0xe1000000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_GCK 26>;
+			assigned-clocks = <&pmc PMC_TYPE_GCK 26>;
+			assigned-clock-rates = <100000000>;
+			clock-names = "adc_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
+			dma-names = "rx";
+			atmel,min-sample-rate-hz = <200000>;
+			atmel,max-sample-rate-hz = <20000000>;
+			atmel,startup-time-ms = <4>;
+			status = "disabled";
+		};
+
 		sdmmc0: mmc@e1204000 {
 			compatible = "microchip,sama7g5-sdhci", "microchip,sam9x60-sdhci";
 			reg = <0xe1204000 0x4000>;
-- 
2.25.1

