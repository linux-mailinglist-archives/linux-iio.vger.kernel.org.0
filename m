Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8D7CA85C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjJPMrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjJPMrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 08:47:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1EE8;
        Mon, 16 Oct 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CFtUyAN6O7E+QyTtUN2EU3o8sz6NRVpWpTj2DZbCLpQ=; b=ZDXmYOWCB6yKXxVmi8wGftScPv
        98EFanT7UhxuI8EtDHvOHMfKvFxtUJTTZZA7Xgof1LZDxbTAHBI8NUwxTmVrF+wDDI1S8c7yKfjBn
        Ktr7thQWYLxB+iGU4uKI+1DVzTTda9wS3YFtVLYCzAwN6KLKALGWDuS3qfGLHTmdaBFTlcsLWzT5S
        sMYi22VcnXRfaioYL9d1PtXbsuq8g1hHGYZSq8rvUR7JfqXJ74mk86VW82LGc0g3Ml/cTREvuGeru
        OZ1QUeQ2BbXy9Po1WvYNm1rUDDH9rZjeUU0dV6okDDuYE6mO/KXGnhIhKEYyyqoIygAyeyscm+1Hj
        FdtAozHQ==;
Received: from re-byods-146-50-198-227.wireless.uva.nl ([146.50.198.227])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsN01-0013kp-Gu; Mon, 16 Oct 2023 14:47:09 +0200
From:   Nia Espera <nespera@igalia.com>
Subject: [PATCH 0/5] support oneplus-lemonade(p) devices
Date:   Mon, 16 Oct 2023 14:47:00 +0200
Message-Id: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQwLWUC/x3MwQqDMAyA4VeRnBdoUy3DV5EdykxdDlZJNhlI3
 93i8Tv8/wnGKmwwdicoH2KylQb/6OD9SWVhlLkZyFHwzkcsktDWZxgc5k3xt9tXOa1IuR8oxMg
 9eWj1rpzlf5+nV60Xxl49/2kAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=nespera@igalia.com;
 h=from:subject:message-id; bh=bIskzxPUt7FDQ9Ass8yJo8NTY3rS5cJSwIYFvaHIvcY=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlLTDMc2l+MDTBvbmuoCZBPwv/k/7mGg2+gHMJO
 Vus5H+a6ayJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS0wzAAKCRDyJM7CN1bi
 rdnhDACtx/iJZxetyCX8WoDbdad9WnhxxRp6xz2Hh+g3e/UN5CFN1mGYn3L3MHv+yS1/Q+IBQe3
 G/9QSCIqvAQBcmQVPZgW1Pujd5PcQ5ASJJ4VgG73j3wAGvt5YX1ILx7LPhbC3VLNWuUPWDAR2IR
 yZhEPkNnDXnr/+7A8dvhNRKGkxIC3e1wvJ16nBJkeFfXWYepurlI9unEUtkS8o+eptGr8kGVB+i
 CVM4lS7gMHwNtCUCHCkgNhGsFW4c//ZLh3j9hWTNYHIhbjSDUne+qyq+dbD39uLXe7oIHDNIhwv
 tuxoHILkFt/u2UeNh/SVMHUs9KtuLJSpWBGzRVCSJJTzvjZtjRNl3quAGjDIjGah1o128jXddK+
 6C+u9tgFQbvGKZIIBaHZGZHDpdnE8Wj4h0jJqEY79hrn8MnyDD6y2EZEjVaQbNc6gAUiwg2InTq
 8m78o+RnwUUB4HKJElKeECJCWlpeoNbp7pLykUN4/LXRff9P53St5+gFdMIUW8Wb91feg=
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
Nia Espera (5):
      iio: adc: add smb139x bindings
      arm64: dts: qcom: sm8350: Fix DMA0 address
      arm64: dts: qcom: pm8350k: remove hanging whitespace
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
      arm64: dts: qcom: sm8350-lemonade(p): new devices

 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |    2 +-
 .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 ++++++++++++++++++++
 .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
 .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   12 +-
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h   |   17 +
 7 files changed, 1392 insertions(+), 7 deletions(-)
---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231016-nia-sm8350-for-upstream-2f452366e421

Best regards,
-- 
Nia Espera <nespera@igalia.com>

