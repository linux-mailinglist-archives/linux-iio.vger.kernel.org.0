Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DFE22A045
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGVTsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGVTsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 15:48:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD07CC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:48:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so1845816pgc.8
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdxrhbiEnbrv2CZWZUN5qEsbCqusV1NWg2B/m17zigA=;
        b=knv8pU5D9iy4L9gm2DopEtT9T2a3dhX+lbLPOZg7iBKcdRMUe2OkUYzr5S9+ukoBtq
         LXxrHK1arjob+HdEqbg5vflnTIyWW0MuReqhu9YAw1E4kMLfZZFXdzvga8zc2XYwmk8Q
         DD1TpAPz/gq0ODYD8+ciYCSn2cxjnhOYGhX5uvSx0uFoEvHNEMVGsBhfDL2X7CFl5bHG
         W/d/y72h3XW7CBXgFOffqEeldg0qK2pr/D+HRQ5bjKp4CPQIpLMu2BVvZmwa+kTSv76q
         2Ih+Nhk/gJuBYKzNMXLsyeCaxIM7S2I13GlSiz2dITJy5SssVEJiB0l/JxR2RB7p4UCl
         smig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdxrhbiEnbrv2CZWZUN5qEsbCqusV1NWg2B/m17zigA=;
        b=WBfzmsag7kp80WRpSFUT+6e7SO5k7wms8IYfG7rLZXZy7MdtqzmZ3P+JXOXx2iYRCn
         xPC7Gcmef3q055NSrBbB8eQuM6fb0YTLOrlbpbayhs/VZyUUC1qwNfb/g5OYvMVCDI0x
         2xnf7ataOjFlpS/1rOB9BAg59WX8oc6MRz0VQub0TMCK36oxuUUJ6TJyqshoxV2177LE
         rCBjX49vLxOVaDnkE2mE0Yc5Kk15NbbTn/hhmA81wuJ4Bgi/5NanGpp/3YEvR9b5u/Vf
         ZbvVq5cUgsCmmOd4Osct4MwNc2iBH46McbjSPbM2FI+HPmm5Mve1AqT1EYZFhQKejC5U
         XWPA==
X-Gm-Message-State: AOAM531i3GQN7zg2SoP0oJO9baJbjzUneicyNJHmpgXK2BASVg+o/9nZ
        fUnzre4v/twZvEs8XEqYqxEAUVUU3Ea6amKcIz4=
X-Google-Smtp-Source: ABdhPJxyhdmCyp/yqeybzRcBz2WQy2it1M3FC7zl5Sqf7MFOMwd61E5s+IubjcW9njckq4HyZlo7E8iU4bVERxe0kkU=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr1207417pgn.4.1595447283107;
 Wed, 22 Jul 2020 12:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-11-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-11-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 22:47:46 +0300
Message-ID: <CAHp75VcGDccaUwuyCBGhATTnFUEbXMw+=gq8Oe7jbYRcoArDyQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/27] iio:light:rpr0521 Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv().

> This data is allocated with kzalloc so no data can leak appart

apart

> from previous readings and in this case the status byte from the device.
>
> The forced alignment of ts is not necessary in this case but it
> potentially makes the code less fragile.

...

> +        * Note that the read will put garbage data into
> +        * the padding but this should not be a problem

> +               u8 garbage;

>         err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> -               &buffer,
> +               data->scan.channels,
>                 (3 * 2) + 1);   /* 3 * 16-bit + (discarded) int clear reg. */

But can't we read the interrupt clear register separately?

-- 
With Best Regards,
Andy Shevchenko
