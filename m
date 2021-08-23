Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7A3F4CA5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhHWOwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOwI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 10:52:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD3C061575
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 07:51:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u1so10745938wmm.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kur3RBD8vN5RjLBs9syNU8xwMW+dc26V4IavA+uRaEo=;
        b=htYRb3Xgqb+Iiedc3WC2bp8QsCoP0NiUDxmFqCP4sIroAY2Xt10gBQ90cFQ5s3Hkni
         G8AWUX/qKQYQH3MbI6GXgt3Z0Gg9SecEIsgoqOhH6E9dNvLvlNzUPKIwITk1uQgYzqFz
         UxPs549E6rq7UYjGh1bJDc+fQUCNh5HiDF0nrDiczRrQSY1zlBuXHAMiDVLqBrNsYNlA
         ehI7TuA/8e5nmlf9YS8YoWMXvIATds/csYCOqWuzdjfU9dtHsTa54sKly3y82J6/4vna
         Pa9IkaFWmVz2iu+eSA/0Z0D65T8Zq2a4mi5/2nH7E4FO4reNB+pybC8jcO9cH7qSytWa
         xhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kur3RBD8vN5RjLBs9syNU8xwMW+dc26V4IavA+uRaEo=;
        b=KUahzcpC14Ie48dPcdSQJ6QZtlcsK2320mHAj6uqBSDqQxYllvHTGnzqpZNM+tF41E
         vkhYrBlULYj8YRvly5p41tb4vQiqyabWHtEQRuaz1xzK0aSovB0z1sWAwzbP/UswMufB
         9DYHvjD7RchS/iHI8X8y20wivtlRyJ1wTRzy/cCvUjz8pkyjnPnIGDHNa/OY34+eHBd1
         Uf/UB0BHoQBKDFHXbZOhTNgzQuLCoDSFcLm4qBNgZc8OfoilqTDuuKfXS9KLmt7aRzFJ
         cEMlGiGKLnfDk5zOlWZP1LkRnf30mdXtMV68sRcffFaD5eB2wUFGI6AjEJdES+P7LTeE
         tF8Q==
X-Gm-Message-State: AOAM5330kSYZPZs+EQ13cT4/MfoYrwIvHLJPRMpsA8wKR/FwdM+TkaVY
        AXP9HKgTfZe+d8XatGytYiM=
X-Google-Smtp-Source: ABdhPJxOV2pnvd4lRyD2GaRicxMc4bUuviK0934CFnFBC+0Rw4DJXnDN5ils6SSbqIFnK2IvDJI8XA==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr17318823wmm.49.1629730283894;
        Mon, 23 Aug 2021 07:51:23 -0700 (PDT)
Received: from nunojsa-N551JK.fritz.box ([2001:a61:2531:cb01:1061:e4b5:709f:d9ad])
        by smtp.googlemail.com with ESMTPSA id o8sm15465136wmq.21.2021.08.23.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:51:23 -0700 (PDT)
Message-ID: <12d40e96658a005d857a49eccede2ac9620c5e2d.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Date:   Mon, 23 Aug 2021 16:51:22 +0200
In-Reply-To: <CAHp75Vcu47BUKPVVtJK0U4G5_6ey-U=o5yDjCH43Nz7TsH+NMA@mail.gmail.com>
References: <20210820065535.6994-1-nuno.sa@analog.com>
         <CAHp75VdDkXT=6d8HKAgeSH-h8O0ERvsNidwrbnyvGZHD0GjgAQ@mail.gmail.com>
         <e81553af88194c89f6d31bf83e6e486fe75bd4ea.camel@gmail.com>
         <CAHp75Vcu47BUKPVVtJK0U4G5_6ey-U=o5yDjCH43Nz7TsH+NMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-08-23 at 17:27 +0300, Andy Shevchenko wrote:
> On Mon, Aug 23, 2021 at 3:51 PM Nuno Sá <noname.nuno@gmail.com>
> wrote:
> > On Mon, 2021-08-23 at 14:14 +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 20, 2021 at 9:53 AM Nuno Sá <nuno.sa@analog.com>
> > > wrote:
> > > > Check if an optional reset gpio is present and if so, make sure
> > > > to
> > > > reset
> > > > the device.
> > > 
> > > ...
> > > 
> > > > +               usleep_range(1000, 1005);
> > > 
> > > The delta should be at least 20%, otherwise I'm not sure why such
> > > a
> > > strict range?
> > > 
> > 
> > No special reason... I just had no hard requirement for delta so I
> > just
> > gave something small. Is 20% documented anywhere?
> 
> Quick search shows nothing, but I remember I saw it somewhere.
> So, the explanation is empirical, because the idea behind is to allow
> less HRT interrupts. When you do a tough margin, you may generate too
> many interrupts from the timer. So, 20% seems like a good balance for
> most of the values.
> 

I see, that makes sense to me.

> The parameters to take into account are:
>  - minimum (or maybe rather median?) CPU frequency the code will be
> run on
>  - minimal sleep (for small sleeps even better to have udelay() as I
> believe documented in timers.rst, for bigger sleeps, like 10ms the
> margin can be 10% or so)

udelay() would be for sleeps < 10us

- Nuno Sá

