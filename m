Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74B2B26BB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 22:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKMV3K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 16:29:10 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52352 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKMV3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 16:29:09 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D046B3ABAEA
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2020 21:27:33 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4CC5BFF804;
        Fri, 13 Nov 2020 21:27:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/9] ARM: dts: at91: sama5d3: use proper ADC compatible
Date:   Fri, 13 Nov 2020 22:26:49 +0100
Message-Id: <20201113212650.507680-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC is different from the at91sam9x5 ADC. Not only it doesn't have the
same resolution but it even have only one and the LOWRES bit doesn't exist.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 86137f8d2b45..e0807b723533 100644
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
@@ -333,9 +333,7 @@ &pinctrl_adc0_ad11
 				atmel,adc-startup-time = <40>;
 				atmel,adc-use-external-triggers;
 				atmel,adc-vref = <3000>;
-				atmel,adc-res = <10 12>;
 				atmel,adc-sample-hold-time = <11>;
-				atmel,adc-res-names = "lowres", "highres";
 				status = "disabled";
 
 				trigger0 {
-- 
2.28.0

