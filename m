Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165C63FDA84
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbhIAMcp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55518 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbhIAMbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499449; x=1662035449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiPgHlTu29YpILohxH7nnDUefzSZI6Vn6zEWq8Ur+jA=;
  b=y1donEpEc8Umip1S6wENC7ZVU/5SK0ZrqggHvNhZZzA3ayFY3tqeme2p
   w2r6yu5zjfMv4NgY9OuYO+0XNEFeqsDFoh/hqfxSpFJ35arO2vjJuYb7k
   fCGJ5uPMU6VvfjDgeH+rsASycerG0ytsSlDBoxRP6/Leq/YCN1nMPoG/F
   revZmN0HZVge7jinc1dJ7KiulRxX55hdzrfge+sUVgtZ4ByaV4gvrkuZ4
   qF1NIN9Q0djQWC2UAGlCF4Hw4tJkjguWjJvLjlfkjGRTgI6HNWWiRl3UR
   ZzF+8JML7Dn11I2X9Zs9s7I8FBVagXdH0TPzs5yw/crXzVxberjJgeiof
   Q==;
IronPort-SDR: z83enoGxyxmWxDQQO08Nea27u7up2T+H44RKLoB6JtHNRLws18Yy1lqUYnULTLBXaDSHAp39mK
 gMZXb9uHyJBahVVFBznwZcWdkn6/ArcQz2EX9F+QOWmgkONcZRITjssjtxpSt1i85rNhGRVhPz
 l4DMF1vBmFWUjrvEvYwln6WkIz+lrRkaooPLMQNCpkJs0cDq6FwFfgTRf40aH1QspxXJmRIWoW
 wOiKx4wbRuPBrinfvgGwsoMvzEdgZBXX4pwk3bP4b95HfNe5dYnYPUGXgjjhiz+NQsmWXh5Ldb
 bhXwKJcbYpB8bN2h2Ggb0lZa
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="134969820"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:48 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:46 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 09/10] ARM: dts: at91: sama7g5: add node for the ADC
Date:   Wed, 1 Sep 2021 15:30:12 +0300
Message-ID: <20210901123013.329792-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
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

