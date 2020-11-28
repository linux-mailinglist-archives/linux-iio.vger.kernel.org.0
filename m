Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBEA2C761E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgK1W3W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 17:29:22 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42627 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbgK1W3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 17:29:21 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 81A76FF807;
        Sat, 28 Nov 2020 22:28:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 09/10] ARM: dts: at91: at91sam9rl: fix ADC triggers
Date:   Sat, 28 Nov 2020 23:28:17 +0100
Message-Id: <20201128222818.1910764-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The triggers for the ADC were taken from at91sam9260 dtsi but are not
correct.

Fixes: a4c1d6c75822 ("ARM: at91/dt: sam9rl: add lcd, adc, usb gadget and pwm support")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 4d70194fd808..bf85a9419c69 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -278,23 +278,26 @@ adc0: adc@fffd0000 {
 				atmel,adc-use-res = "highres";
 
 				trigger0 {
-					trigger-name = "timer-counter-0";
+					trigger-name = "external-rising";
 					trigger-value = <0x1>;
+					trigger-external;
 				};
+
 				trigger1 {
-					trigger-name = "timer-counter-1";
-					trigger-value = <0x3>;
+					trigger-name = "external-falling";
+					trigger-value = <0x2>;
+					trigger-external;
 				};
 
 				trigger2 {
-					trigger-name = "timer-counter-2";
-					trigger-value = <0x5>;
+					trigger-name = "external-any";
+					trigger-value = <0x3>;
+					trigger-external;
 				};
 
 				trigger3 {
-					trigger-name = "external";
-					trigger-value = <0x13>;
-					trigger-external;
+					trigger-name = "continuous";
+					trigger-value = <0x6>;
 				};
 			};
 
-- 
2.28.0

