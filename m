Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA34B1B02
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 02:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiBKBMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Feb 2022 20:12:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbiBKBMf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Feb 2022 20:12:35 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FEB4C
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 17:12:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e140so1314064ybh.9
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J88C2+WacsqQSdxnsSChBU06Pgsig7erWKYvY0xtMso=;
        b=QHe3h5C++nnBcVkD45g4Pk1ynGu3W3SJ97i5ZH3x4r1tUeNQQlMja+CGKROy16PxKc
         fdDI0yzEvBSXSqvDei8yp7P7zLtLPcFYilm3hNeQTKmnmhHKp2/w88Q9WEtDRV5naorw
         xyAzgm3S94EIyAsksmd1nMe095UTYk4/Jk7S5uuYK55ipxFIzWxa1KjebhMupTBS3GUT
         S6HLtkDD5SrQF2M6zBsDSgw8t25XpvKpORymN5to3FtlVf6GkQGFly1R/piHWkFNTnqI
         Jpb3dQQjaNmiR4wVeyYOS3KkIyx+lXedGoR0lGMfsZ8A4AwpAjSACJG1Sdk+Uiv7gK71
         Mo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J88C2+WacsqQSdxnsSChBU06Pgsig7erWKYvY0xtMso=;
        b=PXfraIjoUAc/VjhZA52cmqJy0YHWom5NXnT4zpQuHLI+0Nv5vKs0oqhdp5AoXGOCEM
         KyuSw7eWi9J8xfPCHJuJ3B7RhR/Mql0tX/YL++dxV6AVyEtJwFGkQ+cFMurw3cZ82y0K
         rpATwTgyiwzanlh00qn/C7QarHv/eRelu5aU+gj+X031PbW0Ce5ugIfgfMXgVMUCtOin
         JxevCQRg4fg/s2iV1w2FRK8HFvj9cy0+vD3hVNET+HMpxMEJhTDxxiBFibAodLlddUBh
         y32dhHbWyDMMLls5D8BT8VfUIGLzwCHknVH8mfaPpdjUodM+5CsweIHKR4d1w1QYjOwL
         bhyw==
X-Gm-Message-State: AOAM531HN01+EhFWsNeH/jDvGKoasEp1lGeeGBVWMpvJv2oPWO/3ylcy
        ioxAX7Im/rwc92VgEvN2EMwynQLLFakWOL/VODiGpw==
X-Google-Smtp-Source: ABdhPJxXg8TaVRUvy+OG5/nJN2rIs7DJiRE9bRuV3337tBIjtctQEIhSEBVYZeZkAyqVVQ8HY/6QFcSBbM08YwfOxbY=
X-Received: by 2002:a81:4402:: with SMTP id r2mr10280479ywa.126.1644541953328;
 Thu, 10 Feb 2022 17:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
 <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com> <20220207135858.00000745@Huawei.com>
In-Reply-To: <20220207135858.00000745@Huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:12:22 +0100
Message-ID: <CACRpkdarYo06heRhhi0o5bKbMnVveQ+2j+oKHokxCNftCzq_cg@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] Solve data access delay of ST sensors
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        caihuoqing@baidu.com, aardelean@deviqon.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        Qing-wu.Li@leica-geosystems.com.cn, stephan@gerhold.net,
        linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 7, 2022 at 2:59 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon,  7 Feb 2022 09:04:41 +0000
> Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com> wrote:

> The standard approach to avoiding rapid power up and power down cycles
> is to use runtime_pm with autosuspend and a period set at a period
> of perhaps 1 second.  Would that work for you?  You'll pay the costs
> of power up only on the first read after a period of not reading.
>
> Exposing the control to userspace for this sort of thing is normally
> a bad idea because userspace generally has no idea if it should use it
> as there is no clean way of telling userspace the costs of not using
> it (as those will be device specific).
>
> If you have a usecase that requires regular reading you should also
> think about whether using the buffered interface is more appropriate.
> IIRC that will keep these devices powered up continuously whilst
> the buffer is enabled and will provide a lower overhead way of
> reading data than sysfs reads.

I see that I have repeted similar comments.

Sorry for the hammering.

I agree with Jonathan's stance here.

Yours,
Linus Walleij
