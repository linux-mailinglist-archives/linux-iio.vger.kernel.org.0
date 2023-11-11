Return-Path: <linux-iio+bounces-41-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73C7E8D11
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE2AB20A4C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECD208C8;
	Sat, 11 Nov 2023 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hwkyFets"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61915673;
	Sat, 11 Nov 2023 22:08:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B93253;
	Sat, 11 Nov 2023 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oLB1NGiEPNFZaXayNGepJMpKvCAIVEhg6rNxsCuSgls=; b=hwkyFetssa893Jbr5vdSd2GLMp
	GHOy/TFvmVi2L3EwmPP4hNeAIiSRIeJMbt0DVhRZocz3QyGXiwLKk905EHrygtRSthBKcg5A5/onj
	iICgrQkmfMphj56NfFrKAqzQT8H0GpXZaUaf8OkkebVMcu3X/Horg6LUOSMLxtRQEysLNmSh9Tw0N
	GO2plECFeeyA9jrL4SjHVcRqS7C3R4tltOJ+ghUA1/u/joJEhFGcej9+bdMI62+KJF/FcYSzlJCOU
	CZu2yXdzg4jGVZKc1Z8U6auOJyoXn54XhyPlT2/Ot517s5+BB5bvzbxTCGmv/XQ/1VFHc33tglFeG
	H+KlSerA==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w8w-0029Vw-7T; Sat, 11 Nov 2023 23:07:54 +0100
From: Nia Espera <nespera@igalia.com>
Subject: [PATCH v4 0/6] support oneplus-lemonade(p) devices
Date: Sat, 11 Nov 2023 23:07:38 +0100
Message-Id: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACr7T2UC/4XNTQ7CIBCG4as0rMXAAKW68h7GBSBtJ7E/gdpom
 t5d2o0aoy7fL5lnJhJ9QB/JPptI8CNG7NoUcpMRV5u28hTPqQkwEJzxnLZoaGwKoRgtu0CvfRy
 CNw2FUioQee4lcJKu++BLvK3y8ZS6xjh04b4+Gvmy/jdHThm1ViltmCnB7w5YmQuaresasqAjv
 ELFdwgSpC1IwSF3VusPSDwhzn5AIkG8MAykVU5L9wbN8/wA6KyPNlEBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=nespera@igalia.com;
 h=from:subject:message-id; bh=iz6Nkw3EJXV5T7V4mGGoBF1mUCtOGZEEQH+li2dAIyw=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s4VzrDlRJUTT1/u3z88jS2qfkZ9P2GZaMmt
 nSUAcL4iZ6JAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OAAKCRDyJM7CN1bi
 refDC/9+Pxnu8X0/OVKU8BDsbDc4wiuolt/hRm97HTzy2AAuImks+0On36H9d6663Qm0kXm9F6s
 Ek9XbZAjvb6Llm3K5Fd/9kogyUB+/h7Yarc8WXrAV0tSXn1Ce7zeXTTNjyL29lDeogxBpxtB/DD
 +xlddQylUmDoM2EZWb47FmB4KsOMZ1KLSZJAo44ZlzPPjgipxjXAj1sg+IhsyLoh899HHYimTD9
 hz0FI0RjClZpEQGvkxnNEsPGVL3Lbd9Jn/9aXBBAbyYjM4z4rn2HjXrVoS54rY2TJTPk4TBToky
 u38XkOhUuCnEga62Sw03cPabnBquEftqBbrXC9YkasJOCxRdpqTHU88Qh/T/zZV1EoZqwf7ZLsn
 prW22XYPEE00WlhClHttxmgyAlT4HWPqPtEqC0POHRLURPeDe966nwY5O6r7e0aGoit41bLk1vb
 E0i9orZQKX6ZnisGXgsNP/zLXMInNVMSGj3jh2ktKPJzRQ5noKcqlYZj4FzjD3exFf+QA=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

Patch series adding support for oneplus-lemonade and oneplus-lemonadep
devices (OnePlus 9 & 9 Pro), along with a few needed fixups. Currently
working as of this series:

- USB OTG
- UFS
- Framebuffer display
- Touchscreen (for lemonade)
- Power & volume down keys
- Battery reading
- Modem, IPA, and remoteproc bringup

Signed-off-by: Nia Espera <nespera@igalia.com>
---
Changes in v4:
- Fixed up some small naming-related nits.
- Link to v3: https://lore.kernel.org/r/20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com

Changes in v3:
- Fixed up more incorrect devicetree properties.
- Properly enabled the fsa type-C mux.
- Added node for sm8350 PMIC glink.
- Patch name fixes.
- Link to v2: https://lore.kernel.org/r/20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com

Changes in v2:
- Fixed up formatting/style.
- Removed unused pinctrl nodes.
- Removed unused properties.
- Moved ADC7 defines to vadc header.
- Edited copyright on lemonade dts and license on spmi header.
- Fixed up therm channels.
- Removed unnecessary hack w.r.t. timer node.
- Link to v1: https://lore.kernel.org/r/20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com

---
Nia Espera (6):
      dt-bindings: iio: adc: qcom: Add Qualcomm smb139x
      arm64: dts: qcom: sm8350: Fix DMA0 address
      arm64: dts: qcom: pm8350k: Remove hanging whitespace
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
      dt-bindings: arm: qcom: Add oneplus-lemonade(p)
      arm64: dts: qcom: sm8350-lemonade(p): New devices

 Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |    2 +-
 .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1086 ++++++++++++++++++++
 .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   85 ++
 .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   20 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   12 +-
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h   |   19 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |    3 +
 9 files changed, 1224 insertions(+), 7 deletions(-)
---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231016-nia-sm8350-for-upstream-2f452366e421

Best regards,
-- 
Nia Espera <nespera@igalia.com>


