Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687942B5DFE
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgKQLIf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 06:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLIf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 06:08:35 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103BC0613CF;
        Tue, 17 Nov 2020 03:08:34 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so10060577plk.3;
        Tue, 17 Nov 2020 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwT11DXQwSCtx7U2eB/ExlhlW4IxfqaVPsUn4voZxRQ=;
        b=LS2ZmMQwgssAtfBRB55d/qTPCkX1nmjRI9GL3uiuXmRYL+TW9upIuZwD3/zIsBgRJb
         8oGZZKobwM8UtIQwyZepk8L3AlBNWNpbiW69f2LbhyMYMNVmdLjKFF7sjWWZKpyqPtml
         dy4B50twysl0MVBoROJXQSlGMH7gW6NZpvqkpbOJ7y/yK4BhPyXwG1qdo1eOwLCJA8XW
         R2xPoZ0Hvb887kmqPUeB0XvmkMCWbOFKBtusixLZgHHVLVo/ktTVci3uLxEDgU2HA9kz
         W0/HCjiO4md07I5qtH4/rtRSzrYp3tDbmzRMt3nxSoqoOtKdufwBi+Tp7JSLUE7F4SEM
         TbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwT11DXQwSCtx7U2eB/ExlhlW4IxfqaVPsUn4voZxRQ=;
        b=dz99GfyNmVNR8bFjksuEME7rlaH67n2L675bo/JKV6B/vb3WI5NtHs0+nXLNqhm+zs
         hhQagWyAnH0oM/a7qr64eT7EiHKToh8u3t0DZemdy9FiFBG4wAdQdbVc/4762WOwo4Eh
         p++urvOY7zzFl/YdHOhjf8F49IzN1aE7lOQzUpK5yNTdGKrsHfpOQ5h2g2ljY5r52tRT
         3AbdBI8f2AAYj4R3KBXOLaX9Ke+UwuCU2rUlqUePULF6Om1mo/rUJbNLAk7vJ2gyjRg4
         TFBf4sosK2z6SsjfcFNcGeYKVB5lZ0j7enMbI44yMrLiRYVj4qolfQ4OzOnUM+So6GIj
         Ow/w==
X-Gm-Message-State: AOAM533iSRNoESZvbE3akxIMmteWU6oq5ii0+/ZQyUuM/Oco3vVvQNp8
        lDDrkDdYw6D2hN9lQyzH8OcfqnDf/S8JPtEWDAU=
X-Google-Smtp-Source: ABdhPJzbk+P2lNbfZC5aFBEC7lyxF1Vrb13IESw37uOHQUuKaT9qFUbz6yXtgEd7j6cb9uAZHbSVqX4K8Wot5UOapLA=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr2241273pjv.129.1605611314600;
 Tue, 17 Nov 2020 03:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20201117075254.4861-1-alexandru.ardelean@analog.com> <20201117104126.00000516@Huawei.com>
In-Reply-To: <20201117104126.00000516@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 13:08:18 +0200
Message-ID: <CAHp75VfKDSsiWqK0Bkkbe1ChntsRAFP5C_2qEzw+YE_qPjhJcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: ad7887: convert dual-channel mode to DT/ACPI
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 17, 2020 at 12:42 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Nov 2020 09:52:52 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change converts the configuration of the dual-channel mode from the
> > old platform-data, to the device_property_present() function, which
> > supports both device-tree and ACPI configuration setups.
> >
> > With this change the old platform_data include of the driver can be
> > removed.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Hi Alex,
>
> I'm a bit in too minds about device_property_present()
> vs device_property_read_bool() which are the same thing under the hood.
>
> Not sure which one conveys the correct semantics here.
> I don't feel strongly enough about it though to do more than raise
> eyebrows (i.e. not blocking this series).

The idea as I understand it is that the 'present' can be run against
any type of property, while 'bool' is specifically for boolean (the
similarities is a detail of implementation).

-- 
With Best Regards,
Andy Shevchenko
