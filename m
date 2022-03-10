Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCF4D3E34
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 01:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiCJAfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 19:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCJAfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 19:35:21 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13C6EB26;
        Wed,  9 Mar 2022 16:34:22 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1F276839B3;
        Thu, 10 Mar 2022 01:34:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646872460;
        bh=Jn0ZACdWLVjtTJ3E9qJwJpSjNc3g3GU6etMo/u9f1bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFUEsIdkNimC1tWv/i/YY5Ac3YYx9G5H5aCRc03f63Z9+z/nKFImxSknCessXTO1h
         UBIIEzsdLFmF96l3ZoB40tc1RmMGXB8rSjtMa1VdVQAc0a7I+1R5CYhMEFOo83Vtit
         +kUdwKzUgZS+7RgZggVZ+OgOtESuTUREPe6zkvo+ul1HwiN35m2RGDN7GzPUnaG3hu
         ZhUGu0RnRhgAZ+uqmsUtKVpCVNHCTOnQCn/lVSybR1jFWuaeryYiqLtV7yLBX3smud
         lK80s7+dL+HcELMstMKM0boYCUbTdVcR6BErfV5vNLqX37MPwafk336wshOMqViw6K
         mw1PQKKx/l1Dg==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: iio: adc: ti,ads1015: Add TLA2024 compatible string
Date:   Thu, 10 Mar 2022 01:33:58 +0100
Message-Id: <20220310003402.490478-2-marex@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310003402.490478-1-marex@denx.de>
References: <20220310003402.490478-1-marex@denx.de>
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

Add ti,tla2024 compatible string. This device is compatible with
ADS1015 except it has no on-chip comparator.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index c31c80989cc9a..a3b79438a13a5 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - ti,ads1015
       - ti,ads1115
+      - ti,tla2024
 
   reg:
     maxItems: 1
-- 
2.34.1

