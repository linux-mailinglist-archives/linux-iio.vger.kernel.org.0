Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C058468D4E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhLEUnN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbhLEUnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:43:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CFC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:39:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so34758188edx.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZX/6dEJSyXIg+3TGpQK54+1qtQDYuwQ9qsVbvUSklh0=;
        b=KDaeTndFNPTXMc0nfCYs10ZFCthLLXXLCkP8CL5e+o9AWMoJKu77EtNbCUrKyebxdl
         uG/NOgv/yZ+57tT/m368qwWZCRmWqUGWrfdzzrmKErRb3poMlu7JwD8LoRIPcL6UXGN4
         GrVw4+qJF9yktpHMSJMUf04D6I15CMGW+ToPS2N8xCLsHM2XeMeOcngYVO/lMPYzy5y7
         GJPXfZiiYnOg8iKDNmVyg30jDmt+g8PljSXCg+JHnUODMrC7kJv2UcG7ai0O7/af2auW
         DCEDoaYayiS0q6a/ST9ui1bVZLDgl7lXzuIfUf/XjGs88nHYBVze2gvdV/A4+hX6BH7N
         EZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZX/6dEJSyXIg+3TGpQK54+1qtQDYuwQ9qsVbvUSklh0=;
        b=gpIpgFMjUcixFbhjuzVMOfb4WuNwhcfVA8/+YQLdCNYzRVFOenmvCL+PP4zO7ya1om
         NRJiXenP1bO/QkDr+8879xg3hGFiavPea997oawghitNBppQ9czjIFWtUcG6UVyiDqiu
         7N2jW4+BfANUnWcHZ7/q3ldCKtfzJdXck1pjhIj7FKym6BgP+b4RSuvIQvpdpfqBij3t
         iMPuHzsnsF3p+KNsLmaopCFkf47GcDVknxN+3bOjmD69h15ZhAt9sYFeqy+4oco3lUS0
         pqe3Od1/L52SrRd6w5D1T92UsomSScvdWFpZaZZTmvohEkguAK+TwPlVonQCZptfdwVU
         s+dA==
X-Gm-Message-State: AOAM530xUt2VfflsP+Fbi5TMT7LfuvHCZhWly75yAmcWWws+0sGWWEVj
        4GfCpWlBCRJb0twscttu0FphZ66i55On40laDEON1xVbLOXzIX2l
X-Google-Smtp-Source: ABdhPJw88FTTbRXE6UHxGxHdwD9CTgi4y2UnEjJ1OkIL4LqLj5b8884bl6xNQDweiL1uDvx97AwKcFe0ekSf8nDGUVs=
X-Received: by 2002:a50:c35b:: with SMTP id q27mr47059160edb.154.1638736783566;
 Sun, 05 Dec 2021 12:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20211205200250.2840902-1-jic23@kernel.org> <20211205200250.2840902-4-jic23@kernel.org>
In-Reply-To: <20211205200250.2840902-4-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 22:39:07 +0200
Message-ID: <CAHp75VfGLaTnV67uNf2_n7203_viC6wmayMNk2+gCHAQ2=tnBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: accel: mma9551: Add support to get irqs
 directly from fwnode
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 5, 2021 at 9:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Note the interrupt type should be specified by firmware, not the driver
> so that is also dropped.
>
> Drop previous gpio based retrieval method. Whilst in theory this
> might cause problems with direction if anyone is using ACPI GioIo().

GpioIo()

> As Andy described in v1, such a situation would typically reflect
> a pin that is actually used in both directions (not true here)
> or missdesigned ACPI tables.

...

> -               gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> -               if (IS_ERR(gpio)) {
> -                       dev_err(dev, "acpi gpio get index failed\n");
> -                       return PTR_ERR(gpio);
> -               }
> -
> -               ret = gpiod_to_irq(gpio);
> -               if (ret < 0)

> +               ret = fwnode_irq_get(dev_fwnode(dev), i);
> +               if (ret)
>                         return ret;

I don't remember why we decided that this gonna work, because
fwnode_irq_get() is not an equivalent to the above, more precisely in
ACPI case it only covers the GSIs (Global System Interrupts) which in
such case may or may not be GPIOs. On x86 it's usually direct IOxAPIC
ones.

So, this conversion would probably make it impossible to use this
device in the ACPI case.

See also this discussion:
https://lore.kernel.org/lkml/20211109200840.135019-1-puranjay12@gmail.com/T/#u

-- 
With Best Regards,
Andy Shevchenko
