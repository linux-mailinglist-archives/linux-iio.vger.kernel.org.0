Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B83713B1
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhECKfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhECKfg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 06:35:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA6C06174A
        for <linux-iio@vger.kernel.org>; Mon,  3 May 2021 03:34:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x7-20020a17090a5307b02901589d39576eso904250pjh.0
        for <linux-iio@vger.kernel.org>; Mon, 03 May 2021 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLVZPKBgyVCDdtNAGDOGurpC4ZsRmXnfdtyShpM22ZY=;
        b=mr/JmA1eJmIVCKAf+DiObdrg1jvS5HOaOHVdpmp/8wEdHK88U8Vbhq04E5SvBfIczF
         OUsHP5i5FiyRaneU7VlFNG6t13GLi5N7UyQan3lrxWE59L264k7lFAcUaiYy+KK2Pfyw
         +WN7+z8Qvf1/rMVyHNcEXgzrFTs1GeUtmrTLIPa4tiSKdh+02OKUcE4TEJf0Wt0hmTTF
         1mLvOwIoJz2whhYB3hhMZoO5zfcRvy7PBgBaul0bHruFDljpwpCzAe94b/Qzmc/1QrE6
         QBxfTvlyMjQY1rXpUTRPR/ggz029nhVrSSjgHSpdFmsk5Myaap5UmdXN4MySETePEOl6
         dZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLVZPKBgyVCDdtNAGDOGurpC4ZsRmXnfdtyShpM22ZY=;
        b=hEc/s6XporoIQDLvcoiMh3vuR/XsxcfH12UvTcgxf/zSqBfTlxPk+jUZvJ+fOQfrEm
         Bd8XC/VNKKQWHqKdDN0otcSd01xHugUw8s7qBuEAvLKidCH+lJkZuI/sV1f57MC10GNX
         lFaRZeOh/RoLhlXqzpy5AyZNv4kFsBBZ3K2wOYKlJehsiKNYSTEHokdVDlypNDdKaBUd
         jALfenuGOeHPLj26xncgV50HYgsvGs2mGXuR1Wv244w9YLJma5cfDmTF0ZAkcLQxiV9k
         YwGOn1gKqTnX9hhUdZx6Q5+7F9LTfPN03Uu3aZYII4t6GrB3Z4EhBwFAX9HW6GpEPDqN
         SwNQ==
X-Gm-Message-State: AOAM530bLBF/IgBWqbqXMPW73+5DBAMIiqi0h2cqdv12Piro8ij4yDJe
        biaD0kkEYUyi/L/K97R3vGxdYVA135qC8KJnbpw=
X-Google-Smtp-Source: ABdhPJxwnjgxcTHc/YPqrQfs7FOnMkkciLdNpTSMqT1Sh+xYl92UIPqGtLWJg9s0N7rfxhIcShfHSFloDrUzg/NNVsU=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr15658035pjv.129.1620038082969;
 Mon, 03 May 2021 03:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210501172515.513486-1-jic23@kernel.org> <20210501172515.513486-2-jic23@kernel.org>
 <PH0PR03MB6366C6AB21991C43CDF40B43995C9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210502170849.2f8f7dcb@jic23-huawei> <PH0PR03MB6366F1D06AA32A935718AD99995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <PH0PR03MB63666DF4899946889AF77F95995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB63666DF4899946889AF77F95995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 May 2021 13:34:27 +0300
Message-ID: <CAHp75VfNitg8LArVd52cOnkfW5i+xw3pu+REMthxTvM7AznGFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce iio_push_to_buffers_with_ts_na()
 for non aligned case.
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 3, 2021 at 10:47 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Monday, May 3, 2021 9:15 AM

...

> > Anyways, maybe sticking with realloc, we could just use a more normal
> > pattern like:
> >
> > tmp = devm_realloc(bounce_fuffer, ...);
> > if (!tmp)
> >     error;
> >
> > bounce_buffer = tmp;
> >
>
> I just read your reply to Andy about this and I think you are right... If the
> new allocation fails, the older pointer is still preserved. However, I find
> the above form a bit more readable and straight :)

You beat me up to it.

While devm_realloc() may actually be safer, the pattern is that: we
should not rely on specifics of the custom implementation, it will
really confuse new contributors  or people who may take this as a
"good' (which is not) pattern.



-- 
With Best Regards,
Andy Shevchenko
