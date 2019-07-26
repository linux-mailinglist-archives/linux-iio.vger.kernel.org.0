Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3418176645
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfGZMvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 08:51:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33262 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGZMvm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 08:51:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so40210784oiv.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2019 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvMVXgkYpNN9sZPuxppMuXcoMoKSnEUwXCqI78r7ick=;
        b=TIH72VEwJpwTnsuWC8zz3OaqzRUPMGxpFxy6dYsj38j88Af6eYXPrhYU3vDK71zZIj
         uSKZHqDtlQ6qqNh57BpEnpBsJpDdc90pdEkJLWLyUeosw14uIiEZANxw+3HhOjeDMHNn
         w6De2kMAu5Iyk+tKmj5wBKSauJDf5dg0E5KrgDwKwb721u8CVWXa1NpMvnsp6EYu6cSL
         qfh+NsvPIsu+UOhGfgFUR+6N75jEGBlHyHPyKervAB+TCwrTtl+ifj+YqTaZDQO5F9dO
         O7upC+DFuIYrIvY+CHu0i8DSmUqSu53iyGGnLmqmpljmvEXXFjLW/YQKd1ck1Ub9xrcI
         f+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvMVXgkYpNN9sZPuxppMuXcoMoKSnEUwXCqI78r7ick=;
        b=hq+bUpkoVItzivst/Yb1lLIxDT9pD3dCSU4cKz4maeHQX7hXGR1xmC6LvESc7i4iGs
         zZx6LXlIed6mR5yxuo3/bHZAaiDzASLdCfPn4fcypauFLdHIlsui2TBqIiCTNL2EE5yU
         MJGduKaGq8AelOLstD4NXhv3lBomFMqmnElAJXpk/Qr4MrjBz0vOnFJ+kP2knunaSGWA
         HO5F6+M5HPFViNJSEQD4Vz0g6BLQAP2rYOB2sqKgo3swyUjO1Q/riDCGexPRAaBQuue2
         0Zk4ufdkAUhkymkD3IJEtryDk5321Je9ZvseOioH+gc9c+t6tfPwj7T0eh5v1/3jdA5F
         vkTw==
X-Gm-Message-State: APjAAAXak4BCZ3/1E8UUZGeW7t5M7/lKlHfmgZl5MRak02o+hTZKWaS8
        BfyIq1ltYlDBQ0QmHcxnI4QdsUbIM4dM3X0AoYtW9w==
X-Google-Smtp-Source: APXvYqwx6IXRb/OfiRGUc3dedl/UOL9sv4gr0GbVlzrNIsbqHM0mqlH5VsShWnu+ldh/+do6QZlIJDvDZLjBtdjsE1A=
X-Received: by 2002:aca:b107:: with SMTP id a7mr44870887oif.83.1564145501803;
 Fri, 26 Jul 2019 05:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190726022836.7182-1-hslester96@gmail.com>
In-Reply-To: <20190726022836.7182-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Fri, 26 Jul 2019 14:51:30 +0200
Message-ID: <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Fri, Jul 26, 2019 at 4:28 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Use devm_add_action_or_reset to keep
>     resource release order.

This is better now indeed.

However it seems there is an issue with the mail/patch format, I'm
unable to apply it with git am, and if you look at
https://lore.kernel.org/patchwork/patch/1105782/ the diff section is
missing the beginning of the patch. I don't know why, but I think it
should be looked into.

Otherwise, it's fine by me.

Regards,

Patrick Havelange


>   - _remove() function is redundant now,
>     delete it.
>
>  drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..76c70a6c3593 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
>         ftm_set_write_protection(ftm);
>  }
>
> -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +static void ftm_quaddec_disable(void *ftm)
>  {
> -       ftm_clear_write_protection(ftm);
> -       ftm_write(ftm, FTM_MODE, 0);
> -       ftm_write(ftm, FTM_QDCTRL, 0);
> +       struct ftm_quaddec *ftm_qua = ftm;
>
> +       ftm_clear_write_protection(ftm_qua);
> +       ftm_write(ftm_qua, FTM_MODE, 0);
> +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
>         /*
>          * This is enough to disable the counter. No clock has been
>          * selected by writing to FTM_SC in init()
>          */
> -       ftm_set_write_protection(ftm);
> +       ftm_set_write_protection(ftm_qua);
>  }
>
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> @@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>         mutex_init(&ftm->ftm_quaddec_mutex);
>
>         ftm_quaddec_init(ftm);
> -
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
>         if (ret)
> -               ftm_quaddec_disable(ftm);
> -
> -       return ret;
> -}
> -
> -static int ftm_quaddec_remove(struct platform_device *pdev)
> -{
> -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> -
> -       counter_unregister(&ftm->counter);
> -
> -       ftm_quaddec_disable(ftm);
> +               return ret;
>
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +       if (ret)
> +               return ret;
>         return 0;
>  }
>
> @@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver = {
>                 .of_match_table = ftm_quaddec_match,
>         },
>         .probe = ftm_quaddec_probe,
> -       .remove = ftm_quaddec_remove,
>  };
>
>  module_platform_driver(ftm_quaddec_driver);
> --
> 2.20.1
>
