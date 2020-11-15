Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FE2B38BF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgKOTcI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:07 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F706238E6;
        Sun, 15 Nov 2020 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468727;
        bh=OwGWd3NHSyxIgpZkw6VPdhPHWtFfwz9xDkexRakgkbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsmJnbvWp1czk4RW3dYSN2MSX88EEmDIFO8p7SPt+3vleXSOM0qosKa8DrFGhdHBW
         cVGx2j0JjPczy5ZXE7iLhejSYB/s5IuHrmIqNAr8SftGU+Snq6AjiB6GkmHF/N1olA
         o21+bs3J6Lmfxe23hvKs9qrm0vsuSue0d3C3H3Q0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/9] ARM: dts: exynos: Drop incorrect use of io-channel-ranges
Date:   Sun, 15 Nov 2020 19:29:46 +0000
Message-Id: <20201115192951.1073632-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property is only relevant to consumers of io-channels, not providers.
All these dtsi files have it alongside #io-channel-cells which indicates
they are providers of io-channels, not consumers.

Note that dt_schema will now flag this up due to a dependency between
this property and io-channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 1 -
 arch/arm/boot/dts/exynos4412.dtsi | 1 -
 arch/arm/boot/dts/exynos5250.dtsi | 1 -
 arch/arm/boot/dts/exynos54xx.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a1e93fb7f694..2dcc6b848937 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -439,7 +439,6 @@ adc: adc@126c0000 {
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e76881dc0014..a9df16015fef 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -274,7 +274,6 @@ adc: adc@126c0000 {
 			clocks = <&clock CLK_TSADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index bd2d8835dd36..c43e99b6c1cc 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -844,7 +844,6 @@ adc: adc@12d10000 {
 			clocks = <&clock CLK_ADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 8aa5117e58ce..18a7559054dc 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -101,7 +101,6 @@ adc: adc@12d10000 {
 			reg = <0x12d10000 0x100>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			status = "disabled";
 		};
 
-- 
2.28.0

