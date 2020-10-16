Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFC2907F7
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407458AbgJPPJA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407453AbgJPPI7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 11:08:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C67C061755;
        Fri, 16 Oct 2020 08:08:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so1629083pgk.4;
        Fri, 16 Oct 2020 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+hPhVaR5GY+I1MleoS6eNBmSlE2W0O1gZm+rdUy6VU=;
        b=c+4sNBaGoiaDiRNFEdp0bwVWGYXXUMH965l+YcIpbMy8wy+slJJuqh516o/Uvq/vpS
         zTxHVTvOpefYrwUk2jR1ObuypvVckXAM/zAJA3SmDBFWFBd8Wp7xOMvTRcglC4tPGSEm
         ZYI2ZRKHcE4l17rSmwzZSxx9Ops4tqJB/Z+62R1BnslNTuCkoQyG2GumWstmFnJgY1/w
         SQkYI76RiMmm0rCq//R8nerKrurXDTfke4SobxpzJ8kdm4UhSUKpwo6ghkU3+bWMnxYh
         i/RGhDwRbbOL8YyjUZDEvLKZJtkjg1TBZGjRSJjMXrjGrL0FZBJ48DeHKtdxDGTI4vTT
         uYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+hPhVaR5GY+I1MleoS6eNBmSlE2W0O1gZm+rdUy6VU=;
        b=AqoJ8pVNhBJrkWmhSpAKj8EXoMq9IyEVErQ4HnE6/yzcHdPrEC+HelsnQZVw20bwdT
         2tx/pgpFfmIdWEwK+PNbhX15rY65DOrx1MBa8n9fJ04Ag718HQ65WJgZWVtkQiDGhBKb
         Xbe0tmBmo+JE+tjMp39O3uQ4zwDVjmwjjizhuqNc9vaRVk8w84kt3KK80+7LhPw78Jkf
         2ZKue4qRMqHYIXwH9dVHxzYGFlxKctmTE/w2+OUaV2nAwiXqYEXGnxZ2d8p7yZvx+Ib7
         +dc71JVk5+pI4tw+8ChSm1Z+eBZygmrVfkAUsOwKmr9JJdaUn+kwWniOHEe3xHvKC1l/
         5kMQ==
X-Gm-Message-State: AOAM531sgPNklNIZnX7YX7FFxJyHYM9Q/zSnXwJrmsn31uGJPyywtDe8
        sYPkRLs99Bc31GJMotDv0Lj4XRaAU0oyNWQ81Q4=
X-Google-Smtp-Source: ABdhPJxH69gtM7S4sKUktYCoPE8j5Os4acTrvawLtfWPvOYEo0j/tKYuikKH0LqtRFJP/tnn1Jn7/hC17nXTyFrjiW8=
X-Received: by 2002:a05:6a00:22c2:b029:156:543:7c1d with SMTP id
 f2-20020a056a0022c2b029015605437c1dmr4012698pfj.40.1602860939282; Fri, 16 Oct
 2020 08:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201011160748.4a47b889@archlinux> <1602440546-2376-1-git-send-email-LinoSanfilippo@gmx.de>
In-Reply-To: <1602440546-2376-1-git-send-email-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Oct 2020 18:09:48 +0300
Message-ID: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
Subject: Re: [PATCH v2] iio:core: In map_array_register() cleanup in case of error
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 9:24 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> In function map_array_register() properly rewind in case of error.
> Furthermore remove the now superfluous initialization of "ret" with 0.

>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
> -       int i = 0, ret = 0;
> +       int i = 0, ret;
>         struct iio_map_internal *mapi;
>
>         if (maps == NULL)
> @@ -44,7 +44,18 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>                 list_add_tail(&mapi->l, &iio_map_list);
>                 i++;
>         }
> +       mutex_unlock(&iio_map_list_lock);
> +
> +       return 0;
> +
>  error_ret:

Wait a bit.
First of all we linked all successfully added items to the list.
From this we have two ways to go:
 - leave with as many maps as we registered
 - clean up and bail out

I dunno which one would play better in IIO, but you seem to go with
the latter one.

> +       /* undo */
> +       while (i--) {
> +               mapi = list_last_entry(&iio_map_list, struct iio_map_internal,
> +                                      l);
> +               list_del(&mapi->l);
> +               kfree(mapi);
> +       }

We have iio_map_array_unregister(). Why not use it?

>         mutex_unlock(&iio_map_list_lock);

I would rather drop a label with replacement goto -> break inside the
loop and call the following


        mutex_unlock(&iio_map_list_lock);
if (ret)
  iio_map_array_unregister();
return ret;

Sounds like only a few LOCs are needed.

-- 
With Best Regards,
Andy Shevchenko
