Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA10686FFC
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 21:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBAUp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 15:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBAUpT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 15:45:19 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E579635;
        Wed,  1 Feb 2023 12:44:58 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F3DC62038A;
        Wed,  1 Feb 2023 21:44:55 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: qcom: Use labels with generic node names for ADC channels
Date:   Wed,  1 Feb 2023 21:44:44 +0100
Message-Id: <20230201204447.542385-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As discussed in [1] it is more convenient to use a generic adc-chan node
name for ADC channels while storing a friendly - board-specific instead
of PMIC-specific - name in the label, if/when desired to overwrite the
channel description already contained (but previously unused) in the
driver [2].

Replace the .* name pattern with the adc-chan literal, but leave the
label property optional for bindings to choose to fall back a channel
label hardcoded in the driver [2] instead.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/

Changes since v2:

- Reorder DT changes before dt-bindings changes;
- Update adc-chan generic node name in tm5 example bindings.

v2: https://lore.kernel.org/linux-arm-msm/20230119212632.185881-1-marijn.suijten@somainline.org/T/#u

Changes since v1:
- Require adc-chan name in dt-bindings;
- Replace more node names with adc-chan and a descriptive label, that
  were found by running dtbs_check on adjusted bindings;
- sm8250-mtp.dts: Fix accidental adc-chan2 node name with pa_therm
  label, which should have been adc-chan with pa_therm2 label.

v1: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/

Marijn Suijten (3):
  arm64: dts: qcom: Use labels with generic node names for ADC channels
  dt-bindings: thermal: qcom-spmi-adc-tm5: Use generic ADC node name
  dt-bindings: iio: adc: Require generic adc-chan name for channel nodes

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 16 ++++----
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  9 +++--
 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
 arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
 arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
 arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 39 ++++++++++++-------
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
 28 files changed, 202 insertions(+), 116 deletions(-)

--
2.39.1

