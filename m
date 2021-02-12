Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2E31A2F2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLQk4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 11:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBLQjE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 11:39:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AE3E64E76;
        Fri, 12 Feb 2021 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613147902;
        bh=9WJDOv6LqmavZD/gcwbgUYrQTdVMFQ4jH6W3lKzKcnY=;
        h=From:To:Subject:Date:From;
        b=gkCTxMiw2MJuREDJn/mmcl4VfMx4fZcdedyxfDmjVqIkUsIqvCX4vhol/Ya0y6ikF
         lFGYpSPGNpYUJbWZGpVRACGCqM0r8AXczMVqKzA2+imDLeTK2EvR3Svloy/T9jRTE2
         0Fc2eIYtp5tdEqqatGjhGXwmgJA2GowgGgzXwNkzKXbC0UsMNjDNlHFRwnAF1oTzXA
         bpVD/L+MtL31HXybavHJOe5iaqLSLkBep0p2k2jqQ5H8r5vTUpt+JPQXeLnUYRr1P2
         xrtNavdcro2iSPrmT3aINPN7LvOa1GujZ+iqKElt4X0ALqQOcPuJF2EYTsyHEdwsH3
         +rI13JKVEp37Q==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: samsung,exynos-adc: add common clock properties
Date:   Fri, 12 Feb 2021 17:38:16 +0100
Message-Id: <20210212163816.70058-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add common properties appearing in DTSes (assigned-clocks and similar)
to fix dtbs_check warnings like:

  arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
    adc@126c0000: assigned-clock-rates: [[6000000]] is not of type 'object'
  arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
    adc@126c0000: assigned-clocks: [[7, 238]] is not of type 'object'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/iio/adc/samsung,exynos-adc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index c65921e66dc1..ce03132f8ebc 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -27,6 +27,18 @@ properties:
   reg:
     maxItems: 1
 
+  assigned-clocks:
+    minItems: 1
+    maxItems: 3
+
+  assigned-clock-parents:
+    minItems: 1
+    maxItems: 3
+
+  assigned-clock-rates:
+    minItems: 1
+    maxItems: 3
+
   clocks:
     description:
       Phandle to ADC bus clock. For Exynos3250 additional clock is needed.
-- 
2.25.1

