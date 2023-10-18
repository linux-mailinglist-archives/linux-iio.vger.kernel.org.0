Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB27CDFAB
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbjJRO13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbjJRO1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 10:27:18 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A53C2D;
        Wed, 18 Oct 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wUhOmt/JEXhu/+rgszsfWXdTXH8GnE4jpA6yDaWqehU=; b=fJQHCTN875kaB9N/97kZhJAtQS
        01+2QAFkBZjOZKu/3O0C9PU8HL84wfv4NpjhuxNSZWZXlPcgbt1HyN1Xl4ISFTakXozPQrHYm1WhW
        wOjnsWSUIEZvRFrEKGFkT+8bioxtz0mLxR1lrnWWoGdHTUabqOPVVnORQTTLoajAHCKQuA7hRBDbi
        TO23M2j58HPReriQqhBuD713kkesjSvu0BuEZRV0zsQ/xRqYZOMDGcEyF5MiLXGMJCdHVWSWp8Hel
        8tpORH/D5EmqtZcw6t6Fo7+sX8ERmCngXoyaZnB2e5kTFlxUuUCAORupQX8b9babgR/RUo9jdY/55
        w5gPa/9Q==;
Received: from [145.18.212.154]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qt7Uh-001paE-6K; Wed, 18 Oct 2023 16:25:55 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 18 Oct 2023 16:25:13 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: sm8350: Fix DMA0 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-nia-sm8350-for-upstream-v2-2-7b243126cb77@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=nespera@igalia.com;
 h=from:subject:message-id; bh=YpKfI4JRXwrBSsHlSbVyPJk1UALjztlq3r+ERNAhx+g=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlL+rqQ990LAhoiLSu5iHaZuiLJ/ZxDDbzpGO0l
 MiWIlUG6/CJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS/q6gAKCRDyJM7CN1bi
 rZ2NC/wJN7B79hvv8s57VOtTNPqL6UbLccJa4MT0OZu1r2Gh3S10QWilpc3DJmr8f+bOqyCEn8T
 1mBgm1qnbAcpl1o9RJ4O2PMlhXbAmL44aKMiDcTQFMsbs1fG1zSH1M1gXo5+u/06JZ18qr6H4Wo
 CSOTXkyqr8B3818RsIQrHnEkkLYXxUJ+wJLW/MBciqE6zhk2I/ivhbIvb1mlUiSACQgWrXsxjIV
 SGXymNs1Erq7FIijDDRPYm8V1/hm0ab3cMC8TmZanxlsMZ1nPIzJcyb4ear0u7xg1YrcSQEXihz
 8B99sAUWWbbrJ4lg/3xhOLXwYdpL+XP644Y7KnB7Lmtoi8UUrLSJhvgjxf8kpZhHUbiQHwf9VAo
 NX88nByUyU6kBc5pb7tswXS5KlDLXq0o1KIOdC8jiIEib3miRxDUeoDFk3iIturLOu3iiRYCre3
 /62pTs66z/hWOQaLnBi+72RurSlTaFWgYMC653br0RG/MSGwssNM7NqQEaHxyAM7i54TY=
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
2.42.0

