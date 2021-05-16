Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDC3820B4
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEPUAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEPUAf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 16:00:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF72C061573
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 12:59:19 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o10so3276646ilm.13
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvqkeEA3fOzeabXPBUw35KLASiLPBm77dN3zWPTMi9U=;
        b=mAtLb4yFFNNnQrl3A0JsuHvVDWY2vky9q3qeG8MHmzz1J/kgKX9B4HptRogKTLxwHm
         +Ej4GE6cUJDSnok0Bb3ump0lOaA2m2zouhaQ46balezU/2pcGlOeuNFtv6Y0zWEckzIn
         4gcQ33lZA74e7IifuZOpPXJ6yv3B9A0A8fTKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvqkeEA3fOzeabXPBUw35KLASiLPBm77dN3zWPTMi9U=;
        b=N24DO8tc9nb34QiOK6pvVZACN/yzzOlVRm9mVgvYO38In8jjGSVgEpNJ79p7mQkHgH
         2mQN28/DCxwTrBXsEWMIZH5n/Rh59UFG3p29OF8ySaMsoUlauWys+E592y8ZwrhE18Vr
         3EbCGphKurkXwp8zAZ9RywpTjkrpTp4C24NJhqICzqeEVLHdt6iJRAMESEYpFKqWc0Mm
         nTNnkIynnS7qZiMJgd8/t/4QdlUsOy0L3RJ6tJmbg3pCpiB8p21k7TYIPzsrTn16+8rx
         weqGl0uUpxWmtuIH+/T5ma9xkPur6mnlI3VQZMqLDuQ26upLn5EpGsqydgJ+BPua3xqV
         yZvw==
X-Gm-Message-State: AOAM531oIk/sSZr/165VRaJwZ/8s4kxNuUW6xdsIjHGS8WVJf3lSdFX1
        2g5EgUxYg6kYV4xvhqfIiGHdLCgtUBFUZcW/s/aGeQ==
X-Google-Smtp-Source: ABdhPJzxr4/g4t/FfkyCOyt7ZZPpR0qDTqL+weAqpkrGA0jpvE5FooqnQm7dBqcc06YcLywbbbuu+sRJEjwr2D18zIE=
X-Received: by 2002:a05:6e02:eac:: with SMTP id u12mr50533796ilj.177.1621195158799;
 Sun, 16 May 2021 12:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210516162103.1332291-1-jic23@kernel.org> <20210516162103.1332291-5-jic23@kernel.org>
In-Reply-To: <20210516162103.1332291-5-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 May 2021 12:59:07 -0700
Message-ID: <CAJCx=gnr0tNToRwuptgymQydzaNd4PV81aiUpKemLhxN07ptqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: prox: pulsed-light-v2: Fix misbalance runtime
 pm in error path
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
> There is one path in which we don't do a runtime pm put and so
> leave the device enabled for ever more.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 822a68ae5e03..ecaeb1e11007 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -164,7 +164,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>         if (ret < 0) {
>                 dev_err(&client->dev, "cannot send start measurement command");
> -               return ret;
> +               goto err;
>         }
>
>         while (tries--) {
> @@ -188,6 +188,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>                 }
>                 ret = -EIO;
>         }
> +err:
>         pm_runtime_mark_last_busy(&client->dev);
>         pm_runtime_put_autosuspend(&client->dev);
>
> --
> 2.31.1
>
