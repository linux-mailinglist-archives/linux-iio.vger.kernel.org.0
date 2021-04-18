Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A045363591
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhDRNhE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 09:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRNhE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 09:37:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B5C06174A;
        Sun, 18 Apr 2021 06:36:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14so11585370pjl.5;
        Sun, 18 Apr 2021 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rm5BF8bBOQZOTGk8h4EfJO96XDjZQp1ZxwOmylL+k48=;
        b=MCOgDWx3yOE6mwCmqmF6YgKJZzjT/uxlos229fHCpBvFcmi6MeVG25uzVjRZjIJEKv
         rX8VvgJBIf1Zg6woH4IXvIIPWO/RdYkehlZ1VSKv18UvuUjRxwUh24QSyDkAhNxtzLhu
         70dyuEYXn1LdJtaChrqzVRuOhRUREvLIQmRTiEzsOc2RBMmUYR1O/kinDbSEzRAgb6rV
         oFJbf6wHQeyVxf+Ddswlr+Jpk6QIVDMWMuZQQGsU7c5ND24uroh5cpTZ7idpYfJ4uBEj
         Nzj4bQoa1XUEOdvHARNGcNlhY/VgqlrQ2Qc2cqSDjXAvWWMy+g/ofzczvjNopflKq1+U
         dzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm5BF8bBOQZOTGk8h4EfJO96XDjZQp1ZxwOmylL+k48=;
        b=pLgF/bEBFjiuWkhkZypxJ/3T2NZuXmEcGQ4IjfjamHLTQ9IiL3V1LoAo2QPxdg9suK
         4PC+ASZ/+CaXryguxeuJpz78EQK85i/MTPWKKCeEGe7xFPunl8jTu+KKn37reSOKTrWR
         tnvNBR8JgOft7au5MZQwd3kuuv3q4qPOT6y/MWqyBy98n3Zl27NI+fHjYD6RTqL7Wxkt
         LFAYeuwcyjtNOjLvDOPQyP1+GDvfdl8WzUHJfMDWZCEJR/9/zWqqOXGF7ZjHs8Jc2B+s
         kxiVyk63LjE9EUNstF1m7+Zh6jBW4Oigq7DLIBRsIWsn1aCqpnStN/H0wsIM7xDDv8o6
         v57A==
X-Gm-Message-State: AOAM531V1HsWBmiiYDICI1/78aktkAcrFzRs1rYNyhKB2/hrEK+MZtea
        2Shd4L34gg8TM7B7H1xY6yXfyJTcX1px21eR77c=
X-Google-Smtp-Source: ABdhPJwnMrF/CXTz27JA1rFg2LNAnqHSxEnBBmf0zyxmTAbf2YnRzTXlpPJXUCWkYw2p9qBR78qfUoDiaZO1wt/QBwg=
X-Received: by 2002:a17:902:e803:b029:e9:1f79:2427 with SMTP id
 u3-20020a170902e803b02900e91f792427mr18622276plg.21.1618752993338; Sun, 18
 Apr 2021 06:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
 <20210414195454.84183-4-andriy.shevchenko@linux.intel.com> <20210418115403.059f94cd@jic23-huawei>
In-Reply-To: <20210418115403.059f94cd@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Apr 2021 16:36:17 +0300
Message-ID: <CAHp75Vf=r-rhuzx-DXHcY1xB=t4HP3wNdYAWH1buvqBvTteJ0Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] iio: st_sensors: Call st_sensors_power_enable()
 from bus drivers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 1:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 14 Apr 2021 22:54:51 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > In case we would initialize two IIO devices from one physical device,
> > we shouldn't have a clash on regulators. That's why move
> > st_sensors_power_enable() call from core to bus drivers.
>
> Why is this a problem?

You can't have two regulators of the same name on the same device.
IIRC the regulator framework produces a good splat for this.

>  The two instances would double up and both get +
> enable + disable the regulators.  However, that shouldn't matter as
> they are reference counted anyway.
>
> Perhaps an example?  Even in patch 6 I can only see that it is wasteful
> to do it twice, rather than wrong as such.

Believe me, I would like to avoid that, but it seems a limitation of
the regulator framework. It simply produces a splat. I'll try to
reproduce it again (because this series started like a couple of years
ago, just eventually I found a time to clean up and submit) and will
tell you how it is going.


-- 
With Best Regards,
Andy Shevchenko
