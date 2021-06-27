Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F923B53D9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhF0Onf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhF0Onf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jun 2021 10:43:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC8C061767
        for <linux-iio@vger.kernel.org>; Sun, 27 Jun 2021 07:41:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d16so26667548lfn.3
        for <linux-iio@vger.kernel.org>; Sun, 27 Jun 2021 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btdlc/ifZaWqLzJPrzCmNv9xr6UOVvnu4j5N5Ajddbc=;
        b=yffTw/J5lSDtXKZKMbHb+LYAj2r+UxCDpeXnSWFKiXIFDF619yE7YIq5A87id2LvKa
         Q87cqXc66jFqDBWZR4BnGNgqyAeXaRJjTLIOouA6vrFRvKqoIzkwlROs7MUhWp5znt6h
         JzzRFwzMOT0YaxSY/d/NuW0vY9y6i6jZNOwKEWLjn+6Nb3WzhpE4oqLWDGhNx08GLZjt
         CNv9E1//wPPkVcja7fOjXXz+STz7G9aCld7HIphWRNC/N0IgOh9XAlHPM/M82DG8nx4m
         IR2WxqSeW6s3VK9QWzpCore1k2uJmhYWif/9sCm/yOTj8D8t97/Njy7uLQSVWNUtqi/J
         rElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btdlc/ifZaWqLzJPrzCmNv9xr6UOVvnu4j5N5Ajddbc=;
        b=IVsXND3pee+fpl3F5ccdM4CdEGBu6QXLUuiEAAjTbCHKfCQQbmuM3SmDNdJubNgCbS
         F7GWJN+i0yhe5ToYSqfDxISX1GUhzHTkXo0KigdQmRv0/c/r/UQXJsb0mcxIMUvGPb+0
         0xhTGZq/QuMEpVLi4+FF9gvWi7DzCk9mFoOBkoHEER7+/0lIm2LrVtcmbKiHMAfkuGDI
         13mwgPX3HNR9+Gpy+4HreDSSEGRtH6ZmHWCLnhICFFGpxkExqSCPdQicCGxr7abe1Fdi
         FbGUuqsTN6e84z3QuBZ5qcuHcvUboeunDk3Rolx3PFuMJML0C/wkGiMlj5j9ISAMGikY
         UDgw==
X-Gm-Message-State: AOAM533oeZTRlRMr9Jd1FsJsu1FSfFhwchTSsrkNyMQ748WeYlJ7b8IX
        ErTjW2z+xwI6W+Bu8FmHOMo2hReNDwen+dWjXM/6Pw==
X-Google-Smtp-Source: ABdhPJwomKfBSqwR+h+1fkMj/2by+2A/Vt84AAJQdmIrZY7Vy9QHtS+zQ27ySQ7/GVl60lvKYvUjV5vijNwRvQFpL60=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr13083965lfk.291.1624804869321;
 Sun, 27 Jun 2021 07:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210625235532.19575-1-dipenp@nvidia.com> <CAHp75Vf4TKjtC7cLNape4r+hE-AWnbxtbww2ofCcHQJf9zyh-g@mail.gmail.com>
In-Reply-To: <CAHp75Vf4TKjtC7cLNape4r+hE-AWnbxtbww2ofCcHQJf9zyh-g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Jun 2021 16:40:58 +0200
Message-ID: <CACRpkdbXE2A98P0_juA9PNEKTo89FcgywYmnqJSC5bV+Vox=Fw@mail.gmail.com>
Subject: Re: [RFC 00/11] Intro to Hardware timestamping engine
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ye Xiang <xiang.ye@intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Sandeep Singh <sandeep.singh@amd.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
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

On Sun, Jun 27, 2021 at 3:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > To summarize upstream discussion:
> > - It was heavily favoured by Linus and Kent to extend GPIOLIB and supporting
> > GPIO drivers to add HTE functionality and I agreed to experiment with it.
>
> I guess this series should include more people from different
> companies, especially documentation parts. This may be used by
> different hardware and quite different vendors. Developing a framework
> like this for only one vendor is no go in general.

I forwarded patch 00 to the IIO list and Jonathan Cameron,
and let's page Ye Xiang who made a bunch of contributions
from Intel's side to IIO directly. (Hi Ye, please check this concept
if you have time!)

The actually most important target group would be people
doing things like sensor fusion where a common timebase is
important, I don't know who does really, but Sandeep Singh from
AMD has contributed the AMD Sensor Fusion hub in
drivers/hid/amd-sfh-hid and might know a few things about this
though I don't think SFH would need this directly.
https://en.wikipedia.org/wiki/Sensor_fusion

Also Paging Drew Fustini, who knows a lot of maker and tinker
people, he might know a bit about this or know someone who
knows.

Yours,
Linus Walleij
