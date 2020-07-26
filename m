Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB622DD22
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgGZIGq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 04:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZIGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jul 2020 04:06:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32466C0619D2
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2020 01:06:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so7682313pgm.11
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2020 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKskkTBjEAPr4lCG77C+BYgsnaz/0nkrMH83YCSWjU0=;
        b=kIsn2zKN7Vo2Uyjap/UegyeH/Ad240iyNwFIvS0rDo3C5c7vstfBZCES1eJQZk/C61
         KPW129bKKoimkVt0dcwsLTiLxh7A5sq4tdJDo9D5Z8UycsybmHQSCAAnubKyXcz7TEFS
         4nYQEXlm/VbLSshg7VI43Kjcwn9gLtlgBvVbcAQDLsl/MT2m4pkDDVR5JZk3B+A6UBGE
         /vsdwvIXHGFo8vZ0UBb7NXq/kTQiAXbz45Ga2jESLvt2uG0RK73hNeRkKLpecbzT0u7N
         caN5/y2/DSTi6pfL/dSpNJ9MoGv8oQHEcgpTahUoSbgpQ4OLrpcYeINoWnsc68M+BCd/
         OU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKskkTBjEAPr4lCG77C+BYgsnaz/0nkrMH83YCSWjU0=;
        b=svPp6HGaI4AaclL2SufQahipVUa6ugxTVtOm4AKczL03K39IBhYatlSlRbzlsPc4+m
         VyDtU/cIwjG3BYS0wnaBLwI2RX4/BoGY/LNl3WtyDotmbl5s8JJ+FHZG7Y6XHUFNG1fz
         q+RaNJ0kahEr10OlfoakvnRqA2SNlfQInkRYMijB1Wh3UPvfLGpodoWGVqholjXNeojh
         iU6JB07mg3qhaGnqUr8b7I0lIrvEcdyw2D3t4EvwQ5LTFePotdg9jDlJNDXYFXY5DCYv
         MfTllJUR2Up1LWlFmSO0v8KOrF6qAYERCZC8HzpVdm3QPD8m/NdEC2tcdwdPnhErswwI
         AdAg==
X-Gm-Message-State: AOAM533P81KN+QtYX6uxr5g3hQZz4uLu5C8SDEDO0ygcFtUr9YD6QYak
        A57438I0y14h1OOMyActwyoXegnGU4xkR53r6uen5Y7n
X-Google-Smtp-Source: ABdhPJz2gLTpMxQb0vaq9NfosPjDG+0n21rX5DUrtDHtyzW4qoIlzAnhhlvZ/VdL64/u8+qrWBUdO8AaiszdV2Md5LU=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr14715546pgn.4.1595750804674;
 Sun, 26 Jul 2020 01:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200724100907.GA8977@fbenedet-HP>
In-Reply-To: <20200724100907.GA8977@fbenedet-HP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:06:27 +0300
Message-ID: <CAHp75VcV2iifixojbKZOKAMPiX6Z3ajKAy6-8+EepN2G6=EKeQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_agm1264k-fl.c: Replaced udelay by usleep_range
To:     Fabrizio Benedetti <fabrizio.benedetti.82@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 24, 2020 at 1:10 PM Fabrizio Benedetti
<fabrizio.benedetti.82@gmail.com> wrote:
>
> This patch replace udelay with usleep_range
> according to the Documentation/timers/timers-howto.txt .
> The usleep_range have a range that is >= of udelay.

has

Also all functions we refer to as func(). Note parentheses.

...

> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>         dev_dbg(par->info->device, "%s()\n", __func__);
>
>         gpiod_set_value(par->gpio.reset, 0);
> -       udelay(20);
> +       usleep_range(20, 25);
>         gpiod_set_value(par->gpio.reset, 1);
>         mdelay(120);
>  }

It's funny you left mdelay and on top of this all of the above makes
sense if you also switch to gpiod_set_value_can_sleep().

This will also require your analysis of the context (atomic /
non-atomic) in the commit message.

-- 
With Best Regards,
Andy Shevchenko
