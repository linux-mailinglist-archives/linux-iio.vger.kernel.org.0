Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8416825FEB2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgIGQNi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbgIGQNf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3EB206E6;
        Mon,  7 Sep 2020 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495215;
        bh=mPBu7hsXZsbqx8IHuhKWUMJOlvFkEEFzPFZCMcnLurw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wCaOj2h9hpMr9boPIVg6KkQvdLfyS8BGRA+fXMLu6yFE9pKmBpG2KV+ONyCz4bFh8
         HvYqtUahZJjly+s1wzupb/JyO202CNQ2fnm5xUJhdQlhIXXRYqnCUxkoE9x1RW+NQ6
         mBwtLolELwY5wxBKZjxAU48b1JSeEsdN4uW4MIIs=
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
Subject: [PATCH 16/25] ARM: dts: s5pv210: use defines for GPIO flags in Aquila
Date:   Mon,  7 Sep 2020 18:11:32 +0200
Message-Id: <20200907161141.31034-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace hard-coded flags with defines for readability.  No functional
change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index eaeb0e921aaa..25d4ab4a52c5 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -11,6 +11,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include "s5pv210.dtsi"
 
@@ -50,7 +51,7 @@
 			regulator-name = "V_TF_2.8V";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpio = <&mp05 4 0>;
+			gpio = <&mp05 4 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -73,8 +74,8 @@
 
 	i2c_pmic: i2c-pmic {
 		compatible = "i2c-gpio";
-		gpios = <&gpj4 0 0>, /* sda */
-			<&gpj4 3 0>; /* scl */
+		gpios = <&gpj4 0 GPIO_ACTIVE_HIGH>, /* sda */
+			<&gpj4 3 GPIO_ACTIVE_HIGH>; /* scl */
 		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -84,13 +85,13 @@
 			reg = <0x66>;
 
 			max8998,pmic-buck1-default-dvs-idx = <0>;
-			max8998,pmic-buck1-dvs-gpios = <&gph0 3 0>,
-							<&gph0 4 0>;
+			max8998,pmic-buck1-dvs-gpios = <&gph0 3 GPIO_ACTIVE_HIGH>,
+							<&gph0 4 GPIO_ACTIVE_HIGH>;
 			max8998,pmic-buck1-dvs-voltage = <1200000>, <1200000>,
 							<1200000>, <1200000>;
 
 			max8998,pmic-buck2-default-dvs-idx = <0>;
-			max8998,pmic-buck2-dvs-gpio = <&gph0 5 0>;
+			max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
 			max8998,pmic-buck2-dvs-voltage = <1200000>, <1200000>;
 
 			regulators {
-- 
2.17.1

