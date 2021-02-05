Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62998310A6B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 12:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhBELjO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 06:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhBELI4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 06:08:56 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A2C06178B;
        Fri,  5 Feb 2021 03:08:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id f63so4073110pfa.13;
        Fri, 05 Feb 2021 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLdJvQjaVUboZMXvC6GcKd3HCEk+cLIu/46gm2XOIrA=;
        b=tmeCNQnmjaSmCJ/78Ei4VXMpB96QS9BFl9p4P7ShcVflPcoWDLZtFW5Vjf5gMCWJsG
         3aKwdzuxQesC11Quv0wwqRV03h2jCSPh2YR5za1HrWTBSrxX+sAQQ1Bktx40FDeSN6z0
         JIh8rSx2c1W2milcqd8EaKD6yTrRJMdxHkH82OS8X64B5T1gs126uSTlBTOcF0MT5aWH
         h1+Aj9AnKzvU5j4h5NfCTF5gvNvnJr5Hs1R3tbJjxqPFciTX0j7qilJhVcR4SBLzpwr9
         XubAdUuKeBa5XLh2VxA5E+Ih+x3QWKlA8c6YCKboegneOKrpcfm0tJ2EkWRDlrS1MmJn
         uogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLdJvQjaVUboZMXvC6GcKd3HCEk+cLIu/46gm2XOIrA=;
        b=OiI2vn33/NhcivckItBy0kJ7JtCOnRzrN6hh+CLmGBegRfBwxerDPltfphL6aelRc5
         q/fEAa97g5I8TgYYwZKYhTUKwj5VvyA8c7qBvobzHjdFRgKJIA3Li6gkJOPasYvyMA3M
         98wpY8WIDekh1jAb2+xYMLgr4lkp1uDMCMFihYn71RYNkAapXk1KPwy1W6gqNTj8s3Iv
         +osvLx3EoRYgxQ1iIfADmGdbBxy5fohTHOo4bh4V1gQugDbM1f5C/lEZlBk9iAYvZr+5
         3K5ge3Msgey34AIb/0JTfLWw/GkUz2a+cnCcqx7tCvwt5raU1kJU86LhWJoa6XdAQaL5
         kY+g==
X-Gm-Message-State: AOAM531F2SV/Xba3KqUTkGDRl/Ow1Jjdmr87u2ls7I9GtUbhYY0pN8OW
        SD2v2jSq+xezreENpXb8bT4uM5z3/M2sJ9ckE4QSHa5Tg7lKnA==
X-Google-Smtp-Source: ABdhPJyS9cIlMZ/krFlrqDCBCdHtOQNIU4Ugw2oBEL4m9uH/lSjASDyqnbFcUkTN7WTTjDizm4M9M2MPgDo28X0FgOA=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr4221660pfe.40.1612523295795; Fri, 05 Feb
 2021 03:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-7-alexandru.ardelean@analog.com> <CAHp75VcTk-Lv_Hr0VHnd-r2XoVeRHEocwVyg6kKdWYrkHnf0gg@mail.gmail.com>
 <CA+U=Dso4zosunKgqb64+EwepUwcrpJN0ANwvFXnsz5KxVhOG-w@mail.gmail.com>
In-Reply-To: <CA+U=Dso4zosunKgqb64+EwepUwcrpJN0ANwvFXnsz5KxVhOG-w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Feb 2021 13:07:59 +0200
Message-ID: <CAHp75Vd1kx63WPOYb0KsSCHvazEv8=7-qcn3E+QBmdRBrztpMw@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] iio: core: merge buffer/ & scan_elements/ attributes
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 4, 2021 at 3:41 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Wed, Feb 3, 2021 at 12:04 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Feb 1, 2021 at 5:28 PM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:

...

> > > +       group->attrs = kcalloc(buffer_attrcount + 1,
> > > +                              sizeof(struct attribute *), GFP_KERNEL);
> > > +       if (!group->attrs)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(group->attrs, buffer_attrs,
> > > +              buffer_attrcount * sizeof(struct attribute *));
> >
> > kmemdup() ?
> > Perhaps introduce kmemdup_array().
>
> doesn't add much benefit from what i can tell;
> and it complicates things with the fact that we need to add the extra
> null terminator element;
> [1] if we kmemdup(buffer_attrcount + 1) , the copy an extra element we
> don't need, which needs to be null-ed

Ah, I see now. Thanks for pointing it out!


> > > +       group->attrs = kcalloc(scan_el_attrcount + 1,
> > > +                              sizeof(struct attribute *), GFP_KERNEL);
> > > +       if (!group->attrs) {
> > > +               ret = -ENOMEM;
> > > +               goto error_free_buffer_attrs;
> > > +       }
> > > +
> > > +       memcpy(group->attrs, &buffer_attrs[buffer_attrcount],
> > > +              scan_el_attrcount * sizeof(struct attribute *));
> >
> > Ditto.
>
> continuing from [1]
> here it may be worse, because kmemdup() would copy 1 element from
> undefined memory;


-- 
With Best Regards,
Andy Shevchenko
