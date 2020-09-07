Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821D25FE9B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgIGQTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbgIGQNt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:49 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06086217A0;
        Mon,  7 Sep 2020 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495228;
        bh=2r+P12MEW4n8TZv7IWA3L/5cznKkKx6Gr9KtqUPmiEk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oK+cr7fTgwPkYOEdgPxZMBnyzsrKXWDjUZ2s2Gz8eAdyX3WDPRMxcdVXWbYU+Q5Ub
         xNVqehm1Upzv5FOHtgfP4CcLU0xyB6DR/i/kDBUcLEc4IINL3a4zEDskzBiv2YFXhG
         kXc4KolRxMTZTXsr2+Xi7R3dTGYUf0ePCs/2Bx1M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [RFT 20/25] ARM: dts: s5pv210: move fixed regulators under root node in Aquila
Date:   Mon,  7 Sep 2020 18:11:36 +0200
Message-Id: <20200907161141.31034-21-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fixed regulators are kept under dedicated "regulators" node but this
causes multiple dtschema warnings:

  regulators: $nodename:0: 'regulators' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
  regulators: #size-cells:0:0: 0 is not one of [1, 2]
  regulators: fixed-regulator@0:reg:0: [0] is too short
  regulators: fixed-regulator@1:reg:0: [1] is too short
  regulators: fixed-regulator@2:reg:0: [2] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 47 +++++++++++-----------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 25d4ab4a52c5..28e9e81bb2d1 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -40,36 +40,27 @@
 		clock-frequency = <32768>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vtf_reg: fixed-regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "V_TF_2.8V";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&mp05 4 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vtf_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_TF_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&mp05 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		pda_reg: fixed-regulator@1 {
-			compatible = "regulator-fixed";
-			regulator-name = "VCC_1.8V_PDA";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			reg = <1>;
-		};
+	pda_reg: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1.8V_PDA";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 
-		bat_reg: fixed-regulator@2 {
-			compatible = "regulator-fixed";
-			regulator-name = "V_BAT";
-			regulator-min-microvolt = <3700000>;
-			regulator-max-microvolt = <3700000>;
-			reg = <2>;
-		};
+	bat_reg: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_BAT";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
 	};
 
 	i2c_pmic: i2c-pmic {
-- 
2.17.1

