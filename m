Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1525FEE1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgIGQYf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbgIGQNH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A2321919;
        Mon,  7 Sep 2020 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495187;
        bh=wpdHkjWJjuNWTZckDc5yTTA+zkcQQYAV5zyE6Evwps8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TheR5lpMgTv+Xg8ocpJ4CTPM7Q79eP4d8ReEvNyh5YjFsqaQ9FWLyRzZGUXjZHyQJ
         TVOIKnsNj2hHZN+7uFTJFWOwLKy70ecYn3neIezmhtMEVG4C+Zz3pt/dkVPXPh1UGl
         rhQ/drqMntAmiPoBvCb9OOiYy5i83tBFMEK5uHdg=
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
Subject: [RFT 09/25] ARM: dts: s5pv210: fix number of I2S DAI cells
Date:   Mon,  7 Sep 2020 18:11:25 +0200
Message-Id: <20200907161141.31034-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bindings describe I2S DAI has 1 cells.  This makes especially sense
for i2s0 which registers two DAIs.  Adjust the cells to fix dtbs_check
warnings like:

  i2s@e2100000: #sound-dai-cells:0:0: 1 was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 2 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi            | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index ca064359dd30..a6dc8a173af1 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -102,7 +102,7 @@
 		pinctrl-0 = <&headset_det &earpath_sel>;
 
 		cpu {
-			sound-dai = <&i2s0>, <&bt_codec>;
+			sound-dai = <&i2s0 0>, <&bt_codec>;
 		};
 
 		codec {
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index 560f830b6f6b..0eba06f56ac7 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -132,7 +132,7 @@
 		pinctrl-0 = <&headset_det &earpath_sel>;
 
 		cpu {
-			sound-dai = <&i2s0>, <&bt_codec>;
+			sound-dai = <&i2s0 0>, <&bt_codec>;
 		};
 
 		codec {
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 2871351ab907..96e667ba1c3f 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -251,7 +251,7 @@
 			samsung,idma-addr = <0xc0010000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s0_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
@@ -266,7 +266,7 @@
 			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s1_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
@@ -281,7 +281,7 @@
 			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s2_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
-- 
2.17.1

