Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BEC3820B9
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhEPUC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEPUC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 16:02:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C3C061573
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:01:41 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o21so3816592iow.13
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eq+3WkrZcY+ntCx2YjLGz7HOWItUGDeMkn+2AEt/wwc=;
        b=O9fr9KibgBNI460G/izIMIeo3/YqrHN3FiWeVNnQ/2RTvctuNko/Aa4EfANM/qX6C4
         XTejyApcxXhdnOIcYag1pjglBK4aTa/qrkyk2PUdbQViy/WsmzWf5oxfaV1p4HnebIsZ
         +nwjpVBXNJmZsV51O0OmqAxjrGouOAAnPO1ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq+3WkrZcY+ntCx2YjLGz7HOWItUGDeMkn+2AEt/wwc=;
        b=q59jkO1RB8GGgvM9f60G7O8pdddZ1X7PkmKbXTTL33RAjq6yTjnYHT3DHMRysGfhCz
         t3Hf9gf1gTPShEqwIBdXqRyawP3RI8YrII3DF6gZRf9dmebVOvBUTIfjSpnlOvdcs2Pc
         CtS/Uqj1PzYImUKPFLJ9FfSOlzv1fclvSGGzFdqjQGvuQg4jPafi9f3LXPrCICXnNoK+
         UEgacVCATLpdGM/Z99S67sK+vQdEfxJQ2Bo4r7x5GgXWz4qeurspiNP+zhx07ilBKxmK
         KyXgQk0IBE2jCrdHccsb6oHFZoYAvrdBGZ3ffBkyT5q8i7D11T6bqnRNRmnyhTh/vXVX
         Iwaw==
X-Gm-Message-State: AOAM530PN00Obve58HhuCURs3NWaPLs/Ws1thEzkt8fDd39hJrGdOYeJ
        GEKn0bZ6be6QEc3w9m0QKa62LUDUmqt8V+ca6PHugw==
X-Google-Smtp-Source: ABdhPJyUW/zSjxzhUzyOVKZfZST28FXLjgQmzqomtS5lg5ra2q2R4yIJg1+JIJMJR1F7NNV40roEtYRcDoB7hg8JQB0=
X-Received: by 2002:a5e:a619:: with SMTP id q25mr38471503ioi.95.1621195300761;
 Sun, 16 May 2021 13:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210516162103.1332291-1-jic23@kernel.org> <20210516162103.1332291-6-jic23@kernel.org>
In-Reply-To: <20210516162103.1332291-6-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 May 2021 13:01:29 -0700
Message-ID: <CAJCx=gncAzH-4HSgTzbzEJ5FYbjXUQW96JqBwmO=4Lx4+SLeEw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] iio: prox: pulsed-light-v2: Use pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 16, 2021 at 9:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using this new call makes it easy to handle any errors as a result
> of runtime resume as it exits without leaving the reference count
> elevated.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index ecaeb1e11007..e94f63932edb 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -158,7 +158,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>         int tries = 10;
>         int ret;
>
> -       pm_runtime_get_sync(&client->dev);
> +       ret = pm_runtime_resume_and_get(&client->dev);
> +       if (ret < 0)
> +               return ret;
>
>         /* start sample */
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> --
> 2.31.1
>
