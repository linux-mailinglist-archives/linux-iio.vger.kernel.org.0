Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E707B7CA85E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJPMrT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJPMrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 08:47:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A5B4;
        Mon, 16 Oct 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gZRV5updU3JChhVgMmhjsN3bQoEHIwgtUSD+mM5NGdo=; b=UG75TLDyG8G6zfBjQpFqPNURqj
        Ty0X7Ja4/kzPtQMj+vJZyPf1EsCQ8yX9jMnHtcRpqGGspPtiLt9PTR4d/F8Stgc1QDM6DzhEFZE7U
        LNMabbO/d33tPMfI2OKdbaRL2wPBPndoLCVy39SPVq8Dd33qt4JM3vjNePX/cUGxDKPH47vQ42LOd
        xFBCNGqPqdb3LighgZirwpwRilbgpa9Fyd/JKmWVAKRWfQU9RHWPohaThmDpFgVGKoFJV0zhbEAqP
        5wWN1LDK/d7mb8lqSY/16hNoCIEg5ZsUDRjSgLRcboGTAFVZubbHiayCBEmi8ulzrQ5lb7FPpFGgG
        nQtbP2ZQ==;
Received: from re-byods-146-50-198-227.wireless.uva.nl ([146.50.198.227])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsN03-0013kp-4I; Mon, 16 Oct 2023 14:47:11 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Mon, 16 Oct 2023 14:47:02 +0200
Subject: [PATCH 2/5] arm64: dts: qcom: sm8350: Fix DMA0 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-nia-sm8350-for-upstream-v1-2-bb557a0af2e9@igalia.com>
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=nespera@igalia.com;
 h=from:subject:message-id; bh=O+vro6lsVyRiJ+WlZZyMlPQe73DrzOBSb3On81V2liY=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlLTDMSGrz73g92XkqVSA+Ad8jmZbiHJWW8CFj7
 T1zAoQpSWKJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS0wzAAKCRDyJM7CN1bi
 ra4bC/0fDuE3KWZz7p2965vVdmO/CYW8wqxushzXsmw6tbydZqRdN8tLYrsx9/gkLGkmBtAMy67
 ZGczzIz0jro9hSkdglJOFdmzRJAA2yluhZjAOfkdFhuxFWAdGxHpHC9r161POz/YTmtWRoL5C40
 6gvD7e5jwOhQ13wqdwqNwY/nGYW6bvJvhMSthP+iZfvy//Q2x/emxFRtAu+yLlwFliP8G1m28uM
 5aLznT0EPBIu3rtdAzT+DklG3cQVoDpdPINyb3C7DT/m5ekKe9SHKX8kY6OOhBDJDydgJHuxA+v
 Umo/VMLns2fAUpExIM4USIlYxNW1X1Z0klTbglvOuGwlPek77rpgc81rLKG+qHsJEakeJOWUTza
 JSJaCUTQwGjtFcAyJGB8uaBXNMFYu7wZndNX6ctGy2FjywQBV2Z8N8V7/qVXBxaGyR6XuCzwMph
 Ld6lhFEGVIgC2Idqx8njL5HsSevfGAbSndCvIAELdXeHXKa+d/7sLBe9Yp6RTjsysm4Iw=
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

DMA0 node downstream is specified at 0x900000, so fix the typo. Without
this, enabling any i2c node using DMA0 causes a hang.

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 00604bf7724f..6d12066389fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -918,9 +918,9 @@ spi19: spi@894000 {
 			};
 		};
 
-		gpi_dma0: dma-controller@9800000 {
+		gpi_dma0: dma-controller@900000 {
 			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
-			reg = <0 0x09800000 0 0x60000>;
+			reg = <0 0x00900000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.42.0

