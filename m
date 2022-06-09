Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFC54468F
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiFIIzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiFIIzl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:55:41 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3652EF0F5
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:53:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i39so12632069ybj.9
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0DkjSEsM9B1ipFcPKq7Fh6+GsA8/sySdqZ1Ys1gvV4=;
        b=QKriiGSDS2VWgGPmAw1nqvPXyJmNwsL3NRrcb2lryLC6tAnZ5aoyQVxIzCJUOcWRBp
         PtMoAgDxRCPjLKkhfRwZrSTpo/r4MFrhRmP7n5awnYRjUrLPFTGfM5lvA8qNwNa91Q22
         VJAnrYkTTxWTF9c/u6GTQBrRoUcDPLgdOHFe43b7+pr5QNlj5CByT8zLcr4KU0Ypkioz
         /n5EyIKTJmtufY6l7TiQJFfoMh1g959etPzBhDaAYq83Bg16axcvf1AvVBy536FPUPuK
         DeS7s7flCKwStt53Ncf7TjGXOMyqN1gX7aD32C7ZMzODD8zvHSXQO8jVfwWgZW0afrjW
         +dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0DkjSEsM9B1ipFcPKq7Fh6+GsA8/sySdqZ1Ys1gvV4=;
        b=rxpawfzfj+cR+jS5VogGr8ng0UsGMM3151oGLag9elpO2frd5LwEpt3O02Y7wlT8OJ
         Q6cRH0/wzwP+ivapcYUTCJYqcSn2W9STBUw8i1F0ygb1jSSstnt7J1vbCz4R89/zmDF8
         3Qp1ArwujKpg3XGFFsYu0UOPI09T+FF9LFe4ffRiilLcFMrpzXBTWNFwHkdcxORg0jzP
         b4YAkWcyueiJVLkU16lhmwin4aXjlvDvhagA56naRWX8yoyP6dGCpEe3o1GdOukL7h3M
         2Ic02t6OP6V2D8U7G3oH8H9cLzC2v6UfXasQxlVN/SMRCK3uFXvhn3KExNrbQuRv2meL
         I6tA==
X-Gm-Message-State: AOAM531QFXIBlux/OFTvlpRcCUMupNZ8RWE060KkTJo7YEMiH1gH/dWu
        +nLHplvquauRu4Us9e6DsqC3YYSrd9NgjQpCcnPwsA==
X-Google-Smtp-Source: ABdhPJw/lT3kFvT82YWfRN3zvdCibGU7BfkVgqO+vP484iAXxm2EPK1hlCWh2109hp+j7kXJLDEnwFnJVb6yYEI5yO4=
X-Received: by 2002:a25:c506:0:b0:663:edc1:9f98 with SMTP id
 v6-20020a25c506000000b00663edc19f98mr10424592ybe.291.1654764832235; Thu, 09
 Jun 2022 01:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <80d86bb542274dd30be9c5a22dda00736c605222.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <80d86bb542274dd30be9c5a22dda00736c605222.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:53:41 +0200
Message-ID: <CACRpkdYJhDATBZxASS6+QtRbj_9Qf1Hp2vLvohb+keOKE6-XWQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: magnetometer: yas530: Correct temperature handling
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:38 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> The raw temperature value is a number of counts from a certain starting
> point. The resolution of the temperature counts is different for the YAS
> variants.
>
> Temperature compensation for YAS532 version AC seems to be handled differently.
> It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
> versions of YAS532 apply solely the t value as a multiplier [2][3].
>
> In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove scale
> of temperature as this isn't applied.
>
> Additionally correct sign of temperature channel in iio_chan_spec. It's already
> defined that way in yas5xx_get_measure() function.
>
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L442
> [2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L881-L883
> [3] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-18.1/drivers/sensors/geomagnetic/yas_mag_driver-yas53x.c#L856-L858
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Thanks, my temperatures seem more accurate after this on YAS530.
Patch does not seem urgent as the temperature does not see much usage
outside of the device itself.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
