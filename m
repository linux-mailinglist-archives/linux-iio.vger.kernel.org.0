Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEE420653
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhJDHDk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhJDHDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 03:03:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98544C061786
        for <linux-iio@vger.kernel.org>; Mon,  4 Oct 2021 00:01:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so3788084pjb.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Oct 2021 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2R1T5U6/uHY+8pKMoQy3OzRqK34U35t+1699pbIbV4=;
        b=puRRAMmjylrU//x0dsIJYKYiMkCB1ZoFSHUnIDMbu9wxFaPiAooDKI4vwkkuL4q2oB
         uO5irz815xDd1aEuEW5KLnW9jzaPi1XOzc0SE1qMtb68wqGvuDYCEyd647ncggiL/Kix
         lNBOKJHs9+v8lQa+fFkPn2BgsjLdJi0EpkMtEPROX9rcGQzahe7Xcc4RpJ6dIZi4BJPi
         ypeEdIXVQQEQHnBovAwvs1rwngGwhrbUTzrGNDmsEUQxCOFjDmNfwb7aJqUxPzmNOtGk
         9142x6cdgBh3oqacAeEJgxYuYf3IkTiDkufUNv3nzivaEzeiRagkFDhzyRmTfSqNzXcL
         wwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2R1T5U6/uHY+8pKMoQy3OzRqK34U35t+1699pbIbV4=;
        b=b+f2W8st9gsxCR5ZwlBdXpJXb0I76aaQyTxu6N+V/o9B62oQOo/E329H/KparRkmaJ
         e8wtbdjQtqa++7t9J1ta5LEA+DtEvH+dxyLM9bGKsM+oCbAr8lsUXmqzHYBqtQalwebD
         F3TPaLDiMP1oRC7YsDoC6dHSCPj7vgbmBtT5d5nFk/6nLhfC4WuU9tbTCHKJSoJar34b
         +wJb5D6K8StduxZqBPnabr+LJumyZeYGvATl0P27L8dbCAVa8DA6IlXsrODj5c+/ZT6W
         Ruz4cHUUmFV4AAfPe2fvatn2xkaoaanFy+3f9WnAKPX4pByec2YzqyN5P03weV+LXpFq
         F0Eg==
X-Gm-Message-State: AOAM5334rmv4wTeTKLt9RNhueq6LIlHmgIi5w53Wb+TuabUk08WD42io
        0iVZdP580lLBawrejEjH5a7gSARqRdCdECivYKRBe0++qhw=
X-Google-Smtp-Source: ABdhPJwucWHyiv4ISMxQ9ftUiEZ+CNelopYyEiml5AP/Y/q+s0w4RGbIQ7pHJlK0RIIOSG5OpsPAOYOHlQXoTB6pNk0=
X-Received: by 2002:a17:902:b490:b0:13d:588b:d857 with SMTP id
 y16-20020a170902b49000b0013d588bd857mr22812030plr.16.1633330909005; Mon, 04
 Oct 2021 00:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211003150200.391320-1-jic23@kernel.org>
In-Reply-To: <20211003150200.391320-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 4 Oct 2021 10:01:37 +0300
Message-ID: <CA+U=DsoECgdGv+pTut9Ts9yxfao-3uVYbORUosN62rzLw4H6aw@mail.gmail.com>
Subject: Re: [PATCH] iio: Move include/linux/iio-opaque.h to drivers/iio/iio_opaque.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 3, 2021 at 5:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This header is only intended for use within IIO core modules so move
> it to an appropriate location.  Also rename to bring it inline with
> other IIO core only headers.
>

Should we merge this into drivers/iio/iio_core.h ?

Either way:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> Cc: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>
> I'm not sure if there was a strong reason this file was in
> include/linux/iio before?

No strong reason.
I guess mostly inertial.
I was looking at the "./include/linux/iio/buffer_impl.h" and went
along with the same include/linux/iio path.
I was also thinking that maybe some older non-upstream IIO drivers
would prefer the "include/linux/iio" path, but that's still not a
great reason to put it there.

There is "drivers/iio/iio_core.h" which seemed like a minimal include
to be shared between the core, buffer and trigger IIO files.
Maybe it makes sense to merge "drivers/iio/iio_core.h" & iio-opaque.h ?

Especially since:

drivers/iio/industrialio-buffer.c:#include <linux/iio/iio-opaque.h>
drivers/iio/industrialio-core.c:#include <linux/iio/iio-opaque.h>
drivers/iio/industrialio-event.c:#include <linux/iio/iio-opaque.h>
drivers/iio/industrialio-trigger.c:#include <linux/iio/iio-opaque.h>
drivers/iio/inkern.c:#include <linux/iio/iio-opaque.h>


>
>
>  include/linux/iio/iio-opaque.h => drivers/iio/iio_opaque.h | 0
>  drivers/iio/industrialio-buffer.c                          | 2 +-
>  drivers/iio/industrialio-core.c                            | 2 +-
>  drivers/iio/industrialio-event.c                           | 2 +-
>  drivers/iio/industrialio-trigger.c                         | 2 +-
>  drivers/iio/inkern.c                                       | 2 +-
>  6 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/iio/iio-opaque.h b/drivers/iio/iio_opaque.h
> similarity index 100%
> rename from include/linux/iio/iio-opaque.h
> rename to drivers/iio/iio_opaque.h
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..ed7a5c0a31e1 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -21,9 +21,9 @@
>  #include <linux/sched/signal.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> +#include "iio_opaque.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dbb37e09b8c..6afa70c89c80 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -25,9 +25,9 @@
>  #include <linux/debugfs.h>
>  #include <linux/mutex.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> +#include "iio_opaque.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/buffer.h>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index d0732eac0f0a..1d49714d9832 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -18,8 +18,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
> +#include "iio_opaque.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b23caa2f2aa1..e4e59466a263 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -13,10 +13,10 @@
>  #include <linux/slab.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/iio-opaque.h>
>  #include <linux/iio/trigger.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> +#include "iio_opaque.h"
>  #include <linux/iio/trigger_consumer.h>
>
>  /* RFC - Question of approach
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 0222885b334c..72c130d9fecb 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -10,8 +10,8 @@
>  #include <linux/of.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
> +#include "iio_opaque.h"
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
>  #include <linux/iio/consumer.h>
> --
> 2.33.0
>
