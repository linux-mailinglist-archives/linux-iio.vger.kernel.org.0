Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D783E8AB3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhHKHEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhHKHEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:04:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E641C061765;
        Wed, 11 Aug 2021 00:04:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l11so1452266plk.6;
        Wed, 11 Aug 2021 00:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xzgav6eUnQmltf8HkdcWS198foTYa67bhyoLNro+l84=;
        b=WYCt/2BqlX22QNRrnllXEQcMGmu2Oz0+4wRl2uUVD6Mb2pcmozRVSJaDsgjplbD48v
         3v0W7+0jNX8finaIFxZWJgmYllxvUDX9IqyMfhsmdcbibshAm+3n/WOp+WoR9sOxz2ww
         paNcBTn3GYHvUpB+G17QkdxFrMxT/koGcUROUv1KLRaYhw//1OgxwImNS59vw2frC0dG
         0vLQjTDIEFgiLcav5nEPn+upsOigDdm5AXdyJalpP4RbcCc0t2TmIc+sOwc8meNXiGNo
         YQXhjDUk+W2/aFL5Lb2qwjcLAN56K6zQ06bO4pELxDQLTXT8GFcMZeolqHcXO7n3Zayb
         XJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xzgav6eUnQmltf8HkdcWS198foTYa67bhyoLNro+l84=;
        b=McnCsSWGO5CjZB9BSa0/rxZR8/Tl/sMvF7BpdWf00nQko5KU+Of1fqJ1Qou2NLTxG6
         tifYC++7CoYnZZ9Iz3/0BIPaZ1B0JCNYRPzrRiS22TCp4mArOLwrp+AdhHXRrVPzzxIn
         uosnMnYwPLqu2znQZyrAgOtN9IFjIvGlFRNhvHmXhKDP43nkskf39EV6BjXOxmjTeeMp
         65qEzxegX2tiy6Vqc7Ex7b5sDuodZZlFAk4Ivt1RdnGa4Gsq6mJ4fPN3Z/kWMXxULXvC
         J/03C1Vp83TKGvE4akPoB2/Zxpd+guGVq4KEJVUajw4ed4cAWY1v+K6QNFgkXpmYC71M
         R8eQ==
X-Gm-Message-State: AOAM531Wqq17oRyrl7gvfSSnRqVT+LmTKfV573wVM2E5MMvWHLVl2R5s
        mP47+tjFC0wf6IAg5JYbbWl7VOHFCjYTtVKvSmE=
X-Google-Smtp-Source: ABdhPJwBtkUzFoV8eh3aIXrSMcAt78o66IvJ2x6Gx9IfY5ZJ9PObuCbUjlyKBswnUU6oXboq8dG5YFu0WvtfymT1bKA=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr9253206pjb.129.1628665465692;
 Wed, 11 Aug 2021 00:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075745.160042-1-dmugil2000@gmail.com> <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com> <20210811054558.GA3826@mugil-Nitro-AN515-52>
In-Reply-To: <20210811054558.GA3826@mugil-Nitro-AN515-52>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 10:03:49 +0300
Message-ID: <CAHp75VfaeEzodmPPmxxDoScPQzE2+5D_czEHfF0pq6oOVh-6nw@mail.gmail.com>
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

On Wed, Aug 11, 2021 at 8:46 AM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
> On Tue, Aug 10, 2021 at 03:49:52PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 9, 2021 at 10:59 AM Mugilraj Dhavachelvan
> > <dmugil2000@gmail.com> wrote:

...

> > > +       data->tol =3D data->cfg->kohms * (val & GENMASK(6, 0)) * 10 /=
 8;
> > > +       if (!(val & BIT(7)))
> > > +               data->tol *=3D -1;
> >
> > Shouldn't you simple use corresponding sign_extend*()?
> >
> I'm not able see any sign_extend for 16 bit. Is there any other way?

So, then add it in bitops.h the same way it's done for s32 and s64.

...

> > > +       if (!data->cfg)
> > > +               data->cfg =3D &ad5110_cfg[i2c_match_id(ad5110_id, cli=
ent)->driver_data];
> >
> > Not sure this is not a dead code since you are using ->probe_new().
> >
> Even I'm suspecting that and also removing id_table. But I'm not sure of
> it so just left as it is.

I=C2=B2C ID table is good to have without direct use, but ->probe_new() is
called if and only if there is a compatible string or ACPI ID match.
In such case data->cfg may be NULL if and only if the corresponding
table missed it, but this will be a bug anyway, so the above code will
rather hide the bug. Hence, please remove it.


--=20
With Best Regards,
Andy Shevchenko
