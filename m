Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA237D367
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbhELSV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbhELRfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:35:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA4C061358;
        Wed, 12 May 2021 10:33:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n3so725776plf.7;
        Wed, 12 May 2021 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/Pm8uY+AjoJVI9OqoE7C7bqpQJBmCJUql194cT1sRI=;
        b=YQCkngmEgnmJH8laOgr5SiRh1EjFYL3bZw6APsX8Ws8qgT0glcuzLp80bmFu4yqWbt
         Bg77zKgSEAJ3CU0HoirVKmeAY5KCEaU1x+TJUFFZyvrfoed6kXVUfpFueyjWNuN9ok4L
         YPB1nNk3FFFX182+gyX7v6z4zltqNb8enccvRrUZ6YVlzdzShZfV36TrxaYQmMVUzxJF
         utlM/oC7Cb/9voUmN+Ou7Z59XfxJOZvG1zVR+MwWMAHYXQspt1IeThGMlrZRukkW7deQ
         obD6cxWnZMRItH13f490p/Ca2Da/vZM/NlQiKWdxDmaHkA09EHyMql1GIqBxgLBrHVyN
         n+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/Pm8uY+AjoJVI9OqoE7C7bqpQJBmCJUql194cT1sRI=;
        b=rdRXk7Lp/jOHTA31xiden3CRaYG7p1qz/lLwycy4m05s0vpsLIEGiB/OPfCkkTVSAr
         wv9LX4NKfa7Jyme/yndx2mA9I/ai22bJJup0IWUzuJuvXfTuC2mery7BQNWQmXQlCqb1
         ckaV/rfM7R1njtz0EIVhhCe4JrlsRLgB6bBP81omyU49ktq7gZup/WpMg6RYz1xFC0RP
         ECUva8K8KOlpkwlf3JQCQYDKIm2vh+bgLpEF7RMss+NlOVhLAyenzWdwvYUqWnijF2ZD
         ncWqi4M70Nfj0m021mUGNnJKmo3kGX+g0ELSZWzazFOYDygtV641I67C7Byy7kkvy7Kw
         g0hQ==
X-Gm-Message-State: AOAM530IvBbNhpk9SL2wjTifVF8fW2XSXlFuWDQL/jWG6lty97HUnCrZ
        pW/YFJEjfwCvYyfFUybXxQzBrG9acIY5GFWF5/A=
X-Google-Smtp-Source: ABdhPJwTXd7T2dzSEPTNfRmvseSk41y6zLPIAEHJ+5CYjpYUtwD/xFC07w0jHDeQdr1S8pcozwocecMj1CYFjkUkB5A=
X-Received: by 2002:a17:90b:1c10:: with SMTP id oc16mr7425665pjb.86.1620840800569;
 Wed, 12 May 2021 10:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095649.3302835-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210510095649.3302835-1-andy.shevchenko@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 12 May 2021 20:33:09 +0300
Message-ID: <CA+U=DsoX1kTy-NwNFPajWMZnJT+cY9MocSGpgTggmhgXrhXREg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: dac: ad5770r: Put fwnode in error case during ->probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 10, 2021 at 12:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.

This feels like the device_for_each_child_node() [and the of_node
variant] iterator[s] need[s] some re-design to account for how easy it
is to slip stuff by.
But that's something quite out of this scope.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/dac/ad5770r.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index 7ab2ccf90863..8107f7bbbe3c 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -524,23 +524,29 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
>         device_for_each_child_node(&st->spi->dev, child) {
>                 ret = fwnode_property_read_u32(child, "num", &num);
>                 if (ret)
> -                       return ret;
> -               if (num >= AD5770R_MAX_CHANNELS)
> -                       return -EINVAL;
> +                       goto err_child_out;
> +               if (num >= AD5770R_MAX_CHANNELS) {
> +                       ret = -EINVAL;
> +                       goto err_child_out;
> +               }
>
>                 ret = fwnode_property_read_u32_array(child,
>                                                      "adi,range-microamp",
>                                                      tmp, 2);
>                 if (ret)
> -                       return ret;
> +                       goto err_child_out;
>
>                 min = tmp[0] / 1000;
>                 max = tmp[1] / 1000;
>                 ret = ad5770r_store_output_range(st, min, max, num);
>                 if (ret)
> -                       return ret;
> +                       goto err_child_out;
>         }
>
> +       return 0;
> +
> +err_child_out:
> +       fwnode_handle_put(child);
>         return ret;
>  }
>
> --
> 2.31.1
>
