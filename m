Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD825FED8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgIGQYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbgIGQNK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE70221775;
        Mon,  7 Sep 2020 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495190;
        bh=IvIoj2K7TIRgwMp4PonToROYopW9M5mo7TeBE51xjo0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nAA805Fqp3EYfc9xrjR3f18Q6EcfDrLkpSJ0h2oGbmmVqtFRrdA4GXxl0ndhqjxDs
         LiDEMZm+2eokreabKhc1ESbH/NZVLBv7Ih4ocMKXz2k3Gm06fRoHkuu2GU/R5+RDde
         T9K4fsf4K9f3Po0qyFcoQj/+XglB1tXFqqpMDUH8=
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
Subject: [PATCH 10/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Aquilla
Date:   Mon,  7 Sep 2020 18:11:26 +0200
Message-Id: <20200907161141.31034-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However there is no such clock provider but rather a regulator driver
which registers the clock as a regulator.  This is an old driver which
will not be updated so add a workaround - a fixed-clock to fill missing
clock phandle reference in S3C RTC.

This fixes dtbs_check warnings:

  rtc@e2800000: clocks: [[2, 145]] is too short
  rtc@e2800000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 14969b6529e8..eaeb0e921aaa 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -32,6 +32,13 @@
 			0x40000000 0x18000000>;
 	};
 
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing clock on PMIC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -228,6 +235,11 @@
 					regulator-always-on;
 				};
 
+				ap32khz_reg: EN32KHz-AP {
+					regulator-name = "32KHz AP";
+					regulator-always-on;
+				};
+
 				vichg_reg: ENVICHG {
 					regulator-name = "VICHG";
 				};
@@ -326,6 +338,11 @@
 	status = "okay";
 };
 
+&rtc {
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci0 {
 	bus-width = <4>;
 	non-removable;
-- 
2.17.1

