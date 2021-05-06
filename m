Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F971374F82
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhEFGqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 02:46:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D756C061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 23:45:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z24so3920036ioj.7
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPwA+pUxe79+WQPVdZxPpEh84lqVi7q97k1NDQzFuzs=;
        b=RLjCJgLyQHqQH2C+vPZa9nxIpgjkjT9xO7Se+ewRfoCQAUzksmQKqmIWJcSOPAe6ga
         UJNgpk4SiK4xtlMwI00s2ZYAHuScayIlZX+r0Qv303MS/gaDp39HkXuQkxD08JdJgg5v
         CtpU/MAd27/QHDaQ6opK20ff9Nm+xphV/xZNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPwA+pUxe79+WQPVdZxPpEh84lqVi7q97k1NDQzFuzs=;
        b=DXbQlMdPvml+hsUJEpZYBvtVqesyksvgBsTv1LFpwIFaI3W4qvCT/BduTJ/kNHAKWT
         Z7dSIt/eTAk6htcvYD6xBIb2jvrIxnLKJrxgjzuEOos8byL7m437QQftYNONFqc43jic
         TTh0L2lE0s/oZXmTC4OmiPsuw5UEuNdrPfsEIkudS5ViEWATHI7gg9kv1GqCsUYzDkNi
         Dmj9VMmV43TAwa4fiB82F+sfLDLw9rjTPfguw8mV0o0TYDfz8MU51Erws9bN6YsHUi2s
         YO3CiAO3cFnNq/vrm7KHV9BZ8bWTd7BRMLasLG9sQZNGYJ3rZElP0i28EyuV+yMZie/x
         N9Sw==
X-Gm-Message-State: AOAM531e6w9vKlEJBxbl7bf8NnYi091R90uigvR/VjTEeLrWNCRdHgHq
        nklr20Ni8vsMtrgOkd/pPSGQTOnE7ejX7TsBXm/XsOM+24Cds99F
X-Google-Smtp-Source: ABdhPJyQ0UWC8ADmiWDuQzMbbvgrn/ms3XHw+fGJlBXvrdW0wCAfC1VB6Ia9JAdfwBN7qd6hI7K2h4hLvpYTCLv4m8k=
X-Received: by 2002:a6b:cdc6:: with SMTP id d189mr1915332iog.46.1620283505109;
 Wed, 05 May 2021 23:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210501171352.512953-1-jic23@kernel.org> <20210501171352.512953-6-jic23@kernel.org>
In-Reply-To: <20210501171352.512953-6-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 5 May 2021 23:44:54 -0700
Message-ID: <CAJCx=gnHaX2rWVm5WS9C5j0pSdioK344Ji+s39V8=SxLEL-+gw@mail.gmail.com>
Subject: Re: [PATCH 05/11] iio: chemical: atlas: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Variable location for the timestamp, so just use __aligned(8)
> to ensure it is always possible to naturally align it.
>
> Found during an audit of all calls of uses of
> iio_push_to_buffers_with_timestamp()
>
> Fixes tag is not accurate, but it will need manual backporting beyond
> that point if anyone cares.
>
> Fixes: 0d15190f53b4 ("iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 56ba6c82b501..6795722c68b2 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -91,8 +91,8 @@ struct atlas_data {
>         struct regmap *regmap;
>         struct irq_work work;
>         unsigned int interrupt_enabled;
> -
> -       __be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
> +       /* 96-bit data + 32-bit pad + 64-bit timestamp */
> +       __be32 buffer[6] __aligned(8);
>  };
>
>  static const struct regmap_config atlas_regmap_config = {
> --
> 2.31.1
>
