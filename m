Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF740F397
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhIQHz3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhIQHz2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 03:55:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C0AC061574;
        Fri, 17 Sep 2021 00:54:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso6749915pjb.3;
        Fri, 17 Sep 2021 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fne5QRIvTCtWwjBc2H/rjO+kSdCKQZxO18C+flIqYI=;
        b=dpxjO/PuhQItkgh27b9pR4UXt24P2WAekIO8WNpDwWbKKTvmObFTMtBrFN4jOAMuCw
         M3bqG6zXEHgIdEE6DKBjHXiVpnZnkxjJUDBND3e6PLejj23F6yEdQEY6DqFpAX+7ERCd
         /NCdAchTPw7gSmR3OsncOJYXxlx4rYp8sDPic6KHlal0OvelCdvsy5r1zOjDv/Nhwwjo
         pZwrD6lmAiP9uyHGxWCA4pAF1Pgkna0zc02ROGPcWQmTx0D+hPwTpexuxiweMUMmIcXv
         VfGnEKKYhbyfNGvdEX+2KckCNCU+ufdCT4M7j/oKLhQo0bznoXWFz2YQOGHRCAEG8HmS
         kzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fne5QRIvTCtWwjBc2H/rjO+kSdCKQZxO18C+flIqYI=;
        b=Fz965ydtisZbTvSzAtO2z3iwouW+hjTgxZnFyhUH8oUWTCyukQO2q5XJjJF6GsHTbx
         4m82hCn6N2A37Lh+ZhwI2Ck6rg1U2BiHXsg0KmrERi/49sxFMj1j/jCBt51kXdrPy5bK
         RKLThwRKlvSHQT5FOCI2rL7dGYoZYxdZpehWRG1gjYjV9K8wX28h813GXMrlAFvvxGXX
         9aQnthZPi7PhKaq9JUBMoZu5wN0VBDNGEmUUdyBXljJCvXJ/ZDYeJQCUBy+PIIHctWKy
         n1IGcOOxCbhSssrfab2bd7flT/xXKlc7Fyf69Q2WyvvOoxnC9OWWsuR2l4/ZmeaxaTGw
         X23g==
X-Gm-Message-State: AOAM531bhcGj9D6tCV3Lq3aNnUpkNcl51dXNtU5G+1kY6G9XnSItGmlK
        pt1oVRaMzhNRgup/WGTXxuM6s2rnCyStLpVpP7g=
X-Google-Smtp-Source: ABdhPJxlsJC0TajM6PWfE+eIPszqDTK4CtDp2ZCZuGiZlknw2QAXIbjs6g+/OK7t7KU06IMFzQb5UaFyIVaVEi5iQNQ=
X-Received: by 2002:a17:90b:3558:: with SMTP id lt24mr13096076pjb.98.1631865246830;
 Fri, 17 Sep 2021 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210916182914.1810-1-mihail.chindris@analog.com> <20210916182914.1810-5-mihail.chindris@analog.com>
In-Reply-To: <20210916182914.1810-5-mihail.chindris@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 17 Sep 2021 10:53:54 +0300
Message-ID: <CA+U=Dsrm8daPO+0gob1USqSSxrkpCwR=L-2zQrW=DNEDk9ZhLA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drivers: iio: dac: ad5766: Fix dt property name
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 17, 2021 at 9:11 AM Mihail Chindris
<mihail.chindris@analog.com> wrote:
>
> In the documentation the name for the property is
> output-range-microvolts which is a standard name, therefore this name
> must be used.
>

This requires a Fixes tag.
With that addressed:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/dac/ad5766.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index 3104ec32dfac..dafda84fdea3 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -503,13 +503,13 @@ static int ad5766_get_output_range(struct ad5766_state *st)
>         int i, ret, min, max, tmp[2];
>
>         ret = device_property_read_u32_array(&st->spi->dev,
> -                                            "output-range-voltage",
> +                                            "output-range-microvolts",
>                                              tmp, 2);
>         if (ret)
>                 return ret;
>
> -       min = tmp[0] / 1000;
> -       max = tmp[1] / 1000;
> +       min = tmp[0] / 1000000;
> +       max = tmp[1] / 1000000;
>         for (i = 0; i < ARRAY_SIZE(ad5766_span_tbl); i++) {
>                 if (ad5766_span_tbl[i].min != min ||
>                     ad5766_span_tbl[i].max != max)
> --
> 2.27.0
>
