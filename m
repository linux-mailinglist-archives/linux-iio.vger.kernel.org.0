Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91A2F5103
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbhAMRU3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 12:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbhAMRU2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jan 2021 12:20:28 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC08C061794
        for <linux-iio@vger.kernel.org>; Wed, 13 Jan 2021 09:19:48 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q205so2847084oig.13
        for <linux-iio@vger.kernel.org>; Wed, 13 Jan 2021 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjg/jy0DZZvh04Gg0ZIjuk4S6kMRfKUqimeQdNDRAhY=;
        b=NOSxj9uFAtN+cQGRweNSMDktTTciP/m5r4eugWeqMVmqGUhaZZoEeVw3UlgDzgdZ1S
         zGwm0xBbCsqHEtpRR/SI0HTnITrKvX6xoay3aWHq0gbN5z5v6dpUM5ZS6gRZXKKeCPTJ
         7b1Zmrcp8KmlAJ2aedEuaSRVabZuI2T9yAi01WDXkTG9BzaBopQMjdNi4NFfpElKQKxJ
         /44wANgcMPdCyC4Lzf99g2WYM6qOIicdqF8AoGx+Q7PoxE5PsPNVSeFCvnBuuDIdcpBC
         cXCl6AenutzNgOiU6WncKcGcHjtbiUr12+P4f6vVbI2xG124HYiQxZzHwHMyrrSGx0gY
         Ttvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjg/jy0DZZvh04Gg0ZIjuk4S6kMRfKUqimeQdNDRAhY=;
        b=ta5mqUvbHeY/9kWpCSMZtMaDe8BLr0gQLBm/NJ0aseRWc24Wq70IwjKsoHwpvg2Fzc
         MIbHALd+B2BarToj5Xy4ZZOIE/gVcnbZQmMpSSbSQeY0VPRDZCJvsf9qNFh64VHxaUwZ
         A3IEs4PO6gJ1E/LyEz/Pq4PsZqfxzF5JKVQi2az5+RlG9i5LvdvM1o7Gy9fjlKKrB3T0
         qDjcky1M76hzTurcSbfQpY5xvnICIEstSjSwAWzdhvP3htvSuqAyir0vrRK86WQUn74y
         dGGq7HxooRsN5rJ5RNCmvv8ghTGE09ojuSRPoc5ju1xS8JploUWtmUvmVme0B7ouEPq4
         hDhQ==
X-Gm-Message-State: AOAM530ayPKhbn6DtSl37ydUj2SO6SmRdKdtoVyD/Qs8Sr6X9fIlCLOm
        H3clZiDk5tz/AG2YP6w9a9cZnXxV7x/TfazelhkHOw==
X-Google-Smtp-Source: ABdhPJyblEJ+ghunXPkjZ+L33I7pPCUNf5kVsgKX6Zykxco0gDU7ktSedzB8qJcsKFCITlg6Yk3YhXq9b1JhYPDZ2wQ=
X-Received: by 2002:aca:b145:: with SMTP id a66mr201607oif.92.1610558387362;
 Wed, 13 Jan 2021 09:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org> <20201205170830.4d56ecb7@archlinux>
In-Reply-To: <20201205170830.4d56ecb7@archlinux>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Jan 2021 20:19:36 +0300
Message-ID: <CAA8EJporM=aZAn8-ZmocGJCT=KSZHvRMNH5xeBUQ_hypN_M4=g@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal monitoring
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
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
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Sat, 5 Dec 2020 at 20:08, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri,  4 Dec 2020 05:54:54 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > This patch serie adds support for thermal monitoring block on Qualcomm's
> > PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> > to support thermal zones provided by this thermal monitoring block.
> > Unlike the rest of PMIC thermal senses, these thermal zones describe
> > particular thermistors, which differ between from board to board.
>
> I've just taken another look through the various IIO parts in here and
> I think they are fine.
>
> My assumption is that given the timing this isn't going to make the merge
> window now.  Hence I'll be looking to do an immutable branch based on rc1
> once it's available (assuming everyone else is fine with this version).

Another gracious ping.

Daniel, any comments for the thermal part?

Jonathan, there was  a proposal to have an immutable branch for this
series. Do you still plan to create it? If IIO parts are fine with
you, it might be feasible to get that into 5.12 with thermal part
either being part of the same patch series or coming later depending
on Daniel's comments.

>
> Thanks,
>
> Jonathan
>
> >
> > Changes since v9:
> >  - In patch 12 add comments to the code as requested by Daniel Lezcano.
> >  - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
> >    driver history.
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


-- 
With best wishes
Dmitry
