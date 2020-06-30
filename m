Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3C20ED1B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 07:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgF3FGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 01:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgF3FGa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 01:06:30 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6267C03E979
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2020 22:06:29 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p25so2694499vsg.4
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2020 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2uK/hi+Brt2pyT8LlHzAvwg6MH09+PI7YkbZr7ga+Q=;
        b=1w04gmdNQ9631ByNUaIX12DL4x7KugjLTxDBq6DWEzjTB+Bj7ylamNrLVKFrmZgtNa
         k7fgYt6AF9A/t2fCLvOrWTTlBmnMvX0dZSy7zrb4NVScTeipGAlp9d48kt2sRd6jxGWj
         FUC8F4z5WWmpAB8WHygOoDg35N/GVKFNH575j/jXhKtR3+CULVQQopTznDJnXzXHnTeb
         eUwtKBE7OXcYowlpfj6CtOGL6VTYlPcitOhYYBog+f4Jiwd51v9oWG4d4/Md1lTpFb3B
         7VNsRaU3vmOM7cMKRGgp7dQqe2wIVC2ervcfdFIHkzBW4x0pPMfVV/OnFAs//Z+U/gHX
         oj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2uK/hi+Brt2pyT8LlHzAvwg6MH09+PI7YkbZr7ga+Q=;
        b=WGwwgQhjvUPph1MMcZNifedmiBYKqWXEvTPUsRQtLvE2Y7dnJS7z/04PBS6p6QqLzI
         TBk8MpA/nKpcmgl9IOlm/nPUwiBpO3L5qVy4kN4u33hNNLpMsFPHRa6FzcWJ+VynQoQm
         fPpmg3P6b4NCYsaYdcpnBN6qLrEZ5SgqANckr55QEaZ5+NinHPICYMpoo0Plsf9m4Ujl
         S0oI+xMlPMdELUnBeNLZikyUtuAKlNb0G7qhiqivRRT2OJkThKDzzesFHoqcNyCd8UrB
         YROy9IGSVCCWzqm25W9+Mj4GcVPBukwJIHioOlyMOSrzHkFbJ3ZYBmKJ4dFudKhPo5cb
         dMVw==
X-Gm-Message-State: AOAM532/3rfKMWtV7UiQ6nRzhS8brEwbVvC+TV4S9bkrtIUJaeiSqns3
        GnJJxz6IkbZEtolMH8nYaHsq1ZTTJjtT9xpAWTVOfA==
X-Google-Smtp-Source: ABdhPJyJeJB83cxwO/XegM9Yw4FjPp35g425s3MnN+uM3+yvSRh2sWTu7OFfztRHesCvhTzAgHB9mldeqJIayobuIF8=
X-Received: by 2002:a67:f557:: with SMTP id z23mr13521181vsn.27.1593493588999;
 Mon, 29 Jun 2020 22:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org> <20200621193549.2070434-6-dmitry.baryshkov@linaro.org>
In-Reply-To: <20200621193549.2070434-6-dmitry.baryshkov@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 30 Jun 2020 10:36:18 +0530
Message-ID: <CAHLCerOqWWr3i32tRgGfep12YfDufw-WU80VWUsUNpDDZ13D-w@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: sm8250-dts: add thermal zones using
 pmic's adc-tm5
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

On Mon, Jun 22, 2020 at 1:06 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Port thermal zones definitions from msm-4.19 tree. Enable and add
> channel configuration to PMIC's ADC-TM definitions. Declare thermal
> zones and respective trip points.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 237 ++++++++++++++++++++++++
>  1 file changed, 237 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts

IMO, this should be separated in the pmic dts file like we do for
other QC platforms since the PMICs tend to be used in multiple
platforms.

> index aa37eb112d85..78f0cf582a9a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -24,6 +24,104 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       thermal-zones {
> +               xo-therm {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&pm8150_adc_tm 0>;
> +                       trips {
> +                               active-config0 {
> +                                       temperature = <125000>;
> +                                       hysteresis = <1000>;
> +                                       type = "passive";
> +                               };
> +                       };
> +               };
> +
