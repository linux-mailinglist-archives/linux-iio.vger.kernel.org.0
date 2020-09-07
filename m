Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2925FEDD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIGQYg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgIGQNF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D91221897;
        Mon,  7 Sep 2020 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495183;
        bh=6BAvdsAwxvGCRAvXMQZS4I59p4w7Bxsi3s+90oUZ7fI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PS5JkxRIrPd7Ju/BO352HryeQX+LeigF4gQJqq6SFtYYyZXZ36gr5RJXAT/G7vt0a
         UDBSvv6GElJyGrS5tUECja051Sec+VgMzLdnRHohw9WmXVaaN0AoJe8OB7cWxhiWtu
         PLdVMMWorm+EgEZ8x5XXcde5sFb0Bvw9cBLzk5Vs=
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
Subject: [RFT 08/25] ARM: dts: s5pv210: remove dedicated 'audio-subsystem' node
Date:   Mon,  7 Sep 2020 18:11:24 +0200
Message-Id: <20200907161141.31034-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 'audio-subsystem' node is an artificial creation, not representing
real hardware.  The hardware is described by its nodes - AUDSS clock
controller and I2S0.

Remove the 'audio-subsystem' node along with its undocumented compatible
to fix dtbs_check warnings like:

  audio-subsystem: $nodename:0: 'audio-subsystem' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 65 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 46221a5c8ce5..2871351ab907 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -223,43 +223,36 @@
 			status = "disabled";
 		};
 
-		audio-subsystem {
-			compatible = "samsung,s5pv210-audss", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			clk_audss: clock-controller@eee10000 {
-				compatible = "samsung,s5pv210-audss-clock";
-				reg = <0xeee10000 0x1000>;
-				clock-names = "hclk", "xxti",
-						"fout_epll",
-						"sclk_audio0";
-				clocks = <&clocks DOUT_HCLKP>, <&xxti>,
-						<&clocks FOUT_EPLL>,
-						<&clocks SCLK_AUDIO0>;
-				#clock-cells = <1>;
-			};
+		clk_audss: clock-controller@eee10000 {
+			compatible = "samsung,s5pv210-audss-clock";
+			reg = <0xeee10000 0x1000>;
+			clock-names = "hclk", "xxti",
+				      "fout_epll",
+				      "sclk_audio0";
+			clocks = <&clocks DOUT_HCLKP>, <&xxti>,
+				 <&clocks FOUT_EPLL>,
+				 <&clocks SCLK_AUDIO0>;
+			#clock-cells = <1>;
+		};
 
-			i2s0: i2s@eee30000 {
-				compatible = "samsung,s5pv210-i2s";
-				reg = <0xeee30000 0x1000>;
-				interrupt-parent = <&vic2>;
-				interrupts = <16>;
-				dma-names = "rx", "tx", "tx-sec";
-				dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
-				clock-names = "iis",
-						"i2s_opclk0",
-						"i2s_opclk1";
-				clocks = <&clk_audss CLK_I2S>,
-						<&clk_audss CLK_I2S>,
-						<&clk_audss CLK_DOUT_AUD_BUS>;
-				samsung,idma-addr = <0xc0010000>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2s0_bus>;
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
+		i2s0: i2s@eee30000 {
+			compatible = "samsung,s5pv210-i2s";
+			reg = <0xeee30000 0x1000>;
+			interrupt-parent = <&vic2>;
+			interrupts = <16>;
+			dma-names = "rx", "tx", "tx-sec";
+			dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
+			clock-names = "iis",
+				      "i2s_opclk0",
+				      "i2s_opclk1";
+			clocks = <&clk_audss CLK_I2S>,
+				 <&clk_audss CLK_I2S>,
+				 <&clk_audss CLK_DOUT_AUD_BUS>;
+			samsung,idma-addr = <0xc0010000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s0_bus>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
 		};
 
 		i2s1: i2s@e2100000 {
-- 
2.17.1

