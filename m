Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254C73708B1
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhEATKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEATKj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:10:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA54C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:09:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so3503283pjz.0
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0nouzsd7CfE/HtbUQtxEPnk17JhCB6+zlKQ9B+jeV4=;
        b=Un/Oh7334EUln8UJK/sM4/bJ1KCAkhr+bWRAYmMVXtG33lDE2BK/92NNMwU2k/HEMt
         bjb4BDVASn2sIp/lJ54+gO3ZavsJv51ZD6Al6rx7uUBWN4nvFjwHOQh+E8oQZhGVWLWR
         OPwtR3uzNpJp7ZUEsgTlYyMNlYL146Ym+jCXjpnZEoEQy1MVsBv1hstLzxFsro7EQZiC
         jIw0Zki21k3WIOB/JQa8nmZEzYpzofZB/ixNjUPz77TOW9Nl3PWOQkEqyNcsVygL5o+7
         zNm2Uo1dNX5uc4lMl3c4+wpk8SYjQYkDyMLwkHejIHU592AtdokML2vygnhET9go2NP1
         oyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0nouzsd7CfE/HtbUQtxEPnk17JhCB6+zlKQ9B+jeV4=;
        b=nqRlxRIkJCdBUIWzjUfZC13izhccTLmadaGUrseqMjS8n4+24a1gVz19F5/kvpomRx
         wDzfdgCsWmO9ipZuW4kX/PvTeTEBOP1tXeSyAqlnGmahbKsrUOXtJc33UCKLKkKjpRGn
         0FY8QEAGrowHgaFS/M11zK8E0qGuKKW/7PN9QpcaNMWlZFSlHuxB2/7X0xf4RzP0AlHD
         n6ZTWVAH0yeZWh2FQxBR97O2tTJ8CxPUiK7q5uRetOF/Lh/n+bULAc4sThdJmfRZH6WQ
         cWqstGd43SXFXKkVTKpDnSxvoAtgoMClMcYR+rNGlIwb+Re8coOsCT710P8v185Fp6tK
         0tfQ==
X-Gm-Message-State: AOAM533DOyRw/SK26iLWM78PoOjSxcydJvcJeCWRWge8IBCwFmmZI6jU
        ccWjLkCKLQ5xbGpASsYrpP7yXapt0PdLtKNFx8e6B4fv1CbBQA==
X-Google-Smtp-Source: ABdhPJyK6Kb5ie12x5+9v/KfaGEI2VKVexRXgVnGZGK/rL0JFBxi7wJZtnm25kzjQAcS1ovzc9S2xMBeKQS9+64wp3E=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr11750137plc.0.1619896188778; Sat, 01 May
 2021 12:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org> <20210501170121.512209-20-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-20-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:09:32 +0300
Message-ID: <CAHp75VeDefx25avQSBE0qHbid=wjU=Tof-v1SzUU18BfTbyvmQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] iio: light: tcs3472: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 8:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
>
> Found during an audit of all calls of uses of
> iio_push_to_buffers_with_timestamp()

Missed period at the end of the line.

> Fixes tag is not strictly accurate as prior to that patch there was
> potentially an unaligned write.  However, any backport past there will
> need to be done manually.
>
> Fixes: 0624bf847dd0 ("iio:tcs3472: Use iio_push_to_buffers_with_timestamp()")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/light/tcs3472.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index a0dc447aeb68..90dc3fef59e6 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -64,7 +64,11 @@ struct tcs3472_data {
>         u8 control;
>         u8 atime;
>         u8 apers;
> -       u16 buffer[8]; /* 4 16-bit channels + 64-bit timestamp */
> +       /* Ensure timestamp is naturally aligned */
> +       struct {
> +               u16 chans[4];
> +               s64 timestamp __aligned(8);
> +       } scan;
>  };
>
>  static const struct iio_event_spec tcs3472_events[] = {
> @@ -386,10 +390,10 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>                 if (ret < 0)
>                         goto done;
>
> -               data->buffer[j++] = ret;
> +               data->scan.chans[j++] = ret;
>         }
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>                 iio_get_time_ns(indio_dev));
>
>  done:
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
