Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225CE3F5E27
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhHXMoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhHXMoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 08:44:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B37C061764
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:43:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so1748547pjq.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZCMnQ3bawYb+rLFPf3iFWsuaLtoC25QDrHiI2n2pJI=;
        b=fcEsQOAaELMwpWnw+f40oAKSbuGgYwcFIXdpASjywHzSrLYqwulFPGYh6GoMWzuwdp
         L+PUKxJxdUYB85nlmvuKSwfXEEFLOTdriPFLiRJZeGXXyoHZOhsM/W0lxgSxvAJwLAz6
         6BF64MOdXf3cRDPnq6ZwbhzRJ1h5Coq8GEx1HHMqNe9hgPW3jRca4bPvH0jqUpDAqA66
         mmrpORB2Qd8gwWVeKOpcnhjAf7E76RHYdlWnl0In1hFu4Ty0gU9JKVzQ5hJsRSNAXVF/
         xDw8Rs3FyPFxanQs5D2UFgDrtHG+ENuiaEDxx2RWAxvA7FkuvbsPE1yvikZIhZARcwx1
         Rx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZCMnQ3bawYb+rLFPf3iFWsuaLtoC25QDrHiI2n2pJI=;
        b=tCf3ZqhPJMQGdy9eJbvmJODfooaiYat7qUIMI7Fx5ukveoTEhI9CrKNjqFc9LD83WA
         97r659Tmv5jR3vX9hkJ+BzCPutIW580HphVLgxMrW/EonqbOfJDk7SxrX0l5+BrqU2FD
         QO+0sZ9rKpYWANre5MF1N04vbvxfSeuYEmr8K6l4oIKAlvXRrBHm4JarMHEcSOd6jmPg
         M4tIGd7pRRqXDh4c8nRvll5YeqjjPUbh5aM4skegnXO9Ip55y3jIB7AZWtA+3YqaGPqs
         WlIpiAa0W28O01Ae5YEPPFIsXNmZalKWz1LgkNA7tSRB1p265u01K8/Bsau0JsE1+EWk
         nF1Q==
X-Gm-Message-State: AOAM533zeiy0a9+MF8tEkf2PIhTN/jQ7sVNrWLQSLhAKAxoDfbu+APu7
        4sQsfgXijSIecgePP4l9WKdA4qohGgX0o2NRBgM=
X-Google-Smtp-Source: ABdhPJzBAzW0Aj/Qi5YQ7thH1UwtDjjJKezRsSdAtOtYluJ+TiGAAHyXVOFdJWpzLV5ut+JuMdXdTWhYlt5L2j2DgcM=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr33144223pls.17.1629809017438; Tue, 24
 Aug 2021 05:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210824113709.1834195-1-sean@geanix.com> <CAHp75VeMzs+xyksGB8Kcnr-09a740eoWYmEJQHgbhMNVbuzAwA@mail.gmail.com>
 <20210824123245.z5o452x5s5m2wcyx@skn-laptop>
In-Reply-To: <20210824123245.z5o452x5s5m2wcyx@skn-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Aug 2021 15:42:58 +0300
Message-ID: <CAHp75VcfcAyjSuX=xrVcWdLbDVpoOT2_NKsMmKmRwagL1EZ=Og@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: add threshold event handling
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 3:32 PM Sean Nyekjaer <sean@geanix.com> wrote:
> On Tue, Aug 24, 2021 at 03:15:28PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 24, 2021 at 2:38 PM Sean Nyekjaer <sean@geanix.com> wrote:

...

> > > +       /*
> > > +        * Add the same value to the lower-threshold register with a reversed sign
> > > +        * in 2-complement 12 bit format.
> > > +        */
> > > +       data->lower_thres = (~val & GENMASK(11, 0)) + 1;
> >
> > This looks suspicious.
> >
> > 0 => 0xfff + 1 => 0x1000. Is it what is wanted?
> > I thought that -val & mask is what you need.
> >
> > Can you explain more in the comment (maybe with examples) on what is
> > coming and what is expected?
>
> It's a bit messy I know :)
>
> Some examples:
> val = 0 => upper = 0x0, lower = 0x0
> val = 500 => upper = 0x1F4, lower = 0xe0c
> val = 1000 => upper = 0x3e8, lower = 0xc18
>
> Guess it could work if we special case val = 0...
>
> It doesn't even makes sense to write 0 to this register as noise would
> trigger events.
>
> > > +       data->upper_thres = val & GENMASK(10, 0);

So, I just tested all three and with '-' (minus) it works, while your
code is buggy :-)

-- 
With Best Regards,
Andy Shevchenko
