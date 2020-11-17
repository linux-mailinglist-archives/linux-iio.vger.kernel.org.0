Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53512B6708
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbgKQOII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:08:08 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:27623 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbgKQOIH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:08:07 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 43EAB240009;
        Tue, 17 Nov 2020 14:08:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 09/11] ARM: dts: at91: sama5d3: use proper ADC compatible
Date:   Tue, 17 Nov 2020 15:06:54 +0100
Message-Id: <20201117140656.1235055-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC is different from the at91sam9x5 ADC. Not only it doesn't have the
same resolution but it even have only one and the LOWRES bit doesn't exist.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 86137f8d2b45..bba2a3f41c42 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -307,7 +307,7 @@ ssc1: ssc@f800c000 {
 			adc0: adc@f8018000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "atmel,at91sam9x5-adc";
+				compatible = "atmel,sama5d3-adc";
 				reg = <0xf8018000 0x100>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
-- 
2.28.0

