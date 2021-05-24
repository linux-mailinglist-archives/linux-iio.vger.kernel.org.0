Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD738E1FF
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhEXHzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEXHzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 03:55:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA68C061574;
        Mon, 24 May 2021 00:53:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g18so18514546pfr.2;
        Mon, 24 May 2021 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPfHUyoin9pTzx/DIO0b7eyaBI/hHiN4OVeEyxlvBCM=;
        b=HEYEqhIKMqaxASa/zbV8Zw652IizPKZtHK/TkEsXmRVA0NlDPGpKcLtQoewQaSf3ah
         ty/h0FSF624/lCzINZ9wa/MEsDJKPcbhKdn6o62p/64SOVH3TxJLT9MxyDFcPsHsPLKz
         CTXYHB1o6p1E2povnmw8lgFkUKYzMZuHxCwvCzjuVNln8/ehfnK4HMcyJSU6Qy1tFNb6
         hFy3p8O6V7Goo6urX5L0QclhFHqzZSjVIIwWYBAY+/moeKrM+19pmE/zNqUD1gTAYqyt
         4YT/nM0ob1BqMc2ZxdbZr1CiceN2HSaFUXJKuBbm9v1L/vofRAe6C/9XgY1Guu2m8mY1
         nTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPfHUyoin9pTzx/DIO0b7eyaBI/hHiN4OVeEyxlvBCM=;
        b=Yc+z3yIiZr6KRCQaeQiALW6zRiXJ81d9nWTWgSXNdFdChnV8+1tbBg3plf8gltosXu
         2Dgj/3Z4sLtPswKS7BnrqLUSAiJpx9L9OIha+oAHjPeuBVEG400F9KUyfKRGW8kq9tm6
         ZsNov+Lod4D5f4ZhZVni7Hm+bNiCixVXtNr5Z8zmgKuVMlj7A5NKREwlhIOZV8OsbKnN
         Xgl/n/Ot+1/KPSFV3gMnNiFDQu8YI9zeI4SYVl0HS9EMNiaMm6YNWTWuqlss8PnkUTt/
         WVotdBCwchWXU63GIHrqayrN2HyeTqZvRemeyQrHpwCMxRSNBQDV4Y+MQ0mwZfzXWZGt
         TY1g==
X-Gm-Message-State: AOAM530tzYwYpFdbnuAcY8cG+CNO+bzOuYI+3/Qtlkjrqaz2pMNhR8If
        cjtTpBiLZQjRdlJwESusiBZ4RxzfH+wy3hiP2yQ=
X-Google-Smtp-Source: ABdhPJwH3D8bee8UXImea+42nDIf9DsLn0BVBXpkA66vfMYyEdSpPMjqOxchyw0LSnambnVBFZCf9UUCaF0bUTLnB44=
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id
 s4-20020a056a0008c4b02902b48334ed4dmr22977758pfu.36.1621842808375; Mon, 24
 May 2021 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621786036.git.lucas.p.stankus@gmail.com> <45443b8306893576824effaff57d40231de8e813.1621786036.git.lucas.p.stankus@gmail.com>
In-Reply-To: <45443b8306893576824effaff57d40231de8e813.1621786036.git.lucas.p.stankus@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 24 May 2021 10:53:17 +0300
Message-ID: <CA+U=DsrwK-ae1DSHYp8eLgJoeSF9u+tAw3FsVBCGRzYN3ksV_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] staging: iio: cdc: ad7746: clean up probe return
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 23, 2021 at 8:12 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> Slight simplication of the probe return on device register.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 12b2554a85b5..367a5990ae35 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -734,11 +734,7 @@ static int ad7746_probe(struct i2c_client *client,
>         if (ret < 0)
>                 return ret;
>
> -       ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> +       return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>
>  static const struct i2c_device_id ad7746_id[] = {
> --
> 2.31.1
>
