Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15043775C5
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEIHXh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIHXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 03:23:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B3C061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 00:22:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gx21-20020a17090b1255b02901589d39576eso2007549pjb.0
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LW3gKtUZJT7ZYq0YX3IupbcId89AmP67xLW/IM+hXtQ=;
        b=Pqj9AXDDCzgXRv+vd7DGMZjtu4W+6IGI8hV8RwKNnpJ2o2kVURDU0r3T2NWrhpeyCh
         Iojv4bEmpi3jANB1W+YEFwbIVTs/LPiRbhvjvZEegZiw+KDCoPcGXYTtpGFiXIm9TU86
         uNc3WgsfqjrDgJQRoyveDs073n31W2bbYb5bSUs4/L8xuy+InuEX0+KwJgvMAD0vs0TA
         3rgn15VXnum7BaQxKvsxAhSi3ydxQrgcoMUI0lzshWbToezgRzAvzcjow1XAhHTokbMk
         9/cv4oJvLk7jP75/3M20dTVG7hTkxjQcSDqITG7hTBvjPVJjXXaTICK6Zu/TdjNDWSR4
         8HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LW3gKtUZJT7ZYq0YX3IupbcId89AmP67xLW/IM+hXtQ=;
        b=CrpefvbZFdrDKm29vBg/QAjp2T+HJ3EqDCBAOhg5ngf4lLG2l80rqV4YxeDCzG16lW
         5rqklAgK2ThP4xmJHlHMDFX/onHeOJjbXZKXrcVXJuMjShFSpqtZ5iQAp7Lxkxbz/BhV
         XF3gEzfh1pdOWL3qgcwfwjWjoGvLP/eG02TD8wG1DvXdwVNKjcLTy3wbKys5AG/GO7oR
         wow6nxPSxgUGQn0uMvWfieOfzNY0jj6OEZROhAYvRReQsfx6YgmDuFhL6qKKfdC1YcRX
         J8PBqu6S06bQ6X+Lb/BYErr4YGSADkAwsyC9G6sxPNXfrV2vy1ref+qhv4qM+Vl2gKZY
         uh8g==
X-Gm-Message-State: AOAM5328rxKWyiH9RhXnLNSr5dpPiLmzoiuA3KFoBYEga0T38nmkj9UQ
        dgCKb/qmAIj6uYo+156hhqRoGzG9+ZE0CBMmKPk=
X-Google-Smtp-Source: ABdhPJxaC8NGdFkAGNw0b2mkdxOdm4LRwl0e0oJwzhUYdT0nIfEs+VB+a7w6Zq+CP15lse6ClGth2gzZ3h4Hn2t+L1Q=
X-Received: by 2002:a17:902:b406:b029:ec:fbf2:4114 with SMTP id
 x6-20020a170902b406b02900ecfbf24114mr19141566plr.32.1620544952507; Sun, 09
 May 2021 00:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210508182319.488551-1-jic23@kernel.org> <20210508182319.488551-3-jic23@kernel.org>
In-Reply-To: <20210508182319.488551-3-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 9 May 2021 10:22:21 +0300
Message-ID: <CA+U=Dsq55Le+Bf7fR2R3yVFad5EXpckyDPPFdm0srARLMFLNMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7124: Fix potential overflow due to non
 sequential channel numbers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alexandru.tachici@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 8, 2021 at 9:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Channel numbering must start at 0 and then not have any holes, or
> it is possible to overflow the available storage.  Note this bug was
> introduced as part of a fix to ensure we didn't rely on the ordering
> of child nodes.  So we need to support arbitrary ordering but they all
> need to be there somewhere.
>
> Note I hit this when using qemu to test the rest of this series.
> Arguably this isn't the best fix, but it is probably the most minimal
> option for backporting etc.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: d7857e4ee1ba6 ("iio: adc: ad7124: Fix DT channel configuration")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/ad7124.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index c0d0870a29ff..9c2401c5848e 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -616,6 +616,13 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>                 if (ret)
>                         goto err;
>
> +               if (channel >= indio_dev->num_channels) {
> +                       dev_err(indio_dev->dev.parent,
> +                               "Channel index >= number of channels\n");
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
> +
>                 ret = of_property_read_u32_array(child, "diff-channels",
>                                                  ain, 2);
>                 if (ret)
> --
> 2.31.1
>
