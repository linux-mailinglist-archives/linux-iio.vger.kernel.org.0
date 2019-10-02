Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B423C8DDF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfJBQIU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 12:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfJBQIU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 12:08:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D559222C0;
        Wed,  2 Oct 2019 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032499;
        bh=pcFz/sD7PH4IH6xMAtmOeZNqcSRuozele8JXhvaouMc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bYxG6pWcYa6FygTakxRrGwcHOMRAz4V+pzM86VRYTboCOryby7LctXEtGXVNH8jU7
         cY1CrmkZh4hg5nf4/G1eiD5+nn+tVV+lofSgIxeL9ay2sfjobdylGRVSXNpicp6W31
         9ouUToHfKBDb8nYx2fTmkWwqZi9P1+jgLnQcyclc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: iio: adc: exynos: Use defines instead of clock numbers
Date:   Wed,  2 Oct 2019 18:07:44 +0200
Message-Id: <20191002160744.11307-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
References: <20191002160744.11307-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make the examples in Exynos ADC bindings more readable and bring them
closer to real DTS by using defines for clocks.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index a0a9b909ac40..a3010e7ea051 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -135,6 +135,8 @@ examples:
     };
 
   - |
+    #include <dt-bindings/clock/exynos3250.h>
+
     adc@126c0000 {
         compatible = "samsung,exynos3250-adc";
         reg = <0x126C0000 0x100>;
@@ -142,8 +144,8 @@ examples:
         #io-channel-cells = <1>;
         io-channel-ranges;
 
-        clocks = <&cmu 0>, // CLK_TSADC
-                 <&cmu 1>; // CLK_SCLK_TSADC
+        clocks = <&cmu CLK_TSADC>,
+                 <&cmu CLK_SCLK_TSADC>;
         clock-names = "adc", "sclk";
 
         vdd-supply = <&buck5_reg>;
-- 
2.17.1

