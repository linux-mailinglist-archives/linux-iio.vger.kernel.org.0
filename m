Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4E3F4C56
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHWO2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWO2n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 10:28:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBCBC061575
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 07:28:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so16831791pgm.12
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bjQEsLqePkSp+fckGJHN1HGW8nuzD9cy9eWdu/7Z29E=;
        b=sRDDT634cVGLJAeYm3j/a/0wlLwwbYe4vx+2um6llkDYHfXU3Wqp4vsQupJHtPN2A0
         /U4bLz7fhfrRxvAH7qPjvKMUfHYqolkFG5mDK8RlbnNBCNXxlfxghc2tfikh7Ipgjgld
         7dR76UE/dUXgWuTKAo5blKPIkU/RJD31znfD1kOggmyp01ZdoO+oiuSj39tbjmJL1VQ7
         RUJIqxijfEubAOc8ttH2yIE3ZJbgMfD0GTj15xWoFykN9JE7x6kn9l88JUwDTmETGdMo
         oj67d2O2xEKH7+9Ly1XXUhkHSyMNmT0NU9SZ520jfypXYNucjzt/TgjVzoK02WCS/NQZ
         x1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bjQEsLqePkSp+fckGJHN1HGW8nuzD9cy9eWdu/7Z29E=;
        b=rOcOh+4Tl5JieN66tvGKNg9FwKFLjFXC24pPPdzQIakXGeP6gobCOjl19XXRB0HrVq
         whvAQDTStJ7Wm+D+V/5yjPBlHqVRrVPZvVHnUxTJvA/j7MvvjqxexGZ9xNVELEstp/vb
         TpBxOjRhvAaejR0AyumMYtXVkhYnNQXgRiaiDi9D16gxbz91IUQ/NY8Tc4wojI387hPa
         5NlmsYDOOKPPtVCQC5795JsZ6BCBhzkCTkREAjwKYKDYHh6NBOnYPn90gbAXNv5nVjXF
         9ee5QHlhCmuNCBnRRs28kZFmI9elTHq0Ejg4EPR4C4Vk55oQvPlD+ACYBi8O/t1svPn1
         fjMw==
X-Gm-Message-State: AOAM530O6QH7qDZV3XhDMoSv6LjXaZKALeYpAQMGiL5tdChSllWgDVcx
        fh3b8CEwyKm0GRykeUburzWqS20rzE4mzTHZ7+A=
X-Google-Smtp-Source: ABdhPJwgOXRErPe7n3Sc5+NvZclH8v9tiU/z6PpwWyu9U8sYyey/D+cMUSDnvVZfnNOUolK3F+aSTrABpgIx80Jx9nM=
X-Received: by 2002:a05:6a00:d41:b0:3e1:3316:2ef with SMTP id
 n1-20020a056a000d4100b003e1331602efmr34669902pfv.40.1629728880009; Mon, 23
 Aug 2021 07:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210820065535.6994-1-nuno.sa@analog.com> <CAHp75VdDkXT=6d8HKAgeSH-h8O0ERvsNidwrbnyvGZHD0GjgAQ@mail.gmail.com>
 <e81553af88194c89f6d31bf83e6e486fe75bd4ea.camel@gmail.com>
In-Reply-To: <e81553af88194c89f6d31bf83e6e486fe75bd4ea.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Aug 2021 17:27:20 +0300
Message-ID: <CAHp75Vcu47BUKPVVtJK0U4G5_6ey-U=o5yDjCH43Nz7TsH+NMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 3:51 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> On Mon, 2021-08-23 at 14:14 +0300, Andy Shevchenko wrote:
> > On Fri, Aug 20, 2021 at 9:53 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:
> > > Check if an optional reset gpio is present and if so, make sure to
> > > reset
> > > the device.
> >
> > ...
> >
> > > +               usleep_range(1000, 1005);
> >
> > The delta should be at least 20%, otherwise I'm not sure why such a
> > strict range?
> >
>
> No special reason... I just had no hard requirement for delta so I just
> gave something small. Is 20% documented anywhere?

Quick search shows nothing, but I remember I saw it somewhere.
So, the explanation is empirical, because the idea behind is to allow
less HRT interrupts. When you do a tough margin, you may generate too
many interrupts from the timer. So, 20% seems like a good balance for
most of the values.

The parameters to take into account are:
 - minimum (or maybe rather median?) CPU frequency the code will be run on
 - minimal sleep (for small sleeps even better to have udelay() as I
believe documented in timers.rst, for bigger sleeps, like 10ms the
margin can be 10% or so)
 - NO_HZ kernel configuration
 - etc (if anything I forgot)

> I did a quick look on
> the API's and I could not find nothing related. Anyways, if that is a
> best practise for being more power friendly I'm happy to change it...
> (well, we might end up just having 100ms here which means 'msleep()').


--=20
With Best Regards,
Andy Shevchenko
