Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8991025BFB6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICKy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICKyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 06:54:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E525C061244;
        Thu,  3 Sep 2020 03:54:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so2007025pfp.11;
        Thu, 03 Sep 2020 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEEFAEKafCECfpcvzNqVgOZOstK7v9T5wQj765Bl7u0=;
        b=LGHEIvUC9ycEkxIwSPFGYkT5VPvZ6LJZkUR6axy/4HUgvDL/6qhog9O7RuxbLG7N0q
         FRttEwWXEs7wRK6/2KakJSyXPQqnjewcbSjpiNNRzSDA6nrNhiYOCh49xlpDU4pPis5P
         WB1zdhcXS2rB8vxV6iyV0+Fj6L6Yln+R3iOqXOptL5Cg91V5GXVVIa1lK10xC5/k+xfQ
         GoGZJuWUPr02Fy4xCr0r83/2B8ACGu/IfpCYrn2MAfaN08FtQ23ys3K1iqxlrV5D7sni
         Fg0TCNjJtYoFqUoDSakYBblWXsWCMyOdFgwJ3ndfLMJaJNZZPix++6Go+iufvwM4Rkt/
         Rueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEEFAEKafCECfpcvzNqVgOZOstK7v9T5wQj765Bl7u0=;
        b=SCqgYCTDpNIP+aKbmkluJpT9/umEvrrCjETYXVJwCA7ua0aOh/9FvtGWA6wk8EmK1e
         lfOA5/9sxknwWP0yyYHu4KyhJ8ndzXyYy37VMkhoAFOYbGUX1pevcNwr7a751vbaPg1j
         KLz6GVa70fxc1yjO2kDncYpESMtA7kb19cyiWpg6fOlxn0sb8LskBZUN3p7Jy+STiM0q
         55/J/msu/eGgJh08kFNDIb9NO717gXA+zpmeV7rWJdIdF9N2NAAYAZKg4/Styo1g/9jX
         Jpo8a+11yrqdKY5d9DfdwdQwen4DJfVfoUsgzhLFdUQqSq1iJ1OhpMC44V6WcId08I3l
         sGIg==
X-Gm-Message-State: AOAM532nNZtd4rfy4lSrN0bPoG3bVirqQ8zE4OrBIUDv8CUfMFtBr2T8
        qRUU1rWA7ov9zWU34vodt4ZpwR9axx9uBrFE/kU=
X-Google-Smtp-Source: ABdhPJwwKzY4B+ExThO9guEkJ+85/lSheduMv9l40jHlTsofKe5Mejh4uieFi8mQ+UWH5VpQp/Lnu6hcd3nKVy4aiCw=
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr3312349plb.131.1599130464695;
 Thu, 03 Sep 2020 03:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com> <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
In-Reply-To: <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 13:54:07 +0300
Message-ID: <CAHp75VcJp4zCxOUBgYTypv_R47vLAuAF2ZStLpA9mjFjbzWcxw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 1:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Sep 3, 2020 at 10:37 AM AceLan Kao <acelan.kao@canonical.com> wrote:

Couple additional notes.

...

> > I spent some time studying/reading what you wrote, but I still don't
> > understand how to leverage meta-acpi.
>
> meta-acpi is a Yocto layer to support provided ACPI tables for the
> build. My point here is to have it as a collection of ASL examples.
> It's what you asked for below in this email.

> Also we can collect your ASL example under board (presumably new) folder.

Actually it seems Baytrail, so, minnowboard-max is good enough.

...

> On the first glance I didn't see any issues with it, but on second
> look here is one. Look into this [5] example.
> If you noticed it uses the same path in Scope and in the reference in
> I2cSerialBus() while in your ASL they are different.

Also there is an _ADR value wrong for the second channel (I'm not sure
if it affects anyhow the rest).

> Do you have issues with loading it (as is and after above addressed)?
>
> [5]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/ft6236.asli

Also a link [6] to our Buildroot repository which allows to create an
initramfs with ASL compiled. Maybe used as a reference how we created
initramfs and compile ASLs.

[6]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/common
...

> > > One more useful link is SO answers on the topic:
> > > https://stackoverflow.com/search?tab=newest&q=prp0001
> > >
> > > > [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html#device-tree-namespace-link-device-id
> > > > [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> > > > [3]: https://github.com/westeri/meta-acpi
> > > > [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-tables/samples

> > > > > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c



-- 
With Best Regards,
Andy Shevchenko
