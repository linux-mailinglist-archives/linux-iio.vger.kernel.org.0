Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8588C7CDFA7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjJRO1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbjJRO1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 10:27:15 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F305266;
        Wed, 18 Oct 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q2mznEjXFwi82WPUH5TTMCZdcw6+QbIzW0yvKrrt7fg=; b=COxIoWX3Y40D3dgIwvXKM+yPjH
        Uw1vJI+OWhUstJr8IGGWts+sofnE7O3roV+SbYlWNo1M2/eJ1jzfaGBeMvCUSZEcbzQBchIZnax6A
        E6tncftIdwwC6Jo6jwkK4apeG9qfPRI2+p4TuyPLW6YEr5arYqWSKb8WHKuuz/+4FlfR5qN2/cTNB
        BVUuzJkljztc4XAnPz1hznqNDMtoss2NZZBEwN/xEhjn0TwmJV3hrjY8RuDLhiE3SvhfTA75+xAE+
        LKCzHjWc8scudivnhGp7uxryM8IoQCq6bHwpxd3qKG/iUOwDGi4hnTTKlinPcM0UA0DgAfDS2M6h7
        eb0VMZBg==;
Received: from [145.18.212.154]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qt7UZ-001paE-Gn; Wed, 18 Oct 2023 16:25:47 +0200
From:   Nia Espera <nespera@igalia.com>
Subject: [PATCH v2 0/6] support oneplus-lemonade(p) devices
Date:   Wed, 18 Oct 2023 16:25:11 +0200
Message-Id: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfqL2UC/4WNTQ6CMBBGr0Jm7Zh2oPiz8h6GRcEpTCKUtEg0p
 He3cgGX7yXf+zaIHIQjXIsNAq8SxU8Z6FBAN9ipZ5RHZiBFpVa6xkksxvFcGoXOB3zNcQlsRyR
 XGSrrmivSkNdzYCfvvXxvMg8SFx8++9Gqf/Z/c9WosG2NOVllHfHlJr19ij12foQmpfQFyMVUO
 r8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=nespera@igalia.com;
 h=from:subject:message-id; bh=kN2V9KJ3oNnTqAG3csbn0FmvtFPl5L+DuRK++hMoAqs=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlL+rqp/7O5ifoJM6pY7mCaKLv2R0zVab2FUZIx
 FtxEyTd+jGJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS/q6gAKCRDyJM7CN1bi
 rch4C/4x5stFTczf3691lHkwFw8LsrBxBIjYipEqgBEPGbNsgqnRmnZhj+dMWxCsZfyxEqvtB3I
 V3df4mvdmP2JZEpJhiIwOgl72Sx2t0G4zfCgaqA2SmWusqSZng4G2xHfrNR5JrwWWyMd6VSeamm
 AFjhoq5jOfHwPHxni3Lq5AXHEgtz484v5EPpWbLKA5x0zF3CGs8foXLC/fSUxH8Yy053WmOgBXH
 wjG6Gtipl0aMmoywZPGpZlHV5IwKx2D391ClcX5aCRMjVxDuIv0G2bw7tVGpAZtDcknzogyTzuJ
 gdiubhG0CzcUpysM4VJDFlAvwhX9NcrwW0Nz35epVeKRJlPyFCX5LsdLtba26PDrxPVgzWZXxNC
 vNEAw4tKw8R330GKcunuzTJf/HgqVFvqz4I4XyjSUQnDg3toMcr+uSTMi+tp/4/zr4F6tmbXUMt
 eEf/fb8uS9RMnYA+qi9e1bP7mcOxIVRA+V5+oXCH2Q7C0V9Vbw1gUIqDOnLRx9Dfno9Hs=
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
      iio: adc: add smb139x bindings
      arm64: dts: qcom: sm8350: Fix DMA0 address
      arm64: dts: qcom: pm8350k: remove hanging whitespace
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
      dt-bindings: arm: qcom: add oneplus-lemonade(p) bindings
      arm64: dts: qcom: sm8350-lemonade(p): new devices

 Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |    2 +-
 .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1042 ++++++++++++++++++++
 .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   85 ++
 .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   20 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   12 +-
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h   |   19 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |    3 +
 9 files changed, 1180 insertions(+), 7 deletions(-)
---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231016-nia-sm8350-for-upstream-2f452366e421

Best regards,
-- 
Nia Espera <nespera@igalia.com>

