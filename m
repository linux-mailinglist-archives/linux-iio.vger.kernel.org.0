Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7E22AEC1
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWMNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWMNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 08:13:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76AC0619DC
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:13:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so2977609pjb.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDChTUfKKMMljgC4KF9E0R5fRz5ryuzKJToQcpcZpZE=;
        b=mcupAthSAa16bd02T8RdFu6Ec34uML4noqpSVnIn3ztzqUbFB28L+OmiIdN5E+RYac
         4u/Xv7E8hdSyRRQn7bF1dxwY2lGbgmAQs/pRzuHwKNco94AGmoa6fHy5Rq8FSvv9CHNL
         leYBkkTZY81RR79OCyWB2tOiysY/oySBb/9CPTDfYvU3nlUmB3bd0cvC0/DdJiD4+KwZ
         dV5dBE07r/WaGjka6gTaF5AkrCpZc6fvahMlwPY+29kJ3rQX50o8MXfWkjPEmCKTmRut
         DlbnsqOzDzh3yHs0mn4zVZl5kyveqv1kN0gsFXQD37DeWw4GlLXCAvNBLfu+VVmtxVKX
         +VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDChTUfKKMMljgC4KF9E0R5fRz5ryuzKJToQcpcZpZE=;
        b=HyU+sSj42qciGO49FIxOt/2JdKxYBGnaZQh/9lMeqGhoTfkmL5yUR4lOz+kAc+aMFy
         oUCjxetRlyQrN5OyGqdPj4f3sFmAZy9Jn9JhdJf+ou0ziscyhlBUkjfejWnv+iPNgu9o
         fesDbREw4HDCCuzgPWoPy2M4PR9tcKqxDoVyWzmMIkAiUudQV9EMUzfam5w50UbTElat
         aQSMZszWLYc28Olv8dMuYq8QSl3GukgVUhZ9TLLUxBlak16QkxXjaTqOGGF97dfmg//v
         OvDaIFvvATY1PcIj5eZaA5bSyhCUtzXHNYqwM3SeZU1IhWSrT7gRVfZ/BT0UC+m/HVHe
         syfg==
X-Gm-Message-State: AOAM530840JogY/HBxQebYvM5GnP6hFeZOWGaNHgfBE68Nh9LQWGOANf
        1AML05iQtdv7og6xMybno2uc4bQgYIdPqcJOnA0=
X-Google-Smtp-Source: ABdhPJxYK0TEq5sRlygs3pKpYqqom8JQr8v7ykG9hwXeo51Ive6RKvKby+GPpmdKLOZXRJDKebeeOCryZavvdIANJHE=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr104907pjb.181.1595506419078;
 Thu, 23 Jul 2020 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-15-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-15-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jul 2020 15:13:23 +0300
Message-ID: <CAHp75VcUNBfx1MxtXN1qXP0x-CmqoCTKT7JdzKxr8LH_7DNsjw@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] iio:magnetometer:mag3110 Fix alignment and data
 leak issues.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> This data is allocated with kzalloc so no data can leak apart from
> previous readings.
>
> The explicit alignment of ts is not necessary in this case but
> does make the code slightly less fragile so I have included it.
>

I broke my eyes and brain over temp.
At first I thought it was temporary garbage like in the other patch,
but now I'm guessing (looking into the comment) that this is
temperature.
Can we spell it fully?

...

> +               u8 temp;

> -       u8 buffer[16]; /* 3 16-bit channels + 1 byte temp + padding + ts */

> +               data->scan.temp = ret;


-- 
With Best Regards,
Andy Shevchenko
