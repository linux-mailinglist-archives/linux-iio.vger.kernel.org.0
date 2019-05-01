Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244E610E71
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfEAVRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 17:17:44 -0400
Received: from ch3vs03.rockwellcollins.com ([205.175.226.47]:10406 "EHLO
        ch3vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfEAVRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 17:17:44 -0400
Received: from ofwch3n02.rockwellcollins.com (HELO crulimr01.rockwellcollins.com) ([205.175.226.14])
  by ch3vs03.rockwellcollins.com with ESMTP; 01 May 2019 16:17:43 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by crulimr01.rockwellcollins.com (Postfix) with ESMTP id 137776045D;
        Wed,  1 May 2019 16:17:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
Date:   Wed,  1 May 2019 16:16:59 -0500
Message-Id: <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding optional parameter to AD7949 to specify the source for the
reference voltage signal. Default value is maintaned with option '6' to
match previous version of driver.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
 .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
index c7f5057356b1..14ee9a2cb2a5 100644
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -6,11 +6,29 @@ Required properties:
 	* "adi,ad7682"
 	* "adi,ad7689"
  - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
 
-Example:
+Optional properties:
+ - adi,reference-select: Select the reference voltage source to use
+ when converting the input voltages. Valid values are:
+   0: Internal 2.5V reference; temperature sensor enabled
+   1: Internal 4.096V reference; temperature sensor enabled
+   2: External reference, temperature sensor enabled, no buffer
+   3: External reference, temperature sensor enabled, buffer enabled
+   6: External reference, temperature sensor disabled, no buffer
+   7: External reference, temperature sensor disabled, buffer enabled
+ - vref-supply: The regulator supply for ADC reference voltage. Required
+ if external reference selected by 'adi,reference-select'.
+
+Examples:
 adc@0 {
 	compatible = "adi,ad7949";
 	reg = <0>;
+	adi,reference-select = <2>;
 	vref-supply = <&vdd_supply>;
 };
+
+adc@0 {
+	compatible = "adi,ad7949";
+	reg = <0>;
+	adi,reference-select = <0>;
+};
-- 
1.9.1

