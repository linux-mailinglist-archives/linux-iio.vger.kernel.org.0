Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89B5446A7
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiFII4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbiFII4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:56:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795215D335
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:55:57 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30ce6492a60so234001007b3.8
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQv5IHKS/Xq1nMBFmHNfBkfz9md7MY0lyVvFRrZc0DY=;
        b=XRRHqGnAqOBQ84tBrj9wC8wQ7Y9vKI6Im80+NZQtea6d5zDrM21gQKGAe0EZYhUxi2
         NdKzFqYxN6C4SCounbVFRqFuDGZd0zfWIhOQXrwf/CHx1b+a9GTQWe9Eno/yadSe97sb
         8xsJywepKgtGYbShWy9VUgaeNbEqdAbqKjXKNInos0VC6YxooTNg213FKKLumlDqfKBP
         0uS28v7Uv6tnpzc8q9XxyaQXxjXjv1eKFoz/eBO9/TVAm3bUMw/vTHAkOoDjBOpWAD5L
         dCzw0Q+qebhDw7igIZoleVxKhXp6aqX498oqM4oSazTvGckqmzDXkDFIowRM/hQ6B1rB
         08RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQv5IHKS/Xq1nMBFmHNfBkfz9md7MY0lyVvFRrZc0DY=;
        b=3zsuYqZ22ryeYkFxH+rU5f58PF9iUjKrW60X8dc0cW0xUZGGGtuiRTHgYTfVdI9BkT
         S2VXaXagE1IFoCgFqfAN1H79kpBAyaUFF/XUTdBjdqW+AOkX5xGlvg0SplPHXs7Zu8/F
         lN7Y21kuKl3qwx2TqboYKujaZtrWU0m/GBO3DTitqu3XVoDe+lLiIuY/Aoppwb8ZuXLJ
         PMuOdkDIP86p2c5f9YgXA44QItgy9vDXxl3QoFIK2ugBw3iZCX5skg3FtPCFF3HYEWWv
         BuO8KPpiR37BuBgsH295MNXXCcBICFbjDOkgs7DJwMmA29KYaGZmqgtJSYDjVu0YZQyt
         SaKg==
X-Gm-Message-State: AOAM530B7WykAvUnmsPAKR8PimcUZ9utUc/D4x+YZu+SAtVXgCb7tms9
        J6/5/ukTU42hfOoRD0ngPwgRF+QXHBWXEBOqNMnH8A==
X-Google-Smtp-Source: ABdhPJzYDsP+eH1L8OwT9ZaJDGbZWOYXDBP5LAhASPHy5wsNl4hkBJWT/yOlHskNuzzx/aENd9YGJwpvvGRp12PF8fw=
X-Received: by 2002:a81:1154:0:b0:2fe:d5a4:f26b with SMTP id
 81-20020a811154000000b002fed5a4f26bmr43330621ywr.140.1654764956789; Thu, 09
 Jun 2022 01:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <5ae4b9dda3032acba8b8b0e39352e9e3953e3f88.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <5ae4b9dda3032acba8b8b0e39352e9e3953e3f88.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:55:45 +0200
Message-ID: <CACRpkdbzrqmj-XvL6ut1f4h-8J4Yz7981xUKzGrzSmsX91QUxg@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: magnetometer: yas530: Remove redundant defaults
 on switch devid
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:39 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> This is a preparation for adding YAS537 variant.
>
> In function yas5xx_probe(), there is a switch statement checking for device
> IDs. If the ID is unknown, it exits with a device error. In later functions,
> it's not neccessary to check the validity of the device IDs again.
>
> When adding YAS537 in a later patch, several of such switch statements will be
> added. To make it more uniform, the redundant ones in YAS530/532 get herby
> removed. This is done in a separate patch for better history control.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

No big deal for me, this works fine.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
