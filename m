Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C7356597
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhDGHkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhDGHka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 03:40:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F4C06174A;
        Wed,  7 Apr 2021 00:40:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g10so8891760plt.8;
        Wed, 07 Apr 2021 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0HqwbRDMsL0HeE4ze7Mb/YeGbLkf8kKL2SuI0HMZ0I=;
        b=pI+pq2HJvInbR8Xk9AXXrAqfkRiYR357oaQTkdZoplMzNey3/1al94cvoZwpJiXg8E
         6uQhLi8y60oZaCb9KY/+n0fjH+LbPd360Lo1XOA9H5nC9NphvueeFhk6tlyVHgQAF6uy
         E4qNlrBMBVPKrqKwiFKBaOk/bt7EBC8Um9m2FFEWgEZEgQkEa19Xt3jA5ipQSLbzTNk9
         0iV780FP56NQSjRlH77HHQ3QARf9nQKWw2yIC2lpeJsgbUHfWMk82TB9c4JLfTREdRtj
         UbkgxinAOiqVmhUDrmzx/DdGwsol8hhpAPNLi8Lo8bZKTkYnnYd4w6BqPuQNjzp/DSCD
         3/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0HqwbRDMsL0HeE4ze7Mb/YeGbLkf8kKL2SuI0HMZ0I=;
        b=fVbVPkrqUOJWvqzChfnFPXOZloLhzdk8kiHyTRDjHAjJdZ0wxhe6w/tSjdvFoRu21z
         SCecuRO0TcW4KDvd3fszGbhw0BjAJFKjo4v8+dHCmo4K8yYm9QiFu2R4sH/eJNnf5Gk8
         cE5oJlh+xkB8C6TjrfHKQ0JaR7Cd62ByaA8ULjyHm6kp+AYJdMYXd5/kqbiImemz2QRG
         nHP6eYq00D9ezchx9mF1UVBYSMm39rIaN9An59xFba16JNlU3sdLxP/q8pqeCiijx/t8
         MhP8eJu3gpp3NEiY6a0nbSEx1cWjg98VxT3Z2OtEE0eH6kDF5g0QV+/KUiBYGsVQTwh6
         aDLw==
X-Gm-Message-State: AOAM530Oe8L1laLE91NkXr6kpVi2Zmo68y2NHGKSouP9hBRZPPkYHv5j
        DEOwtoRIbKfaJjVu4RjMBKr+E/ICw2WfQ64AOLQHZnXMEPs=
X-Google-Smtp-Source: ABdhPJwLWkfhmDPrGu8OIr1wBENfJbPhlYX7GbkNK6sZYAvZ3941djMcZP4ew06WI+oVhJf2v2DM5+REaao14Wy/Jtk=
X-Received: by 2002:a17:90b:1e0a:: with SMTP id pg10mr1419277pjb.129.1617781219051;
 Wed, 07 Apr 2021 00:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210407045938.29129-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210407045938.29129-1-dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 10:40:02 +0300
Message-ID: <CAHp75VeH08V8UUDmPx=XrA98cvMnQXyF3Qe+5+mrTBe4C=1MFQ@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: pulsedlight: Fix rumtime PM imbalance on error
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

On Wed, Apr 7, 2021 at 7:59 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When lidar_write_control() fails, a pairing PM usage counter
> decrement is needed to keep the counter balanced.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
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
