Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD93E4D68B0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350979AbiCKSvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 13:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350983AbiCKSvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 13:51:24 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA51C60C8;
        Fri, 11 Mar 2022 10:50:18 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 63F5583AE6;
        Fri, 11 Mar 2022 19:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647024616;
        bh=ef2fUlbkiG+xLfCk0wzsrrxYdCKRD/aNyVgIIKyI+vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzDqnR0wzXWdTa4E+xK6oMbtT5HUYZLJ7eNp8HsWYUVyMMGhFN7A/iLGFz2F/n5vP
         ZylGxwngPwPaRsEAsY8aPdY8Cch8Mn8Vr1KLPKlLZaUVL2/Peqm0l1w5zCde19x2RX
         XBTr/yo0DEFdn380v0MvzdUXFyL4Z/Mo8LRYClDRKSvUJB+J9s14X69Ts6gzVqFd0v
         ykw3j0pgYzaPJMQIe6RgGnL1+uNYKNwzuDhFucdkf2d9aZJzCp61aIuul8jV3XYoDJ
         UoRdUCwAz97s12E0hQsDgmMco1iythNAcsqLLBFbh7vw8pLYFVfePgqdVnT0xlTmgj
         4Jr4Pf09514Ig==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: iio: adc: ti,ads1015: Add TLA2024 compatible string
Date:   Fri, 11 Mar 2022 19:49:19 +0100
Message-Id: <20220311184925.99270-2-marex@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311184925.99270-1-marex@denx.de>
References: <20220311184925.99270-1-marex@denx.de>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
V2: Add AB from Krzysztof
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

