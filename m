Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7CC30F413
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhBDNn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhBDNma (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 08:42:30 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39CC061573;
        Thu,  4 Feb 2021 05:41:49 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q5so2560860ilc.10;
        Thu, 04 Feb 2021 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcwGwCNpcpd+qkLWuVWx4j+sB84HP58bIF6W3jSzKOw=;
        b=OwCcrEz34nwaoYgHVhYEuXLUxN8RsVj2AxTD/T++bzASAocHN6OCmydkROHqxhktJ5
         sz3z7SuApibMd7eQmd4xure6C8lCmXKZ/eEzi70plH7RHOgHYxE6vvNbOWnQ6iNcWoVj
         +2F13KRS4/cf/3nPwnGNBEkdSpQEWBDbfVwVgNnLneIlb5+nz59xHpy3lv/sWEco+xzz
         7xJgRhcKcL+Ojf42FcjoXILfFKdKzKZ8b69nuXb8OjhLBljz72vYnyhVv92PJ17p4M8Z
         jofF6+KxapcXk7914r4cxtm5dCA7165gGVYZqe8vh19cSri8alc71d/nyciiqMxE1BtE
         v+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcwGwCNpcpd+qkLWuVWx4j+sB84HP58bIF6W3jSzKOw=;
        b=mxbKEbEnWWsWnsFt/3UOYnq05wfuWFbMpds5eZ2FlPX6Qrzw1tpcxpdbAqYbzuvGC4
         lj4bXh/gYzsum5Gyz6IfWPAU/VgbMG2M8IEmia2a+dg3jb5rZjt5y0MbfBB6at9xNMPQ
         Gxfywune01ywGqf8VKEzikFHqaTj7wjWyRCfRCcl1Y+uxszKhcXl2ynpvF2bV0h+X6k0
         FPxlAZWZa1ZOnFff3WCF6OU5RtHjdCnfFVHVdb3BwYbIwuP2+M9am7LdfdmKYs+4zkAM
         UGe9v1H/mlE6zleE3ddSfyrMZmrJDKmjoN3H2oRHl/XBQsW6CZhZ54IRzQN5wnok7BIN
         6tHg==
X-Gm-Message-State: AOAM531jlW9wwL2xMhl/QixjyuFMDkyYLNMOLk1bDFS+7ZNhaPYCqfD8
        0lEYro180xbdCx+xJJr6TZELfmu7jh/LzBcAa027mKCpEQY=
X-Google-Smtp-Source: ABdhPJxX3tx631C9/WljgQULwuwYchT/xtMMxnMCZXMpmx6EZW8w6PdFEfGKQbSsOeASSpuPvY/REB6IUOez0hVWFeI=
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr6968376ilo.303.1612446109179;
 Thu, 04 Feb 2021 05:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-7-alexandru.ardelean@analog.com> <CAHp75VcTk-Lv_Hr0VHnd-r2XoVeRHEocwVyg6kKdWYrkHnf0gg@mail.gmail.com>
In-Reply-To: <CAHp75VcTk-Lv_Hr0VHnd-r2XoVeRHEocwVyg6kKdWYrkHnf0gg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 4 Feb 2021 15:41:37 +0200
Message-ID: <CA+U=Dso4zosunKgqb64+EwepUwcrpJN0ANwvFXnsz5KxVhOG-w@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] iio: core: merge buffer/ & scan_elements/ attributes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Wed, Feb 3, 2021 at 12:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 5:28 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > With this change, we create a new directory for the IIO device called
> > buffer0, under which both the old buffer/ and scan_elements/ are stored.
> >
> > This is done to simplify the addition of multiple IIO buffers per IIO
> > device. Otherwise we would need to add a bufferX/ and scan_elementsX/
> > directory for each IIO buffer.
> > With the current way of storing attribute groups, we can't have directories
> > stored under each other (i.e. scan_elements/ under buffer/), so the best
> > approach moving forward is to merge their attributes.
> >
> > The old/legacy buffer/ & scan_elements/ groups are not stored on the opaque
> > IIO device object. This way the IIO buffer can have just a single
> > attribute_group object, saving a bit of memory when adding multiple IIO
> > buffers.
>
> ...
>
> > +static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
> > +                                                  struct attribute **buffer_attrs,
> > +                                                  int buffer_attrcount,
> > +                                                  int scan_el_attrcount)
> > +{
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +       struct attribute_group *group;
> > +       int ret;
> > +
> > +       group = &iio_dev_opaque->legacy_buffer_group;
>
> > +       group->attrs = kcalloc(buffer_attrcount + 1,
> > +                              sizeof(struct attribute *), GFP_KERNEL);
> > +       if (!group->attrs)
> > +               return -ENOMEM;
> > +
> > +       memcpy(group->attrs, buffer_attrs,
> > +              buffer_attrcount * sizeof(struct attribute *));
>
> kmemdup() ?
> Perhaps introduce kmemdup_array().

doesn't add much benefit from what i can tell;
and it complicates things with the fact that we need to add the extra
null terminator element;
[1] if we kmemdup(buffer_attrcount + 1) , the copy an extra element we
don't need, which needs to be null-ed

>
> > +       group->name = "buffer";
> > +
> > +       ret = iio_device_register_sysfs_group(indio_dev, group);
> > +       if (ret)
> > +               goto error_free_buffer_attrs;
> > +
> > +       group = &iio_dev_opaque->legacy_scan_el_group;
>
> > +       group->attrs = kcalloc(scan_el_attrcount + 1,
> > +                              sizeof(struct attribute *), GFP_KERNEL);
> > +       if (!group->attrs) {
> > +               ret = -ENOMEM;
> > +               goto error_free_buffer_attrs;
> > +       }
> > +
> > +       memcpy(group->attrs, &buffer_attrs[buffer_attrcount],
> > +              scan_el_attrcount * sizeof(struct attribute *));
>
> Ditto.

continuing from [1]
here it may be worse, because kmemdup() would copy 1 element from
undefined memory;

>
> > +       group->name = "scan_elements";
> > +
> > +       ret = iio_device_register_sysfs_group(indio_dev, group);
> > +       if (ret)
> > +               goto error_free_scan_el_attrs;
> > +
> > +       return 0;
> > +
> > +error_free_buffer_attrs:
> > +       kfree(iio_dev_opaque->legacy_buffer_group.attrs);
> > +error_free_scan_el_attrs:
> > +       kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> > +
> > +       return ret;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
