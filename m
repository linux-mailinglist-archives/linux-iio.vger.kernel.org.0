Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788C73F5D8A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhHXL5s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:57:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16412 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbhHXL5r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806223; x=1661342223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=solFwV4JTQfjT1p/kr3lKPxhmPtCyWwDUzcwzBiiHAo=;
  b=TTL2ozgi1fD97jkBMYgM1WBeMpRRMaz6qlbVxDHwuutJ6LDsPdCzfLJP
   v7QWhADIcGX5Bc5pzvPY+K4pqgUXKoDrZJxRANnPSj9A3XN20SlubFvSs
   7PgYlYfxmAkbYxvBaovxovhWVFX/jBe4WdcXBOSkhkYFM3PxMTbju54kM
   WsNyHO8LWUzQ0TiuFGXSaLXo5Oi+i/4w5ndNwsNuusZm7Tji4BaUCtRxU
   AhXm28LQiYAz7tL/DHX9ofafabJO2TVmJqmwtJHGR5H9j6MdXvYLvENH6
   pXQ6bCyJ4BFTOY6R+OHlxaPYq978CKunv8iWb0nDS0FofZoapeZuBpLs/
   g==;
IronPort-SDR: /EuT0nHQYMwrxDb7fe/Bxtk3AMvoBVzQ3CCiLOPVjsUdGkXA4JpS4lzpjxKQ4pmkoyBZAFNCcr
 SNOzWDt5U1Xtte9tYL1cAPhnOgo0Urnzzah21A8dFKaLZY3OM+IdQiE2dnBM+aZh0VQolPdYB6
 FXwqqehm4em5s5M+Sw+4MwdLWs1rFSdxNIVdKmN6nSNc2Gw67MQ/oq1FwBLH31xuX5weGaOSLo
 Ravua/CNtMeiCcHXKgjn4wnEjgwC9CLbLeREy20DlmVyhzDByrQHdux2a+Vu30g1dw+GjH2Nr7
 8Pw0FVE+j4X/H+qLdNLCx/BW
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133946072"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:57:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:57:02 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:56:50 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 10/10] ARM: dts: at91: sama7g5ek: enable ADC on the board
Date:   Tue, 24 Aug 2021 14:54:41 +0300
Message-ID: <20210824115441.681253-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC controller on the board is fed by a 2.5V reference voltage.
By default the channels #14 and #15 are dedicated to analog input
(marked AN on the board), on the connectors mikrobus1 and mikrobus2.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 4cbed98cc2f4..c46be165f2ba 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -122,6 +122,14 @@ spdif_out: spdif-out {
 	};
 };
 
+&adc {
+	vddana-supply = <&vddout25>;
+	vref-supply = <&vddout25>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mikrobus1_an_default &pinctrl_mikrobus2_an_default>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vddcpu>;
 };
-- 
2.25.1

