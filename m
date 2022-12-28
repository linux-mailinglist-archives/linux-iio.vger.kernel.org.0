Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3A6587CD
	for <lists+linux-iio@lfdr.de>; Thu, 29 Dec 2022 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiL1XKU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 18:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiL1XKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 18:10:19 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Dec 2022 15:10:17 PST
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9429B4A7
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 15:10:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1672268696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX12PPrpVaQ0okjZ3v8ED+SmTV830cTNmWMddh4n+Lo=;
        b=QLNE5vt8ljE1dRTI8h1E118N/nN3feZym7Ma+9Qih+dnAkHUHutHetU7TXhbZ9vXAl7nri
        EcsMhLnqM01hsu78E7088xdWo1OkpVIjxZMCMlWPDCFORhB14u+DNtj7cSCVsFPEFjouI7
        31+FaDg68lOhNdqEgHpmjhcYfgE3+88=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: iio/adc: qcom,spmi-iadc: document PM8226 compatible
Date:   Wed, 28 Dec 2022 23:04:19 +0000
Message-Id: <20221228230421.56250-5-rayyan@ansari.sh>
In-Reply-To: <20221228230421.56250-1-rayyan@ansari.sh>
References: <20221228230421.56250-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the compatible for the IADC used on PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index fa855baa368c..18aaf6df179d 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,pm8226-iadc
           - qcom,pm8941-iadc
       - const: qcom,spmi-iadc
 
-- 
2.39.0

