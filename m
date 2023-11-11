Return-Path: <linux-iio+bounces-39-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E817E8D09
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DD9280E24
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C920325;
	Sat, 11 Nov 2023 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EJCJeh7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903E1DDEE;
	Sat, 11 Nov 2023 22:08:03 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0423840;
	Sat, 11 Nov 2023 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2CnUQaTGxqUvfFdrUxE6AYsi+03ONnUHcjpsmARcoik=; b=EJCJeh7J0t0UmxZVZpbSXrf30U
	l+b8MZQmixHxAWYLA4YkpVgwB67/3C60v7R4SxahGhwK6bhB99u8neX604x57th3bG/2gBVIn0wwR
	hL/Qr1L8um8MZ7ST2HbbRj2uRsSQWTittyHpQUJd0r4014unxEKpR6ecWPTPq9/IYYaYwnVSa6Du3
	iLHrNuy3ro9oRzBT1lSN9pO1BHuUVbfe2ZdzS9j8Fzye+07MuEcqDHM1olzrdu57LXgmMRXb4jfhc
	9fsqCWBmEla6gPuik6C0ef01iz3k7hc7ldAWCNb05hIZPiG2c3DyMM0IdSvd1RnZbEpmJPfSlDZvn
	XrmrK+9A==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w8z-0029Vw-WC; Sat, 11 Nov 2023 23:07:58 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:41 +0100
Subject: [PATCH v4 3/6] arm64: dts: qcom: pm8350k: Remove hanging
 whitespace
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-3-3a638b02eea5@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=nespera@igalia.com;
 h=from:subject:message-id; bh=0RUB7KOCa+Dyd4ytet9GLCvRq0z08dzAK+GEyion9dw=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s5UjcjTmdZAw3kS04syOcCyCUWjZxYmlwt8
 zv/GSaAJ7SJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OQAKCRDyJM7CN1bi
 rZeZC/9SkQZpfkgdNuEbx273eRja6ZhHoTlIfCaDdXIzrc8VBw9rGlyXLIDSBeFYGoA9d93ETE9
 /UbHtBOCk3GgdrX+PWvFRXo+ElShHmEp2ycfEZSKlAbwwJNgBPnnxK0C1oQUZA8tjTG5LEJt0HM
 wPwwcTUXoFa0CpwQjU81a0W1mFvNdIE41Wb3nCZUZoX+1IWs/b/H+SzzKOGTRQooYSCeNo6X1s6
 cw85tlq6XGegu4qH6C1tbognaaOI/iTCX13ZKM/HtUzjxh4X2TFI/2ZDR8Io+Nyxt4mVY50sove
 vGqp0RELUNJCIiAYV8LIMn4R0WRDLDKpMbbIAf4U/3yusGAdR6U9/JzEtwmOvUXxa5ZvoYVgs0k
 nfPOjoGl963AHjuAR0xuLj3gX45+BHi1R+tlxli/nnC0jjJfgQ0NrnnZnJFninFfZ9+L1NRNGRt
 wdGh0geEiERpSrzCfWuG2JPjpPza63Ucg2F1g177YyCLufOK3CRCB/6cczSRb7UN+XPCk=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

pmk8350 has a random tab character inserted, so remove it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nia Espera <nespera@igalia.com>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 1eb74017062d..f0ed15458dd7 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -22,7 +22,7 @@ reboot-mode {
 		mode-bootloader = <0x02>;
 	};
 };
-	
+
 &spmi_bus {
 	pmk8350: pmic@PMK8350_SID {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";

-- 
2.42.1


