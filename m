Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4324D10E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHUI7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgHUI7c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Aug 2020 04:59:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4CC061386
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2020 01:59:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so1040530iom.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2020 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0dxk+YAxU8AGUSVq8I4mdsBmmP3C22pS73+np6hl8U=;
        b=b0Bt5iIIABnBan/+FeypOshmjGN854M+FsnCjPSB93/mARJJbae1tfhKhTDKAlf2BR
         Y7V/EMRRZM3S46/1jcqWMfs0rPEgDZtGqEh73v8jpk7FtOQPS1dFWBmqVSOX80ViseRC
         SiCFTiG51XfWRxXOtBQJsbYTiFR+9F1f9Jqtvplv70dGOLyeV8/dhXJzKE+NGg1HLIeA
         LTT3UyGc7NsCj4q9UJZQ06pEqgUB/U7MFLwRem15MZWKMDsD9fEoWQ/tLJ5oOMug6h9a
         5lWN55kd3V3bhFSEpm1JtDWp06QM+D4jagJI4NesOy8gYfIBy+LZkJ1oWuKJ1TAF6DLF
         k7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0dxk+YAxU8AGUSVq8I4mdsBmmP3C22pS73+np6hl8U=;
        b=JhYoXPoTNmoix57c97LAiDcbVF5K6o0Stua8mEiz8R9kfmOEmNwjmy3gTiC7u7ch2G
         kXJUlt/aEbOKUtcv7vuh90Ky4g9zjNPHwSPMdVPmZ09roc6zgv4UL1/UxVtpotim+N8J
         ToR4rZgLcmo+rmh2nF6DkN1+ZzN/4l7lIPrNftFkbI6jJPtl4RUWuhl6OCb5ezJKiq9d
         o01DjId0mgKOejQAMB+pqpAUHuEH+t39hUQUXsC3b3P/gZQHD5jxXy+NDx8gXcfSYNz9
         40cuWYWixByP6T0TgfzbxM6V7Z4Jv2BZ+yH5ehb7QJdxcLe5yCeR7PY7814YTniVqMYp
         Favg==
X-Gm-Message-State: AOAM533xqLlcfsLGYmGT09MwUd+NnDMuyF8LuPlMCc74Xu5mA/1hXBnl
        s/St94hZozN5KyaegWw45Qh2G9Nv+UjaZxXpT8FtBQ==
X-Google-Smtp-Source: ABdhPJxZMDfLVTuLtK0UKeNOHbpwzyh/MLQSbRYHKv4AYJ0os+C4fhkoB2hzOWyUFbN60IpBxRqSGZ3GGupzW5LQIWA=
X-Received: by 2002:a5e:8f06:: with SMTP id c6mr1548343iok.119.1598000370739;
 Fri, 21 Aug 2020 01:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200820185110.17828-1-brgl@bgdev.pl> <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com>
In-Reply-To: <20200821081555.GG1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 21 Aug 2020 10:59:19 +0200
Message-ID: <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 10:35 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the managed variant of krealloc(). This function works with
> > all memory allocated by devm_kmalloc() (or devres functions using it
> > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> >
> > Managed realloc'ed chunks can be manually released with devm_kfree().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > +static struct devres *to_devres(void *data)
> > +{
> > +     return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > +}
> > +
> > +static size_t devres_data_size(size_t total_size)
> > +{
> > +     return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > +}
>
> I'm fine with above, but here is a side note, perhaps
>
>         offsetof(struct devres, data)
>
> will be more practical (no duplication of alignment and hence slightly better
> maintenance)? (Note, I didn't check if it provides the correct result)
>

Hi Andy,

The data pointer in struct devres is defined as:

    u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];

And this value (assigned the value of ARCH_DMA_MINALIGN) varies from
one arch to another. I wasn't really sure if offsetof() would work for
every case so I went with something very explicit.

> Another side note: do we have existing users of these helpers?
>

Which ones? Because I assume you're not referring to the ones I'm
adding in this patch. :)

Bart
