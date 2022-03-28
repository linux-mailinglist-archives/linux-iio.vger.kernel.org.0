Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D714EA0BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiC1TvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345649AbiC1TuC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:02 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205DB13;
        Mon, 28 Mar 2022 12:47:45 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 84FAD83F7E;
        Mon, 28 Mar 2022 21:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496862;
        bh=Cjl9mSicvUiED0u0YTBFHqN+vdDBzVXFMydlI4w/oTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZV8+nHqD4JMDUBF/Yv2Rh/vXeYOeZmiYm7aWhEuw9/qZzvB8v1dX0hl9W4eAnMb5
         zuOH6UUXNXlQso7UvOzcs7vbr782EkbDTMa6wgrk1JSy66HFy+gCCciTw0lySmhAN3
         nNtmlhT4yAoGylbqfmaOxvJtJ4eV0JevQ8DDIRG0nuhqfqa5WRdhfm+jpx2SxMHCYH
         RJnDdcliCnZdctL1pnl5ffiRPfEzA/+uCwPLbGX0wtAr8hJqU0HETBZEoJq7n0QL+Z
         iLQNxaoZay75xZVjRAzvMdKQGdXibS6efmxKOv0ffD7Wmf1di7VscDlhTDudFCdHcs
         mOzO7B3uWkg2g==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 02/10] dt-bindings: iio: adc: ti,ads1015: Add TLA2024 compatible string
Date:   Mon, 28 Mar 2022 21:47:17 +0200
Message-Id: <20220328194725.149150-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328194725.149150-1-marex@denx.de>
References: <20220328194725.149150-1-marex@denx.de>
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
2.35.1

