Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0B3E8AC3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhHKHGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhHKHGl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:06:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9900C061765;
        Wed, 11 Aug 2021 00:06:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3074962pjl.2;
        Wed, 11 Aug 2021 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UvcgK0+rQdblk0xtTCyiUYf9oJ8OzcTny0hyRS8C02A=;
        b=UZ/PRojWKXnWpO1OGqce9RHvhChvopo2iBq56x4sMiuiQ1+itve2g5JDEulc28YJjs
         6vUIFouSplyRPuTyNZtRHK79pJx+eUNjRy/adoh3dVbjI6rTvD9lvocwy5AFziWOW0NT
         Kp4fn3ZTjydQ2/rGsn3WnrM0J0tO5DTPs3DmUrtZkgRaFEGKq68CIa0nFocvjlywsyDJ
         29r8BF1w30xXq02Q1bYcV6iMZ9MbeueS7l7mS0amfxauUkJtveHpRzd0FT0jHXVdmsxO
         7GKErXZoViIVKim1KHzeYr+AsZLDGtAPIZNDdYYtH58DDD1rJGfzVH6Z3N4KWd+z0qhO
         yAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UvcgK0+rQdblk0xtTCyiUYf9oJ8OzcTny0hyRS8C02A=;
        b=tlnjY8v6OLOUtKEytTaZZL58H/p+FKFv79wCXDXQ4KsXZY3z3d0G3LD0mbold3NfQ1
         6za/jfp5evX9Rze7flGoBYEzDGjk1U8zgMboImVI4nKSMLnhAoNNGUix3doTQJWOWmBS
         0qkrOrbuzfPtgxTP3IkCOfe+JyNCWoUUN+fHex6QWK4giq05s1IdKtMC15ByaDRafBrd
         Ai/PP9aLvD9ZpqlY/wMp5sfWP+k1fSGBZfnTK8E45SSL9iw3StOZ+J9tW+WcyrDFKDWx
         NqXii1cQWNrAlE5uGa7hc06VXDDC1zZk+knfPxrY67NTu1tKuwB5STXxE/J363DvaWlX
         6bgg==
X-Gm-Message-State: AOAM532Z7pfvgrrjWJIumveQ5mYszNXeWvcU4NFOhjQJRrpd617YPN1l
        2Z3DjmIBK193rtb41Wc+jHWvsbbJCrCUI/YtVCM=
X-Google-Smtp-Source: ABdhPJw8Ou1BGfhDjoe6vcxMI+DwbaCEw/05yQ6K3jNYq6PWm+pMx9D0aZCIrvpqvwcz91wM0n3HovAXgijz3rU61so=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr9260109pjb.129.1628665577419;
 Wed, 11 Aug 2021 00:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075745.160042-1-dmugil2000@gmail.com> <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
 <20210811054558.GA3826@mugil-Nitro-AN515-52> <CAHp75VfaeEzodmPPmxxDoScPQzE2+5D_czEHfF0pq6oOVh-6nw@mail.gmail.com>
In-Reply-To: <CAHp75VfaeEzodmPPmxxDoScPQzE2+5D_czEHfF0pq6oOVh-6nw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 10:05:41 +0300
Message-ID: <CAHp75VdqM+XVCkkE+GXCytBUqgT5QLNq5=68KOzfs92t-Vb7ww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 10:03 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 11, 2021 at 8:46 AM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
> > On Tue, Aug 10, 2021 at 03:49:52PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 9, 2021 at 10:59 AM Mugilraj Dhavachelvan
> > > <dmugil2000@gmail.com> wrote:
>
> ...
>
> > > > +       data->tol =3D data->cfg->kohms * (val & GENMASK(6, 0)) * 10=
 / 8;
> > > > +       if (!(val & BIT(7)))
> > > > +               data->tol *=3D -1;
> > >
> > > Shouldn't you simple use corresponding sign_extend*()?
> > >
> > I'm not able see any sign_extend for 16 bit. Is there any other way?
>
> So, then add it in bitops.h the same way it's done for s32 and s64.

In case you are afraid that this will delay patches and you are in a
hurry, you may define it locally (but in the very same way, so
somebody can make it generic). Nevertheless, I think this one can be
added directly to the generic header, it will definitely have more
than one user.

> ...
>
> > > > +       if (!data->cfg)
> > > > +               data->cfg =3D &ad5110_cfg[i2c_match_id(ad5110_id, c=
lient)->driver_data];
> > >
> > > Not sure this is not a dead code since you are using ->probe_new().
> > >
> > Even I'm suspecting that and also removing id_table. But I'm not sure o=
f
> > it so just left as it is.
>
> I=C2=B2C ID table is good to have without direct use, but ->probe_new() i=
s
> called if and only if there is a compatible string or ACPI ID match.
> In such case data->cfg may be NULL if and only if the corresponding
> table missed it, but this will be a bug anyway, so the above code will
> rather hide the bug. Hence, please remove it.



--=20
With Best Regards,
Andy Shevchenko
