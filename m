Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55019949A
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgCaLBE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:01:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35653 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgCaLBE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:01:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so7974003pga.2;
        Tue, 31 Mar 2020 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8U2QSDHa+y/e0j1Jilc1FkjIAm5z/QbjVI8HcCrHKY=;
        b=At5xJ/o53UDzNQStGX5zKZ9i8BO3eeSmwVp/fmpfxCisPyywpPo7GcjVhntocjABlu
         WUrPaIKfongAw/BiElmPvgPDI+E12Le1dgXbP8gPhjINGARAz4nW6vFSTjmA3CUe4LJL
         Swuv0cb1ZU0eHsTUchGvsVQb9nRIAWJ2OLxxame/AFP9KfUd8sPb2od7nOHgNlYmmc/R
         ySmIkkz4j/ADQVvyPai6pxWOC3yECTE/AKh62qnUpXQfKkpfs2RbufzzQSgG+uBH/jPd
         MH1Cd9eDy6IeAnjoAOwuDQ+T2kNE2TvoWjJNLxt6VgoGeTmrtol/75FCfZ+j+n/ibIi2
         jeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8U2QSDHa+y/e0j1Jilc1FkjIAm5z/QbjVI8HcCrHKY=;
        b=AWQj7/xxhq7d/t32raHl2ciWe3TK5HPyTubNgNmMZC1jHifhMs97DjboxfkWb8Nlwo
         KSE6s1VdYFmjXF4J7bsuMgpsduNRWUphVnrJKvmIGQsoFnqmf0l5krRIiZrylQSjnPDj
         SDFBwMTuU7s/5xa82gBoUrW4c+6bz29HCtVNZw2rGGt8NvLdq7nHIf+5J2troW65Z1F3
         625ey1Q9kM/qltrN3oipgwW+2NE38XQgTubeBH2qlBDAge0m9RfRykXC0lugGEF5GNV4
         5q3sUN1LG+0yph2jg2k+WCYi7iLzkGmtMFlNVp9PEpaLqN8Z/DNBr0E2Rsl5WeunOYpO
         TpIA==
X-Gm-Message-State: AGi0PubhZ+U/X3yHyz4s6PrH7o3b/ERRqgkrWsxCalx/QAQfNtPrrLOD
        gp6omV8jp9LuI9NIU1gAPrYoTOln4xgvlpfNJ6Q=
X-Google-Smtp-Source: APiQypJubSp9zq2/eye5c5WXaJ42/CmTuUTWONYN6DCYmdEisUBwlGtu4qzWnOJIcuUiLTf6e1YkPWz0zBwwRSXp2Lc=
X-Received: by 2002:a63:5859:: with SMTP id i25mr3529135pgm.74.1585652462807;
 Tue, 31 Mar 2020 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200330152711.8769-1-i.mikhaylov@yadro.com> <20200330152711.8769-3-i.mikhaylov@yadro.com>
 <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com> <5cb43513906e1175801ea4e753c855623fcd11d1.camel@yadro.com>
In-Reply-To: <5cb43513906e1175801ea4e753c855623fcd11d1.camel@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 14:00:55 +0300
Message-ID: <CAHp75VexS-iVeDXsCFqgzCKokgzzeH=BFtUqOJdY+kS8O6B9bw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 30, 2020 at 11:41 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> On Mon, 2020-03-30 at 22:07 +0300, Andy Shevchenko wrote:
> > On Mon, Mar 30, 2020 at 6:27 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

...

> > > +#define VCNL_DRV_NAME          "vcnl3020"
> > > +#define VCNL_REGMAP_NAME       "vcnl3020_regmap"
> >
> > I'm wondering why you need the second one.
>
> For regmap initialize as name in
> static const struct regmap_config vcnl3020_regmap_config = {
>        .name           = VCNL_REGMAP_NAME,
>
> I can get rid of it from struct with name definition.

I don't think we need a specific suffix. When somebody will look at it
they will already know that they are looking into regmap realm.

...

> > > +       rc = device_property_read_u32(data->dev, "vishay,led-current-
> > > milliamp",
> > > +                                     &led_current);
> > > +       if (rc == 0) {
> > > +               rc = regmap_write(data->regmap, VCNL_LED_CURRENT,
> > > led_current);
> > > +               if (rc)
> > > +                       dev_err(data->dev,
> > > +                               "Error (%d) setting LED current", rc);
> > > +       }
> > > +
> > > +       return rc;
> >
> > Why not to use standard pattern, i.e.
> >
> >   if (rc)
> >     return rc;
> >   ...
> >   rc = regmap_write(...);
> >
> > ?
>
> Optional parameter. There exists a lot of ways to do it:

I'm simple reading the code. And I believe the above I suggested is
cleaner equivalent.
Is it?

> rc = device_property_read_u32(dev, "milliamp", &led_current);
> rc = regmap_write(regmap, VCNL_LED_CURRENT, (!rc) : led_current ? 0);

This seems not equal to above.

> Which one would be more preferable?

One which has better readability and smallest indentation level.

-- 
With Best Regards,
Andy Shevchenko
