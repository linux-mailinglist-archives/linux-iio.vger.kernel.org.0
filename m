Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68C2B0515
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 13:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgKLMly (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLMly (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 07:41:54 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACCC0613D4
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 04:41:53 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m143so6212471oig.7
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xPF1Lz4nYrB6C/anWXLAqDEnq22PRnhe5LG+L020aI=;
        b=iW1jERexvQ1poJctwFKEjsfG+AJO62Hu/YEdjGXy5qhtBWMORngcS19a8CUANUQJBZ
         cPjxno1FNV04E3Oa+SJdWZY6UcMprEdExZfqX0TJ6OrU+98QlL1XGh4+toNkUNMs3O1a
         o0P2Z91VkVXGOHCvy03gUcX82Qus0Omid6PqXUBcFqzqi3IKloRCef/lbtm8+VfmiYK3
         ACTozLts8w7s8uy6dEOxr+Tf11PxT0wIdSK+hFlNTUwIcdz5Wod/xY+QeOtqZQc+dmUu
         1BINXe0cqdPnh2Lwq284JAljvQ/XrjTUE08qcnM4PSrvsvN/O5LPgpFU6HVUDOblug4h
         XB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xPF1Lz4nYrB6C/anWXLAqDEnq22PRnhe5LG+L020aI=;
        b=NUo4XDEgM+iDd1LoefZhET7fAcCuLhIkk1GDh8a/NhV7qVqHKCqQ3CzZNKMDdYh8lr
         y49SkHTl/E1YjiuZab7L9wAz8gx+ydnIPYHaECKJl3u01QA0VzbLxrAyDPlnKWzi1/Cn
         BtLf/wI8NBzs3laDQvAaDo5k3519FbL3rdRw1FhqsI7TAcQFoTVyRcfz7QuJ/1N+dWAC
         sduhIbYvnNDGJ9gnsLp5bnSQ7KI19AkAO0at9/t+Vh354LUBW+bX6ncssP2iDNi6nDmZ
         tryDaqf4wXT9NmZOvCHi6DdSQCmdRjLolVCX0zWnvPDAXQ48eS3rYjTGA4mREvIztwp9
         cWUA==
X-Gm-Message-State: AOAM533znHTEGPhvcjwvbui/PHFPuGOXjAoHaDySjkqQFVBNJv6Hk8En
        SEwIq7VJpNtY0dimhesVWj+RMceyvn03bp/Wrx2/gQ==
X-Google-Smtp-Source: ABdhPJzmjcStUcQx4ZEKaJfl4Ln54yI5c7yw8uIsCn/EiLI5nf+UwJP1vwZCHYtEjWBk7fQxjf5W9lFvqudbY503C/E=
X-Received: by 2002:aca:548e:: with SMTP id i136mr5532382oib.177.1605184913361;
 Thu, 12 Nov 2020 04:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org> <c943f56c-f72c-0f14-b6ed-b67e91573b1e@linaro.org>
In-Reply-To: <c943f56c-f72c-0f14-b6ed-b67e91573b1e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 12 Nov 2020 15:41:42 +0300
Message-ID: <CAA8EJpp+=sQAre+kCiDLEFT+gDB0wO7KypGTXeCDncO8wWzQ-Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/15] qcom: pm8150: add support for thermal monitoring
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Nov 2020 at 14:39, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
>
> Shall I take patch 1/15 and 12/15 ?

12/15 will not compile without several previous patches, so it might
be better to take all of them through the single tree.

>
>
>
> On 02/11/2020 18:49, Dmitry Baryshkov wrote:
> > This patch serie adds support for thermal monitoring block on Qualcomm'=
s
> > PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extende=
d
> > to support thermal zones provided by this thermal monitoring block.
> > Unlike the rest of PMIC thermal senses, these thermal zones describe
> > particular thermistors, which differ between from board to board.
> >
> > Changes since v8:
> >  - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
> >    tables support
> >  - Simplified qcom-vadc-common volt/temp mapping code
> >  - Implement suggestions by Matthias Kaehlcke: message formatting,
> >    rewrite comments, remove unused variable initialization.
> >
> > Changes since v7:
> >  - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
> >  - Use explicit sizeof(var) instead of hand-coding 1 when accessing
> >    adc-tm registers.
> >  - Remove buffer read from adc_tm5_init().
> >  - Remove extra on-stack var from adc_tm5_get_temp().
> >  - Minor formatting changes as suggested Daniel.
> >
> > Changes since v6:
> >  - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
> >
> > Changes since v5:
> >  - Reworked DT bindings:
> >    * Removed qcom,adc-channel, instead it is parsed from io-channels
> >    * Renamed qcom,hw-settle-time to include -us suffix
> >  - Re-added monitor enabling which got lost during refactored. Noted by
> >    Jishnu Prakash.
> >  - Use threaded IRQ handler as susggested by Jishnu.
> >
> > Changes since v4:
> >  - Added kernel-doc comments to ADC-TM structures
> >  - Used several sizeof(buf) instead of hand-conding register size
> >
> > Changes since v3:
> >  - Fix DT description to spell "thermal monitoring" instead of just TM
> >  - Fix warnings in DT example
> >  - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
> >  - Fixed whitespace chanes in qcom-vadc-common.c
> >  - Removed error message if IIO chanel get returns -EPROBE_DEFER
> >
> > Changes since v2:
> >  - IIO: export of_iio_channel_get_by_name() function
> >  - dt-bindings: move individual io-channels to each thermal monitoring
> >    channel rather than listing them all in device node
> >  - added fallback defaults to of_device_get_match_data calls in
> >    qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
> >  - minor typo fixes
> >
> > Changes since v1:
> >  - Introduce fixp_linear_interpolate() by Craig Tatlor
> >  - Lots of syntax/whitespace changes
> >  - Cleaned up register definitions per Jonathan's suggestion
> >  - Implemented most of the suggestions from Bjorn's and Jonathan's
> >    review
> >
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog



--=20
With best wishes
Dmitry
