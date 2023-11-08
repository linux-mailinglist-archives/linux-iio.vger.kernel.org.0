Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAC7E5CAD
	for <lists+linux-iio@lfdr.de>; Wed,  8 Nov 2023 18:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKHRum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Nov 2023 12:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjKHRui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Nov 2023 12:50:38 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF451FFB;
        Wed,  8 Nov 2023 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S5rT8rE+ClvIH+jOcR2k9TwkiX+vDd+dKto1lL4KPuU=; b=GjVz95bGbtOWZ/NuFPASJKrMtR
        0ujtCK4NAK/+7SOrnNyW9STYlMCJkPrqYj6vPUFugSZvS/IWz0Ai9s0tCzopFVd1G/6kRRJdq5u5/
        ATy6CmFwApC7m26KJ8ux95gSLWoNEW36qPUGQ7/hC341JjP8pAJQI8Prp4zujNwRhA8e+vGn9dTP8
        16Pvk1gpibtjQCEmQjXDYphbQ3KKUDr5eZaAkhjO5JpSPqpGzKWfKgYp02u+W0/KpV32/tNoOqE2I
        L0kLDZfqDBnbXStPNLdKsinvK9Zu3TocpsIxPCsFbFrXcmvawd//sygh7x3QzdAf2kXrqx75OlKKw
        0iOwCZ5Q==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r0mhB-000vX4-Gy; Wed, 08 Nov 2023 18:50:29 +0100
From:   Nia Espera <nespera@igalia.com>
Subject: [PATCH v3 0/6] support oneplus-lemonade(p) devices
Date:   Wed, 08 Nov 2023 18:50:24 +0100
Message-Id: <20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGDKS2UC/4XNQQ7CIBCF4asY1mJgKFBdeQ/jAiq0k9jSQCWap
 neXdqUL4/J/yXwzk+QiukROu5lElzFhGEqI/Y40nRlaR/FWmgADwRlXdEBDU18LyagPkT7GNEV
 negq+kiCUchVwUq7H6Dw+N/lyLd1hmkJ8bY8yX9f/ZuaUUWul1IYZD+54xtbc0Rya0JMVzfAJ1
 b8hKJC2UAkOqrFaf0HLsrwBKwj/6AgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=nespera@igalia.com;
 h=from:subject:message-id; bh=YddSMrW4DZiUiNgGyxwXH0caeo5iX7lnnBQmIFb7hBg=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlS8pkolc8xkc5Y7FgqzYUB0GVYa+8JsC4P4rHv
 nI0SrUW4eWJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZUvKZAAKCRDyJM7CN1bi
 rUNEC/4kQ0S176UMZTgZf6B6WvIbREsTIFsAAd9/JIQ1hNUQPZdMGtND8Zx1hSNPOv0A0oaKPAD
 PPqUFocZEPBGUGKfVI93lViNASQylZ/meOmLYXFfUMiEm+/TzGAXbYWcEhzrMTOZjnz5/DQOC7l
 hl2yWr/Yx8z+/7EQ5plgWhkB86dFxBKf4L6Q81QSd4fPLLQDGonR57+kYdUWZeqPE4uIyReP0OL
 /2rdxAzljum5w9IVJroo3KUMKjEhwdRd7rWKEyAoJCvTlYLWaz8p8KddKtOT19aR2w9+pXAJPG8
 3PqCmDFYx+xFp+/iEDwS7LZm04G4I4v2rCxWRf2HAudR+AhqTFEMYn8GROUzSK/xn01PjK60ATw
 xTjjBPqVfUmAZAs2sylrfmuy0dSVMTR3OPQRuBZi2oD7sHWYwvFp8b1petWOgX8WdhVVci04Rbo
 G4TwqftUAYyDCOTutaKjaXzMywd7XIEbFcFZ/eyKeFKbJ5FNqn5CoSXdb3vhOaBV/onzQ=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
      dt-bindings: iio: adc: add smb139x
      arm64: dts: qcom: sm8350: Fix DMA0 address
      arm64: dts: qcom: pm8350k: Remove hanging whitespace
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
      dt-bindings: arm: qcom: Add oneplus-lemonade(p)
      arm64: dts: qcom: sm8350-lemonade(p): New devices

 Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |    2 +-
 .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1088 ++++++++++++++++++++
 .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   85 ++
 .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   20 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   12 +-
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h   |   19 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |    3 +
 9 files changed, 1226 insertions(+), 7 deletions(-)
---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231016-nia-sm8350-for-upstream-2f452366e421

Best regards,
-- 
Nia Espera <nespera@igalia.com>

