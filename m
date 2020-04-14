Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD491A8805
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 19:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503085AbgDNRzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729303AbgDNRy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 13:54:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA93C061A0C;
        Tue, 14 Apr 2020 10:54:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y12so231917pll.2;
        Tue, 14 Apr 2020 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnzfUDYxEvrxL/hRN3b8DZ36m1G+UapytgfgeqmXarc=;
        b=swBZHQ+jeuu12Wr0DzOy4+d7GhoNyfBfqvvcT6dufJgPIVxKZLFx6afFv3bN+nYF1u
         cW8OwvCjLY8uzqBvvxfU7UwQIxZktJnZ6k4SjTe/YR02adq03/7nTLm9qYizxFtTT5Vn
         BFqdyN4/o2+d5f/rdKzmku3S+qRp1+oCN+nwc1xttnYlqJBGYMwD7f5I7QIMKp2k42qa
         N1rLFy76U84nz1m9K3oPvpg3vWYK3Lus7H9iqk+7LYFIZHshp5+7SeNcQ96fTIYPVUhI
         2/NRjlxvwGxGhRnTvQF/41ItaC89soYy5Vbvi4XF1l+k3b3CtnemHemG958vucbjsu7y
         S8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnzfUDYxEvrxL/hRN3b8DZ36m1G+UapytgfgeqmXarc=;
        b=a7BcWTXfO1FPEKpv/4gEJUJIwaqC4AGYimfzLwnUlvdO/hcSzVvopXB7cpe7SUtK5H
         VpMQlK2jIlOiKHzWJid0/laeBR2J1eEb6OUoWYlBdkw65uzNqWC4TMXFETOpAtDaqU15
         wqHHXeliaNjRztEouXpsCYZ+T9Zd/Gu6I87f/MrGV7mhXBk7/WD3LHPZtNof1wYDyeYp
         Z5TKqB/SjVdSzUft/F/98XX+v8csKj5mG2RcIwzRi0niS+ZL0DsBLucZkWasScPzHaUj
         2eQGamBzbFw6waRRlldj9tiY8vM/DTXvkyrsBQdsC2EZFSLRhZsURlIOR3GrUXHsDiU3
         SmcQ==
X-Gm-Message-State: AGi0PuZfU59qudvJXJYSqviQHSE08mB1kVEP/ySQIdOHX8NGcgVzHvp2
        X4AXFy0K78FqXYmDLwqLvSoUyDGwM4JpyMtrQd8=
X-Google-Smtp-Source: APiQypLhumr4MJTllRY/t3SmDpj5VuGCv8QLFhjePjpnX+8t78azioJLwE+BGzZDSVtfTJLeDKmwIpL7GsgVCgMz/FY=
X-Received: by 2002:a17:902:5985:: with SMTP id p5mr1063294pli.262.1586886896754;
 Tue, 14 Apr 2020 10:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200414153415.957-1-mani@kernel.org> <20200414153415.957-3-mani@kernel.org>
 <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com> <20200414170547.GB3334@Mani-XPS-13-9360>
In-Reply-To: <20200414170547.GB3334@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 20:54:49 +0300
Message-ID: <CAHp75Vfk3aw30j8U+BJiobU6s2KsOis_VyUv4+6csbYLFnV9eg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 8:06 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Tue, Apr 14, 2020 at 07:42:24PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:

...

> > > +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > > +                                            GPIOD_OUT_LOW);
> > > +       if (IS_ERR(reset_gpio)) {
> >
> > > +               dev_err(&client->dev, "Failed to acquire reset gpio\n");
> >
> > If it's a deferred probe, it would spam the log.
> >
>
> Hmm. But error is an error isn't it? Would you recommend doing a debug print
> or completely removing the logging?

I would remove completely, but better to wait for Jonathan to comment.
Maybe he prefers something like
  if (err != EPROBE_DEFER)
    dev_err()

> > > +               return PTR_ERR(reset_gpio);
> > > +       }
> >
> > ...
> >
> > > +               static const u8 reset_seq[] = {
> > > +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> > > +               };
> >
> > I would suggest to comment above from where you got this and the
> > meaning of the numbers.
> >
>
> The datasheet doesn't specify the meaning of these values. But will add a
> comment.

Thanks!

> Btw, just noticed that 0xFF is not needed and only 4 values are
> sufficient for SW reset.

Better to do exactly what datasheet suggests (in case it's not clear
or deductible what is going on).

-- 
With Best Regards,
Andy Shevchenko
