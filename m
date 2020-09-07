Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267225FE96
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgIGQTS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgIGQNw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C0921789;
        Mon,  7 Sep 2020 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495232;
        bh=LCZiNPIu8jZhAFtcfPg9X65S8kNcPL3i2BZfvFXvaVM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MpNx5OKX8ND25kEGqAv67cBNVnPCrNRD5idk6KCBbLRucUK8v6NwfjLaiItYc7f0R
         yWFxB1O6hVraOXJsqOsncVQAjr+K/UyRUc4UIRvzhmg/q5laLEja1dkjQagxVvmlxV
         p6uDmMsFLwLyYWAqilto+JEOA9DaW//5zSxuBbuo=
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
Subject: [RFT 21/25] ARM: dts: s5pv210: move fixed regulators under root node in Goni
Date:   Mon,  7 Sep 2020 18:11:37 +0200
Message-Id: <20200907161141.31034-22-krzk@kernel.org>
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
  regulators: fixed-regulator@3:reg:0: [3] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 64 +++++++++++++-----------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index 20f1c2773805..eec6531e6ef8 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -42,46 +42,36 @@
 		clock-frequency = <32768>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vtf_reg: fixed-regulator@0 {
-			compatible = "regulator-fixed";
-			regulator-name = "V_TF_2.8V";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			reg = <0>;
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
+	};
 
-		tsp_reg: fixed-regulator@3 {
-			compatible = "regulator-fixed";
-			regulator-name = "TSP_VDD";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			reg = <3>;
-			gpio = <&gpj1 3 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	tsp_reg: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "TSP_VDD";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpj1 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	i2c_pmic: i2c-pmic {
-- 
2.17.1

