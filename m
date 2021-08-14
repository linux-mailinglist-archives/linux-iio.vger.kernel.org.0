Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368EF3EC15B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhHNISm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbhHNISm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 04:18:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E3C06175F;
        Sat, 14 Aug 2021 01:18:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso5268093pjh.5;
        Sat, 14 Aug 2021 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlwkvMA5TKL93cZfm6M/CQUNPE2+oYy9JxRaVYzYyAg=;
        b=FD/+MbNAvOYFb7/jptc9n+3gwgnj1+DzxQhYXtrzYQN8kw5RT7yCjsxTtRMyvvRcgv
         ZnIXGVm1BU8koYL79u5bKmkaQJLvjSFD5L+WkR+t0qkMoG0GBgTqVDPylbnJPAFlAxEt
         DkydKSy3pnTCwRASf08koslXni/OQsjgxgekQ2HC/NFcHZleoRl1YOjOORupFF5Nv9n2
         Rb1082VcCqad+Ha3MAVL6E2Kx6FIximf/E2v+UGhXU4QTYAvJ+DZgz9MYsEqoLpucDGN
         jNX0MN8FvpEgCqsVmUpm3WD813ZoNIc5fyoHhOUActmErmMMFBEO+VF/l2MUYCHx12E6
         LGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlwkvMA5TKL93cZfm6M/CQUNPE2+oYy9JxRaVYzYyAg=;
        b=If01E0o6JPWxPVo9FzxNHAs6C1u/FTLuX7FeJS0qAsVukUQJU+pb1++lQ2GvcLSvgz
         +3NvmAtbUSzgO4f8faX2BRfPCVXxVKswNHy0Sdm9gHw3fkhUtJracm6Vt0ySVO5YoGYN
         pdGBA8LVpl9q/IMZX9mjKobrGHUznQsEeUDf/C74t/kRpR9dncmKCTCqL5Cg4ieOhw/l
         eh0yDYBlvfJ+0o96zHtoWkjF+DlZCsuGzBmeGOOIqyLANn5UlC5m+oxD1dqy8cT7lXwq
         WAVEA9UzOMmzZWxBoKCL+ANa3e6mGgx+UhV7n/LiAkx13TlQoWYxAjpti94KlXaU20R0
         NVxw==
X-Gm-Message-State: AOAM530senXLns3p02GI5gqgb9lmmGbVI+8umrwnH6go8ZV0/k/f8Bwd
        wV/5jLsUcFQr2Iv2WzA5bYk=
X-Google-Smtp-Source: ABdhPJwR4yOSrSk9d8Py+pklZ0xWbsDncc7HtDYpqbAD6il/Uya8CTwDyUwHEzYUnP50bUkEWtIFcA==
X-Received: by 2002:a63:303:: with SMTP id 3mr5889661pgd.439.1628929093503;
        Sat, 14 Aug 2021 01:18:13 -0700 (PDT)
Received: from mugil-Nitro-AN515-52 ([2409:4072:608b:6e91:963e:30ac:c1d8:e28])
        by smtp.gmail.com with ESMTPSA id y62sm4655325pfg.88.2021.08.14.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 01:18:12 -0700 (PDT)
Date:   Sat, 14 Aug 2021 13:48:02 +0530
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
Message-ID: <20210814081802.GA11128@mugil-Nitro-AN515-52>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
 <013bcb79-c496-44d8-2e93-57eb57834ee0@metafoo.de>
 <CAHp75VcvA=dDOJXSFzgz69JVgbez4Lz27EGOEF7JWUehyrwQrA@mail.gmail.com>
 <20210812165327.GA4542@mugil-Nitro-AN515-52>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812165327.GA4542@mugil-Nitro-AN515-52>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 12, 2021 at 10:23:41PM +0530, Mugilraj Dhavachelvan wrote:
> On Wed, Aug 11, 2021 at 07:06:43PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 11, 2021 at 11:15 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > On 8/10/21 2:49 PM, Andy Shevchenko wrote:
> > > >
> > > >> +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> > > >> +       if (!(val & BIT(7)))
> > > >> +               data->tol *= -1;
> > > > Shouldn't you simple use corresponding sign_extend*()?
> > > The data is encoded a sign-magnitude. sign_extend() works for two's
> > > complement numbers.
> > 
> > Good catch!
> > I'm wondering if it's a good idea to have a sign_magnitude_to_int()
> > helper or so?
> >
> So, What should I do now?
> 
Will send v3 with other changes and add this change in v4. Hope it's
okay.
> > -- 
> > With Best Regards,
> > Andy Shevchenko
