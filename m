Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D14410CA
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJaUYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 16:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJaUYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 16:24:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB1C061746
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 13:22:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t11so7770574ljh.6
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iSbuVjJlzB9DdZ5jUHx3CMU+Mp2RW2SyUPqcplwAFs=;
        b=TIdDitvF55xQp5TIJUgR7B56eb5OVuWOZhZFQmFiq/n27aJUAE8FD8a2o1TcAdBGg2
         BRKfEWr624d+XH0hvv39FSR17EnIXFAj36DmFEL4Ysq6eN44H6D7OgzFxKTtJbHMQGUP
         pTFGPQhni/UB7KBZhq8u6Iza0HxDZH9GVqwV4nB9crZSbCn34tZivHm+vbjrJUudh7TG
         IizEjw23nN/SOntvh18PSH2FXqrUgCtEQDuujDJ47Qnbah16MokSiEq4M8hsE3JvdPiw
         ICKQ4ScS6+dsSF44Xl7O9ZkGDdfi1VjHEM3C5bbubrBg86AOLGcaQl0wSBFKXbzBHbI7
         btnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iSbuVjJlzB9DdZ5jUHx3CMU+Mp2RW2SyUPqcplwAFs=;
        b=aaDKBqEyAbFdC45vBXntW8/elFPBEU5LHvCpgGtgvdj476cdJeNqUG0zKsX9IcS2cf
         aOtZVPUMU0clROn3VXzmUc4KZ0OgnKrNTBSbXp8wsoaRMVFw/5KbmjJ7gDBjDY3DeF2W
         B5NcAsgMA0XGrUmuKcpxmv5xK1Ze8PDitWNsmFJIrDhi3As71v3vo4cHf5A8q+q/x5BX
         /LE14SuTig4FVdL81QHv4AvH+lsTlbM/JZ0VnNUdKSOHoVMBIXTJdBgpKTmoMZ1OeqFf
         pc4wJ/u343FNT8KjLLfBgQBvipRMuEsAV7xVa1+cdUC/3NfScuDrcY1oU/n8rbQ96uSn
         lPWg==
X-Gm-Message-State: AOAM532qNoOmDjdATFBf0Q4YwpkG7vSJ0F1Cb8NR1zlLtk6y1uevKB+4
        VPuOArZoutAheHIdx1yx2bmgrkN7z4Ev9n/PV9+VmX3Qc9o=
X-Google-Smtp-Source: ABdhPJy4sgUD31Xy0+i6/BD9IK/ktzEF50sOu9OM5pDPOFVZhYzrbuiBGparb8EJsyeqJDQLV3skes0/KiAhm5rvUtU=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr27084992ljm.74.1635711740337;
 Sun, 31 Oct 2021 13:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211003153306.391766-1-jic23@kernel.org> <20211031170854.6990d79e@jic23-huawei>
 <20211031171206.75960513@jic23-huawei>
In-Reply-To: <20211031171206.75960513@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 22:21:44 +0200
Message-ID: <CAHp75Vc3m8+iFX+aufv6f79GcR+GCFSrmnb8R95fYHng=tGE8g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] IIO: Bring core header includes up to date.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 31, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 31 Oct 2021 17:08:54 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun,  3 Oct 2021 16:32:55 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > Given ongoing churn in core kernel includes as Andy cleans them up, I've
> > pushed this particular work out on a branch at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=iio-iwyu-cleanups
> >
> > This will get me 0-day exposure and allow me to keep moving these
> > forwards as the core kernel headers change.

Thanks! I'm in favour of the work. Here are few things though:
- blank line in between of the groups of headers (like before iio/*)
- fixing properly bitops.h and other typos (hope lkp will tell you about)
- thinking more about the list of very-low-level includes (see below)

On top of that, the main idea behind header usage is to make sure we
have no circular and other hell dependencies in the *headers*, C-files
can go with more relaxed rules (but again, I'm in favour of the series
and effort).

> > I would like to start merging 'some' of these in the meantime and
> > there are some precursor cleanup patches that I'll pull out separately.
> >
> > Perhaps most 'useful' is the top patch in that branch which is the iwyu
> > mapping file I've put together to get it to make more reasonable suggestions.
> > Note that there are some cases where the answer isn't obvious and some
> > where you can't push iwyu to do the right thing.
> >
> > One example is struct regmap which is deliberately opaque.
> > iwyu always wants a forwards definition of it in all files where pointers
> > to it occur, but personally I think including linux/regmap.h is sufficient
> > as that will always have the forwards definition needed.
> >
> > Note this branch will rebase frequently and may well eat babies.
> > In particularly I will be cherry picking Andy and anyone else's work
> > to the top of it and making changes through the rest of the patches as
> > that affects them.
> >
> > I'm not particularly expecting feedback, but I do want to avoid duplicate
> > work.  I'm also likely to 'fixing' new code as it comes in based on this
> > toolchain - I may main in reviews or just fix it whilst applying (and tell
> > people obviously!)
> >
> > Long term plan here is to bring consistency to includes with benefits
> > of resilience and hopefully reducing just how much code is actually pulled
> > in whilst compiling.
>
> I forgot to mention that I've take a stricter view since doing this series
> so it needs an update even in the tree above. This mostly affects
> err.h, errno.h, stddef.h and types.h

I don't think we need to include stddef.h to every C file, it should
be guaranteed via something like types.h or so.

> I'll update those in that tree sometime this week.

-- 
With Best Regards,
Andy Shevchenko
