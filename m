Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633606CD8E1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC2Lz1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjC2LzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 07:55:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2054EC4
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 04:54:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5456249756bso288156707b3.5
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680090881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjpMMJalxQfUkZZ8222itIWqInHhIjI83LpikQoWUYY=;
        b=n2Oqz9YFyaYGosKmBW5/zhoJL741BzfYq8rR1BkCUANJgCnfK2uyHLp++X1Y2ffXU7
         0kXTICzMAYX0N5M2QxhGvEz0a/eZLvl/t8d+2t7JQafuMmIOURGf3NYvFgJOXG6eKheI
         7mA6OMa+odcErTWgKHgc5/ZgCvgXq3jIxl+BxkatC5jAQJtMCwnMZxD6+g7iuVNNtn0b
         qllBD0ZFt5FBc/zQOhZeA9z/301/0rtNMnLTb1C6MUz5AwR6EdQtmPyMMCw6amb8ZE94
         BiVVfJd7fE0K+qqODDOFvQ3bEGAU4WE4XSLBP3VsVTGsbUigPe0z3RnNfTFQQSHn1WIh
         TQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjpMMJalxQfUkZZ8222itIWqInHhIjI83LpikQoWUYY=;
        b=6Kc0BeaBU46GEXVdIIbxKdQnUCgKx82gyDlucRGga0QMRSVTbx0eB8tpkNbd8+fG85
         s0jOoynQDua2PW799gs6fBsMSASD95tMt9AiR5pGth9pBZ5iHFLXNJ2Kc9L/ZkERNN53
         7eT8KFWDT0hjuWeyHZC+GE+ao2/lEjgNCTJZ/1RILWIm6Ph9gUerTXw3bXV1O03MX6vM
         itiXyvnmVenFvcpOfJfSucN/YMHk7VXDu69jPFmkCDPm+AZu3do6T5RMnDbvCyYpPS5k
         OmZe3Gq6lLCAsEEDxF7XVmvCvQW/5k1tnhhpMDgiUMmOcH9VAPddLMbtQf8q2gQShrGJ
         CHcg==
X-Gm-Message-State: AAQBX9cLCWh7SoLln413gkekIH83c7mo/foSfTZyOO2+VWKxzhleyqTa
        EYgsYAPnWqZcmm7skGrSboiqIfTLc/olOa3dWrzj1g==
X-Google-Smtp-Source: AKy350Zzj++XBCM7DLBHF9YbZ4XqpZy7N+euPwZ3yga/tOc1TDODBWTP9d6GBHLZs9VQRUH1w8784KBwARE1HzshsYk=
X-Received: by 2002:a81:a9c5:0:b0:545:62cb:3bdd with SMTP id
 g188-20020a81a9c5000000b0054562cb3bddmr9427518ywh.5.1680090881398; Wed, 29
 Mar 2023 04:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
 <20230329000833.2507594-4-dmitry.baryshkov@linaro.org> <9746792b-fd4a-6808-0c6b-4834ffc9c059@linaro.org>
 <195dddb5-25f7-ac8c-8609-776ed6724650@linaro.org> <09b97204-514e-1262-04ee-3536a11e7ffc@linaro.org>
In-Reply-To: <09b97204-514e-1262-04ee-3536a11e7ffc@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 29 Mar 2023 14:54:30 +0300
Message-ID: <CAA8EJppf8WhNngfDzQBN5xdfLdEsXQ=Ew65oq_AHAGukRT5Phg@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: qcom: use main pmk8350.dtsi for sc8280xp platform
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

On Wed, 29 Mar 2023 at 03:35, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 29.03.2023 02:29, Konrad Dybcio wrote:
> >
> >
> > On 29.03.2023 02:27, Konrad Dybcio wrote:
> >>
> >>
> >> On 29.03.2023 02:08, Dmitry Baryshkov wrote:
> >>> Employ existing PMK8350_SID and switch sc8280xp-pmics to use
> >>> pmk8350.dtsi to reduce duplication and possible discrepancies.
> >>>
> >>> For example, this changes sc8280xp platforms to use qcom,pmk8350-pon
> >>> for the pon device compatibility rather than the incorrect
> >>> qcom,pm8998-pon.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >> Bit of a loaded patch..
> >>
> >> This could probably go like:
> >>
> >> 1. outer join 8280 on pmk8350 (for feature parity)
> >> 2. rename all labels in 8280 to 8350 (for 3.)
> >> 3. switch over to the actual 8350 file, remove 8280 (with Fixes:)
> >>
> >> [...]
> >>
> >>> +#define PMK8350_SID 0
> >>> +#include "pmk8350.dtsi"
> >>> +#undef PMK8350_SID
> >> Not sure if this undef is necessary
> > It looks like it would be for multiple instances though
> >
> > Konrad
> Also, it'd be a good idea to use interrupt-parent, as:
>
> 1) it would be a regression for OpenBSD and friends to remove it

Ack, I forgot about interrupts/interrupts-extended. I'll fix that for v2.

> 2) the interrupts=<> is dangerously long with SPMI

I don't think we can do anything about this.

>
> Konrad
> >>
> >> With or without all that though, the goal lgtm..
> >>
> >> Konrad
> >>
> >>>
> >>> +&spmi_bus {
> >>>     pmc8280_1: pmic@1 {
> >>>             compatible = "qcom,pm8350", "qcom,spmi-pmic";
> >>>             reg = <0x1 SPMI_USID>;



-- 
With best wishes
Dmitry
