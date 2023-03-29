Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A836CD7EE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjC2KwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2KwI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 06:52:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3841FC3
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 03:52:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p203so18673686ybb.13
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680087126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYv9M7coslMJJF9TLVoPr0zt34O6GZ1VxBOMD5WWM8g=;
        b=SikfAN/1ZbiBGg+zmydA9bfihedbZQOop+X5LZrPAALXv6NwuPk8ZorNDnOhtCveb/
         VrxXg+bB4RdVp+HwYWjDKX9BDmtPOp8fORYDewtQxM5kJvcgV4wxAQA53766Y9WQ0mE7
         WxCsZStIPbyVp3OBw9fcD/KNnwfgpIlyCgV0AylycYH1hRhehXOtO0z9yMF9EPZd4cIf
         5nwGp3OA/yNlyF8Jiin8lCt4HKPfH9J+PGLogFZWUek+WZoRClvUtAqZ7Kvx12HKewHN
         dGGsn0HBZcRu6kZYew1Y+C1nLZFEIcqOllG4Ljuk7mNJe8cnRI90wH94xN1ZF1qh46Z8
         LRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYv9M7coslMJJF9TLVoPr0zt34O6GZ1VxBOMD5WWM8g=;
        b=bXDAG1b0Xsz6KteB+BKakBeFeArUPnpqHX0vSrNm4TW+MGcfeDijLgYWBtiwzvmKhY
         Oy9evdEtR21VrML2A3EgTi5PkeMkMGkzsKlNBJYjlovoLwpKAeL1thyGT5ltf2UUlIfF
         bcLLcCnSmm1WarlK+ltSGs7W0AsIf/wTEFv8+gOd1y+vl9I2SmID+t9FlOYVDkHroXhb
         BwKmjxGQwC9yDluh/JxSSNMiWAw++Z1kOBAG2Zrtycuh3o0lB2vIO6HdQaUjRm1Xtmws
         tuhakMQlH2oycaH6OQ4MuMpb7fqbPW2x+f2xIaFSKlpr6GW/rY00WxPuiaELMAa02Zlr
         nGEg==
X-Gm-Message-State: AAQBX9egKWwIjqgmQ/CK0SvfZ5cnAMvzLs1Zo5zDdIN/ARuNfmhbiPRo
        A6vtnKv53JjyILpNCRHxGDM8yCgfq7h3eA6yjedTrg==
X-Google-Smtp-Source: AKy350b9UYOLX6PmwVyIWe5dGiWYyVV1F8d9u3fYOjbsXwVN0hv3JrowfI+/bMUSRJSpvSpbWHcaVAPuE6pPb/O3G64=
X-Received: by 2002:a05:6902:1549:b0:b77:be38:6406 with SMTP id
 r9-20020a056902154900b00b77be386406mr9547201ybu.9.1680087126218; Wed, 29 Mar
 2023 03:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
 <20230329000833.2507594-5-dmitry.baryshkov@linaro.org> <281c27da-a0a9-b866-b156-50db681cd656@linaro.org>
In-Reply-To: <281c27da-a0a9-b866-b156-50db681cd656@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 29 Mar 2023 13:51:55 +0300
Message-ID: <CAA8EJpoD_8tUO+QmwJtfAPqYAjMUD=hkGORxJEdUByYM0xc0Zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: qcom: pm8350: include SID into labels
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
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

On Wed, 29 Mar 2023 at 03:33, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 29.03.2023 02:08, Dmitry Baryshkov wrote:
> > The platform can use several instances of PM8350 PMIC. Include SID into
> > all the labels to simplify such platforms configuration.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8350.dtsi          | 31 +++++++++++++------
> >  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |  4 +--
> >  .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  4 +--
> >  3 files changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
> > index 2dfeb99300d7..f1ef242760f2 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
> > @@ -6,21 +6,30 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/spmi/spmi.h>
> >
> > +/* (Sadly) this PMIC can be configured to be at different SIDs */
> > +#ifndef PM8350_SID
> > +     #define PM8350_SID 1
> > +#endif
> > +
> > +#define __LABEL(pmic, sid, name) pmic ## _ ## sid ## _ ## name
> > +#define _LABEL(pmic, sid, name) __LABEL(pmic, sid, name)
> Perhaps that should go to some Qcom PMIC-common include now!

I usually prefer to have a "second case" before generalizing things. I
think we might have it with sa8540p-pmics (which includes 4 instances
of pmm8540). However I didn't dare to touch that as I do not know if
they are really the same PMICs or there are some differences, etc.

> Also, at one point, an idea came up to stop writing so much dt, I'm
> not necessarily a fan of creating .dtsc (like ACPI-C sources), but
> perhaps we could explore having e.g. a "gen_dt.py" which would take
> in some data and generate device trees based on that.. Not very
> related to this patch, but I'm just throwing it in the open

Standard issue: one has to find a balance between the generated source
and the actual code. Given that most of the blocks are more or less
standard, we might be able to create a DSL for describing PMICs. But
then we have all kinds of strange nodes (like Type-C handler), which
do not follow the reset.

>
>
> Konrad
> > +#define LABEL(name) _LABEL(pm8350, PM8350_SID, name)
> > +
> >  / {
> >       thermal-zones {
> > -             pm8350_thermal: pm8350c-thermal {
> > +             LABEL(thermal): pm8350c-thermal {
> >                       polling-delay-passive = <100>;
> >                       polling-delay = <0>;
> > -                     thermal-sensors = <&pm8350_temp_alarm>;
> > +                     thermal-sensors = <&LABEL(temp_alarm)>;
> >
> >                       trips {
> > -                             pm8350_trip0: trip0 {
> > +                             LABEL(trip0): trip0 {
> >                                       temperature = <95000>;
> >                                       hysteresis = <0>;
> >                                       type = "passive";
> >                               };
> >
> > -                             pm8350_crit: pm8350c-crit {
> > +                             LABEL(crit): pm8350c-crit {
> >                                       temperature = <115000>;
> >                                       hysteresis = <0>;
> >                                       type = "critical";
> > @@ -33,25 +42,29 @@ pm8350_crit: pm8350c-crit {
> >  &spmi_bus {
> >       pm8350: pmic@1 {
> >               compatible = "qcom,pm8350", "qcom,spmi-pmic";
> > -             reg = <0x1 SPMI_USID>;
> > +             reg = <PM8350_SID SPMI_USID>;
> >               #address-cells = <1>;
> >               #size-cells = <0>;
> >
> > -             pm8350_temp_alarm: temp-alarm@a00 {
> > +             LABEL(temp_alarm): temp-alarm@a00 {
> >                       compatible = "qcom,spmi-temp-alarm";
> >                       reg = <0xa00>;
> > -                     interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> > +                     interrupts = <PM8350_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> >                       #thermal-sensor-cells = <0>;
> >               };
> >
> > -             pm8350_gpios: gpio@8800 {
> > +             LABEL(gpios): gpio@8800 {
> >                       compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
> >                       reg = <0x8800>;
> >                       gpio-controller;
> > -                     gpio-ranges = <&pm8350_gpios 0 0 10>;
> > +                     gpio-ranges = <&LABEL(gpios) 0 0 10>;
> >                       #gpio-cells = <2>;
> >                       interrupt-controller;
> >                       #interrupt-cells = <2>;
> >               };
> >       };
> >  };
> > +
> > +#undef LABEL
> > +#undef _LABEL
> > +#undef __LABEL
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > index e28f49e31b9f..5c09b1d8881b 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > @@ -72,7 +72,7 @@ key-camera-snapshot {
> >
> >               key-google-assist {
> >                       label = "Google Assistant Key";
> > -                     gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
> > +                     gpios = <&pm8350_1_gpios 9 GPIO_ACTIVE_LOW>;
> >                       linux,code = <KEY_LEFTMETA>;
> >                       debounce-interval = <15>;
> >                       linux,can-disable;
> > @@ -564,7 +564,7 @@ &mpss {
> >       firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
> >  };
> >
> > -&pm8350_gpios {
> > +&pm8350_1_gpios {
> >       gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
> >                         "LCD_ID",
> >                         "SDR_MMW_THERM",
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> > index 99e9b776b93d..d90e3fedb742 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> > @@ -56,7 +56,7 @@ key-camera-snapshot {
> >               key-volume-down {
> >                       label = "Volume Down";
> >                       linux,code = <KEY_VOLUMEDOWN>;
> > -                     gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
> > +                     gpios = <&pm8350_1_gpios 6 GPIO_ACTIVE_LOW>;
> >                       debounce-interval = <15>;
> >                       linux,can-disable;
> >                       wakeup-source;
> > @@ -622,7 +622,7 @@ &pcie0_phy {
> >       status = "okay";
> >  };
> >
> > -&pm8350_gpios {
> > +&pm8350_1_gpios {
> >       gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
> >                         "LCD_ID",
> >                         "SDR_MMW_THERM",



-- 
With best wishes
Dmitry
