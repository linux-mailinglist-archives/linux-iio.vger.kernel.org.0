Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20812557A8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1Jag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1Jaf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 05:30:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C441C061264;
        Fri, 28 Aug 2020 02:30:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so211775plr.5;
        Fri, 28 Aug 2020 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6auKxjABp8YXUIlDJF9wtAGoOtymbxc4WRIaQCnHnVM=;
        b=naRW4w7le/y5do4SyfWsvc3IZ5gXnazcX9lYqMnQYkXxoH0qkqZM+3s99LoxOA14Ba
         t+eFc1J4jBI9BtHtSGRx10SI3UEXsE+6LpctMy3wsYEbEKDvvkdmZEL/pCK2zqKW5E2s
         9mwgjcw2maacFVMBTUG3GZJUqFZEN2UfT0mxdiAXauVEKLDfGCol3ApCPvB6VjAcwuqE
         dXHPWQy3MqvJpYXhaDcMDlz4ZkADvo4MKkPru9Ab+kGwsKv1DpLc9WmtC0jBQeUNdxet
         cAAvnyViT6uZTt9D8YZLIkpt1ZtpyBM3/Lqlk/z60W7SD5soIsUtfR67i97EJuhdCJtH
         foSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6auKxjABp8YXUIlDJF9wtAGoOtymbxc4WRIaQCnHnVM=;
        b=YQxMDhupt6hRqv1nyN3Ym5032xxo/TXIWmhxhRRlRygqi8WsrecF0HYK5RqSBxotEW
         024tQkGCVXmBOe5jBW5Ug1DU50giKIq8jb/trL0kWiIu/f/CUruFBak1ro64wMGcAEQ/
         3wKzvYlHDMyI59uSz62/k2vMVCVvVvR/0gotS3xaHzkFba/ZGjyAVxr7OqcR/2dyTSWQ
         Gl0WnZ1RGH9YIpVqbTvv3DDtQB+0taWtXn0sF5XzKw8F+dnp7c4nfEQDwCpTwD/7oVLl
         tp5vRLb9rghnlimhH5bk8+fz/+9zTMzsXLbeyyMee9CW4i0qID7tAO2LtFVYBh1NqLcs
         K5Tg==
X-Gm-Message-State: AOAM533Cd1qqkkAZcUHNocRP1/AHoQKN59XTnz2p3XzL0UhQtFDsvG9x
        mSSX9+QgXKLEXiXKKoQBXnmKgs99VekIFMav7IM=
X-Google-Smtp-Source: ABdhPJzk3I3Y5B5oN+gAHy9JGTl43ke6auVS++wh6yF16T11jn259sPUb2TXq+hzFsHBPx2u+g3H2qlV7QXqw1wsd08=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr490987pjz.228.1598607034956;
 Fri, 28 Aug 2020 02:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200827202452.27714-1-krzk@kernel.org> <CAHp75VdE-Nxr7yDPPyRjG2vJZs-nkZowi+daUJTKK348Su_Pow@mail.gmail.com>
 <20200828090038.GA17717@pi3>
In-Reply-To: <20200828090038.GA17717@pi3>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 12:30:18 +0300
Message-ID: <CAHp75Vcz7ByVFSTeXLn7AvNcOgr=bw26mrmi=DsCfC9khro_kQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Hartmut Knaack to Credits
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 28, 2020 at 12:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Aug 28, 2020 at 11:20:58AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2020 at 11:25 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hartmut Knaack was an active reviewer and contributor to the IIO
> > > subsystem and drivers.  However last message on LKML from him was sent
> > > in October 2015.
> >
> > But this is not a problem we solve here. His address is invalid for a
> > long time...
>
> I did not receive any bounces so I cannot confirm it. However I can
> quote you if you are sure that email is not valid.
>
> >
> > > In thanks for Hartmut's effort, move him name to the Credits.
> > >
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>
> >
> > > Cc: Hartmut Knaack <knaack.h@gmx.de>
> >
> > ...and this?!
>
> Since email is not bouncing, he might still receive it.

Hmm... I'm a bit puzzled now. It seems gmx.net has some policies in
places that make my replies to your emails (patches) bounced, but this
one is okay. Strange...

> > Reported-by: ?
>
> Reported-by is for problems/bugs, so here Suggested feels better.

Okay, works for me.

-- 
With Best Regards,
Andy Shevchenko
