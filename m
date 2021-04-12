Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750E535C593
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhDLLsc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbhDLLs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 07:48:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8496C061574
        for <linux-iio@vger.kernel.org>; Mon, 12 Apr 2021 04:48:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u4so14971265ljo.6
        for <linux-iio@vger.kernel.org>; Mon, 12 Apr 2021 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUFubz1j8LGr9ATXYl9u2QKnAieDNtMiSF5oBCM5mI0=;
        b=a0rgbYleRMInpz530yuepu/ja7ke0KfZ9DzB26VrVHb8zOggeKazMMs8gcjko2zqSJ
         +akGiprarmQnYtIUU+aMkcon92Qh7r7XlCdU77amFksT4gV8NVYQ4k2Xl2lxRwylCO6b
         7DHq69AIYJXhAiaH6RTWDjQmzeHk1aBfqQe3xFUnSNRlSmoHlr2RRkpz9iqct4E9IYSa
         2j0bcOU/xVjg3NAIS9MxbOCWTouLGHqOWFWDGASfUM936sBx+hTUbNAAR4XGY2YOlZd4
         eE4M4vAYwWd44PxI3Z/T4qRiGQuSobRZqbPTULsYoV95sgNCc9QGBvIA4X6epHrfYAqB
         aXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUFubz1j8LGr9ATXYl9u2QKnAieDNtMiSF5oBCM5mI0=;
        b=dW0CT7a4U/CViUX2I/2Nl/ga+XffoyJfmz+cskfTLJfqlA2Z47vlEFQMJT0mYk/zkG
         OyK5JlCs5KBtYaHATKE6WMx3Lt2f3Tl6mPNplenuq8nXjFMLvHoeXt87sKcppxG++hCB
         lv3/hGVsfkCOhiCjlerGcPnbVT0XS2I7wi+C3P7tHat8KAKR3cd/iKxF4qEinW4dHXcj
         7UorzYFzAvVa5zz/bNU4sIqKFxGbsYirJkJezBkrQeeL9b+NPZB2QcQYn+R1lALX7Mgi
         ira+IcMZaRXkejhlulqHFvmvVyNJQHkpkcE9xUw2xnosM55FOY4wb3UpS+VKvVWbHpM3
         xnPQ==
X-Gm-Message-State: AOAM532GMdLAXRjla9dm2IXbsytHEW7mJ2OGXyPXvlF9k7WROlKPovSf
        TINg/pUJy6jfOm6ySw/uv5/vFgv72qrHmUzctYQt5g==
X-Google-Smtp-Source: ABdhPJwYJtFNwwe4zEqxGrjI2C/7Btg87W2JCrAV2iwsB4JfrUIONAlcTaXG99VcqsQ9SrZIoj6IM9uMZPKgZrU/Kno=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr17872999ljc.200.1618228090192;
 Mon, 12 Apr 2021 04:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
 <20210411160720.037c405c@jic23-huawei> <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
 <20210412111506.0000653c@Huawei.com>
In-Reply-To: <20210412111506.0000653c@Huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Apr 2021 13:47:58 +0200
Message-ID: <CACRpkdY9sDbVSjBULg3tV-Zpr_Tizd4HKeTG-NjCjUru=94QYQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 12, 2021 at 12:16 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> An example would be the bmc150_magn driver which does exactly the
> same call sequence as this one, but without the reference count increment
> and decrement.  Basically I want to know if there is a problem in
> those other drivers that is being protected against here!

The bmc150_magn driver does not look like I would have done it.

That said, I think it works, because the only thing it is calling is
bmc150_magn_set_power_mode() and that seems stateless,
just poking some regmap bits. The state is tracked by the driver
AFAICT and we don't need pm_runtime_get_noresume() because
it doesn't really matter if the pm_runtime_suspend() callback
gets called immediately or randomly out of sync with what we are
doing from this point.

I would anyways patch it like the gp2ap002 driver because it
is easier to follow the code. Including using only runtime PM
att setting SET_SYSTEM_SLEEP_PM_OPS() to the
pm_runtime_force_suspend and pm_runtime_force_resume
functions, everything just get so much easier when you use
only one type of PM and not two orthogonal ones.

drivers/iio/light/bh1780.c
should be a good example of how to do it idiomatically
because it was reviewed by Ulf Hansson who knows this
runtime PM stuff better than me.

A sequence like this:

   pm_runtime_get_noresume(&client->dev);
   pm_runtime_set_active(&client->dev);
   pm_runtime_enable(&client->dev);
   pm_runtime_set_autosuspend_delay(&client->dev, 5000);
   pm_runtime_use_autosuspend(&client->dev);
   pm_runtime_put(&client->dev);

is very nice because you can clearly see that it will not race
and after the last put() unless something happens the
runtime suspend will kick in after 5000 ms.

Likewise when disabling:

    pm_runtime_get_sync(&client->dev);
    pm_runtime_put_noidle(&client->dev);
    pm_runtime_disable(&client->dev);

same thing: crystal clear there are no races, the device is
definately runtime resumed and we can proceed to
shut down resources explicitly after this point.

If you then add:

SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
                                pm_runtime_force_resume)

Now you have ordinary sleep PM for free. It will just
force the same suspend/resume callbacks and they are
guaranteed to be race free.

This doesn't work for everyone but surprisingly often this is
what you want.

Yours,
Linus Walleij
