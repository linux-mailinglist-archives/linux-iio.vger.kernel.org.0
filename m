Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAB7CDFB1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbjJRO1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjJRO1U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 10:27:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3959132;
        Wed, 18 Oct 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WUFvCaplwb+OMl6szO4dvGflNfgGik7yhQL1tZppQ9o=; b=p/BAYykqqn83qNlFhYXWT4G61s
        +F7VZnZB4gYlepgqRm99u2gvb15986CVTGhCSbDlkYCn1vw/Evv8Ng2f656Wx7l4+jlUb5/fUY7qM
        bZkP38FUhW+M07HrMp7FWrLrvclgWk6mft1eB1kDUyj0jynjEa3PLUKNv6sNVw2PD2QfP7ze9IcH/
        AQ3qbakLBVi9xTSDLl5efKe7TiXuSF078LbzrJepmYZuU6vDHrmVFnnBcOYV7DR+Ayne+UiKUG0uA
        MDHtsMcDF/PYdPBUPymDIJaO1KTBmvQ5aBiLnPJm4Fb0MUsB7DhRCM6L3ZYLL9Ie0P2QLCNRMXOHA
        CFYPiReQ==;
Received: from [145.18.212.154]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qt7Uk-001paE-AI; Wed, 18 Oct 2023 16:25:58 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 18 Oct 2023 16:25:16 +0200
Subject: [PATCH v2 5/6] dt-bindings: arm: qcom: add oneplus-lemonade(p)
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-nia-sm8350-for-upstream-v2-5-7b243126cb77@igalia.com>
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
In-Reply-To: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=nespera@igalia.com;
 h=from:subject:message-id; bh=fZWUMa7J9qxmkjbmCBSVu6chMI8eH7xgrGVd2NuK9Js=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlL+rqoA3/hMxECL3x8PW+HKmTzeUQrPnGFnzMl
 0K4I2z/vryJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS/q6gAKCRDyJM7CN1bi
 rQ4tC/9ILy259rh/cNC/u8bFYdGQHq95g2AZ8EZSasCZlgfpqWy9z5+6jKnxKzhSXYh136bMdxQ
 X0xFdUuoEcxwMXL4qpixzxTynd7IFL2L77zRd8/YS85vJaE+FXm2PlGIPaYQcCcSNwm+ddxq/rP
 mKPeU/6TDcWXn/VG8I208+jQoOFvq9XksWFdeQgR6iz6C0jisBKS7Ufiae8Yc99maqCqBD+UPhD
 w73Cq7it7IadmQ47evA38Xszr7tbbO5QJeCUubo9JbGYQLVw4v4GwcDkcGpsoXZQEZYSaxsYL5P
 eetY6vBSFMddQu1gSM5Akn9v3FET1/RT6FIdaE9JpHwMMXaUguba0w952RWI6qibWZj6ZS8mc5o
 wFlz9wwphLxkJp4mnKCvv6/B0nGphxtlmPVC06azRlrxjRxrp1GEey5H1r+Oz64uUEPozb0q/M1
 dqRyaOA6Cx0albMAd2bcgMXDZbQm3GsXR8QY+dwDCmdH0KCRiB8/D81T1fMp41Dvdo3kc=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the devicetree bindings for oneplus-lemonade and oneplus-lemonadep.

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..72832ee5b876 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -974,6 +974,8 @@ properties:
               - qcom,sm8350-mtp
               - sony,pdx214-generic
               - sony,pdx215-generic
+              - oneplus,lemonade
+              - oneplus,lemonadep
           - const: qcom,sm8350
 
       - items:

-- 
2.42.0

