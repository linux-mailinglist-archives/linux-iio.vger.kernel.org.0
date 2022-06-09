Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F285446AE
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiFII4f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiFII4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:56:20 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824E151FFA
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:55:15 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso233875967b3.9
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuMz68s5Fg6EuYHopZIT7HJlCZTmw82TFxcZiT0Ql1I=;
        b=o/CoGKvPKJ3XW3jtB5IFQK0EhzqnRlx1qUyYGd4S358pQxdqNgde7doTTF1bt/+lR5
         1ubUCjRvzG15oP294uZp+UN1X3DnZi7atvmYN9E0xm5d+bjw5teF3e/44s3Hzy4mRSEF
         WlSYgwweQQ6gFl6VUO4Ci7ozNKhXWxpkHStZb2JSKig/Dd6f70PJ3ZcWjZe8eSSgoUdI
         0O2X9M7YU+jy5FOOen24EsnV3HNyr9TyO7fD4pxDpiY6L7QWX/slPbUb26N1Cp74FA2w
         JbdBLfLuz7nh74WyJvNttz5kLIYCyw9nQB7W4YevlO5rgBejjRYqmeJYxQLiwm4giQAR
         vuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuMz68s5Fg6EuYHopZIT7HJlCZTmw82TFxcZiT0Ql1I=;
        b=WDXzJOuTlS8nso9xdM7tU8iUees45tik342XwaGsaIEFij6eitkAmDV4JAVHcpOU+O
         rZmpUQWqf/2ccHmCB1S9TwPTlGCYjxh1kbPyBs/O1shGpYnLD1Nf88G4RKXaNzj8mzPX
         s+NfUjEhLoSsk7W0EWl8VOnCgPvu85ascPWjewB7UTF8rnlcESXyhau1fSO0Jk7PCimP
         +GbXcoZoo3M7SGwBu0p6KW1IOI07x8Zo5sS1VEb7lQr1P2QuNNmC+aiXPjythcegJ5Jd
         JR0uKjGWl1xkGEyYkEP/pHnerfd7mbglcatm3ejZOWJO+8Fud3+L6BvcMpTu6rxpHijS
         kk5A==
X-Gm-Message-State: AOAM530Q89VDk1VBl7+tYxYFshn3/AL3zx9/zfY1RGOk6Y7TROc44WRp
        Af16qnF5S3GSSm+dDZosr46eYaQO+uwd2LFTG4GmmWkdEI7opw==
X-Google-Smtp-Source: ABdhPJxVNYAv/+ZaABH73RIztHnTR1ak8UfaOI2+wg1nUy0DqcfFKrR/QLtehwRc17anuMWy+ybL9xot1E94J8cCuWA=
X-Received: by 2002:a0d:ca44:0:b0:30f:a4fd:2ae7 with SMTP id
 m65-20020a0dca44000000b0030fa4fd2ae7mr42796069ywd.151.1654764914930; Thu, 09
 Jun 2022 01:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <b2e1c3e59b72f83c51701470091560f9375ebc61.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <b2e1c3e59b72f83c51701470091560f9375ebc61.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:55:03 +0200
Message-ID: <CACRpkdYvFdUjpJjEAYJ9gwZFOThhxoBwfWpuo1CVZ=GGcSdwLw@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: magnetometer: yas530: Change data type of
 calibration coefficients
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

On Thu, Jun 9, 2022 at 1:39 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> This is a preparation for adding YAS537 variant.
>
> YAS537 uses other data types on the calibration coefficients [1] than YAS530 [2]
> and YAS532 [3].
>
> On YAS537, at least for a4 and a7 this could matter because 8-bit unsigned data
> from the register gets stored into a signed data type, therefore this should be
> 8-bit as well.
>
> For YAS530/532, on the other hand, it doesn't seem to matter. The size of a2-a9
> and k is smaller than 8-bit at extraction, also the applied math is low. And
> Cx/Cy1/Cy2, now being defined as signed 16-bit, are extracted as unsigned 8-bit
> and undergo only minor math.
>
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L76-L78
> [2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L526-L527
> [3] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L76-L77
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
