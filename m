Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA93D7851
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhG0OQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhG0OQs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 10:16:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31DEC061757
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 07:16:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso4517037pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GDHXSVhhzON6Patr/wgP0Z4tKG+rc8S41UE0pWuxy4=;
        b=su5h/GV9D+B3DQIU+hbKcct1jJ+IoNTI4lk0xSiLJzjRr+qxmdNJU45Vdkm5nqUMJE
         4rBaeXQ3T0EvKLXLTM4x14Lr99GianT1cBJzz/01Q+V1N4HYpx7hwcmU5/4fBJY4LoUn
         S4zFzHIU+v0GzUmG/oajTBkCmk2jwXrLRrTZ7SB144TuRTKc9D+9dMETJ53mwKDIp86L
         A7T2MBSrCqCQpUoKkj9qjMHSUOK0DHkX1lTgfU3QoHMpzU5R/jGtdHLlUnS+m8ZGSyEQ
         l3CgRdYA0NCJQn+Q47DB/gS+ZyxDc2i4DPNndzQFjSgVtmShRMzO8Q/5jEU30UvJuot+
         Nm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GDHXSVhhzON6Patr/wgP0Z4tKG+rc8S41UE0pWuxy4=;
        b=KSquj14kfvBKiXh2fDim/qmVXEBYf+RQxOKY9jbHXyZ5Ded9qYLakCk7GUd6Y/rSze
         PEqEgPlLbtURKaVDuyXVekMxcUJesRFuF0mlTgpmSz1feH2iJLhddq0JoqmCSXAfzACh
         b7TuirQe9Oynp+R4IOhhZQmszVJl1+hE1CXcicgILWYMc68XlW6rPW6r69GTZukJHxaI
         EJ9BHjlkWHl7a7PakmnYFAqOHBBJdXkLsmZotaPOZ7x7yawk8ErxWXDfh2moJ6+od7R2
         pjKvczi/Lj188mRVKAfBsUuZZo07DnYRZ6GQWRa2PS3Zee+ZTKtUphZi7ACl1ZXe3c/y
         RZFQ==
X-Gm-Message-State: AOAM531ISKfbtzKOvfFoVd59GgN3t4ODrDMr1UHRUB7CjNVu98miRFPd
        HnP+EYUni2k5dFkcfUDOatElKHyZuVe+qLbudz0=
X-Google-Smtp-Source: ABdhPJxPeiQcg2go1yv6JGhgtT7skOg40FKW3XYhreAL8Jx3UjvOyPqrLU3PmEUBPvPq2ARiY70RvnOetYsFqzSqpNY=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr23742359pgm.74.1627395407442;
 Tue, 27 Jul 2021 07:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210725172458.487343-1-jic23@kernel.org> <20210725172458.487343-3-jic23@kernel.org>
 <CAHp75VcgMkPw8BudKkF9MN2ijjDuT=VRo3FivVcjEYsEY4L-0w@mail.gmail.com> <20210727145141.0000230d@Huawei.com>
In-Reply-To: <20210727145141.0000230d@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Jul 2021 17:16:07 +0300
Message-ID: <CAHp75Ve6L+5zAwBJ5ep2VExyNDaSSrEBAonfMT6cFCxEpgUQQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio:adc:ad7124: Convert to fwnode handling of child
 node parsing.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 27, 2021 at 4:52 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Sun, 25 Jul 2021 23:33:12 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jul 25, 2021 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > -       for_each_available_child_of_node(np, child) {
> > > +       device_for_each_child_node(dev, child) {
> >
> > Isn't this
> >   fwnode_for_each_available_child_node()
> > better to use?
>
> Given we would be extracting the fwnode just to call this
> loop, I'd say no, device version makes more sense..
>
> >
> > ...
> >
> > So the gaps I see are
> >   device_get_available_child_node_count()
> > and
> >   device_for_each_available_child_node()
>
> Do we then fix the fact that
> device_for_each_child_node() will call the _available() form
> for device tree?  That seems inconsistent currently and
> I was assuming that was deliberate...

I'm not sure I got your point. Mine (see below) is to add the APIs
that you want to use as a direct replacement of the corresponding OF
counterparts.

> > Both of them I think are easy to add and avoid possible breakage.


-- 
With Best Regards,
Andy Shevchenko
