Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E964835B678
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhDKSH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKSH7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Apr 2021 14:07:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD8C061574;
        Sun, 11 Apr 2021 11:07:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a85so7245907pfa.0;
        Sun, 11 Apr 2021 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEcbYX8Y08bH641l8oqV2fm1Zee8I5Yt330pQIjrzVk=;
        b=pgYrJQULHlSnRawowMrMHD1vjVKyGInW9gfvEHYsWwQM8Mr4xTjOMBigglW3/iQ9dG
         DW2f/ffyxMzB+/hksKSaYgkuN/gN9gRnF8yKuaVZtLHp+VV9niC4FdBet0Vk+bRTJNOP
         qY6pggvzlbs8aCOxit3o+h5BADahAuwZJpw8OeZuZormFZ0e7KQ3QkH6Tt6vc3DbXDHi
         axOM1mibDy/zuunSfLv+OdnXVzEH8X4d3/u6cL8AfgEllSe75XShqY9IH7g1VG3HoNjW
         tcGftpvdXrbtmCa9sN3gFLKhimxnPWnsiZLzZIo2L55QphYULMR9/KjXuZDfd/jZuKbV
         WRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEcbYX8Y08bH641l8oqV2fm1Zee8I5Yt330pQIjrzVk=;
        b=laQamOeMZnyOV3+Q3NMqJmtf3uIaUA/UJUs279mYZC+2PbjHS4FF1LLQFXtXPXEViD
         i6dRwPZAwoH9KdN3k+NaDtywqJTd5FobgW3X3lxG6/0HKG7CzXERTGBPoqs4fvnlJBeY
         4QddSX19mK98/7oLFizsEcU1kTzzsGM1JlB1+rIR0SSF/3mHBZD6MoGvR2ZrBa9FCokY
         4vjX6SRrxIfu/1ENsYewrUVXXCUFm0dbn3Jqu5YbbrwDIbS5Uf4wKlb97GN07Q+rniT7
         7KJDPcYWzHzgbwrEY2JfBIgdSm0tbDMsLe4qu8G1v7XoxrMKWLnGUnycdQSTObaXXJpL
         B2+w==
X-Gm-Message-State: AOAM531J0Voncr50xp84fAFbwq8lyNrmEoHHjj7pfDNtnZ1PxyzIMz9N
        qOO0NV0YkGvI6FNbcG8l4BrDHGYjWpM5txrukUY=
X-Google-Smtp-Source: ABdhPJwkzlrouaFhCAJ7iLqKaaTDjIhbP3qlzq8AMegpU8mUaAcB9EY6MM44FCYn9Z2x5IstFiib/ie6d6/vfWTp7FU=
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr22714087pga.203.1618164459392;
 Sun, 11 Apr 2021 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210407182147.77221-1-puranjay12@gmail.com> <20210407182147.77221-3-puranjay12@gmail.com>
 <20210411155420.318e866e@jic23-huawei>
In-Reply-To: <20210411155420.318e866e@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 11 Apr 2021 21:07:22 +0300
Message-ID: <CAHp75VcQYLRJ-p4CWJyk3h0=nL=TqwEFAxkO+z1Nbg8=3Fchyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: temperature: add driver support for ti tmp117
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 11, 2021 at 5:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  7 Apr 2021 23:51:47 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > TMP117 is a Digital temperature sensor with integrated Non-Volatile memory.
> > Add support for tmp117 driver in iio subsystem.

...

> > +             off = clamp(val, S16_MIN, S16_MAX);
>
> With a C=1 W=1 build (sparse an lots of warnings) this causes problems because
> the S16_MIN and S16_MAX are as you might imagine s16 values whereas val is
> an int.  I've added casts to force S16_MIN and S16_MAX to ints as well.

Good point, but better is to use clamp_t(s16, ...) rather than explicit casting.
I always consider explicit casting in C (and esp. in Linux kernel) is
a red flag. Should be really rarely needed.

> > +             if (off == data->calibbias)
> > +                     return 0;

-- 
With Best Regards,
Andy Shevchenko
