Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DB1A6097
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgDLU7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgDLU7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 16:59:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E396C0A88B5
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 13:59:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o1so2213261pjs.4
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYUpqWyzt2mwnp2ikU5H5KVYIrDK4261Ybf6ta2ml0A=;
        b=gmUxQDTGEeUz2KWhPjmmuD+RIFaPOMuE/D+vy06y3LlXrGNMPN7G3tcBoOtD40B0US
         tv3bz33IvHiZIqQdqco0ZcOuAZ9AkQRNBigmmo8alNegm2yalRpnUkRerTT0mrQWsQE7
         QJ4c6s9IDQfvYWm0spNAzEn1htpnedaJCuSR8FMnpUq5RHbQNkFqUfhKww2SLrDjCQA5
         1UczIKtk0ymqRlpxaangzfPQ6kfDNrdlWd0seTCvC3uPoD5yzpQCnq6EoKkonVniQ1c4
         4lTui+yUCw8Vhh/xm1a/AcTubjrkWMrOLBBs8PwFX8dcMX6ksiJ9kuEo7zKkhk1tU3Xc
         wfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYUpqWyzt2mwnp2ikU5H5KVYIrDK4261Ybf6ta2ml0A=;
        b=e3vzczl+totMzsfFoVhYTM5sOuj02aNaPFLH/0w5aX0e1TrOoo9nLWZMYvImDWp8yt
         Se0wC3OlYgk80XhZ2RyfpOIbAlbIqpnvU+KkQZCOjys3v6cQzq/R5tYwU0furRaMxumR
         f9+xYHxn/KwKDdOG/vsxYzfLjCyaYzxdquMaX2ZolaDMsoZ4ncMhrqFMhCC8zRujzOX5
         OFqhm0pDyy7oKC9QUYt0BbtO7SYsvQ+0GOxFgJ0uKwVms9ko5t9nMcXzFT8/w/Uw+bi2
         jgYNjEb5wauhFQJXu+BpbSZkxGTeGukYPojiV5ARN5yCNjdhmgh55RUSJxzJziR358YK
         ys7g==
X-Gm-Message-State: AGi0PuazyJE9ADKVtyNiNYeN8yCxMMigcfbp9eMwsmt3Cs0lbE6owHCI
        I59NCpYPzb+4Lst1XBENYo+5G+5zlgHn6d5ER8zYJd/mRBk=
X-Google-Smtp-Source: APiQypK4rb02NTbd0nfXbqoEY5q6IXWLwfWuE04jnw+jHUlk2aq5O95DRQ5viTNHtXSZKVFAowtc3ww43m37R0uq8fA=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr18427707pjy.1.1586725171456;
 Sun, 12 Apr 2020 13:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200405180321.1737310-1-jic23@kernel.org> <20200412144812.1c65e88a@archlinux>
In-Reply-To: <20200412144812.1c65e88a@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 12 Apr 2020 23:59:20 +0300
Message-ID: <CAHp75Vc87TNTx-jVS-YmFcxVe3Y0FfxWZsFT2SpuMM8dsfdxMA@mail.gmail.com>
Subject: Re: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 12, 2020 at 4:48 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> If anyone is bored and fancies sanity checking the ones in this series
> that have had no eyes on them yet, it would be much appreciated!


The series makes sense to me. Feel free to add my Rb tag to it if you like.

> On Sun,  5 Apr 2020 19:03:15 +0100
> jic23@kernel.org wrote:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of Andy Shevchenko's recent patches tidied a case of this up
> > and a quick grep showed we had some more.
> >
> > The main focus of this set is calls to regmap_bulk_read /
> > regmap_bulk_write.  Both are used with buffers of many and varied type,
> > but as they take a void * there is never any need to cast a pointer
> > to said buffers to anything explicitly.
> >
> > Whilst I was here I used sizeof(buf) in various places to reduce
> > the use of explicit values when we could derive it from the source
> > / destination buffer.
> >
> > This isn't remotely urgent, but I'd like to clean these out to avoid
> > replication in future.  Not I didn't go after any other unnecessary
> > casts in the files because that would have take thought and its Sunday
> > evening and about time for a beer.
> >
> > Jonathan Cameron (6):
> >   iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read
> >     calls
> >   iio:chemical:atlas-sensor: Drop unnecessary explicit casts in
> >     regmap_bulk_read calls
> >   iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
> >   iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
> >   iio:magn:mmc35240: Drop unnecessary casts of val parameter in
> >     regmap_bulk*
> >   iio:light:ltr501: Drop unnecessary cast of parameter in
> >     regmap_bulk_read
> >
> >  drivers/iio/accel/mxc4005.c                |  4 +--
> >  drivers/iio/chemical/atlas-sensor.c        |  7 ++---
> >  drivers/iio/chemical/bme680_core.c         | 36 +++++++++++++---------
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  4 +--
> >  drivers/iio/light/ltr501.c                 |  2 +-
> >  drivers/iio/magnetometer/mmc35240.c        |  4 +--
> >  6 files changed, 32 insertions(+), 25 deletions(-)
> >
>


-- 
With Best Regards,
Andy Shevchenko
