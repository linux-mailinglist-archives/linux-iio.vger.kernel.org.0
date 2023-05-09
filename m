Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA276FC67A
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEIMef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 08:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjEIMee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 08:34:34 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B940D9
        for <linux-iio@vger.kernel.org>; Tue,  9 May 2023 05:34:31 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:5484:c4b7:4aff:589c])
        by baptiste.telenet-ops.be with bizsmtp
        id ucaT2900C2rLuoZ01caTeG; Tue, 09 May 2023 14:34:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwMXs-001duD-75;
        Tue, 09 May 2023 14:34:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwMXy-00CHJT-Tk;
        Tue, 09 May 2023 14:34:26 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476 compatible value
Date:   Tue,  9 May 2023 14:34:22 +0200
Message-Id: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The conversion to json-schema accidentally dropped the "ad" part prefix
from the compatible value.

Fixes: 8c41245872e206ec ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
index 1c7aee5ed3e0bfb2..36dff3250ea76fe5 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
@@ -90,7 +90,7 @@ patternProperties:
             of the MAX chips to the GyroADC, while MISO line of each Maxim
             ADC connects to a shared input pin of the GyroADC.
         enum:
-          - adi,7476
+          - adi,ad7476
           - fujitsu,mb88101a
           - maxim,max1162
           - maxim,max11100
-- 
2.34.1

