Return-Path: <linux-iio+bounces-37-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76EC7E8D06
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17D8280E27
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A1200B7;
	Sat, 11 Nov 2023 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FNTrbi8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BB1DFE1;
	Sat, 11 Nov 2023 22:08:05 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DA385C;
	Sat, 11 Nov 2023 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hqS3Xb8zxQKiAcPlqwtp/fc9T8jT+De7Oynf6zktYA8=; b=FNTrbi8JZQ4KcefnIeZxW+H1DC
	DaL8n1Q3VrGZhg8SyOK0WUi1/dLAX0s/0clbgC3vsFR0g7k+OPanU5dNgAd3Dfk3Qzws4ZYwnXgVc
	k/GuGKp+B++ZGZdLaWMWtc0U2x959u7oQus2rn/jqtLxbI5dXoGb2bOAW23oJ/3VZkT2l39Vivl1a
	e0gxi//20sQodcNVyB/qB9OuRO90bouxt4fybSTLc4emaykjyZibg1lgTBkLQY45dAvdWC7k9/S9j
	51aGLssHmGpAP/W6gvVdBn/dHvC3lkZT4TLGk8R6AF/0DPVR6XYXsY9/Jksn49gCF4/LWGe5qmJiN
	tE/DWfqg==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w91-0029Vw-8E; Sat, 11 Nov 2023 23:07:59 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:42 +0100
Subject: [PATCH v4 4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt
 type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-4-3a638b02eea5@igalia.com>
References: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
In-Reply-To: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Vinod Koul <vkoul@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org, Rob <Me@orbit.sh>, 
 Clayton Craft <clayton@igalia.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=nespera@igalia.com;
 h=from:subject:message-id; bh=TP6Qt/wFuV5FNgiSUkAeQOpv15rthluHHEVgMBNHlOM=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s5x6goESgCEgVPSsbpBkCjY67TRbWFqFEm1
 ZyVRBCmSY+JAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OQAKCRDyJM7CN1bi
 rdYYC/4rkd1hkdh9OCRfg6E1AKVU5jfFwN6Q6NNlf+i7Oj2X7Jxu/8GVHAuWsNHywel8DbcmZnq
 3TyilBcxTA73HbXz+k5CMp8vfb09fmssSNGkTlAZJ5iSK/Mv17RWLA881aB9vIOAkutnaGYq438
 gXro7dwok6TqKT1acJj5dFXzZjjMFqg8yXoIpsHY+Ki3Dx+WIw/XkjwjY1TIb86Ar7YQmhP812d
 LJLzrzD+L7cVXVTAuz8HHNrTjlvk1ahXWuaApayd/nH13ILofHp1woBMmIAhpVyS9WDWLXlRQOX
 g1nfD91SF8kzduwOylE5NMoONaJKq2o+2mDnBlwFiUOkwCrP2A5ocNoDUAIZ66x0omdOjF46Hut
 0kwviD4ULbnH+8PVvx/RGPajbWjf+n9eQctjM42Af0Bkry3fSgVvk/QlyHrmzk0Xo3Ps1VLQBCK
 4e65TSjLhW1EqJR+xoZUqjfwy60njp6Bxdi89yZBS+UxKwb9A9KQAp8AbnIByhbRgLWDE=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

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
2.42.1


