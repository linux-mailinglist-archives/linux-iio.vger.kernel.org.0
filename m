Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F23E849F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHJUvq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhHJUvq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 16:51:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17EBC0613C1;
        Tue, 10 Aug 2021 13:51:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t68so24012958qkf.8;
        Tue, 10 Aug 2021 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=5mYXNmeFQWZZstD53CM/l7n7XLqNKoMiU1KuQzcBS4w=;
        b=TxtFHFqFPe8sq61wlfFVSXCqbFLVqoWzpUc0VUi8orYW/A6PWl30RK1LrImf60fnyi
         x9E5uDKTgMXzxBM5zba0+ZzzFU4h4ClqSOp9ZjVc8dx2/N2kU5XIUM7ivQkH1U4NSor5
         yOAtIddDiJhva8ad0vQDRfbFEHZYmdqtv8i8H+9KaqjDWTUbAq7a6+LC4GeO7zVlWsTa
         9nGyUR96kyfzIb+OVbJNBOaRysgSPtzNzPqfaH35eYfJgxDFpAZvY6JTAVICXLmKY8IG
         0dSDhI6ycQfikcaW4e0wGAgk627ohpct5KejUDooWUIdAFYRmQi4t11Vm7ZYxVxKQbnK
         FTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=5mYXNmeFQWZZstD53CM/l7n7XLqNKoMiU1KuQzcBS4w=;
        b=pWNSExCPqvCTPp0tczs13sG/S4u3TDyN0t09WDiLHQhnsboNkAsq4JhnynNcsYZX2V
         GtAxO3+M58DpQay6UOqi9qoWDJ8JDhoMy/3ViuYzGuYdLJlbqXg+X6Mz+lahtmKA1Gi9
         P12ODyMLKj6ihaQ2aV1HRHc9x+2bEoq6OLyGbA+Q5ParqTJbUSxbWDXkmd5dm10qfR0O
         4B3iYVDGpKFGZEvnP4S82qdCaY3pRI9mpB9tqLdEcbjzR0Aixd0jx5+5Np2PzESTnEQs
         dsD225UrItfua+s0AZBBusXNsOUiZ8s8ejrPMGATXSMAqhOM+qwFw4e36YqT0XdYIFfq
         FwVg==
X-Gm-Message-State: AOAM533gzoHVh2Wkn9o8u0AQwez+9ROwe6FOnIzUfwNI9+grqZaFHYh1
        9CJ/4qxV8Pkkg3F62KcXCCc=
X-Google-Smtp-Source: ABdhPJzLb7WxcsucQE1flCY1q3+sLtkuyf5b4pcnIup/qZ27viKkr7U5PpFgwmuXm4BQdnQj+vvgFA==
X-Received: by 2002:a05:620a:1790:: with SMTP id ay16mr31029115qkb.67.1628628683067;
        Tue, 10 Aug 2021 13:51:23 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l145sm1493002qke.92.2021.08.10.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 13:51:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Aug 2021 16:51:21 -0400
Message-Id: <CDG4ONJVGKQ9.1BNDI32KIK6R9@shaak>
Cc:     "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Charles-Antoine Couret" <charles-antoine.couret@essensium.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <Nuno.Sa@analog.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-iio" <linux-iio@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com>
 <20210808173630.5c384a4b@jic23-huawei> <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
 <CAHp75Vc3o-RrHD_wt_CfJY3P8hoRhJkdiRRySFS_O_7VdtJTQA@mail.gmail.com>
 <CDG3ATRV00VV.57ZPL3OPU5N4@shaak>
 <CAHp75Ve6Csjeeh7+ti6UE0-YPRHHFHXFA3jQwp+bqTAfL50_ig@mail.gmail.com>
In-Reply-To: <CAHp75Ve6Csjeeh7+ti6UE0-YPRHHFHXFA3jQwp+bqTAfL50_ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue Aug 10, 2021 at 3:55 PM EDT, Andy Shevchenko wrote:
> On Tue, Aug 10, 2021 at 10:46 PM Liam Beguin <liambeguin@gmail.com>
> wrote:
> > On Tue Aug 10, 2021 at 8:15 AM EDT, Andy Shevchenko wrote:
> > > On Mon, Aug 9, 2021 at 1:50 AM Liam Beguin <liambeguin@gmail.com> wro=
te:
> > > > On Sun Aug 8, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> > > > > On Sat, 7 Aug 2021 21:56:57 -0400
> > > >         ret =3D fwnode_property_read_u32(child, "adi,internal-ref-m=
icrovolt", &tmp);
> > > >         if (ret =3D=3D -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNA=
L) {
> > > >                 continue;
> > >
> > > >         } else if (ret < 0) {
>
> > > Side note, redundant 'else'
> >
> > Are you asking to add an 'else' statement?
> >
> > because, unless I'm mistaken, in this case ret can have other negative =
values
> > that we want to catch with this 'else if'.
>
> You lost me, I have no idea what "to add" and "other" mean here. No, I
> asked to remove it. It's redundant.
>

Oh, I see what you meant now. I'll fix it. Thanks!

Liam

> > > >                 dev_err(dev, "invalid voltage reference in %pfw\n",=
 child);
> > > >                 fwnode_handle_put(child);
> > > >                 return ret;
> > > >         }
>
> --
> With Best Regards,
> Andy Shevchenko

