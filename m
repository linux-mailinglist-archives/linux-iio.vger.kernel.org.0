Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D27CDFB2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjJRO1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345541AbjJRO1U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 10:27:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303FE10C7;
        Wed, 18 Oct 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=efNuveP4VSQprhkHQkpwOHrplziHFsZy17voswzgGok=; b=sIbMid20VaYul+AKT7kDbObZs7
        EPY6mXjJUjfl15uvhcURAWRFNOITE90SaCvOH2XnVQx0GFBo9ZTxmu4bnzOiYYT/q4wEEP/BRTEQ6
        Oo+ny7BagahAzAvJW7jGUvp7D1xez2RxwN9UYTorVkkdk3LxbuWOFbigHA9IdulWJ5uID0kCNGvwg
        QagfzywzmkwmLrlUZVPXtc4wGWPWavD5Klb6EFq5Ru6N5JOhdHkqz8+mWkXgZhnfc/hrX+yygdmnV
        4LvxEA7Vbnth96uTvg9CkuBmPhB4waTne+Im/2bKV6AewNTqZI5ynESD7gK3sbahe6ArjYXq2WnC0
        b+lTua8Q==;
Received: from [145.18.212.154]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qt7Uj-001paE-9O; Wed, 18 Oct 2023 16:25:57 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 18 Oct 2023 16:25:15 +0200
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt
 type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-nia-sm8350-for-upstream-v2-4-7b243126cb77@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=nespera@igalia.com;
 h=from:subject:message-id; bh=2PFXMWXBlmj0rQF2r2HKHb1q9m6vmsAuphNOSZ7iliw=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlL+rqoMi+lT6l3oC2K//kUoPDjzNRtkqPDeteR
 fNs+bLOflOJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS/q6gAKCRDyJM7CN1bi
 rQ4yC/95ExZFTdESZ6udg5FlQz/41i7JcVGI4Cxr0kjIfB3dBhG+te87REsmjRGE00MXDGiHtV+
 wpHVqQKNTDJcBUalUu8jOeH9ECfh9+XDVP3ebz/y8VqTkj1FZEcPfvzDE6KXP0Tu6mFaU77fzB1
 4sYohwYRiWlC9XYpmI0D/uJqFK+Js+xHxlG5KI/O60ohSUgcwNAwWPxV4skKLU486FM4Gym5lkv
 tlAhJiIdt/z86U0qAXxkvUL2dtuxYlMpVz1NpFEMFrYkcwPiyhFnTGhedJMaws6ymkDaSFQp7n6
 gjv8l7mW6BwraDdsxeFEduX7K9RbtcVRVvnprcPD7Ao8Z0R49H1lqjYHOfK1Vymd+s94u1OWdUo
 wqGQti2gLBdrfPtPiIecYfUMag7/jzQOf4jVsMCDjrqMRzrLpgFxdup0WyteXDKCy8kQOdvnNyd
 TKEA09am1HHsLD9Tpm02ug64JdNPD5NK+3hhegUWEarCCogMOsmA/IDl+7asRBjaHpscU=
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

In a similar vein to
https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasivam@linaro.org/,
the remote processors on sm8350 fail to initialize with the 'correct'
(i.e., specified in downstream) IRQ type. Change this to EDGE_RISING.

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 6d12066389fa..7d5ea338a870 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2020,7 +2020,7 @@ mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8350-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;
 
-			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -2062,7 +2062,7 @@ slpi: remoteproc@5c00000 {
 			compatible = "qcom,sm8350-slpi-pas";
 			reg = <0 0x05c00000 0 0x4000>;
 
-			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 9 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -3206,7 +3206,7 @@ adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8350-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
 
-			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -3511,7 +3511,7 @@ cdsp: remoteproc@98900000 {
 			compatible = "qcom,sm8350-cdsp-pas";
 			reg = <0 0x98900000 0 0x1400000>;
 
-			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,

-- 
2.42.0

