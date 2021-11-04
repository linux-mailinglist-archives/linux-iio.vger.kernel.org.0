Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB03A44519A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDKkU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhKDKkU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 06:40:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51CC061714;
        Thu,  4 Nov 2021 03:37:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j21so19519326edt.11;
        Thu, 04 Nov 2021 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/5kzstrkCSMv/VlfIvA09LX8Wmh4ujtObG/Bz7zjo8=;
        b=SYm+x2aTcUAbNag1u+t8pykgwihu7OPqbr+De9Sy4saPQhIiIYINSWcnetDyxkADLx
         GAqTVV9kFSnYl34aEXVQOoToZPuDSBrM2AalqfEBvG7W1+lFdENG/H5R+J/5G8yp93Ue
         K76c8U23FtJ76V+saka2xjc84tsY2+AJGEmWLHghyEWKUg6iwgFhPAgu9DBTQIuUpo2q
         BNkbvelsuGyG3/09T08lO20pMSrCWhGpDpS28i6vpKdA++wXW0cKP3FrJDvlSiu6D3Ji
         Dfrpm2xB4aFu8WcNQNxhSlNi5maO5V6v+RFhsiOLU6cmUScK84bYYu/XzKx3/BcY7Tay
         nzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/5kzstrkCSMv/VlfIvA09LX8Wmh4ujtObG/Bz7zjo8=;
        b=te8+AUo1MW586Oeyipc9e0cmxP9OeIGN5ULPwyFvqhdCSMWxGGpUyYDo+TEzMd5r+H
         BHBCGSO3vijIHkYpuGGBBgPQCnYRkH006ZqfogTa10qGZbG/UxIH8r3MdioiLLWgMtXy
         Fs4u85QHlQqzSisFNZ2T9atU9zxyySlRkZMzcuG4eTAJtqQl/M3KCYzdDDMg0N/HqdM3
         j7iiOvhT0Ucui5OsuqxXIU0QKgSlP1tXVyTmya0UlLEcycNvkr5Rk9hpcNgKmSi9/ZID
         70+aT4aM2kE3h+u9BkyVSpVgqDS5LSIW9MeNcHpHAeHfLn83kATuAKCMUSwsvr02PpRP
         CMgw==
X-Gm-Message-State: AOAM531iMiO2fgm7KB8Tn88H7pBCJdniqTHw/DEnYs0qYEM0HX+cCA09
        8HPsKUtEEAZNL9HkcH154kCXsQE/zXjKJ1tlK/4=
X-Google-Smtp-Source: ABdhPJyZRIeLfANMQW/aRk2JABXKzjfwnUHUyvs4iKOZjJ23Kw0AcrJwVY6ayDPqUZxjvuCUpVcPw75svoyvwSNM6Io=
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr47345622edr.238.1636022260947;
 Thu, 04 Nov 2021 03:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211104062032.1505899-1-yang.guang5@zte.com.cn> <CAHp75VedwDcBoz=dOGf_-7aOHC1mdvT8+hyvyK+hbK-5soJoYw@mail.gmail.com>
In-Reply-To: <CAHp75VedwDcBoz=dOGf_-7aOHC1mdvT8+hyvyK+hbK-5soJoYw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Nov 2021 12:36:52 +0200
Message-ID: <CAHp75VeUfRQ279iY3tZs298h7Vpnca_Lso=N2THEKuqc=hW1_A@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: use swap() to make code cleaner
To:     davidcomponentone@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 4, 2021 at 12:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Nov 4, 2021 at 8:21 AM <davidcomponentone@gmail.com> wrote:

> > Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> > opencoding it.
>
> Same as per other patches. Don't be a dump addon to the robot, think
> about the code a little bit more.
>
> >  void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
> >  {
> > -       struct iio_channel_info temp;
> >         int x, y;
> >
> >         for (x = 0; x < cnt; x++)
> >                 for (y = 0; y < (cnt - 1); y++)
> >                         if (ci_array[y].index > ci_array[y + 1].index) {
> > -                               temp = ci_array[y + 1];
> > -                               ci_array[y + 1] = ci_array[y];
> > -                               ci_array[y] = temp;
> > +                               swap(ci_array[y + 1], ci_array[y]);
> >                         }
>
> Name of the function suggests it's a sort, we have the sort_r() API,
> use it instead.

Ah, it's the tools folder...
Anyway, the first part of the comment stays valid for all your contribution.

-- 
With Best Regards,
Andy Shevchenko
