Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97877E5CAC
	for <lists+linux-iio@lfdr.de>; Wed,  8 Nov 2023 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjKHRul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Nov 2023 12:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjKHRui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Nov 2023 12:50:38 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4681BEF;
        Wed,  8 Nov 2023 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qwqzZtkcXZc3OkNPJmm1+6PhhO4xyqN1G7JcRiwKhlI=; b=Fjj288HTDMLCJWN0KjkegXCR1m
        qWBmGvOOlT0EkTAFhtcjh0RajOyPozi/DTZiBq5qdbARjYC4V396z4E7XiBUOe6+iTz25YOogVdgN
        4a8ZH6QbJv0hRHrbAFyS8W7qNGIn9Al9e+TYUzI6tpe8jSLGaG1SlcU0tP1lkIxH7Si8GBJH/AjHI
        8jSOhXXgt+jQzZEJm0zcRsAfiOBzD1sALZ9LnHnq+SAgPHckOui0+MMLUT043gpVhTwBYd9WclPst
        dyera8XY+dQSFg0Z7XOtI36AdlWdTk8vxM913aeN9brpTHQWmObVteVDJFeItgykNKNplbEBettB4
        cTbzX+5A==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r0mhE-000vX4-0d; Wed, 08 Nov 2023 18:50:32 +0100
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 08 Nov 2023 18:50:26 +0100
Subject: [PATCH v3 2/6] arm64: dts: qcom: sm8350: Fix DMA0 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-nia-sm8350-for-upstream-v3-2-18a024b5c74c@igalia.com>
References: <20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com>
In-Reply-To: <20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=nespera@igalia.com;
 h=from:subject:message-id; bh=uovBa8q6G8tS3dULOFwRiS9jeP93jHuTebmV0TK766Q=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlS8pksJJlF5qjz3S+bxuj7DQx9yy947g34uvKl
 P27At5KFB2JAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZUvKZAAKCRDyJM7CN1bi
 rVTkDACO7A3BmR3eGe0OJ8TK5cRLPCVmGXTpqX+QXzLY6uYGoPfIuQFrvo9EsB46Otlj6z55L49
 e0OKXSSbhTYuu5S0KS6Sbu4G6AsEk5UfmE0eozF+rI7XKwuvEclsxIhvNRIX2sIiO8LO6/JGCU2
 rcM0SXEwWEv6ItVSqvOdiwRkJMyW9CiqWAoSJ9Lie0xHo4+LIeE3ahGOq1o8BRuJ4riOHryP0gG
 d/HED+ZrKr7vUL+MyKYB8HYy8evpmW5Ide2kw3qbs5wcGLzFEWPo6fsoteUJEliqTrhxbI9LU7N
 4YXjlotxeXJ2cRray1+3JEVWLxGhdwuuMokJ4vWdVkVzDphgGjXgAko39pS7h755a23f7c0KxIA
 y6C6yPk3gBLOdP2ckjBcXHSsz8DNq0DV5Lpzkwu+TzAm+WpbdBBTqqr0nY59KHi9wNUFFGSLuqg
 grzsgpW8wqHUxyRn/U/gw+V/m1chGXbGrx6RQyCC+c5LSv+QNHJ90IAG0RHigrtraXWTk=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DMA0 node downstream is specified at 0x900000, so fix the typo. Without
this, enabling any i2c node using DMA0 causes a hang.

Fixes: bc08fbf49bc8 ("arm64: dts: qcom: sm8350: Define GPI DMA engines")
Fixes: 41d6bca799b3 ("arm64: dts: qcom: sm8350: correct DMA controller unit address")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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
2.42.1

