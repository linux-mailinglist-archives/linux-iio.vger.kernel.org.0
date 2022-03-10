Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA694D3E32
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 01:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCJAfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 19:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCJAfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 19:35:21 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FC6D3AB;
        Wed,  9 Mar 2022 16:34:22 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4A9F8839B0;
        Thu, 10 Mar 2022 01:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646872460;
        bh=rxXM6fRiMKH0DIBMhPwOHgYLt0QPS1MCveP5wJWaHrY=;
        h=From:To:Cc:Subject:Date:From;
        b=xIU7mS8AME02Jsa+tWrC4oyOoDf95XKwM8Suc/e28BOihoMnplj1ed3oc6s32E8rS
         g4DUynBn3dDbyVDJ/NXL1YGdyyPe8VYuTkWWpi6qwQIAwmhFeHX0z9FdBxjqPB/tUh
         /dUZPx/Q7wpeKa2p68D8cVWpnOj3cP7DLmgQ0sBmdeA7gMg+nuwoOirxVI8OA+jyOm
         J3OSSyvI7mQLi9d/TNw++dNf4h5LxbdIVoveQe2ORVwDDynb0wkvFUg1SquBROSCyv
         E2Q7so/QbLmUAWVrNwFwQ8VxPSMnJ7Q/1lq82YetROmuhfsqhpM2brSYvHbv+qwxgP
         lPl1gSmXXKQPw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: iio: adc: ti,ads1015: Add missing ADS1115 compatible string
Date:   Thu, 10 Mar 2022 01:33:57 +0100
Message-Id: <20220310003402.490478-1-marex@denx.de>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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
2.34.1

