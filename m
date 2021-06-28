Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B93B5D82
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jun 2021 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhF1MFo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Jun 2021 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhF1MFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2021 08:05:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817DC061574;
        Mon, 28 Jun 2021 05:03:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d12so15270037pgd.9;
        Mon, 28 Jun 2021 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hC95X8dILV4yUsxnWcqyaUSRLR/4KhkkqpuXQlMJ+os=;
        b=j/1qnIN05R1GrGDHQLT945i6wPcIK8UlPXIPynREbRgcev1CYX2vV3PdaSuMf/fkFk
         5cqvLfoq5LYsQxXfM7WQ0FhWh/GEM4zDYp5YUE+qMxSxIVkZ7BKnlyGaKE/bSRaOvHBg
         TBZ0p8k4IY1hA9bUBHOp66D2kooiwq9RIKp0v+M+UCECYePx1BGSp6UWwbcxRdr1vGBU
         YhrN7Hyf6PH/SHx5y8fvtG5Q53KD9JWDK6pJ02iF3Cy0+B3mLGowTZUmWFnuQlP3f7Nx
         +XjgCAXiaMUgzXVlCRGJGktRvkV7Bp51kBbOk6qaMNw6n64Vu4Jj8gRaEQVLEsn/xxNv
         kMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hC95X8dILV4yUsxnWcqyaUSRLR/4KhkkqpuXQlMJ+os=;
        b=RnPTzM1taTLl4W5n+cIexpiXT28ml9J8lJs3VAWL6VH+n5K193xCj1EQARZQ0jY4lA
         4ML/VaJaSIzavDrc6svh8wD3wkAqLI43AVbXvFFRhgRBcrkuBW+eE9HhMZlevHPW7IqS
         tMWgGeAhV3YbKX9IILxu2iONOl250J+LcsWC9WHPJTff8TWXI2nfODpyi9SQJXJyxfZ/
         uZeqbhcqL+HQlhu4w/yda75TxHJnX+VY7LU3NVJwbhL3l3rv7xHoyyUauWIS9h+p0Lnd
         T4di5v1ifT1xbKisBDy/r+BcEhefhgzgiP7/ouB6PmuhlU/O02WGODi5ZVUfKNhD6E+Z
         n7Tg==
X-Gm-Message-State: AOAM530bKDNQSI/J+Esjde5p2KKiwTUl4Sk75mK+Wt2nz1A/62hHj37v
        s/TSKrT/y5a/1TvHm38Lf7LFxCQWQVU1TZaOFo8=
X-Google-Smtp-Source: ABdhPJyAv9znER5hh/JOnKHGaD1NRGWHP3IrFfiODa8IXBazHOnTNyl7L/0rKn7rdXQ7fCvZ/iGF6s9IOTuD8HfB+dg=
X-Received: by 2002:a63:f609:: with SMTP id m9mr1004059pgh.74.1624881796677;
 Mon, 28 Jun 2021 05:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210625235532.19575-1-dipenp@nvidia.com> <CAHp75Vf4TKjtC7cLNape4r+hE-AWnbxtbww2ofCcHQJf9zyh-g@mail.gmail.com>
 <CACRpkdbXE2A98P0_juA9PNEKTo89FcgywYmnqJSC5bV+Vox=Fw@mail.gmail.com>
In-Reply-To: <CACRpkdbXE2A98P0_juA9PNEKTo89FcgywYmnqJSC5bV+Vox=Fw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jun 2021 15:02:39 +0300
Message-ID: <CAHp75Vcv3BsQ87bnnYK07npQsp3GU4JC1k+iXUw2uuGbSKBQNg@mail.gmail.com>
Subject: Re: [RFC 00/11] Intro to Hardware timestamping engine
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ye Xiang <xiang.ye@intel.com>, Drew Fustini <drew@beagleboard.org>,
        Sandeep Singh <sandeep.singh@amd.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 27, 2021 at 5:41 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jun 27, 2021 at 3:08 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > > To summarize upstream discussion:
> > > - It was heavily favoured by Linus and Kent to extend GPIOLIB and supporting
> > > GPIO drivers to add HTE functionality and I agreed to experiment with it.
> >
> > I guess this series should include more people from different
> > companies, especially documentation parts. This may be used by
> > different hardware and quite different vendors. Developing a framework
> > like this for only one vendor is no go in general.
>
> I forwarded patch 00 to the IIO list and Jonathan Cameron,
> and let's page Ye Xiang who made a bunch of contributions
> from Intel's side to IIO directly. (Hi Ye, please check this concept
> if you have time!)
>
> The actually most important target group would be people
> doing things like sensor fusion where a common timebase is
> important, I don't know who does really, but Sandeep Singh from
> AMD has contributed the AMD Sensor Fusion hub in
> drivers/hid/amd-sfh-hid and might know a few things about this
> though I don't think SFH would need this directly.
> https://en.wikipedia.org/wiki/Sensor_fusion
>
> Also Paging Drew Fustini, who knows a lot of maker and tinker
> people, he might know a bit about this or know someone who
> knows.

Thank you!

-- 
With Best Regards,
Andy Shevchenko
