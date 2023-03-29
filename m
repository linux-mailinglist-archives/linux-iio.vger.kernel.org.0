Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A86CCE81
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2AIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC2AIj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDD1738
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q16so17978426lfe.10
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6v+NVQCPV1S0g7YrDwjpX8zVJI8HxRYTaWqAbSLfFQ=;
        b=Rkwvx+kc9LdiXyqq+gK7o4FaQTAHyMJGU2UJ1WYlcqzB5nFM2ByuNgdyF+Q2gVmkwf
         wgBr0vTFrPxmKQsbhLwQ7/xGL2j+D/oyvr++p98rUE/NXONDro7hNKzXm76EQ8hjKuG3
         qNls2QgbPJTVX7NR9nIAawYvQf6Gdh3Hi0AtKw1k0ZAfBQpkZPtL3ciJyDpMDQcNyT2e
         XwJgOAWE4euiNknTTCDu8o5jBIKVik+YnoMlTe1l/gR5EIASoEZwObxOnodLz+PR+BrW
         6huL3TRKJa15oiS3ojeJTo8Ceceq5RBiwA0Cck++B7WSCxJmbmedVTf04cnPCDnqgpp3
         WIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6v+NVQCPV1S0g7YrDwjpX8zVJI8HxRYTaWqAbSLfFQ=;
        b=YPV3kZiZEimLcnbzyybJ3KIGBi3yBmg9PQC2eU3AEs482gls5LsRC9eMijZ9x7pASp
         WZmSXt7//8LwoSRfKpcuwBcuQ7FlTD7h69KEPcOd/M0rO5AWS51Oi5+L3h5d3f0fyQn/
         vB1hYVxJHYqrGf26xbs2kTp2zKSt1ZUF/jfzE78ikhh5V7XpGU5p/xS2NWTtSlNgSaV9
         ZaPWq7nigSXR9DPdiHT1gsKRpYXagW/l9olLera5UE17Xg9lr9xaDvo7O2tXVLFz5Ug1
         Kj6TV2L4/1dYTzHfmo6UMgYCZVlL9OF/5nOhKPYccxCHiSL1XTwv8N534Oa88RXRxY9/
         LZcA==
X-Gm-Message-State: AAQBX9cySlNxtXUSfn4taAqsROYWv80hI2uE7R3XcgHkhr1eFIx2Fymr
        CGLy6TP4ve1m1BLzpRYQp0cUHA==
X-Google-Smtp-Source: AKy350Za28zGAfrrbml0T2NM56Ru3yBouMHlRvEj+r1KVgPudhZFpaMuV5kQg+H4u+ELE38DdDft9w==
X-Received: by 2002:ac2:5d31:0:b0:4e8:5f9d:13d5 with SMTP id i17-20020ac25d31000000b004e85f9d13d5mr5245146lfb.43.1680048515236;
        Tue, 28 Mar 2023 17:08:35 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: qcom: sc8280xp: remove duplication in PMIC declarations
Date:   Wed, 29 Mar 2023 03:08:27 +0300
Message-Id: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The sc8280xp platform uses its own copy of PMIC declarations. This can
easily end up with the issues that are fixed in the main PMIC include
file, but are not fixed for sc8280xp (and vice versa). For example
commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the correct PON
compatible") changed pmk8350 to use "qcom,pmk8350-pon" compat for the
PON device, while sc8280xp-pmic.dtsi still has the incorrect
"qcom,pm8998-pon".

Another example is pm8280_2_temp_alarm device, which uses interrupts
tied to SID 2, while having SID 3. This can be easily left unnoticed.

Employ a small amount of C preprocessor magic to make
sc8280xp-pmics.dtsi use standard PMIC include files.

Dmitry Baryshkov (6):
  dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include sid into defines
  arm64: dts: qcom: pmk8350: rename pon label
  arm64: dts: qcom: use main pmk8350.dtsi for sc8280xp platform
  arm64: dts: qcom: pm8350: include SID into labels
  arm64: dts: qcom: sc8280xp*: use pm8350.dtsi
  arm64: dts: qcom: sc8280xp*: use pm8350c.dtsi and pmr735a.dtsi

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   4 +-
 arch/arm64/boot/dts/qcom/pm8350.dtsi          |  31 ++-
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  13 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  24 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  52 ++---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  | 210 ++----------------
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts       |   8 +-
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |  12 +-
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |   8 +-
 .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  |  52 ++---
 14 files changed, 128 insertions(+), 294 deletions(-)

-- 
2.30.2

