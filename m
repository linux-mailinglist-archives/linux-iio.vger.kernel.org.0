Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F13363479
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDRJn4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 05:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRJnz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 05:43:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1231B61029;
        Sun, 18 Apr 2021 09:43:24 +0000 (UTC)
Date:   Sun, 18 Apr 2021 10:43:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
Message-ID: <20210418104353.5a6e498f@jic23-huawei>
In-Reply-To: <CACRpkdY9sDbVSjBULg3tV-Zpr_Tizd4HKeTG-NjCjUru=94QYQ@mail.gmail.com>
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
        <20210411160720.037c405c@jic23-huawei>
        <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
        <20210412111506.0000653c@Huawei.com>
        <CACRpkdY9sDbVSjBULg3tV-Zpr_Tizd4HKeTG-NjCjUru=94QYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 13:47:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Apr 12, 2021 at 12:16 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> 
> > An example would be the bmc150_magn driver which does exactly the
> > same call sequence as this one, but without the reference count increment
> > and decrement.  Basically I want to know if there is a problem in
> > those other drivers that is being protected against here!  
> 
> The bmc150_magn driver does not look like I would have done it.
> 
> That said, I think it works, because the only thing it is calling is
> bmc150_magn_set_power_mode() and that seems stateless,
> just poking some regmap bits. The state is tracked by the driver
> AFAICT and we don't need pm_runtime_get_noresume() because
> it doesn't really matter if the pm_runtime_suspend() callback
> gets called immediately or randomly out of sync with what we are
> doing from this point.
> 
> I would anyways patch it like the gp2ap002 driver because it
> is easier to follow the code. Including using only runtime PM
> att setting SET_SYSTEM_SLEEP_PM_OPS() to the
> pm_runtime_force_suspend and pm_runtime_force_resume
> functions, everything just get so much easier when you use
> only one type of PM and not two orthogonal ones.
> 
> drivers/iio/light/bh1780.c
> should be a good example of how to do it idiomatically
> because it was reviewed by Ulf Hansson who knows this
> runtime PM stuff better than me.
> 
> A sequence like this:
> 
>    pm_runtime_get_noresume(&client->dev);
>    pm_runtime_set_active(&client->dev);
>    pm_runtime_enable(&client->dev);
>    pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>    pm_runtime_use_autosuspend(&client->dev);
>    pm_runtime_put(&client->dev);
> 
> is very nice because you can clearly see that it will not race
> and after the last put() unless something happens the
> runtime suspend will kick in after 5000 ms.
> 
> Likewise when disabling:
> 
>     pm_runtime_get_sync(&client->dev);
>     pm_runtime_put_noidle(&client->dev);
>     pm_runtime_disable(&client->dev);
> 
> same thing: crystal clear there are no races, the device is
> definately runtime resumed and we can proceed to
> shut down resources explicitly after this point.
> 
> If you then add:
> 
> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>                                 pm_runtime_force_resume)
> 
> Now you have ordinary sleep PM for free. It will just
> force the same suspend/resume callbacks and they are
> guaranteed to be race free.
> 
> This doesn't work for everyone but surprisingly often this is
> what you want.

I'm still far from completely convinced that it is 'necessary'
to take the reference whilst going through this sequence because
there is nothing to kick off the suspend until we tell it to use
autosuspend.  However, I appreciate (much like taking locks in
general in probe) that it makes it easy to see there is no race.

Anyhow, fix is still valid either way so applied to the fixes
togreg branch of iio.git with a fixes tag added to the initial
introduction of the driver (which I think is where this came in).

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

