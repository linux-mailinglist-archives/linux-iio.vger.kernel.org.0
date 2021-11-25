Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FF45DD64
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355995AbhKYPaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 10:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhKYP2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 10:28:20 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B5C06179E
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 07:21:58 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1511:ffa3:275:45dd])
        by andre.telenet-ops.be with bizsmtp
        id NfMw260045CGg7701fMwz6; Thu, 25 Nov 2021 16:21:56 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGZP-000DKm-NA; Thu, 25 Nov 2021 16:21:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGZP-000gMF-AO; Thu, 25 Nov 2021 16:21:55 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in example
Date:   Thu, 25 Nov 2021 16:21:54 +0100
Message-Id: <20211125152154.162780-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"make dt_binding_check":

    Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
	    From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index c65921e66dc1f4d0..81c87295912cec04 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -136,7 +136,7 @@ examples:
         samsung,syscon-phandle = <&pmu_system_controller>;
 
         /* NTC thermistor is a hwmon device */
-        ncp15wb473 {
+        thermistor {
             compatible = "murata,ncp15wb473";
             pullup-uv = <1800000>;
             pullup-ohm = <47000>;
-- 
2.25.1

