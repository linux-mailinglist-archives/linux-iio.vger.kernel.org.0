Return-Path: <linux-iio+bounces-40-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0107E8D0C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8257D1F20FB6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60D208A6;
	Sat, 11 Nov 2023 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CzyCJ8SI"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAF1DDEC;
	Sat, 11 Nov 2023 22:08:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4F3272;
	Sat, 11 Nov 2023 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qwqzZtkcXZc3OkNPJmm1+6PhhO4xyqN1G7JcRiwKhlI=; b=CzyCJ8SI12ZIBmK3408OeB8aVH
	s2NEMg12U7WOMYgKMhv0zTBD+vmQgH8yWrgC0qSlz99NmdGzI99tlJAEC2Za7WyEa3zjWM4sJQ3PN
	2GSvRcqcw1hBFYK+9vmAupki/SipIN6L6d12iy0o33yc4DslAidaB1YDPtgfHLPeiB3fML5UC5sLD
	XpfOD2ivdXxF7SiEdF004F/HjXH6wziiRSyayTRRVXPr+3n2deN/7Wxq8XGwCQDWAY8YODyXpV7Lk
	Rb0BvxLlrn1j0A6q5o4Uh8To7/i/eabeOgo2qM0HQ0iHGxyO6A3VjJr9JRuvOTfTkgHcLOgpvLHUV
	jDCzHBMA==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w8y-0029Vw-Nc; Sat, 11 Nov 2023 23:07:56 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:40 +0100
Subject: [PATCH v4 2/6] arm64: dts: qcom: sm8350: Fix DMA0 address
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-2-3a638b02eea5@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=nespera@igalia.com;
 h=from:subject:message-id; bh=uovBa8q6G8tS3dULOFwRiS9jeP93jHuTebmV0TK766Q=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s4np8H5S0hOna8t05ffx/mA+Z0mtZibx6Rv
 piwgAnb+TSJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OAAKCRDyJM7CN1bi
 rcw1DACcDiVuAB12Ql6u84b0ahab246ooXTnIudohg5hep23wp8ebC4YUj5YMcwTEZcQ0J/h7+d
 fXPxXncaxFXD8IdgydD0Ww5FgM0do/Vmv1/VewexdGUKnW1P1hq+9ltzQlny4OzG3tTT75mrO6p
 FBhpYdAUujHV8GKJ1wWeNlXIhkEub/fEBDOfKzuLtUuJhlVjppPYhQY2gk/IPv07MaslmP0hzAf
 X2B3eG93HjVXd5MwUkA1GXsWAdOm49KD34pO1KQkGWShC7s/mAbukjBWu0NhPT7gwkScKCUa97c
 k1Ov+drMgvGYxKRDljmUrd9/b2gojPvFs54sXq6i0TBH0VikOe+oWSVIqqGi3vhZ56wW+hOqCl2
 nEmp+IgL1XxZUwHH98qFvVDTHA6W6rbvNSvbr3LH8YZMFQoCTemFmnKwhI2oPf7T4TAjA8jkIw4
 cOvUcT3GWUP6eb8zi6oIyEmplwSQ7KNJui05AjXsaWg6RDOpAqcStOa0ZX8hDT2HzeNH0=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

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


