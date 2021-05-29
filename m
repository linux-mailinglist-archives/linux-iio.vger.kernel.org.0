Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC3394B03
	for <lists+linux-iio@lfdr.de>; Sat, 29 May 2021 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhE2Hyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2Hyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 03:54:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC9C061574;
        Sat, 29 May 2021 00:53:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k5so3826115pjj.1;
        Sat, 29 May 2021 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9VngEDZWf8zqYQ8lObuf/Fz5NYel1p8aArrZZ5hl1co=;
        b=kKyfrbsCjXmMvkkTj1y8OxbSUz/jJL8eJXDeK/KTwHIAfKsOGmEAIQsEMbP9ccMgEy
         Huz9GtJPwsCcRS61+n0uLjV1hJOZ/Lf10zvPIDdhVHHd6GI3rrCPAXpeXo9g/mYt808Z
         j7vmq3NV5t9vKmXf20ooTndRt74qvE6wSrhw8U1Rt7CLf2C7dLSGwHAiHYIDS/8z1Tet
         g1OqRjsEorHWrByvt7kcOCBhS2BwfIB7qrsyAuRStOuJmbp9JvCKVsclCJkR2MgR4yHX
         2AMFqghfq/xOaVd897tGnVcaL3wFnSoPlj8cthaBAOHIfGR/9rzR0WEBoma+frhQSFas
         RTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9VngEDZWf8zqYQ8lObuf/Fz5NYel1p8aArrZZ5hl1co=;
        b=JxZDE6nzxLO8fGoYd3vDStT6s3S4pC85/zJJ9t4utG6SX1IASF6wU3CcabFKEBFy7r
         foZZuQMXKq+4fMWgOocRnoEMN/JfaIs+kghYEV0hb2KYgCcLw6XVwM40Ol8Ni3taE72I
         cBeMFP7I7NVdKt3rRw7cCDlh4EEEAISEFy5kREeAzFtCdKJEwGFck6qmz6xw178sLFGO
         OvJChQeab4/aFgbNVTGamx9KSI840JuJoYN1nwJzg8einF7JvU+EVniRnm1HVLHG57z8
         cCmVT+6P+IkxdE4wDnlQdazmEGg3SwwI21m5+irr3pPDMDhusi8zTDProUUwxS7CzD6A
         ohXw==
X-Gm-Message-State: AOAM5330XfndrqO1mJAYC+gxhJMa/lQTILKQXB/KDNPKTXz0Js+e4TeF
        ZySz4XupwUPwzOVlP+ViZu5TcGzlFJPMaS/LY1E=
X-Google-Smtp-Source: ABdhPJzXmdeDYG4OtxsFfC0Ztq98QovLwN8iUDmk4Te06JdlaLlMCmxkuN+eKpG6c6P9e093nkkIjO7SMwFv+ztTUbg=
X-Received: by 2002:a17:902:8c82:b029:fc:e4ed:4958 with SMTP id
 t2-20020a1709028c82b02900fce4ed4958mr11595619plo.0.1622274780671; Sat, 29 May
 2021 00:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210514135927.2926482-1-arnd@kernel.org> <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
 <20210516103628.2cf899a0@jic23-huawei> <644a711e4d2639a23bfc50dffa180ad184a4acb1.camel@perches.com>
 <CAHp75Vc72vMbj311P3xnxh6ExxzD1=enoETj6wY8dHn+xBJ4+w@mail.gmail.com>
 <fc3afc8e74ee9eda0b4eaff9a4d9ad32f1c461c4.camel@perches.com>
 <CAHp75VeQdFoJrPhXU2fYdrhLUwvM4NEoPn=Z4WBPkhOa4xK+ig@mail.gmail.com> <cfdbe504c7ed3964bef22c551f0c78c048ce3d2d.camel@perches.com>
In-Reply-To: <cfdbe504c7ed3964bef22c551f0c78c048ce3d2d.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 May 2021 10:52:44 +0300
Message-ID: <CAHp75Vf2ZO-5XEQtzdN2ABLLC3KLDmQxGps2uD1z06Rs7L2z=w@mail.gmail.com>
Subject: Re: [PATCH] iio: si1133: fix format string warnings
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?Q?Maxime_Roussin=2DB=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 29, 2021 at 12:35 AM Joe Perches <joe@perches.com> wrote:
> On Sat, 2021-05-29 at 00:16 +0300, Andy Shevchenko wrote:
> > On Saturday, May 29, 2021, Joe Perches <joe@perches.com> wrote:

...

> > > > > Likely these should be 0x%02x
> > > >
> > > > What=E2=80=99s the difference (except printing 0)?
> > >
> > > (assuming the argument is unsigned char/u8)
> > >
> > > %#02x will always emit more than the specified length (3 or 4 chars)
> > > values < 16 are 0x<hexdigit>, values >=3D 16 are 0x<hexdigit><hexdigi=
t>
> >
> > 0 will be 0, btw.
>
> Hey Andy.  Right.
>
> > > 0x%02x will always emit 4 chars
> >
> > *Minimum* or at least 4 characters. There is an upper limit of sizeof(i=
nt)
> > * 2 + 2.
>
> I did write assuming the argument is unsigned char/u8.
> For the general unsigned int arg case, you are of course correct.

Signed char also.  Basically for all signed types and unsigned int cases.

--=20
With Best Regards,
Andy Shevchenko
