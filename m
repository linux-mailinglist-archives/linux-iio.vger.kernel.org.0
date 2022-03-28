Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B44EA07E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiC1Tvf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbiC1TuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:04 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB95B65;
        Mon, 28 Mar 2022 12:47:45 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0F64383F7D;
        Mon, 28 Mar 2022 21:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496862;
        bh=eNaPFGNFNc1sKelaNjDEWR3YYyLoKTdtvyHaR1Eu4vY=;
        h=From:To:Cc:Subject:Date:From;
        b=e097iEkQY49L1NxFV/bgDU3Y+lM6afUEmME3HphNfYHbS2JUn8vNrZY4RQx6VT0+5
         ywqsJWRSIad8mOzVKXydEmXBI1ugz+p99p4fnSeJug/tYPhPlhv0JGIrr9IwXZVB2Z
         +cCuThvQRJBPBzOT/yzWv3Non9zIPvG/rbtET+9KyyGN76smtcmnIdzSbwLEAa8DLz
         PV7bPIorTIDdFLXr+uSmT/MCUS3mT+sNlLgXN3V20dGRP+gLxGVD676OL+J66P99pz
         8rLZ8NOhIDruodi5ClO2k+GfRE8iJg8xg0LFfKfnCG8VqZBfhUa7H0EEbOjzoHunyT
         BI0QFc+SKYJTw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 01/10] dt-bindings: iio: adc: ti,ads1015: Add missing ADS1115 compatible string
Date:   Mon, 28 Mar 2022 21:47:16 +0200
Message-Id: <20220328194725.149150-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing ti,ads1115 compatible string. This compatible string is
supported by the Linux kernel driver and the ads1015 is a 12bit ADC
while ads1115 is 16bit ADC. Add the missing compatible string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
V2: Add AB from Krzysztof
V3: No change
V4: No change
V5: No change
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 2c2d01bbc296d..c31c80989cc9a 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1015.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1015 4 channel I2C analog to digital converter
+title: TI ADS1015/ADS1115 4 channel I2C analog to digital converter
 
 maintainers:
   - Daniel Baluta <daniel.baluta@nxp.com>
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: ti,ads1015
+    enum:
+      - ti,ads1015
+      - ti,ads1115
 
   reg:
     maxItems: 1
-- 
2.35.1

