Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261A71B880D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDYRPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 13:15:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8353C09B04D;
        Sat, 25 Apr 2020 10:15:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so5245458pjb.3;
        Sat, 25 Apr 2020 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ptuc5FZNVWukCEs5Hrts5YeBt29P4c401lvcj9WBH0w=;
        b=ZmeMVFa4E0Z/XLac6ZRPXg7zKQwBJ4tf9pvfJE/l7ECgkj+ukXx71XiqtfdESqETEs
         0NEk1/51KRLglqDV9yCiNlamx6x4ZPKayBJIL3nhoawzichsfb3ty45ugf8fVo/F6liu
         ab3TDvXAUdENyvASiA3aRn1u1yldv81t6h0c04DnZcuaAiCgCzcu7+zqW+k+WTLf68SW
         4Os6wV1Zv9RNq6SZLbFbwvAUyBayjE12Zz7iXOR8Ij/Vzg9Wsu4ieyyKtfAHksclZGeC
         0iUXcRY0lISWorR6gWOcF0dLbTib576CB4NhSRQa4rTS76fpq4Id61zFxLXNxYKBqt96
         YZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ptuc5FZNVWukCEs5Hrts5YeBt29P4c401lvcj9WBH0w=;
        b=OuXG8tyaxmKt1xhf55UDOXB9eo599ju4wk5D1fCm+A2BBMbXteW24n5PWLbBN9UvhZ
         kYQNfmbjSi5/tTcNjdJTUKIW3+msvau5wMiVGAOLiFiJn0wvxGvt5/yqXk1awq4RXKqz
         WzJR/vFuW3xbx0kTvG/597oHdp5BzzDJD6sKLTm7/Dxxi1P9IUuVAaV0rBCd259eQCLr
         47M6meMFMmFuW3VcCj2UUDE6K/MpBtwpf60S+BR314A9TdVLuLXuZAE9gWi4lYdzSwU0
         4eL1zlPZtFn+uuHu9WpXxVdDmOOYU53/uA8Fgj++LSRw8SNpuzhlKXdXI12X1N96V1tJ
         U2Lg==
X-Gm-Message-State: AGi0PuYMpt8MZBl9veWV6haIGJbuC5ujYO+TSkwJIvS/iJ0FQQ/ZiPwI
        +rBIsWMsbqO+nycjRo9iJ/qXzdtmhrPpWOoYPWM=
X-Google-Smtp-Source: APiQypLg1NAeHqe6aOeXb1RmvYHOFQRbDU3OEOKtVbNq0IrKCBfmPCg9q8o7xde559oPE0qV/GPHudfAu1bFgPfwjQY=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr15526982plb.18.1587834903128;
 Sat, 25 Apr 2020 10:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200421075532.19192-1-m.othacehe@gmail.com> <20200421075532.19192-4-m.othacehe@gmail.com>
 <CAHp75VcJ300S8r_f2cueYzB0OaLBJK9oJySgz5Jekb7dGFWnCw@mail.gmail.com> <20200425165223.0fc0e930@archlinux>
In-Reply-To: <20200425165223.0fc0e930@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Apr 2020 20:14:51 +0300
Message-ID: <CAHp75VebfouNqOJjiKY0zAdxG5d+_JmpO5aVYR_EqcjsmBeXyg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 6:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 21 Apr 2020 15:22:11 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Apr 21, 2020 at 10:56 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:

...

> > > +static const int vcnl4010_prox_sampling_frequency[][2] = {
> > > +       {1, 950000},
> > > +       {3, 906250},
> > > +       {7, 812500},
> > > +       {16, 625000},
> > > +       {31, 250000},
> > > +       {62, 500000},
> > > +       {125, 0},
> >
> > > +       {250, 0}
> >
> > Leave comma here, potentially helpful if it will be extended.
>
> Hi Andy,
>
> Doesn't particularly matter either way, but given this is a list of the values
> supported by the device, very unlikely it will be extended.
>
> Games like trying to share the first part of a longer array between
> multiple device types might occur, but those are usually really ugly.

Good point. Though I would limit amount of entries by explicitly
writing down the array size.

> > > +};

-- 
With Best Regards,
Andy Shevchenko
