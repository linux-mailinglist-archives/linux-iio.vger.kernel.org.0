Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72C325570C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH1JAq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 05:00:46 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:32897 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgH1JAo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 05:00:44 -0400
Received: by mail-ej1-f66.google.com with SMTP id a21so564477ejp.0;
        Fri, 28 Aug 2020 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BoGGK/CeRvP+1P6A40PXG1dSM618NDQKChv/ftgEPFk=;
        b=guLKbhtJnPk/1XY7+iSihpzZk1QEXhbCIuYJKb5HBo8Bld7AmD3ro1At34nYUoe4Nx
         JIxhRRj5JSiIVddA3vsiCs5rjoZRiG1XM5+KDicA6hnxpwmGyidxgQGqgJtM/Jn1iIgc
         le8h29ShTtmUJ60YFc50kEiwQhUKNeip12Z1CEzbhuLXctwL1+qLyUWTiKIDAt+5MllO
         1g1WBqYAm6MyMJEFCY8zS0Ta0M7eT0wB1yOcFxh9u9UuH6lkJNlPuZbFWsmDJmFC2y5W
         UHrx56e1WG16J+5MTxDwxc6V0MLcneZJnjLEKEYgk7zi4+0UXcI1tNwOWA3ZYaLANhMw
         f0gw==
X-Gm-Message-State: AOAM532UyOS7WSo5Nkr1EDwxNkE6HAismFQ07nNIp2wvy66cK8PT0ecv
        ySaF65iBH/xsp42nEuAtDgZ/JYQSApNeTbx2
X-Google-Smtp-Source: ABdhPJyJXWNff4qgN77yujQ0S8TX7b6tdnQWjdtoPIPC5tlF6n/b5lr2j8ZBFOvEx9vm66q7OEHoFQ==
X-Received: by 2002:a17:906:2a0d:: with SMTP id j13mr795771eje.474.1598605241866;
        Fri, 28 Aug 2020 02:00:41 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id d23sm312329ejj.74.2020.08.28.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:00:40 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:00:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: Move Hartmut Knaack to Credits
Message-ID: <20200828090038.GA17717@pi3>
References: <20200827202452.27714-1-krzk@kernel.org>
 <CAHp75VdE-Nxr7yDPPyRjG2vJZs-nkZowi+daUJTKK348Su_Pow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdE-Nxr7yDPPyRjG2vJZs-nkZowi+daUJTKK348Su_Pow@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 28, 2020 at 11:20:58AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 27, 2020 at 11:25 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hartmut Knaack was an active reviewer and contributor to the IIO
> > subsystem and drivers.  However last message on LKML from him was sent
> > in October 2015.
> 
> But this is not a problem we solve here. His address is invalid for a
> long time...

I did not receive any bounces so I cannot confirm it. However I can
quote you if you are sure that email is not valid.

> 
> > In thanks for Hartmut's effort, move him name to the Credits.
> >
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio <linux-iio@vger.kernel.org>
> 
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> 
> ...and this?!

Since email is not bouncing, he might still receive it.

> 
> Reported-by: ?

Reported-by is for problems/bugs, so here Suggested feels better.

Best regards,
Krzysztof

> 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  CREDITS     | 4 ++++
> >  MAINTAINERS | 1 -
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/CREDITS b/CREDITS
> > index 32ee70a7562e..edb81e3159b1 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -1953,6 +1953,10 @@ S: Am Bergfried 10
> >  S: 63225 Langen
> >  S: Germany
> >
> > +N: Hartmut Knaack
> > +E: knaack.h@gmx.de
> > +D: IIO subsystem and drivers
> > +
> >  N: Alain L. Knaff
> >  E: Alain.Knaff@lll.lu
> >  D: floppy driver
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 523ac1602b62..1276833532c4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8532,7 +8532,6 @@ F:        drivers/iio/multiplexer/iio-mux.c
> >
> >  IIO SUBSYSTEM AND DRIVERS
> >  M:     Jonathan Cameron <jic23@kernel.org>
> > -R:     Hartmut Knaack <knaack.h@gmx.de>
> >  R:     Lars-Peter Clausen <lars@metafoo.de>
> >  R:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> >  L:     linux-iio@vger.kernel.org
> > --
> > 2.17.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
