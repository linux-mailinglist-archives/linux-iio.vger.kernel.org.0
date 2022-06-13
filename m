Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310345492A7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiFMPQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387075AbiFMPPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 11:15:37 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96E121CE8;
        Mon, 13 Jun 2022 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655123734; x=1686659734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oY0J3ZwlUA5PrPLGwau5PWqQWKKy55Oq1A5fnzIP4e0=;
  b=dVfAiI37yXhV2yqalzMdpDX/XJf159jYQDa1rghziDs2JNHjX6ZH2YCH
   0JD4cxjJ0C/7iumvhUN81kdo4fj2gzYrtQXvh/pjiKqbLVRCPX/iQpdfs
   fjQFC5+LzIT2bSfy4Evn+XoOR+XX638AKXGmsX926twSNRlTem/ZSeGMY
   CIu/ZuKX6XlHjIhLvq9EdzoOa44JPL8c4pfCHSmxNDzyL+Pc5LH3L2Z3I
   TtYA13+W8SOT9RIEKYs/I14LWTEl6OYMfQwq05FenrdjIXfdD+6fmHpk/
   DlIULqj2uUaSChANEomGk6LaHe19e9JZsO07vzPe8cw8k3Z7wFnqoUEdA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="24418790"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Jun 2022 14:35:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Jun 2022 14:35:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Jun 2022 14:35:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655123731; x=1686659731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oY0J3ZwlUA5PrPLGwau5PWqQWKKy55Oq1A5fnzIP4e0=;
  b=I10LMRIJydLEjNqG5RVbtLgXbn04Aa54D8tR3rOOPmf3WWViS7Zm3Mve
   Kfr8tnTJoPcxPrDwj1bjx69HuWjelkt3hdUaShmFQuZqHbF7Dx8zjdiSf
   bB5NNsxWOVmhznpMrdcTajIByvfquY4roJLwPbAcD7Tq7yg23iybxo6OW
   EI34tXqr6Q4Y+BmYXmIh0w97c9b3EnoI9Gz01gT/BpawZ51a7hbHzyBFi
   BErjS0ePuToCcHoa3edcN24TyF0bZNqqOf56UmTdYo5vH3Vlk+apVuCvJ
   6D1+mxFSpKPrU+JWoqj2/RniIOYwO1YuefbtICVhChSIWASNSMUYjOZ6L
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="24418789"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Jun 2022 14:35:31 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 39FA3280074;
        Mon, 13 Jun 2022 14:35:31 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Date:   Mon, 13 Jun 2022 14:35:29 +0200
Message-Id: <20220613123529.466528-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both are already using the vf610 compatible.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
index 925f355cc21f..c770ff4998f5 100644
--- a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
@@ -14,7 +14,14 @@ description:
 
 properties:
   compatible:
-    const: fsl,vf610-adc
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6sx-adc
+              - fsl,imx6ul-adc
+          - const: fsl,vf610-adc
+      - items:
+          - const: fsl,vf610-adc
 
   reg:
     maxItems: 1
-- 
2.25.1

