Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28B3A2C59
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFJNEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJNEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:04:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC000C061574;
        Thu, 10 Jun 2021 06:02:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 27so22541180pgy.3;
        Thu, 10 Jun 2021 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9LSFZNbm/MaeD6MXhWHORKk8t5cnVy9vvWN1eklncY=;
        b=GapnyBzWAYxsChJY5VZdzy15cr9KtHFu0jvhzep4p+iBiJ8BWi35QeYBDNzWKhhF0A
         8jUYWz4QUYOkR8Nb7iiNMJF2vjXvq+FH/h2AYz2Z0HIMtip2ld4cdxzqo16qJXaWKEXP
         ywb665TSPMTaNDRra7ApG1K66nDUjdn5O6qqrWLEmjciKl2pwlCGK2dnzH5lr0IhxAhw
         t4u0wLBxA/OSqMD0G8rnDS8eBZkxgeZqGYccsTHdub9YbEMiUcMROCfODnINtfNYaWzm
         pKQZUeR2mppQzW9dZelw6qA8wPsez2+7uuEIj0fdf9kQoiFRAITPcSN1Kknx6KpDmxlU
         CeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9LSFZNbm/MaeD6MXhWHORKk8t5cnVy9vvWN1eklncY=;
        b=NsAV/zaEeOBHxnvnCqP0Z/pyISFUver1BIOCPuLFW3xSW3DBlApu4rT3XV/ZjLy4px
         F+yL1wAyXyk0Syl+Mu0G/IiCi2tO36A+hjXDPfs04wKzmodN/TDWp0E8ZvKmFsBwGqK5
         tdXMNE2oNhNsnNq3roU0kfBvME/MJiDG9goEY2kLxWELnC7PJ/xdhMAmKaCtGVyPyY67
         xysHZo1OD6S+LTyqYD3RAMOU3KFoYOZPODQBPckB0sJVYVMYdYB71rY5YbPSYjrzy4Gy
         K5TYHMt6c7T1hlYUp1S66dGnvvTczMS9ax9xnoSKLgIYAbVCfFqMDpphw7szl7KFEcr4
         frdw==
X-Gm-Message-State: AOAM533kyXrVLVdd4elhIbWhuWw10c12rp/xjBa23Vr1DIOE4ptwyI4t
        +OW1vkWr7NkhyhJ6ocUyfcOTeP5+FwP93QTWmkY=
X-Google-Smtp-Source: ABdhPJySIuUkGxwqNSpMGDUs0nvJGIno65c9UYq/3MMYyTEPeDk0XSOivlDmmBxi3SBkE/K38KUUz8+M4wSeClKis24=
X-Received: by 2002:a62:e404:0:b029:2ee:f086:726f with SMTP id
 r4-20020a62e4040000b02902eef086726fmr2916062pfh.7.1623330163446; Thu, 10 Jun
 2021 06:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210610124556.34507-1-paul@crapouillou.net> <20210610124556.34507-2-paul@crapouillou.net>
 <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
In-Reply-To: <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:02:27 +0300
Message-ID: <CAHp75Vf=S2xUYdxNYO1vnjL29q2NhfzFXB_pfi1OCEmvpBv==w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:58 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > By default, when a channel has an extended name, it will appear in the
> > filename of channel attributes. E.g. if the extended name is "aux", the
> > filename of a "sample_rate" attribute will be something like:
> > in_voltage0_aux_sample_rate
> >
> > Add a mechanism to disable this feature. This will be used to add a
> > "extended_name" channel attribute.
>
> I'm afraid, NAK. Otherwise, please put an explanation that clearly
> shows that it will be no ABI breakage.
> I.o.w. users for the existing drivers and devices will always get
> those attributes at the same platform configuration(s).

Reading two patches doesn't show to me any breakage so far, am I
right? Then amend the commit message, please.

-- 
With Best Regards,
Andy Shevchenko
