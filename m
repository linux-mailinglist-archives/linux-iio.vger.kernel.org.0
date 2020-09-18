Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81226FBA9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIRLjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRLjb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 07:39:31 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3064C06174A;
        Fri, 18 Sep 2020 04:39:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so6654248oie.0;
        Fri, 18 Sep 2020 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hv+H6dY6nRfqSFBOoFPMbAJc7waktRobbMQ296CJc44=;
        b=VNPYvm2KioNyGT532r6jWxdYOsBWKKG9wrye0nG3XwS+dSLtTcVEy2jd9XIYDojmiU
         10kKcqbZ4RmknzE5GfHV9ek+PzSmk+caTONhXsBYfKu3s7CDKm/UtmCKrL3rcXcDuycZ
         z6XrAX8Iv3PkfRR9bMEXBen1gl7eAFRc6M4XYUmfE/U3rFH05GO7dbkM/StQ9OlEUpsy
         NYHA/YvLhEe2OyYxSAzLFy+MPuNyXc5aHgranS9AmgfESsGj+5ENUimgzHigeMXDsvzL
         kAVFnMZ24kRLp+CJ0zTvuZWApc6qnYCe2f/XUnBg56IBgjN2ttP890w34kM5EcVcpjNi
         hYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hv+H6dY6nRfqSFBOoFPMbAJc7waktRobbMQ296CJc44=;
        b=Ow9Oo0O3SrkUurXZeaSb32BYXxCPHOPVHLaYMe3VZzL6svZZNw/hz54AX52baaYQF+
         yrijmTncy+cZ9+TyYTQLosxXu+rzq2TJBTyHIU/YmnsrrCawlEh1r51LTM4IZYlNtNyH
         UDbL4hv0wKrfFQG+gUx0pjwow04GDDIbK4XjVH5uXV49q3YAYjeWYwNnOnmegptUuAkt
         Ij9nfnhRcmjWyrl0nf0LTFHvoY7/nF+JSBDTYj2ocDBZ0W79qciA3ZI1wNB74ngmU4SK
         oIxpW/7pIhpdy59ha40Ss1UA2NI/Y6ka2GoyLnew6uiw+JSZB70rc9vsAFvUL71axjet
         tjQQ==
X-Gm-Message-State: AOAM533TlvR74GSQAU4n+ZUGHSJY6/hpLsj4UUoJmv6EkJQRLL3Xh2ND
        dSEVXJna9Y7Qjs2TtlgJa2OktC1uzZNJAZ/cs3PQjRZDBpI=
X-Google-Smtp-Source: ABdhPJzHXSUmI2FjzpOSvUFXSwe1uczz1hrAT4joMRm8e5xrWbCJSCrjxqZheGCbOrYVdCvJFIvYdlbu8i9Nzt1LFBk=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr8819128oic.124.1600429170085;
 Fri, 18 Sep 2020 04:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200918103247.1484-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200918103247.1484-1-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 18 Sep 2020 14:39:19 +0300
Message-ID: <CA+U=DsoaOJHyoK30CDFie7XWknoeG6ASXLhzS0+zKJxWWJivnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: event: use short-hand variable in
 iio_device_{un}register_eventset functions
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 18, 2020 at 1:34 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> With the recent 'iio_dev_opaque' variable name, these two functions are
> looking a bit ugly.
>
> This change uses an 'ev_int' variable for the
> iio_device_{un}register_eventset functions to make the code a little easier
> to read.
>

Please disregard this series.
I found a bug with this.
Seems I didn't test it properly the first time.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-event.c | 50 +++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 2ab4d4c44427..96b7fa63f96c 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -477,6 +477,7 @@ static const char *iio_event_group_name = "events";
>  int iio_device_register_eventset(struct iio_dev *indio_dev)
>  {
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +       struct iio_event_interface *ev_int;
>         struct iio_dev_attr *p;
>         int ret = 0, attrcount_orig = 0, attrcount, attrn;
>         struct attribute **attr;
> @@ -485,14 +486,13 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>               iio_check_for_dynamic_events(indio_dev)))
>                 return 0;
>
> -       iio_dev_opaque->event_interface =
> -               kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> -       if (iio_dev_opaque->event_interface == NULL)
> +       ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> +       if (ev_int == NULL)
>                 return -ENOMEM;
>
> -       INIT_LIST_HEAD(&iio_dev_opaque->event_interface->dev_attr_list);
> +       INIT_LIST_HEAD(&ev_int->dev_attr_list);
>
> -       iio_setup_ev_int(iio_dev_opaque->event_interface);
> +       iio_setup_ev_int(ev_int);
>         if (indio_dev->info->event_attrs != NULL) {
>                 attr = indio_dev->info->event_attrs->attrs;
>                 while (*attr++ != NULL)
> @@ -506,34 +506,31 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>                 attrcount += ret;
>         }
>
> -       iio_dev_opaque->event_interface->group.name = iio_event_group_name;
> -       iio_dev_opaque->event_interface->group.attrs = kcalloc(attrcount + 1,
> -                                                         sizeof(iio_dev_opaque->event_interface->group.attrs[0]),
> -                                                         GFP_KERNEL);
> -       if (iio_dev_opaque->event_interface->group.attrs == NULL) {
> +       ev_int->group.name = iio_event_group_name;
> +       ev_int->group.attrs = kcalloc(attrcount + 1,
> +                                     sizeof(ev_int->group.attrs[0]),
> +                                     GFP_KERNEL);
> +       if (ev_int->group.attrs == NULL) {
>                 ret = -ENOMEM;
>                 goto error_free_setup_event_lines;
>         }
>         if (indio_dev->info->event_attrs)
> -               memcpy(iio_dev_opaque->event_interface->group.attrs,
> +               memcpy(ev_int->group.attrs,
>                        indio_dev->info->event_attrs->attrs,
> -                      sizeof(iio_dev_opaque->event_interface->group.attrs[0])
> -                      *attrcount_orig);
> +                      sizeof(ev_int->group.attrs[0]) * attrcount_orig);
>         attrn = attrcount_orig;
>         /* Add all elements from the list. */
> -       list_for_each_entry(p,
> -                           &iio_dev_opaque->event_interface->dev_attr_list,
> -                           l)
> -               iio_dev_opaque->event_interface->group.attrs[attrn++] =
> -                       &p->dev_attr.attr;
> -       indio_dev->groups[indio_dev->groupcounter++] =
> -               &iio_dev_opaque->event_interface->group;
> +       list_for_each_entry(p, &ev_int->dev_attr_list, l)
> +               ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
> +       indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
> +
> +       iio_dev_opaque->event_interface = ev_int;
>
>         return 0;
>
>  error_free_setup_event_lines:
> -       iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> -       kfree(iio_dev_opaque->event_interface);
> +       iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> +       kfree(ev_int);
>         iio_dev_opaque->event_interface = NULL;
>         return ret;
>  }
> @@ -557,10 +554,11 @@ void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
>  void iio_device_unregister_eventset(struct iio_dev *indio_dev)
>  {
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +       struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>
> -       if (iio_dev_opaque->event_interface == NULL)
> +       if (ev_int == NULL)
>                 return;
> -       iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> -       kfree(iio_dev_opaque->event_interface->group.attrs);
> -       kfree(iio_dev_opaque->event_interface);
> +       iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> +       kfree(ev_int->group.attrs);
> +       kfree(ev_int);
>  }
> --
> 2.17.1
>
