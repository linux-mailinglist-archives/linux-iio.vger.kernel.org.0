Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D161D7BED
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgERO4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERO4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 10:56:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F24C061A0C;
        Mon, 18 May 2020 07:56:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so2137839pjd.0;
        Mon, 18 May 2020 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0vgPkzC0SrMw1LKftBMhKbRArXUYnbbA1/YhTB9uaQ=;
        b=H24gkmj4DfDfuJCrO+06TCGDojdN1L9EUvpR5Ip3kE+bWfnp24rarC1anGDdbcKBM8
         hDgd2N7B6rmEETzkobnuyliskxRCTQlzWNrzdQ+PsYY+Q9/zRy23jmiGPHREE1MM0NV/
         yP2jVkjfW363I9E4dh+FK5deMTF+E5pXAlZ+D0N3ZDO8+wQ2ofNpPS5WNbOQV6zbfx2U
         LQA+xrE7n3ZnbOLCtZV5e0shXEb4ctn9y91k8CDcZToocRNuweWiDt8nsacjdm8son3A
         mPSrlUxJzdjMFPkm6wH+ZjHcd3LVWWTbGRdLxOl0fjfT6zRgnDvBBTDOf1gF8bt9auI2
         zXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0vgPkzC0SrMw1LKftBMhKbRArXUYnbbA1/YhTB9uaQ=;
        b=EdBiMPnk3SSVkr3YM9+sEVoanOs4IO4uhp0LNWSq8OkryJba2VvFlJA9J5b/v2bW0i
         IZyNYWVdS8hGbUGjtbvb6iFfD9rLe1Y0qpeu7noMhF1GyAqMsi+UhzeX7Wk6BRLFeNwR
         z+zRwWamhmrK7pWZQpoFN6V2wNofSD+QFY0gyovfBqpvloujyU13U0sfA7fsxro/RxWq
         PsgOmG3uRHT+uHvmc0qlvOhoZlVEtwF+9J/312rGmx1epsEF/4JaesPfo8hl3UJQ404v
         julLiSehGgwKEI6hWxH76GQ5ID0/CVqF9KHRrpB57iPSeVEjTyDI76wbCgNJK0MdzYsD
         ix/g==
X-Gm-Message-State: AOAM530Sc2U6VNVfKlD7nXpMxbnWhsDWeXUsJFgr6qTzKjDOX9+1uBBX
        s40/KMg7FUhxcoBwZKuDlk8ElCqXTyPFgNEEHH8=
X-Google-Smtp-Source: ABdhPJzz4iSJwpMHgi49aKOPdGMYFISG3X9YPDm7J/TYfsTMb/LHGyys39ppu1LINRhi2P3ZQj6t6s08ynYuAvMi11E=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr15165549plt.18.1589813762929;
 Mon, 18 May 2020 07:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com> <20200518133645.19127-4-jonathan.albrieux@gmail.com>
In-Reply-To: <20200518133645.19127-4-jonathan.albrieux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 17:55:51 +0300
Message-ID: <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> +       gpiod_set_value_cansleep(data->reset_gpiod, 1);

(1)

...

> +       /*
> +        * If reset pin is provided then will be set to high on power on
> +        * and to low on power off according to AK09911 datasheet
> +        */

Wording is confusing, perhaps you have to use 'asserted / deasserted'.

Btw, in (1) it's also "high" (asserted). I barely understand how it's
supposed to work in all cases?

> +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> +                                             "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(reset_gpiod))
> +               return PTR_ERR(reset_gpiod);


-- 
With Best Regards,
Andy Shevchenko
