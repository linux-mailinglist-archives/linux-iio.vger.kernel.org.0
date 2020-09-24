Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896AC2769BA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgIXGxd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgIXGxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 02:53:25 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E0CC0613D3;
        Wed, 23 Sep 2020 23:53:25 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i17so2573636oig.10;
        Wed, 23 Sep 2020 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq0QKvIordIaZcr3XeQxpTeJs/oKQ71mPnmpL7sFBPM=;
        b=cAaM2ux0PtnbGD2VZVNKGww0gMEOZytJtQeU2bSWkKWcV1zIvO9EpwZNSGUfjgpqI+
         rNz2EPR7AmMT011AHqSAphkw2oLGlyzHgBEFMRqLQKsCXmEa7XvAFx1VS5D3wcHzcXOd
         eILmF4cX9S2afndZWlyUj/Bb3Bgags1SYq84+bjbITnqs5orh39PhsVWIUI7yIlBDhnf
         IqwWPS7FNJMC8mwflCO+Lr1NJkSlurG0yDq6g2JNZTFTCVFRMjmQEUskw+8nl1kqjyNl
         ZmPuXrr/oAaxH0M+soGg0GFmKxCbexboFz1n/1YYSp7UwH7f12WQAjbRolwtsJrmiVt/
         sXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq0QKvIordIaZcr3XeQxpTeJs/oKQ71mPnmpL7sFBPM=;
        b=T260yx4Qn6LEQHGeX+MQwfeAoSOQNn6R2H9j80mAah7xDqvj0/Jh63aZXwzkMsh8cl
         SVLxfeDbtJKS64dXOJlj+ORfuINuPu6fdScNGx9XS8IPnPCUH1XlclBJCs4WBm0plOOq
         4RLhUrJkQLaabY/bAkatcoeT++VzT+nYDCuf2W01/A5V6NRi8RCVj0F4nzT5ZnYqFCRx
         MM46EO7iPZxEIGju+fqNeU4Qkdr+D9ZRXO7ClAkC9/2ufUEszK8AuUnL9to5BjXxdOod
         JO5ZIQxNQ2u4QSukS2WizLVb1GkQGJvdR2O6jnMbMWLo36KBjIc0yxQ+APvCOMQ0W+gX
         gkqg==
X-Gm-Message-State: AOAM531r/u4IzvVBXsX75cZK37A3EgTs2IRgmyyZiFRhnJewwzvHLBBr
        By8ctKSdcLcHB+fzfcHVSEkD7J5IBfRSb+/3doW/SGyYDFP399Uy
X-Google-Smtp-Source: ABdhPJzQjvkvlkQQ38zYXDDIn6f8gV/hAdJtXg4Hv9hCze/xz/wjQhCxNh8rXPqbnuQNVMPC4MGznutZ4E+jXSWEJkQ=
X-Received: by 2002:aca:ea44:: with SMTP id i65mr1624885oih.117.1600930404771;
 Wed, 23 Sep 2020 23:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921103156.194748-1-alexandru.ardelean@analog.com> <20200923211249.164241d0@archlinux>
In-Reply-To: <20200923211249.164241d0@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 24 Sep 2020 09:53:13 +0300
Message-ID: <CA+U=DsppX2sPyE+QNhnJE9dCwm9QCQ12eg3JjoCHrC3+-MWVEw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] iio: event: use short-hand variable in
 iio_device_{un}register_eventset functions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 23, 2020 at 11:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 21 Sep 2020 13:31:55 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > With the recent 'iio_dev_opaque' variable name, these two functions are
> > looking a bit ugly.
> >
> > This change uses an 'ev_int' variable for the
> > iio_device_{un}register_eventset functions to make the code a little easier
> > to read.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Seems sensible.  Series applied to the togreg branch of iio.git and pushed out as
> testing.  Not sure if this will make it into a final pull request for this
> cycle or not. Kind of depends what Linus says on Sunday about whether we are
> going to see an rc8.
>

No hurry from my side when this goes in.
This is in a longer series of things that do with the whole
multiple-IIO-buffers-per-IIO-device.
I might need to take care [again] so that I don't block myself again
with too many small/parallel series.

> Thanks,
>
> Jonathan
>
> > ---
> >
> > Changelog v1 -> v2:
> > * move 'iio_dev_opaque->event_interface = ev_int;' assigment right after
> >   allocation to avoid crash; 'iio_dev_opaque->event_interface' is accessed
> >   after init
> >
> >  drivers/iio/industrialio-event.c | 50 +++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> > index 2ab4d4c44427..a85919eb7c4a 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -477,6 +477,7 @@ static const char *iio_event_group_name = "events";
> >  int iio_device_register_eventset(struct iio_dev *indio_dev)
> >  {
> >       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_event_interface *ev_int;
> >       struct iio_dev_attr *p;
> >       int ret = 0, attrcount_orig = 0, attrcount, attrn;
> >       struct attribute **attr;
> > @@ -485,14 +486,15 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
> >             iio_check_for_dynamic_events(indio_dev)))
> >               return 0;
> >
> > -     iio_dev_opaque->event_interface =
> > -             kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> > -     if (iio_dev_opaque->event_interface == NULL)
> > +     ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> > +     if (ev_int == NULL)
> >               return -ENOMEM;
> >
> > -     INIT_LIST_HEAD(&iio_dev_opaque->event_interface->dev_attr_list);
> > +     iio_dev_opaque->event_interface = ev_int;
> > +
> > +     INIT_LIST_HEAD(&ev_int->dev_attr_list);
> >
> > -     iio_setup_ev_int(iio_dev_opaque->event_interface);
> > +     iio_setup_ev_int(ev_int);
> >       if (indio_dev->info->event_attrs != NULL) {
> >               attr = indio_dev->info->event_attrs->attrs;
> >               while (*attr++ != NULL)
> > @@ -506,34 +508,29 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
> >               attrcount += ret;
> >       }
> >
> > -     iio_dev_opaque->event_interface->group.name = iio_event_group_name;
> > -     iio_dev_opaque->event_interface->group.attrs = kcalloc(attrcount + 1,
> > -                                                       sizeof(iio_dev_opaque->event_interface->group.attrs[0]),
> > -                                                       GFP_KERNEL);
> > -     if (iio_dev_opaque->event_interface->group.attrs == NULL) {
> > +     ev_int->group.name = iio_event_group_name;
> > +     ev_int->group.attrs = kcalloc(attrcount + 1,
> > +                                   sizeof(ev_int->group.attrs[0]),
> > +                                   GFP_KERNEL);
> > +     if (ev_int->group.attrs == NULL) {
> >               ret = -ENOMEM;
> >               goto error_free_setup_event_lines;
> >       }
> >       if (indio_dev->info->event_attrs)
> > -             memcpy(iio_dev_opaque->event_interface->group.attrs,
> > +             memcpy(ev_int->group.attrs,
> >                      indio_dev->info->event_attrs->attrs,
> > -                    sizeof(iio_dev_opaque->event_interface->group.attrs[0])
> > -                    *attrcount_orig);
> > +                    sizeof(ev_int->group.attrs[0]) * attrcount_orig);
> >       attrn = attrcount_orig;
> >       /* Add all elements from the list. */
> > -     list_for_each_entry(p,
> > -                         &iio_dev_opaque->event_interface->dev_attr_list,
> > -                         l)
> > -             iio_dev_opaque->event_interface->group.attrs[attrn++] =
> > -                     &p->dev_attr.attr;
> > -     indio_dev->groups[indio_dev->groupcounter++] =
> > -             &iio_dev_opaque->event_interface->group;
> > +     list_for_each_entry(p, &ev_int->dev_attr_list, l)
> > +             ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
> > +     indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
> >
> >       return 0;
> >
> >  error_free_setup_event_lines:
> > -     iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> > -     kfree(iio_dev_opaque->event_interface);
> > +     iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> > +     kfree(ev_int);
> >       iio_dev_opaque->event_interface = NULL;
> >       return ret;
> >  }
> > @@ -557,10 +554,11 @@ void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
> >  void iio_device_unregister_eventset(struct iio_dev *indio_dev)
> >  {
> >       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
> >
> > -     if (iio_dev_opaque->event_interface == NULL)
> > +     if (ev_int == NULL)
> >               return;
> > -     iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> > -     kfree(iio_dev_opaque->event_interface->group.attrs);
> > -     kfree(iio_dev_opaque->event_interface);
> > +     iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> > +     kfree(ev_int->group.attrs);
> > +     kfree(ev_int);
> >  }
>
