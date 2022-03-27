Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50CD4E89C2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiC0Tho (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 15:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiC0Tho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 15:37:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741C11A13
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:36:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x34so14696505ede.8
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/0F9OtTjR0USGKBTAF4uToVBc+3oRrAkzLKjx3JjxE=;
        b=pmIFr7vXbsHLXN8sd0IZVuWS7NISSbirFRUhOc2HjRVSFqHWXBhw049RQq4mbdiiua
         pga+kYUJng58uSnt8ZzHYN/3EUp115dCSWYcWOJNxq1qB0MHulFdakQMwujRdOP75ezg
         gBrngZEO7eua1iQIx6csj+U0apNShaJM3K0Ex/gaxc0Xg+l/GnHJf6ZBb0MJqiV0H8+U
         fd1ka9D077QsH7g0vmQ8K4O424Uo5LXrYODOB8Oiexnne+XWFFuU9+k6bMhd9KGyLQys
         B7+PxcG0D0FV58OejL1u+w4SrLWyYl8cgkmqbshfEuI07sUMi3wdWsBvSsIYECbEWkfF
         ZeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/0F9OtTjR0USGKBTAF4uToVBc+3oRrAkzLKjx3JjxE=;
        b=tNG/XYr4DxSae5+tI0CIXyJFZidM2eQOc4R9ilHukagRaAOSf7xSwMvEDE/05StjWD
         P21ViA2MeOvF1cJFYO5Kww15FPMZnLu9M+TAmr2JuHEWHUIrsSeMXKnrzA+esH+myLc3
         B+74wT2wCbXV5tT4SawFi95ELSjs/wW311bESSzQx6PjSrgXRyNdE5X+ukk/PFfnGcS1
         +O7FSvqhaMl6vB++RgJ0kXN2odsY2dVv4TwWquA30d2p7WVfxJj28A/9Te3zfBkk3IrY
         OOk49jfo9q5KIrvJPG1hFp/Ib/CuHkGr3rMnHAUgDpB9kWodbtOqssOWwhmSUVgJp6Yy
         Ullw==
X-Gm-Message-State: AOAM530UlfDiUvWQ5RKeKYJxjKo61LtxJ/O/x65os5evyJGUciuYjmg8
        qYse50MbnXMXmIjYZ2v3Y7zZKisZyfPWkoPPtKU=
X-Google-Smtp-Source: ABdhPJwOwwXXdSgK3UvIyhdPuwIPcgZEJH1iB1yBBLGKgqn+BaFweZ4XN1lTpmG38xedu5kZGOR8EvoBKcCzwSnI9xg=
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id
 l15-20020aa7c30f000000b0041902af4845mr12045798edq.296.1648409763944; Sun, 27
 Mar 2022 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220324055821.3184872-1-liu.yun@linux.dev> <CAHp75VfEyhB92iP8sRyGn+2WLzazFtok=47xzewhCt=bo=a7Zw@mail.gmail.com>
 <20220327155718.0d00be25@jic23-huawei>
In-Reply-To: <20220327155718.0d00be25@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:35:27 +0300
Message-ID: <CAHp75VcQ5c1XviKBMr7eU-fsy5jLViVcEt=ahHoSHzqoz3JNpg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: da9150-gpadc: fix build on mips CONFIG_MIKROTIK_RB532=y
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jackie Liu <liu.yun@linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 27, 2022 at 5:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 24 Mar 2022 12:18:14 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Mar 24, 2022 at 7:58 AM Jackie Liu <liu.yun@linux.dev> wrote:

> From some very basic grepping I 'suspect' you could just push the defines
> down into arch/mips/rb532/gpio.c but I may well be wrong...

It would be ideal if we may hide them in the C-file(s).

-- 
With Best Regards,
Andy Shevchenko
