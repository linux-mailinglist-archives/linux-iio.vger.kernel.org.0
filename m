Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0D2FC4B2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 00:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhASXVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 18:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbhASXRy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 18:17:54 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DAC0613D3
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 15:17:14 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b64so23686253qkc.12
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dB7F3Mtlu9hzcaH0arXRlX+sy8rlfc5xRtRuFS9rvVg=;
        b=SibYt1GVdrviyGqBHiuRdkDJ212F7mKHeGAGTB3L6VdvZ2tX3F1XaE6kRQ89HeDHwg
         ctZ9o3Y7tlLWqVfF7LjJMXmKGSrNa7VSowWHy5QAb8k8NxgbCOgJC1zipjomGEe3iJea
         5TUZlIHbOQHHZiG4nXdh4SABgjHW6NYYLnatBHGCtcOa1VU0mfaYrkyObMYi3FoyzCIS
         u9No6XJWWpJnuT3Yd0j9glu45Q1AoZ59LbenJHRMpv6VgZ3urxG+tii+h03WPMXVJeF0
         oYBrTIqMJDQYiiWTHVH+nvfZqnu+QcedayPLqgxAsYcqY9Mg7ssCkwU2X4lXf6mmRWne
         Q9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dB7F3Mtlu9hzcaH0arXRlX+sy8rlfc5xRtRuFS9rvVg=;
        b=bPzSL++w+TzZs5FB3BuhVayrqoj70A1OltLTIe+zf7Ym/64gcpTKzvf59lOiIs2NJZ
         0NAj94sEdLKihF+Gbck1GG3IP02sDRKiZaVuMeUas7gRJAdWr3bJoVu5BQeP2fWkVymv
         p+lnZGYRBaJbRoO/uFhfZn2q1HwsvAU0pNiu4kcvwJKTGRTdAVMxuzlKILBhDLbA9MSQ
         0KKSSZkchp9EmhNYpUpWXIITpgY2GZXFhCQYcTUoFSMg/fhMvCQXgeG1dWgV1lxbpAvb
         T7GXeRN9Vfrr/OgWzoFs5slBktB8OlKH/q0CrCVVqzpBSb9IT6o3UJI63/O6hObtnbN8
         JJMg==
X-Gm-Message-State: AOAM5316p+1keaiJwGRLMl/GmWwKw1Iuk8T7Xb03kPikAuYMCWJNsbA2
        xxYfxmqygfwON9x+0khMRfjLYuvlhYRGobjTjsmMX8Kp4Ihp5A==
X-Google-Smtp-Source: ABdhPJyGeUyg+YiDKqtN0x6dVvip4U9xb9aSUrHVlWP6pb2DIhbKAAN/SFc8tehaF+Bmf26mv1wmQWdcJ5xXSunbNtM=
X-Received: by 2002:a37:be84:: with SMTP id o126mr3005803qkf.138.1611098233468;
 Tue, 19 Jan 2021 15:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org> <078a7025-ce5c-a252-f8f4-694c56153b3a@linaro.org>
In-Reply-To: <078a7025-ce5c-a252-f8f4-694c56153b3a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 20 Jan 2021 02:17:02 +0300
Message-ID: <CAA8EJpr2bubGBtUGf=4+d4ZVT1nReTBzT25scGehdwKy2EepmQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] qcom: pm8150: add support for thermal monitoring
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
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jan 2021 at 23:58, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 19/01/2021 06:48, Dmitry Baryshkov wrote:
> > This patch serie adds support for thermal monitoring block on Qualcomm's
> > PMIC5 chips. PM8150{,b,l}, qrb5165-rb5 board and sm8250-mtp board device
> > trees are extended to support thermal zones provided by this thermal
> > monitoring block.  Unlike the rest of PMIC thermal senses, these thermal
> > zones describe particular thermistors, which differ between from board
> > to board.
> >
> > Dependencies: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1
>
> Shall I pick 3,4,5 also ?

I have no strong preference on this topic. It might be easier to get
3,4,5 through lk-qcom so that we won't face possible conflicts. Bjorn?


-- 
With best wishes
Dmitry
