Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C35AC5B9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbfIGJVO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392381AbfIGJVO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:21:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7AC21907;
        Sat,  7 Sep 2019 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848073;
        bh=szqE7WiJE89jv3JbD2laqpsXkx3HLaIdOm2W3JGMdpE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zd0Y7YJtoxY5qK8DvNeob75REKPQ9QeNh0+sDDr8qLaL/9R74fyOJNRmufmuz7tff
         MlS5uhzeyIOeLBd+LfG7MUJpPI2fmPlH4KI0It9IEYADDHpW6/5K/Xdk2kiFxSCc/s
         Nht6nLxiSI40MyvaLcODhJKtyyhTWxY0Hed9MYzE=
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
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH v2 11/11] dt-bindings: iio: adc: exynos: Remove old requirement of two register address ranges
Date:   Sat,  7 Sep 2019 11:20:07 +0200
Message-Id: <20190907092007.9946-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit fafb37cfae6d ("iio: exyno-adc: use syscon for PMU
register access") changed the Exynos ADC driver so the PMU syscon
phandle is required instead of second register address space.  The
bindings were not updated so fix them now.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch.
---
 .../bindings/iio/adc/samsung,exynos-adc.yaml     | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index dd58121f25b1..b4c6c26681d9 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -25,8 +25,7 @@ properties:
       - samsung,s5pv210-adc
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   clocks:
     description:
@@ -55,7 +54,7 @@ properties:
     $ref: '/schemas/types.yaml#/definitions/phandle'
     description:
       Phandle to the PMU system controller node (to access the ADC_PHY
-      register on Exynos5250/5420/5800/3250).
+      register on Exynos3250/4x12/5250/5420/5800).
 
   has-touchscreen:
     description:
@@ -83,19 +82,8 @@ allOf:
               - samsung,exynos4212-adc
               - samsung,s5pv210-adc
     then:
-      properties:
-        reg:
-          items:
-            # For S5P and Exynos
-            - description: base registers
-            - description: phy registers
       required:
         - samsung,syscon-phandle
-    else:
-      properties:
-        reg:
-          items:
-            - description: base registers
 
   - if:
       properties:
-- 
2.17.1

