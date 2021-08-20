Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318E3F2907
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHTJTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhHTJTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 05:19:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569DC061575;
        Fri, 20 Aug 2021 02:18:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k24so8540444pgh.8;
        Fri, 20 Aug 2021 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcKjNJ245vgXkYDCK3fscDqcfPmoCHJwUwzzjEOFm9w=;
        b=KldDjx+4deNAq8RuCrxjwWAscLzgXpjMx+wScTUJ4b6oG0/t6Gvq7MLF/LK0SfjFa2
         tlCffeCWYACzN8pKvFKyPiBgtp22zbU8U24sZdHFLCQmEuWcySyn87S14HZae6fT3HUO
         jALT21XG7OyIaRHAkmGoaP51Pynfned6wv0yG7AWbEJ61lOhd94GfC2pj1C+1WRf2tH6
         +o7DvpdKiF9TtQyHNf7LSVQNO6mKEOl0D7A0f6RliwaSYXNHhgVDqhXxXBNUHrrgcxsi
         syyT3wFoigSScfR/l6F4OX98lUNfVV5WK8/Du6dgWMwsZo//JHNFv4tpnaHv3D3uGEXm
         f31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcKjNJ245vgXkYDCK3fscDqcfPmoCHJwUwzzjEOFm9w=;
        b=BenDHTBsTQ/s6jVupEGwjMMo7DWbbEuhP+xs89shdeLN9jSTifbo15w9XP3LkpppYt
         3Id0u4cyKrdDyCR5aQuN/WQHQzl6UTRdeq+Im66GUG2QOES301DO0tIux0iV4RIGsXbo
         05tUavicvh+6gC93CsMOZ6X6LyHllv3em8ELWO/ATjaRTATPnjwEJNP8GlfPaj5f5KI9
         Oz+LP1N8MjHUNk/TIpZ0dvUHImFo91XSctkk4rmBOavW2mzAeOSElKb5f7k+D84QA+56
         M+iLJv1GTR/zGa63t4lv9c98V/d60EAtTtcvdD13X+8YV7sR2mpGhmMv2Ixhx5JPBXU2
         +OeQ==
X-Gm-Message-State: AOAM531U13w1BJKjkKbes43P93l2D9AeRON6jdIMCqUp5NFnilECcPaW
        Ovfj0GESFMxRNEyRgxpBvV2NscHx1hXcWxdfADs=
X-Google-Smtp-Source: ABdhPJzupCmshVSpth/8oJXEYvw8HZi7Ue6oqqg1DP4aio42xLNgH9e7xfflT9CWGvNI8THNag1cDqG4O1Bq33K3duY=
X-Received: by 2002:a05:6a00:d41:b0:3e1:3316:2ef with SMTP id
 n1-20020a056a000d4100b003e1331602efmr19029953pfv.40.1629451102470; Fri, 20
 Aug 2021 02:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210819132416.175644-1-yangyingliang@huawei.com>
 <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com> <9b848f1c-9acd-243e-2c5b-d489d2427464@huawei.com>
In-Reply-To: <9b848f1c-9acd-243e-2c5b-d489d2427464@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Aug 2021 12:17:46 +0300
Message-ID: <CAHp75Vdim8S5kMZY1DYSMM-gLbPHoqRcEMD-rcZ1sm9hPeTaOw@mail.gmail.com>
Subject: Re: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 4:52 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> On 2021/8/20 1:20, Andy Shevchenko wrote:
> > On Thu, Aug 19, 2021 at 4:19 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().
> > ...
> >
> >>          ret = clk_prepare_enable(adc->adclk);
> >> -       if (ret)
> >> +       if (ret) {
> >> +               clk_disable_unprepare(adc->pclk);
> >>                  return ret;
> >> +       }
> > Huh?!
> The pclk need be disabled, when enable adclk failed.
>        ^                                                         ^^

Indeed. I'm wondering if those clocks behave like a bulk or any
combination is possible on a working case?

-- 
With Best Regards,
Andy Shevchenko
