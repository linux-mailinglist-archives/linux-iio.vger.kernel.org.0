Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9425FEDA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgIGQNH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgIGQM4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4039206E6;
        Mon,  7 Sep 2020 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495175;
        bh=qDYGfZ3RmLMzEdL/D31BVomLhzU4Yf8Q9HdCrkY+B7M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2HlZYLGDXRkHSOlvKLZG4N1MYxjdg3kgFUw0boXQ+tQCu/eUQINFSNUd4gvaBfJml
         vQ6L90Mnr1qXXK/azSFdFF7j6CbTXhzC0BhYGaDIZ3Y0mVUtcRqRjt1z8GE8rjbEbu
         3S3ak1/xNBLuZcOBZm8k3ASFgoZLMORPQTtLcF4Y=
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
Subject: [RFT 06/25] ARM: dts: s5pv210: move fixed clocks under root node
Date:   Mon,  7 Sep 2020 18:11:22 +0200
Message-Id: <20200907161141.31034-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fixed clocks are kept under dedicated 'external-clocks' node, thus a
fake 'reg' was added.  This is not correct with dtschema as fixed-clock
binding does not have a 'reg' property.  Moving fixed clocks out of
'soc' to root node fixes multiple dtbs_check warnings:

  external-clocks: $nodename:0: 'external-clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
  external-clocks: #size-cells:0:0: 0 is not one of [1, 2]
  external-clocks: oscillator@0:reg:0: [0] is too short
  external-clocks: oscillator@1:reg:0: [1] is too short
  external-clocks: 'ranges' is a required property
  oscillator@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 36 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 84e4447931de..5c760a6d7955 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -52,34 +52,26 @@
 		};
 	};
 
+	xxti: oscillator-0 {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "xxti";
+		#clock-cells = <0>;
+	};
+
+	xusbxti: oscillator-1 {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "xusbxti";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		external-clocks {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			xxti: oscillator@0 {
-				compatible = "fixed-clock";
-				reg = <0>;
-				clock-frequency = <0>;
-				clock-output-names = "xxti";
-				#clock-cells = <0>;
-			};
-
-			xusbxti: oscillator@1 {
-				compatible = "fixed-clock";
-				reg = <1>;
-				clock-frequency = <0>;
-				clock-output-names = "xusbxti";
-				#clock-cells = <0>;
-			};
-		};
-
 		onenand: onenand@b0600000 {
 			compatible = "samsung,s5pv210-onenand";
 			reg = <0xb0600000 0x2000>,
-- 
2.17.1

