Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6825FEE3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgIGQYx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgIGQNA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A91021789;
        Mon,  7 Sep 2020 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495180;
        bh=GtKhtYeqhoFhkk4l+56UWm2i17dljFhd74agdK6C2Ew=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1HtKxRs+iHnNOY6R6jfZ5BjznDhzhDljRmRFsaA+oDVT7biI+paXbhSVSYefBbH5c
         RWilAlgGup9PDTDvQF4NK/kbiRwvTiMby/9/r43rcNd/ygb08hYwoCtEZwqCxI73ZM
         qiX3bUrZveJfPjCkY/XQ3Q39CjSsqM1f0oCdurnI=
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
Subject: [RFT 07/25] ARM: dts: s5pv210: move PMU node out of clock controller
Date:   Mon,  7 Sep 2020 18:11:23 +0200
Message-Id: <20200907161141.31034-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Power Management Unit (PMU) is a separate device which has little
common with clock controller.  Moving it to one level up (from clock
controller child to SoC) allows to remove fake simple-bus compatible and
dtbs_check warnings like:

  clock-controller@e0100000: $nodename:0:
    'clock-controller@e0100000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 5c760a6d7955..46221a5c8ce5 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -92,19 +92,16 @@
 		};
 
 		clocks: clock-controller@e0100000 {
-			compatible = "samsung,s5pv210-clock", "simple-bus";
+			compatible = "samsung,s5pv210-clock";
 			reg = <0xe0100000 0x10000>;
 			clock-names = "xxti", "xusbxti";
 			clocks = <&xxti>, <&xusbxti>;
 			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+		};
 
-			pmu_syscon: syscon@e0108000 {
-				compatible = "samsung-s5pv210-pmu", "syscon";
-				reg = <0xe0108000 0x8000>;
-			};
+		pmu_syscon: syscon@e0108000 {
+			compatible = "samsung-s5pv210-pmu", "syscon";
+			reg = <0xe0108000 0x8000>;
 		};
 
 		pinctrl0: pinctrl@e0200000 {
-- 
2.17.1

