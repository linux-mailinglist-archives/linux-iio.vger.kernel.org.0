Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F094D2D45F5
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgLIPya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgLIPyH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:54:07 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E6C0613CF;
        Wed,  9 Dec 2020 07:53:27 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so1148117plb.4;
        Wed, 09 Dec 2020 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tn/MqYnGNPsxFHJomulLqVNeRAPMOywqyg1X+RE7cuc=;
        b=mlAA6cxKNHJ3cNM911r0FD6GHC+lF7lShDoVXDtdUUtJe0FTsSrIhUhrZBPQjJW1I2
         Wt58lIb0MybGboux9N/tR+GVNTOr3Eoy4IA3xh/H5z5mnqzT2HnPkEQyRJQEiBYOabvN
         zRZOYiKjYKz7wfI8Y32temDYhtQKEPkIvRwo3lJ8lBnCoNZg8I8Vk1zNoHWOXC+zYNyr
         Q4958JPMuSh8E59SKdu0NzyYasFfh1w91EK2besRlIF3pzOS/mk6h0RtOY9rb9fIQSEd
         enNszfTiJwjs3RQBKGvhLyC4tUAN2Nwl5s6BJYlb2nUcoIPa6QtEQgrdgn+2TDQ+cV3m
         uZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tn/MqYnGNPsxFHJomulLqVNeRAPMOywqyg1X+RE7cuc=;
        b=qBlKWSwDObVVfq8OXU4sLHgunW8YetGTRTxJ60P3PcdBgsdRBY5w4MOHfoZKafbLsn
         3NQDjwUG6iUGvIp3X7cXgRNJbJ8v0pYCuaV9Qi0+6rLUabSLnCw5IdUOtufzEMpTWRgA
         olifGBVLKTNjp2YwjpSK01d65GWoKFm7FVlw4ZY2YY2014h+fuiv7x12pUJlajU8wfzC
         bBQrdXRXGzTNtRuXxE4xIfjQB/bms4utyw8HEhoIiNQaLZVIrAsPayeCGGJ3dCVf2a/d
         kKADU5bww5uOtylBnSPXAYdWzYrVqOraA0iMimJmhSyIVkfDqAXw09LLvnv6sNO07sHG
         WuTg==
X-Gm-Message-State: AOAM5317FmagU6QaUgJYPFzEXQsZvWxpfOitke4pud/VZHseayu0aIgl
        GJT1rHOaUBRXqoA9qLghUpmk6sbtYzlPymIeO1k=
X-Google-Smtp-Source: ABdhPJwd5RYD0Twhj04Yad6dUfCjv6dSzEor7A6Qh0enjWu1UjD8I+JISjtAnnoRyfrmEAo+zlKwBkpRsIG0Y9sE9RQ=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr2843949pjb.129.1607529206922;
 Wed, 09 Dec 2020 07:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20201203095342.73591-1-alexandru.ardelean@analog.com>
 <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com> <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com>
In-Reply-To: <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:54:15 +0200
Message-ID: <CAHp75VcxZd1xW+ayi_km3zCYKV3aC1VRJ5bwyVpevZkvgg_ipw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 5:45 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Wed, Dec 9, 2020 at 5:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:

...

> > Are you sure there is no user space application that doesn't rely on
> > character device to be always present?
>
> Nope.
> I'm not sure.
> I'm also not completely sure how Jonathan feels about this patch being
> added now [so late].
>
> Though, technically if the chardev was already there, without all the
> control in place [to enable IIO buffers and other stuff through the
> chardev] then it's technically just a "marker" file.
> Which arguably is a lot to have (i.e. chardev that should be unusable).
>
> If it is usable with no control in place for buffers or other stuff
> (i.e. I missed something), then I also don't know.
>
> So, this patch on it's own can still be interpreted as an RFC.
> See:
> https://lore.kernel.org/linux-iio/20201121180246.772ad299@archlinux/

Don't take me wrong, I'm not against a good change (I doesn't like
dangling files), but it might break some use cases.

-- 
With Best Regards,
Andy Shevchenko
