Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B37D2C0B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjJWH6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Oct 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWH6i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 03:58:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDF107
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 00:58:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7ad24b3aaso31222717b3.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698047914; x=1698652714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hc1HQxMK6cov0ESZHcOE2hl8RJaLivF3ZZ3pITnRe4=;
        b=dEDJpjG3E9QicDV/6CPz2khqGc+ze6HAwGYcRmhSEQizzis6mJhooPs3K2uIDKs8bq
         g6ltCafmP6S0Kso9TVDLppWiTRCCtVEcZHNZ3uvqtr5qc+SrjFuORKcuyoZQ9j//X0E6
         tj7qpji+G/Dh1EcGzp2TOBYEb05MNaWCePvlw94zeNakXNTZJxb27fZe04hHE14tgQmQ
         9JKL08LD9pHa0nTvX8Dm6S/8Sd0VIXkTNjddimzuHfQ1hQEE4rb7P6/utU1CAo17bQ58
         Cd3PE5ZM53mQtAwBnennJDeDxCYu8kDJJqSCwc0kDJre3+hCHifjwNWV5pRo++C770tI
         tnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047914; x=1698652714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Hc1HQxMK6cov0ESZHcOE2hl8RJaLivF3ZZ3pITnRe4=;
        b=TNkGJBkCkhXCiWAQxfHJZDafRPfP/O6FqloRPzs5wk/3mZAPDs+cVbtsROm6w65t+3
         teCG7SQC7+G3HK/6T7CNm9Quraeqbhzn8S3pj/lMbSIbkfzVpN8WFQB0ffcimF2iMTth
         /TwFkLk/qzQLyFRurYjQMBsGEYl6dDneKj9qngaNqo9odIIHq5mPUDjtKqzXMv7oJGA3
         sez5vbJNzowJVI/UbBvaUfLwebVK53pJPkpcmi9CmSuKXgzDQL/P5izqJM7EUTOnhk4Q
         MhKSEjF5G3QIbyn+oEnv8pZWiHkgazwvzjPAkggDbV6l+4XZw+4qm/zh3kjnqWXVb9Bd
         cllw==
X-Gm-Message-State: AOJu0YxukApwpwAF6Xj5/F+fOk20ISEa27IbVL3VNfU+7LDzHporq1S7
        ILUtIziuXtOgqTOZYGWv70kdJGHm5KB0tKHXp4VN+g==
X-Google-Smtp-Source: AGHT+IHcGE7eYAlI8p2WSlLx/bFwKZDKurAJkefqlL92QCw9E55DVNlDs2SBU6J1Dc2EK+Fwg347Fnxddm2kJpuCkrA=
X-Received: by 2002:a25:2d14:0:b0:d9b:4f28:f6ce with SMTP id
 t20-20020a252d14000000b00d9b4f28f6cemr8193335ybt.1.1698047914463; Mon, 23 Oct
 2023 00:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-10-quic_jprakash@quicinc.com> <20230708162318.1e2b169f@jic23-huawei>
 <2dc93e2b-61b4-943c-f938-296922fbece4@quicinc.com>
In-Reply-To: <2dc93e2b-61b4-943c-f938-296922fbece4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Oct 2023 10:58:23 +0300
Message-ID: <CAA8EJprQFPvBdiwnnkGet7SQiv9nuo4zaDCn9kuLWS0QZ5Kc9Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] iio: adc: Update QCOM ADC drivers for bindings path change
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, quic_subbaram@quicinc.com,
        quic_collinsd@quicinc.com, quic_kamalw@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        krzysztof.kozlowski@linaro.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Oct 2023 at 09:17, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> Hi Jonathan,
>
> On 7/8/2023 8:53 PM, Jonathan Cameron wrote:
> > On Sat, 8 Jul 2023 12:58:33 +0530
> > Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> >
> >> Update ADC dt-bindings file paths in QCOM ADC driver files to
> >> match the dt-bindings change moving the files from 'iio' to
> >> 'iio/adc' folder.
> >>
> >> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> > Do the move in one go.
> >
> > Diff rename detection will make the resulting patch more trivial
> > to look at than this multistep version.
> >
> > Jonathan
>
>
> Hi Jonathan,
>
> Just to recap, in patches 8-11, the intention is to move the dt-binding
> files used for QCOM ADCs from /dt-bindings/iio folder to the
> /dt-bindings/iio/adc folder.
>
> I'm just confirming, can we move the files and update documentation,
> bindings, driver and devicetree files all in one patch? Or you mean one
> patch for documentation, bindings and driver files and one patch for
> devicetree files (based on the comment from Krzysztof for the next patch
> 10 in this series)?
>
> Based on this patch series:
> https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/,
> I'm wondering if I should add the files in the new location first, do
> the file path updates and then completely remove the files in the old
> path to avoid breaking the kernel.....or is it possible to get the
> devicetree changes picked along with the binding changes, to avoid any
> problems with bisectability?

Perform git mv & fix all failing DT and drivers in a single commit.
You might also update guarding defines, if you wish. Perform all other
changes in a separate commit.

This way git diff will actually tell what has happened, instead of us
seeing a series of add files, perform changes, remove files. It is
impossible to review your changes otherwise.

>
>
> >> ---
> >>   drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
> >>   drivers/iio/adc/qcom-spmi-adc5.c      | 2 +-
> >>   drivers/iio/adc/qcom-spmi-vadc.c      | 2 +-
> >>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> Thanks,
>
> Jishnu
>


-- 
With best wishes
Dmitry
