Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E604368DF0
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHdb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHdb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:33:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E49C061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:32:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w6so18991869pfc.8
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7o/J49XnttM3C7JtSbDdwuykDnVIXLGSUqWKPIFokg=;
        b=QajwIcWvDKTo6VUgurUTGs5oRJsxFhcBH3KDDxVMspyXqAlo4SXaJ8nDoauD9ybuc+
         OlxK4Nn5TDTGWQJvDkQRmrIFZVR4NfdGaw6ffKv8NYtxZxaBKiHPyDKonQ5z/JhZZc1m
         5UdbPvF2mi4ZkS+NY1JM528P/tMwB5BQL1zd4AmrLBN/j69Mz49cm+2fKgqXZpIDkbKN
         XWb9A8vT9zHtXiNEv4weV9IX8eadSc3ju1Vgdq+djeS0aZPvIuyqt6ECeZI/gjiOPLdg
         s/5yY792CoxYsEVRZVjksQwtVIQPPreBFgVsS4BKKO1YqDbJsuD/fYH1nPRex52fnH7Y
         S0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7o/J49XnttM3C7JtSbDdwuykDnVIXLGSUqWKPIFokg=;
        b=VsGMWVn2yGY2wwqJlZFOpoyNXMRWFO2HsFhe3BXGifFPS1zEdu0rXIEdMuNDLwQM/3
         XNlFvIAbQ1stEHrjAX5VORj+3Sy49wXxac09klYsqLzPmfFXRDiAbLDXoJi+p4bu7ta6
         iGa764OWqEJ9uYuHryfVs21vcq9FlbLhMVMz8r5JcEbYyWEvtHoUre6gqafm6QJ9fN0Z
         fHo9rnJ0JgQUsJsX+oceujLRdEwUUJpYTZfLnaVvU4lSoIsTEvA/z3l1TrQ6cqGtC/qU
         pfbFZySzt5rBZiD7cqR1lO68OCIKqGEzKBh/7+z4Kk1zLWKx7nZVknU6dl+KHTBCfGgG
         LblQ==
X-Gm-Message-State: AOAM531qKXGp0cbb31fXRrboX5tE62JXpiFy2lZqYliTW+tofA+599r/
        yTHsm/DLqHEMLgWLZxeAgkUvHrcoVm45gdOXXux/cSrJWZ5IAT7P
X-Google-Smtp-Source: ABdhPJysEisGMBX8H6L7SpY4hAnhK8tduVQ/cVAxPLtDku/gmcRQeEf2NjQoKgzWyyrTApRcTudQVX1FCxMbTYlr9CY=
X-Received: by 2002:a05:6a00:22d6:b029:246:6209:b483 with SMTP id
 f22-20020a056a0022d6b02902466209b483mr2759426pfj.58.1619163173443; Fri, 23
 Apr 2021 00:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-7-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-7-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:32:42 +0300
Message-ID: <CA+U=Dsphpu97Et6sgjd+9TUEHTw7xq44M5yL=CFtuCEU9QLxQQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] iio: adis_buffer: update device page after
 changing it
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> With commit 58ca347b9b24 ("iio: adis_buffer: don't push data to buffers on
> failure"), we return if 'spi_sync()' fails which would leave
> 'adis->current_page' in an incoherent state. Hence, set this variable
> right after we change the device page.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index a29d22f657ce..dda367071980 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -140,6 +140,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                                 mutex_unlock(&adis->state_lock);
>                                 goto irq_done;
>                         }
> +
> +                       adis->current_page = 0;
>                 }
>         }
>
> @@ -151,10 +153,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                 goto irq_done;
>         }
>
> -       if (adis->data->has_paging) {
> -               adis->current_page = 0;
> +       if (adis->data->has_paging)
>                 mutex_unlock(&adis->state_lock);
> -       }

So, continuing from my comment here [1]:
   https://patchwork.kernel.org/project/linux-iio/patch/20210422101911.135630-6-nuno.sa@analog.com/

This can become more elegant, because this block:
       if (adis->data->has_paging)
                mutex_unlock(&adis->state_lock);

can be moved right after "ret = spi_sync(adis->spi, &adis->msg);"

And then the duplication added in patch [1] can be cleaned up.
So maybe a re-ordering of patches could simplify/remove the added duplication.

>
>         iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
>                 pf->timestamp);
> --
> 2.31.1
>
