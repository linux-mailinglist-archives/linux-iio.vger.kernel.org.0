Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FE6D42EF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCLGX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjDCLGW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 07:06:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7D4EDE
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 04:06:19 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536af432ee5so545033717b3.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680519979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CvVcGwETxNUxjmnzyVFM5c5Wao4X2W2K1dZSQ2JBFI=;
        b=DA9HiaQekXxpmNBBWkLKyAPrh5lBKFcstgq2+nygnRKjsRg40GLkDLrG/OKExudAZA
         B9NmrExWI1oUboCUFV7fKZaGrTjkScSCC10qF9HNNEsm+WcwW52uDiPZSivgna7HFGM1
         dJpikvegaa9n3DnC41mbmw8wyI03+3A3AvaLFXUunLMQNrxfKT8jrpeYbUHM/pSZ6TsF
         0zC3QdaNyhSJzstXY6XVe8sgy1/xvNjSNREfwUyPxIGbQXQiLPRSaGE7uHNlyOO5oms0
         abrDDZ7Gn7iShLdwPw0e0DhMbTXl56Yw9vvAd4qIcpMw8zi8Yu3cdpBLQhGLFwcywq9D
         ktvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680519979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CvVcGwETxNUxjmnzyVFM5c5Wao4X2W2K1dZSQ2JBFI=;
        b=ktHQfpk9hn0ma9orb/Hm1ivO9pSfpNTCAhsSSBwWs8WXeLTPgfmvbc6PCaGaAiHEAF
         EIzC/CNhBSpC6IRjm6zEysNUKdZucZ99umw5OPIP/y6jZp0Y6daPfkHTnmNp588E9flt
         1uZ9g5NpOSn+hD8odnRI5Hq3RnK9QcMlCVZ8rr19Xm1Q/mCdQ9XGTKRDX60yswcXSQeH
         ah4fKK3nWmJxSj1DEKilmWTA4S9M386sqtgNe0kMWLpWpPpVisGXSw2kl5iey1YqzMqk
         pvDr+8PSyOtkb4Ne/uvTfiztcK0ywe6p1/kGvr76yBjSxLQtFDEwbjqZSvwzKXPUeGqa
         Cr0A==
X-Gm-Message-State: AAQBX9csw2X2lFoTEamFIqwblQeDx6YdhIE6p8OPRuqc9YW+dOSsQRPd
        NKAVXnEYQeZYDWSOQMe4tAgXL7dnphH+3wExuvZgcg==
X-Google-Smtp-Source: AKy350a5AohugSc8KPjYklr2VvA1zeITsunoumjRKmfAkkZAXRB4Y08SpHNQ0ThHJLdP3hJC4BGUgJ5anThH4FcljI0=
X-Received: by 2002:a81:4410:0:b0:545:a7d8:f278 with SMTP id
 r16-20020a814410000000b00545a7d8f278mr16955387ywa.5.1680519979061; Mon, 03
 Apr 2023 04:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-10-dmitry.baryshkov@linaro.org> <e6d47121-fb3f-7536-1f73-923fc489e6aa@linaro.org>
In-Reply-To: <e6d47121-fb3f-7536-1f73-923fc489e6aa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 3 Apr 2023 14:06:08 +0300
Message-ID: <CAA8EJpoY+1YsTBM3YBvFrNTR0cN7zksHuqtqTB9qcwuNytk+gg@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] arm64: dts: qcom: pmk8350: allow overriding the label
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Apr 2023 at 13:14, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 2.04.2023 00:07, Dmitry Baryshkov wrote:
> > sc8280xp-pmics.dtsi incorporates a copy of pmk8350, but the dts files
> > use labels following the markings found in the schematics. Allow
> > overriding the labels in pmk8350.dtsi.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi | 13 +++++++++
> >  arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi | 14 ++++++++++
> >  arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 28 +++++++++++--------
> >  3 files changed, 44 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> > new file mode 100644
> > index 000000000000..1c81269f0783
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/* cleanly revert the effects pmic-dyn-header.dtsi */
> > +
> > +#undef LABEL
> > +#undef _LABEL
> > +#undef __LABEL
> > +
> > +#undef PMIC_SID
> > +#undef PMIC_LABEL
> > diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> > new file mode 100644
> > index 000000000000..75f0448568bd
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/*
> > + * Preprocessor symbols to assist in describing PMICs which have configurable
> > + * SID. All effects of this header (or its parameters) must be reverted in
> > + * pmic-dyn-footer.dtsi.
> > + */
> > +
> > +#define LABEL(name) _LABEL(PMIC_LABEL, name)
> > +#define _LABEL(pmic, name) __LABEL(pmic, name)
> > +#define __LABEL(pmic, name) pmic ## _ ## name
> #define PMIC_LABEL pmk8350
> #define LABEL(name) PMIC_LABEL##_##name

This doesn't work. Using LABEL(test) results in PMIC_LABEL_test.

>
> ?
>
> Konrad
> > diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> > index 02e7518ab57b..f26ff3daf119 100644
> > --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> > @@ -13,33 +13,39 @@
> >       #define PMIC_SID 0
> >  #endif
> >
> > +#ifndef PMIC_LABEL
> > +#define PMIC_LABEL pmk8350
> > +#endif
> > +
> > +#include "pmic-dyn-header.dtsi"
> > +
> >  &spmi_bus {
> > -     pmk8350: pmic@PMIC_SID {
> > +     PMIC_LABEL: pmic@PMIC_SID {
> >               compatible = "qcom,pmk8350", "qcom,spmi-pmic";
> >               reg = <PMIC_SID SPMI_USID>;
> >               #address-cells = <1>;
> >               #size-cells = <0>;
> >
> > -             pmk8350_pon: pon@1300 {
> > +             LABEL(pon): pon@1300 {
> >                       compatible = "qcom,pmk8350-pon";
> >                       reg = <0x1300>, <0x800>;
> >                       reg-names = "hlos", "pbs";
> >
> > -                     pmk8350_pon_pwrkey: pwrkey {
> > +                     LABEL(pon_pwrkey): pwrkey {
> >                               compatible = "qcom,pmk8350-pwrkey";
> >                               interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> >                               linux,code = <KEY_POWER>;
> >                               status = "disabled";
> >                       };
> >
> > -                     pmk8350_pon_resin: resin {
> > +                     LABEL(pon_resin): resin {
> >                               compatible = "qcom,pmk8350-resin";
> >                               interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> >                               status = "disabled";
> >                       };
> >               };
> >
> > -             pmk8350_vadc: adc@3100 {
> > +             LABEL(vadc): adc@3100 {
> >                       compatible = "qcom,spmi-adc7";
> >                       reg = <0x3100>;
> >                       #address-cells = <1>;
> > @@ -48,7 +54,7 @@ pmk8350_vadc: adc@3100 {
> >                       #io-channel-cells = <1>;
> >               };
> >
> > -             pmk8350_adc_tm: adc-tm@3400 {
> > +             LABEL(adc_tm): adc-tm@3400 {
> >                       compatible = "qcom,adc-tm7";
> >                       reg = <0x3400>;
> >                       interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> > @@ -58,7 +64,7 @@ pmk8350_adc_tm: adc-tm@3400 {
> >                       status = "disabled";
> >               };
> >
> > -             pmk8350_rtc: rtc@6100 {
> > +             LABEL(rtc): rtc@6100 {
> >                       compatible = "qcom,pmk8350-rtc";
> >                       reg = <0x6100>, <0x6200>;
> >                       reg-names = "rtc", "alarm";
> > @@ -66,7 +72,7 @@ pmk8350_rtc: rtc@6100 {
> >                       status = "disabled";
> >               };
> >
> > -             pmk8350_sdam_6: nvram@8500 {
> > +             LABEL(sdam_6): nvram@8500 {
> >                       compatible = "qcom,spmi-sdam";
> >                       reg = <0x8500>;
> >                       #address-cells = <1>;
> > @@ -75,11 +81,11 @@ pmk8350_sdam_6: nvram@8500 {
> >                       status = "disabled";
> >               };
> >
> > -             pmk8350_gpios: gpio@b000 {
> > +             LABEL(gpios): gpio@b000 {
> >                       compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
> >                       reg = <0xb000>;
> >                       gpio-controller;
> > -                     gpio-ranges = <&pmk8350_gpios 0 0 4>;
> > +                     gpio-ranges = <&LABEL(gpios) 0 0 4>;
> >                       #gpio-cells = <2>;
> >                       interrupt-controller;
> >                       #interrupt-cells = <2>;
> > @@ -87,4 +93,4 @@ pmk8350_gpios: gpio@b000 {
> >       };
> >  };
> >
> > -#undef PMIC_SID
> > +#include "pmic-dyn-footer.dtsi"



-- 
With best wishes
Dmitry
