Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFB2EA329
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 03:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbhAECEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 21:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAECEd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2021 21:04:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96DC061795
        for <linux-iio@vger.kernel.org>; Mon,  4 Jan 2021 18:03:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 15so34434982oix.8
        for <linux-iio@vger.kernel.org>; Mon, 04 Jan 2021 18:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAvFCM+Nwif6O5rB2lkK+etNk69rgmZatie3udkuWWk=;
        b=JEQGcbrEExUn23fbUObkvAsqFSmvjavNCW95udNjzmDUw+ZxJ3fnGwrfLxoKLcykHz
         OuKMNKC+aiZguWeo9jvT/aFaEoQ8j+w9iShHE5NFu5Hl6tVkGGPKvxQjmlphH80X9Ctl
         iUpSMGvZh8PVguEGHBTSnQPRj1YI59ZGUpP/51FfMIaYJpWyDghBuYrjD/M1DJVG2KkA
         +G9Z+GwZ4fXsQeWrqZMg2PYk5cbGMvDUJWUcuou5x+WwnNBuYXvJyvyR1iJ6v2QOSzpW
         upKtGURRTl/DboW6NK0xlQLn0eTLbZwWz6Nyb1ZoDqk0g9WH6+Zqt0PYrg69LufKneau
         RXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAvFCM+Nwif6O5rB2lkK+etNk69rgmZatie3udkuWWk=;
        b=n5qrOVte0KzLmqczJNXffRyEGLLIrMWXgSgtU88KoaFPQdDJEpaKhfuQiqI9+21SWg
         xZiwxtVU88RszlqwmaceW4+s6NrR9qmVCLiipwwdT1O1MAiLebEO3A4J5PVMP5VrnTYQ
         mxtYAYHyJo4mXSFNvFU6ndIPIeULPyCQjr1aqO6nAdxxvCRxO2pd+9oiJyah8B4ell/g
         9MhGwEfEzcrOxQ9V4CJJQJU/7i3i3ayg0A22Uy6qphog60AGGeKn4Lht/rUcYvExzhh+
         vBg6O7dAmZqTJrKI3GFulJXmU8/neUCb3lwdPBQj7TAUlwYv1VrMi65yXHslP7Kg4QWB
         rFDg==
X-Gm-Message-State: AOAM532M9Rmo4u+K3c3g4s198p9NDR1E1e3KZCQD2nic8ihg8zFN+Yfm
        2sCpQYtBNyQsr6IcCuYdXfXeaNGH7Fz58dXqmMV0gg==
X-Google-Smtp-Source: ABdhPJwdorJTBMpB8iLRhXColNJZKPg+WmJhZQkbynEQO5a3WJG4d8wVpu0P7MWethLJaacAsXrMP+lj0wfEWFjIUFw=
X-Received: by 2002:a05:6808:64d:: with SMTP id z13mr1233982oih.177.1609812231819;
 Mon, 04 Jan 2021 18:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Jan 2021 05:03:38 +0300
Message-ID: <CAA8EJpqvBs-cwSHqUTeL_YUGsacTKGBiM=tkKsGM82rF4Q9Qww@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal monitoring
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Colleagues,


On Fri, 4 Dec 2020 at 05:55, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> This patch serie adds support for thermal monitoring block on Qualcomm's
> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> to support thermal zones provided by this thermal monitoring block.
> Unlike the rest of PMIC thermal senses, these thermal zones describe
> particular thermistors, which differ between from board to board.
>
> Changes since v9:
>  - In patch 12 add comments to the code as requested by Daniel Lezcano.
>  - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
>    driver history.

Gracious ping for this patch series. Daniel, do you have any comments?

>
> Changes since v8:
>  - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
>    tables support
>  - Simplified qcom-vadc-common volt/temp mapping code
>  - Implement suggestions by Matthias Kaehlcke: message formatting,
>    rewrite comments, remove unused variable initialization.
>
> Changes since v7:
>  - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
>  - Use explicit sizeof(var) instead of hand-coding 1 when accessing
>    adc-tm registers.
>  - Remove buffer read from adc_tm5_init().
>  - Remove extra on-stack var from adc_tm5_get_temp().
>  - Minor formatting changes as suggested Daniel.
>
> Changes since v6:
>  - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
>
> Changes since v5:
>  - Reworked DT bindings:
>    * Removed qcom,adc-channel, instead it is parsed from io-channels
>    * Renamed qcom,hw-settle-time to include -us suffix
>  - Re-added monitor enabling which got lost during refactored. Noted by
>    Jishnu Prakash.
>  - Use threaded IRQ handler as susggested by Jishnu.
>
> Changes since v4:
>  - Added kernel-doc comments to ADC-TM structures
>  - Used several sizeof(buf) instead of hand-conding register size
>
> Changes since v3:
>  - Fix DT description to spell "thermal monitoring" instead of just TM
>  - Fix warnings in DT example
>  - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
>  - Fixed whitespace chanes in qcom-vadc-common.c
>  - Removed error message if IIO chanel get returns -EPROBE_DEFER
>
> Changes since v2:
>  - IIO: export of_iio_channel_get_by_name() function
>  - dt-bindings: move individual io-channels to each thermal monitoring
>    channel rather than listing them all in device node
>  - added fallback defaults to of_device_get_match_data calls in
>    qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
>  - minor typo fixes
>
> Changes since v1:
>  - Introduce fixp_linear_interpolate() by Craig Tatlor
>  - Lots of syntax/whitespace changes
>  - Cleaned up register definitions per Jonathan's suggestion
>  - Implemented most of the suggestions from Bjorn's and Jonathan's
>    review
>
>


--
With best wishes
Dmitry
