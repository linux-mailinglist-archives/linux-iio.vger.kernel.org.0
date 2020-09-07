Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2825FEB0
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIGQNj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgIGQNc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70CC20757;
        Mon,  7 Sep 2020 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495211;
        bh=qgXqI4frisFwx8QzGcIa8tBsjc+jjvV/N85jzzXwX90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lhlP2atmwmPguVgSXCI4YIVL6tyzpJrfhphhFctmVThZToRl2T1f148DWmY1M5DQ0
         lFOZ8f33+AhCk+PyHsR8HjoZZAIA92ghniWQ/nCufS+FPKNu0vuygIwsO+e3tPpgC2
         44Z8Nnv673y51nyIV5Xlf0TGA1c22EEKDL7eYGVU=
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
Subject: [PATCH 15/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Torbreck
Date:   Mon,  7 Sep 2020 18:11:31 +0200
Message-Id: <20200907161141.31034-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However the PMIC is not described in DTS at all so at least add
a workaround to model its clock with a fixed-clock.

This fixes dtbs_check warnings:

  rtc@e2800000: clocks: [[2, 145]] is too short
  rtc@e2800000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-torbreck.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-torbreck.dts b/arch/arm/boot/dts/s5pv210-torbreck.dts
index cd25e72ccd84..e18259737684 100644
--- a/arch/arm/boot/dts/s5pv210-torbreck.dts
+++ b/arch/arm/boot/dts/s5pv210-torbreck.dts
@@ -30,6 +30,13 @@
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
+
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing PMIC and its clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
 };
 
 &xusbxti {
@@ -54,6 +61,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &sdhci0 {
-- 
2.17.1

