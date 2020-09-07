Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8C25FEF5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIGQMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgIGQMa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9171206E6;
        Mon,  7 Sep 2020 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495149;
        bh=mmrbMHMlywRamMbAoD8m1NVZ3xc1llmLdf9vpJqmSWo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hxu6rgxfiW5iKv9B71dOEX1kzrSB+ZYt+jhvfDbkfRFnmnvS6eX2DH/XPC4N3lKpu
         /PgWsiwEnSuoQx8iUkpRVrFOYYn0uFjBMWSd1s4UXaTA9DNVQxGibJkseL5//NfLG9
         Eyb3VQ6NgnRYkwyP7nrUpwzH/UwHSLEBjRIPMdzQ=
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
Subject: [PATCH 02/25] dt-bindings: iio: adc: exynos-adc: require second interrupt with touch screen
Date:   Mon,  7 Sep 2020 18:11:18 +0200
Message-Id: <20200907161141.31034-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
screen.  In such case the second interrupt is required.  This second
interrupt can be anyway provided, even without touch screens.  This
fixes dtbs_check warnings like:

  arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/iio/adc/samsung,exynos-adc.yaml      | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index cc3c8ea6a894..89b4f9c252a6 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -41,7 +41,10 @@ properties:
     maxItems: 2
 
   interrupts:
-    maxItems: 1
+    description:
+      ADC interrupt followed by optional touchscreen interrupt.
+    minItems: 1
+    maxItems: 2
 
   "#io-channel-cells":
     const: 1
@@ -107,6 +110,16 @@ allOf:
           items:
             - const: adc
 
+  - if:
+      properties:
+        has-touchscreen:
+          true
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
 examples:
   - |
     adc: adc@12d10000 {
-- 
2.17.1

