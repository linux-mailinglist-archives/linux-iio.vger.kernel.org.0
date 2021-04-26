Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96536AFA8
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhDZIUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhDZIUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 04:20:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F7C061574;
        Mon, 26 Apr 2021 01:19:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t13so2486379pji.4;
        Mon, 26 Apr 2021 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EeZklbjQKGjin+Lakck9x8V8uk/mDUkAw9ZCXokqmo=;
        b=bm/dM4kseRfn+6iwG5A9tvUwXCEwXO6+eRY4+OxWUzHgTKYOgp3S7ovM18uWBvMgSR
         oyebKm/dqBzcP2jACib/KAp1HuTDS9BLJTlyZRYKsd3XwN2O3UiPTnDObNVRGDwiMbQb
         mEiDZhSv2r888BC4QuQC7EUjIjLQeeBbqTTCJIzxmOcugAr+8G3586H7zaxsFVNOZcez
         oal7ehgzrPwRIyDA0c5OTAUGuFGPIuEKfR3IdmnJXx1vSOuHQEdBkzzKOfwe16YZGRrx
         QV0xWdb87L3/GbEsFqOs/4kxGnJNQmuedcTdTEFXbb+Cfvm/VJxEWsGOB+Ixjm9BlgPh
         SkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EeZklbjQKGjin+Lakck9x8V8uk/mDUkAw9ZCXokqmo=;
        b=QS9ye/1yLoeRFxPH+aHvYeSSCh4lmXLwzfMeO8xa7ybTbOWyDBMFO3aPMkjbDz8Vn6
         NQR4vnY18XIiJZHdMg7vi47zy2Ltw0Up8Hv9Uhd5Lf9IRvtE2UMpNVYBP8jKON3JoMRM
         bpfnP4h9A/cZYMaeucxy4L5IRU6+ejC/R9DqzU8WTYxv5hJrZHra3FmkLynqBed3O7iN
         EjDEVJVlG99pcws40gURNB3aPtuY48eKDdrR1I/DXvEYrWIjv49OdQt7uNZBbMGJgkg0
         iA2Nl49wVnWx65VysolKF9D86J2wFA67hVdV7374lfYLRzMKngKAKjXPX6LPPEZwsJAv
         UivQ==
X-Gm-Message-State: AOAM532JMfPmLQWxgkWqGY+IkY3L5C0RogdHKOm0XZ0nPeoEuEzUJ60O
        uef9DBVBu+OnopZkX8d9HR/knSUcZKlJEEqhQdEWJ/6x928=
X-Google-Smtp-Source: ABdhPJxmK/tVrLooqvcyGoMmOvUrg3Qb6phTUdsbI0VamiEL8fmmKK2VfuuwEMdKKZBcpne8jglU0dvQy8nfdxZisxw=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr22274380pjr.181.1619425196333;
 Mon, 26 Apr 2021 01:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
 <20210425135546.57343-2-tomasz.duszynski@octakon.com> <20210425164613.7eda8f6c@jic23-huawei>
In-Reply-To: <20210425164613.7eda8f6c@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Apr 2021 11:19:40 +0300
Message-ID: <CAHp75Vec_BPsgFQGP-8EUkLR6jaZU+4ur0EZBsc0-o1GgsT=CQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: sps30: separate core and interface specific code
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 25, 2021 at 6:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 25 Apr 2021 15:55:44 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Move code responsible for handling i2c communication to a separate file.
> > Rationale for this change is preparation for adding support for serial
> > communication.

Lars and Jonathan made very good reviews, nothing to add from my side,
thanks, guys!

-- 
With Best Regards,
Andy Shevchenko
