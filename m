Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E424D93A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHUQAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHUQAP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Aug 2020 12:00:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD604C061573
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2020 09:00:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b16so2211709ioj.4
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2020 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWjzEcPwT/6hwotRNTIY9NaBUTyN7quweFTkYLEKd40=;
        b=jDClVLEKJWhVolsUnITnsSQo1HZzq0iWZfsy/liv4zabUX+ksQm7q238ZH77pv1pww
         IE2xpVnuJb0uUGalHSvWp5hGTYvxUx0+HkDPoxchFCTb86f4kJvl+QgU/xdEwcfd12or
         N0oR8zb3+O+MdVq+R3wLWUjrLcP38QTN/0dRYdDDE3yysc+3hHqQz4J+GexYsxP1PLHE
         AowSSCByJw/nNarcPN/7VDb3U/wCv5B3QN6KbccLZuljorjIguGphz9/a/CGgn3oG543
         6yAp00g7o29yBR/8IX02hwpwdvpe2OV+yxIF42nETH+66Ebc2yEb3h5XPuCtnhZoBK6c
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWjzEcPwT/6hwotRNTIY9NaBUTyN7quweFTkYLEKd40=;
        b=hcrL3EvjY8rkv7+Y6LEOENKiuEyz8OeZt05GunAB+azTqpvgDjnky/deZXyu2exWDU
         S9CXOhposFEBbCqpQlLNWwMalmAm1K7V2QhTRv+RTQrdKKBwrQW3mzIyOh0VxW38bSO2
         0C7EGdKg+dkA5mscUGcO1+3631j4o0AWBU2SPXak4PIG3MfUqdxH/Xx5wCYQFyuBjlRx
         PiTBNVukbMHdvZ7KRxXzDIu485Iidx9qqBO3C2e0LzFaeStM4nrIPvSJruOcKIFz521i
         CirX6/UPEI8LYgWCdp11u72PymZ+jC0bKfhXy29DTOPdvOyp9jAGj4PZLUDZDeG4L+Qh
         blDg==
X-Gm-Message-State: AOAM5303/OVFawc10pouf4bOAwMC/8kIo/dAHXilq5qNA6olVXRN2IAf
        F77FqByMZj2eLiKZSCou4ohJHx2R0zLEOtI8ifU9Lg==
X-Google-Smtp-Source: ABdhPJwBm13KEUhNRpo7vk4oIVXm7ASv7AuOGK/3nYoePGcCxW34adTWVSkCHauITkFQuVHyKmTrX4EY/gRMqEK65h4=
X-Received: by 2002:a5d:8cce:: with SMTP id k14mr2831399iot.13.1598025613850;
 Fri, 21 Aug 2020 09:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200820185110.17828-1-brgl@bgdev.pl> <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com> <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
 <20200821105119.GL1891694@smile.fi.intel.com> <20200821110403.GP1891694@smile.fi.intel.com>
In-Reply-To: <20200821110403.GP1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 21 Aug 2020 18:00:02 +0200
Message-ID: <CAMRc=MfLkBRKu9ofSUGH=k3hxiJk-g=MMvab2awcsmeyF4RAKg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 21, 2020 at 1:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 21, 2020 at 01:51:19PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 21, 2020 at 10:59:19AM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Aug 21, 2020 at 10:35 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > > +static struct devres *to_devres(void *data)
> > > > > +{
> > > > > +     return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > > +}
> > > > > +
> > > > > +static size_t devres_data_size(size_t total_size)
> > > > > +{
> > > > > +     return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > > +}
>
> > > The data pointer in struct devres is defined as:
> > >
> > >     u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> > >
> > > And this value (assigned the value of ARCH_DMA_MINALIGN) varies from
> > > one arch to another. I wasn't really sure if offsetof() would work for
> > > every case so I went with something very explicit.
> >
> > I have checked with a small program simulating to_devres() with your variant,
> > offsetof() and container_of().
> >
> > The result is this: if MINALIGN < sizeof(long) and since struct is unpacked the
> > offsetof(), and thus container_of(), gives correct result, while ALIGN()
> > approach mistakenly moves pointer too back.
>
> ...
>
> > I think you need to change this to use container_of() and offsetof().
>
> To be clear, there is probably no real problem, except unlikely possible
> MINALIGN=4 on 64-bit arch, but for sake of the correctness.
>

Thanks for taking the time to check it. I'll switch to container_of()
for (hopefully) the last iteration.

Bart
