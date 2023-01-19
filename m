Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD167463A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjASWg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Jan 2023 17:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjASWfz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2023 17:35:55 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E610924116
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2023 14:18:02 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B11463EAF1;
        Thu, 19 Jan 2023 23:17:59 +0100 (CET)
Date:   Thu, 19 Jan 2023 23:17:57 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: Use labels with generic node
 names for ADC channels
Message-ID: <20230119221757.wltdog4owclidejl@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212632.185881-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+cc linux-iio@vger.kernel.org

Apologies, I blindly copied Jonathans request [1] to send this to
iio@vger.kernel.org, without checking for the common linux- prefix.

[1]: https://lore.kernel.org/linux-arm-msm/20221211141526.463f43e6@jic23-huawei/

On 2023-01-19 22:26:30, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic adc-chan node
> name for ADC channels while storing a friendly - board-specific instead
> of PMIC-specific - name in the label, if/when desired to overwrite the
> channel description already contained (but previously unused) in the
> driver [2].
> 
> Replace the .* name pattern with the adc-chan literal, but leave the
> label property optional for bindings to choose to fall back a channel
> label hardcoded in the driver [2] instead.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Changes since v1:
> - Require adc-chan name in dt-bindings;
> - Replace more node names with adc-chan and a descriptive label, that
>   were found by running dtbs_check on adjusted bindings;
> - sm8250-mtp.dts: Fix accidental adc-chan2 node name with pa_therm
>   label, which should have been adc-chan with pa_therm2 label.
> 
> v1: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/
> 
> Marijn Suijten (2):
>   dt-bindings: iio: adc: Require generic adc-chan name for channel nodes
>   arm64: dts: qcom: Use labels with generic node names for ADC channels
> 
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 16 ++++----
>  arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
>  arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
>  arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
>  arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
>  .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
>  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
>  .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 39 ++++++++++++-------
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
>  27 files changed, 196 insertions(+), 113 deletions(-)
> 
> --
> 2.39.1
> 
