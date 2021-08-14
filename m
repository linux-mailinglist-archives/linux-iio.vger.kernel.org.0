Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498043EC4C3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhHNThY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNThX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 15:37:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B4C061764;
        Sat, 14 Aug 2021 12:36:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f3so16160326plg.3;
        Sat, 14 Aug 2021 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMa88ZgCB+pmOBkgSDJjtHbmNgQd6frmdHWpKQQEAuM=;
        b=S1uZWzn+8JhxQyga0SXC1Zd6wfLiV6UZ+pL9/PMiilWNM9eCbSVa+lMRFCu8BoaJcc
         gFbQ5qAFuO/bpT3NWPxKRYOrGebMUDqeWHyrtfJPNR5aZ+/Gc3MGX9YdvmCkFoVYwwI/
         eW/eDhptxWiI9I4ISq53vtHhSLAWAdT+j63UZzUy7XyPq52Nyw9eKME42CnVMsAO6teV
         rWNRUUH3IpxhfSHginc8gvP+9MT+nNWqv49wosZuX718OaH1B2p4jS6QWA23TRU7CyHl
         IDQsVwoMwkomQVfQN41IxjUdOxsq8UAbvGXKAC3qlvV6gl7BX/gubsH3bWaDf366i/H1
         0d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMa88ZgCB+pmOBkgSDJjtHbmNgQd6frmdHWpKQQEAuM=;
        b=XyfE+9mwVl1+HzeMs1HY1g5cFRBenyPKbtgfFut8RyA60KJO4n8/sOW4xMjKM1+HoF
         pP701TI2QTnUAVM3b7QfMIIpRwdDDjX+7IOOg6g4ndBER4t7DwN7bJhXX6bQEh3pdHRH
         vcIZeaAkCIwtAm2mvA0xHkkGKeTRS5c3tmXpXxHOWPuMKwvIFWfbwYr2nTGagapAnCKD
         7WFR/DNpduXQZfyx84ykyeKLXuWxEMEXSocD+twytb3aHt41Bfva5Ez5lNbuDNTWCLyi
         9h5h63+3lDtqlYrKs0MTVd/6oNnzvgb5yquilzD/VZCTCGEcVNn/GCQnENxvPlTzn+DK
         OWjA==
X-Gm-Message-State: AOAM533bN2on5EU3IGD9yZO9/AwpMUEcNl9WZ65e+e44rBDRLNnhzPcO
        BhXGQBgJELvyrdRCkRenJXF5Dly9wGo9nOc8ak4=
X-Google-Smtp-Source: ABdhPJyxYRv8dIkJvibLt0nJ919CHV6jw4qAjCxZfRmiWkPkBwIT/SlZq+NQFhsHMj+EemYmUtwWdhboR6eaiNjeXYE=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr8727886pjb.129.1628969814122;
 Sat, 14 Aug 2021 12:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210814135509.4500-1-len.baker@gmx.com>
In-Reply-To: <20210814135509.4500-1-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 22:36:18 +0300
Message-ID: <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 14, 2021 at 4:55 PM Len Baker <len.baker@gmx.com> wrote:
>
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. So, remove all the uses and add
> devm_kstrdup() or devm_kasprintf() instead.
>
> This patch is an effort to clean up the proliferation of str*()
> functions in the kernel and a previous step in the path to remove
> the strcpy function from the kernel entirely [1].
>
> [1] https://github.com/KSPP/linux/issues/88

Thank you very much for doing this!
Now I like the result,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> The previous versions can be found in:
>
> v1
> https://lore.kernel.org/linux-hardening/20210801171157.17858-1-len.baker@gmx.com/
>
> v2
> https://lore.kernel.org/linux-hardening/20210807152225.9403-1-len.baker@gmx.com/
>
> v3
> https://lore.kernel.org/linux-hardening/20210814090618.8920-1-len.baker@gmx.com/
>
> Changelog v1 -> v2
> - Modify the commit changelog to inform that the motivation of this
>   patch is to remove the strcpy() function from the kernel entirely
>   (Jonathan Cameron).
>
> Changelog v2 -> v3
> - Rewrite the code using devm_kstrdup() and devm_kasprintf() functions
>   (Andy Shevchenko).
> - Rebase against v5.14-rc5.
>
> Changelog v3 -> v4
> - Reorder the variables (Andy Shevchenko).
> - Get the device in the definition block (Andy Shevchenko).
> - Reword the comment (Andy Shevchenko).
> - Change the conditions in the "if" statement to clarify the "0" check
>   (Andy Shevchenko).
>
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 30 +++++++++++++---------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index f282e9cc34c5..7eceae0012c9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -261,6 +261,7 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
>   */
>  int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  {
> +       struct device *dev = regmap_get_device(st->map);
>         const char *orient;
>         char *str;
>         int i;
> @@ -281,19 +282,24 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>                 /* z <- -z */
>                 for (i = 0; i < 3; ++i) {
>                         orient = st->orientation.rotation[6 + i];
> -                       /* use length + 2 for adding minus sign if needed */
> -                       str = devm_kzalloc(regmap_get_device(st->map),
> -                                          strlen(orient) + 2, GFP_KERNEL);
> -                       if (str == NULL)
> +
> +                       /*
> +                        * The value is negated according to one of the following
> +                        * rules:
> +                        *
> +                        * 1) Drop leading minus.
> +                        * 2) Leave 0 as is.
> +                        * 3) Add leading minus.
> +                        */
> +                       if (orient[0] == '-')
> +                               str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);
> +                       else if (orient[0] == '0' && orient[1] == '\0')
> +                               str = devm_kstrdup(dev, orient, GFP_KERNEL);
> +                       else
> +                               str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
> +                       if (!str)
>                                 return -ENOMEM;
> -                       if (strcmp(orient, "0") == 0) {
> -                               strcpy(str, orient);
> -                       } else if (orient[0] == '-') {
> -                               strcpy(str, &orient[1]);
> -                       } else {
> -                               str[0] = '-';
> -                               strcpy(&str[1], orient);
> -                       }
> +
>                         st->magn_orient.rotation[6 + i] = str;
>                 }
>                 break;
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
