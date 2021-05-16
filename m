Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15AA381D04
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhEPFbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 01:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEPFbs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 01:31:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837CC061573;
        Sat, 15 May 2021 22:30:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so2010191pjb.2;
        Sat, 15 May 2021 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XycNsvUn7CHpCcQXZ6y/TPm+iOJFX98cdFZ4Z5eckqo=;
        b=M/HyjsVjIdS+U2CWpLkvuYHDuv0ZcuQBMY1q9vZopf8pkZCzyoJWJDzW1eye0wdBPg
         qNa3RQggBLjzvxj8WRZ+Czs6sr62CtIKUnDfrnHxvWGlbndsFe8zDBA3h7ONEmDblExa
         2yxkbYLabLUXEwqQehYpsNQP4PF+BJlPb2xHmfdmFpg9K+yCMZEJuhM9/gS1cLyQhFzh
         RN79sbLP4Fur+aUx588tiU1rxLtrQneG079wG5KGejsPQxiSNwcyyHdTyesJJE7IwtCg
         GHxRnabJ8tBBMMlJwRsf/FcCvZ6bg+yUYQvU2PkFIabxnag52HAZWbxxIo5v6Qy88klB
         LaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XycNsvUn7CHpCcQXZ6y/TPm+iOJFX98cdFZ4Z5eckqo=;
        b=DwqmJe/b7U4Xdsc+feiWSRUPRmr6MhX9Nq7LxlD3SHttaaAIuXRi92/pNg3EqrdkxI
         iXtQzN999StvcGuRe3Rkn4v5iaqpbVHC96Tp0I3vQfJ7EcvM1B3wI0RbgfkHoCMU6T5M
         KIUSFiNjIiXyCACsRlkWypVSXAl3j5++UooBP9obWuMPbLqx7G33Faz5VvpFO9fJHEFx
         oL6TVZQEQN01PvQAPe4dmFOldklv7AwIStBiK54mIQmdEAcKRQAOYvP/EiXwho+UW6ku
         3QlD+qtzCwjLTvUtk5xnNpLmv7BF/gS0ae240MXi+HMKz4P5/Cnz+urTFI2Y9q/mjLs2
         T+Uw==
X-Gm-Message-State: AOAM530A7blTkKWQ4sdXubWtuAggmj4wpNAF+PiwjwJgGuWnrthMBwGC
        UxbtLVC8qcgiuYt/UwDolMpIx7+ca9Ny+EbX5yM=
X-Google-Smtp-Source: ABdhPJwWOKAz8QY9vwUBv/7eEwOLULTgeUZabK7S0Q5neIFWfEwFpERiEgFmiFOMpzLodDD+WnyZVlEDPO9r8XiVQxI=
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr20114144pjj.19.1621143031367;
 Sat, 15 May 2021 22:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <YJ+a1yaMu2QNATgt@mwanda>
In-Reply-To: <YJ+a1yaMu2QNATgt@mwanda>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 16 May 2021 08:30:20 +0300
Message-ID: <CA+U=Dspvr4J=vRYK7ntdB2-XSLss8YutMd0YOQi4zkDr-UkxWw@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Fix an error pointer vs NULL bug in devm_iio_device_alloc()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 15, 2021 at 3:01 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The devm_iio_device_alloc() function is supposed to return NULL and not
> error pointers.  Returning an error pointer will lead to a crash in the
> callers.
>

oh
that's a good catch;

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: d240dc25e3b8 ("iio: core: simplify some devm functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index bfa20a346f71..75e92bac78f3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1711,7 +1711,7 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
>         ret = devm_add_action_or_reset(parent, devm_iio_device_release,
>                                        iio_dev);
>         if (ret)
> -               return ERR_PTR(ret);
> +               return NULL;
>
>         return iio_dev;
>  }
> --
> 2.30.2
>
