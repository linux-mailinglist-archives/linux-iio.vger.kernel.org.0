Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7835C197
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhDLJbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 05:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbhDLJZP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 05:25:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D3C06134C;
        Mon, 12 Apr 2021 02:24:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u7so4232408plr.6;
        Mon, 12 Apr 2021 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIGQO9nYpsI/HgMjEptp4zz4oGeZWu2/3SsVEhd+9po=;
        b=ZFWAhZimDycszC+pOXKzjXZ0blVkeVP3qf/F01akrbzIiOnX6SIOZmIVg54q2UnUvp
         mHjaXffYXxr+9otijaD24X/2532BlkA/BOa06jAD4Rcl3WRmD5Mw8ARzBvS0l+DE9byV
         aEj1IVlKcPtXJOp5zKfBku6Vf6Tpo4753EAQ906IDdKs5o7ne5JJf6EGAWZnvbXE4IEv
         39a/pcDQ+Smd3leerNckwtVPDXqsNnqfOKNT4elFI0UEY9Y8m2SFGG+Pd8xNuuXM7xBe
         J2BtzQM+lFX4Yzk0VLVKB9tikbERvHgzSmIRCLpAksIfHEQyn6crhVy2KADF9dW6c+Gj
         cg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIGQO9nYpsI/HgMjEptp4zz4oGeZWu2/3SsVEhd+9po=;
        b=hSwTiHfnPspGsJ7VjSQmEIHQJOq6xXvvkBuhhs1LIfU29YoR++uWsb+ioHBFMqZpFm
         7DGkpO01D2JH7HCGd7JlDuUb2+ruCDb2GHWdA49Ehskb8xIjF3CUhD1oQVPwrF7QKXp9
         J49Hml6Lwh/5ezTa14EvtUfUUOnTDJc2XQQIdkdhSeu8HxD1ErxxaMUGgBb+76YHIKlZ
         2wfGhW5rmRRHe/BbCkKKmrt9NO1/OqPz80CTYZQT2KRyw2xj9u62MsLUrh5qTdLhA05E
         uqzUiLbs5L6zUJccaIbM0CjuxrHmajUuhNIMsVGcGDdS/mre7gbml9rjKiidDK5wmnNd
         jxLw==
X-Gm-Message-State: AOAM531JB2k/6OVUA9PgXgtZSgridzfDYb/00d0VexfeRfIbbXT9e987
        EHF9TRUYrSUyztJpU2BbbZIy56Dag1cJ07ur2O2Ic8v7N/E=
X-Google-Smtp-Source: ABdhPJz1pBrpFo/vAqpBjDCsf8p0x7DUOAC1VTRX9FBLoB7jXKvOJypbiHnRm6FRziX1XdaGcPJlfC9ViR5tJwJ9PV4=
X-Received: by 2002:a17:90b:1e0a:: with SMTP id pg10mr28396882pjb.129.1618219439594;
 Mon, 12 Apr 2021 02:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210412053204.4889-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210412053204.4889-1-dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 12:23:43 +0300
Message-ID: <CAHp75Vch8zrFmRQNkXE1HopPN_JBsNYfuRDpPN-W0m74OE7fhQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] iio: proximity: pulsedlight: Fix rumtime PM
 imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 12, 2021 at 8:32 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When lidar_write_control() fails, a pairing PM usage counter
> decrement is needed to keep the counter balanced.

You forgot to collect given tags.

> Fixes: 4ac4e086fd8c5 ("iio: pulsedlight-lidar-lite: add runtime PM")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: - Add the fix tag.
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index c685f10b5ae4..cc206bfa09c7 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -160,6 +160,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>         if (ret < 0) {
>                 dev_err(&client->dev, "cannot send start measurement command");
> +               pm_runtime_put_noidle(&client->dev);
>                 return ret;
>         }
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
