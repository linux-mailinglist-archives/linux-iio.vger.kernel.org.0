Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7E23F8AE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHHT6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHT6W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 15:58:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737EC061756;
        Sat,  8 Aug 2020 12:58:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so2773387pls.9;
        Sat, 08 Aug 2020 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqngm3iZM+Mi0jVvtW8AgHeoVYZvgYkVe0BtnTQBrTI=;
        b=BEqSCD3lMrl3V+1PlSx1xTxEwrwrCsUCUmvL4rCPIzs384FqXiaxhdYUKOociEXbpA
         tAl6sPD9oZx4pCBduLaGrfw35G4d7yiENmBp+oxS6FjQSxCLQggF5YYlPLtdYEwBxm7E
         xHQbtcAgB3mWlaJ8GUQ8W1ABcmsNtT/nOwwABMWSXUK4f6BcWzHtFVypnb0xUAa3TYSn
         R4g8xhaz1kRrzMrVkmDK4IpkgvKb0uXrxLhPfzBvwsR6vtAcsVi30Zk8kUe+aRsLeLve
         7kGbifoKbSTjWbjec//T3TF3VtVZHb9MNVM9GgruKxmO6e5yt4W1KJzrR13VWCAS1MoK
         D6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqngm3iZM+Mi0jVvtW8AgHeoVYZvgYkVe0BtnTQBrTI=;
        b=N3tmo9clPls0nTUrFsie104+z6gcih3DxlafCi7dhZx5YFIVL+/md4tHPhiq+kBJDd
         XskgvAsAvrBF6BC/bKLfcvZKiG6lDH1G5IsCl2XG1Ltp9rOTpqMqeQwtRKIsFqB7Fwqz
         OcYaSQvJUKspbDyXenWOvLLpeHZz/7TPq6PU4fMGvaqxmczZcRQ+sQ7g9WYuA34mCB0a
         czmT7EnHLx/UHBCwIK/HYi6/Nh2k9gQI8gMHS9mnrecYIJSa7CaecIiG7jLQk/przLM8
         88+h1t6QeE9RWx8xcTo2UyIGjeO2mKdam9RIfjg5e8+AdfAKP+6961ps4peIQp8HXUsN
         1yyg==
X-Gm-Message-State: AOAM531297iB/3XkJB7YnImc6hFo8PyYtYSzVPGEh0fJrtbpw95E+pCD
        NkOtCFNxdpCsd4IPIiYw8bAAdhAMPaHC+1Olt4M=
X-Google-Smtp-Source: ABdhPJy3oUsFoduPp6iA54MzvxhS2v3CS/SETAyx6Hyb+w6P78KDH+JCcj+6AFx77C51xDrq1ibofo2KD8drH0BYHSM=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr20206879pjp.228.1596916701394;
 Sat, 08 Aug 2020 12:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com> <20200808121026.1300375-2-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-2-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 22:58:04 +0300
Message-ID: <CAHp75VcEAeVpD+n=TpQWr56XPhBYMUs6JUOXKAUiUBejVLBceg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] iio:temperature:mlx90632: Reduce number of equal calulcations
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 3:10 PM Crt Mori <cmo@melexis.com> wrote:
>
> TAdut4 was calculated each iteration although it did not change. In light
> of near future additions of the Extended range DSP calculations, this
> function refactoring will help reduce unrelated changes in that series as
> well as reduce the number of new functions needed.

Okay, unifying these two changes (helper function and move the place
where it's called) perhaps good.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 51b812bcff2e..c3de10ba5b1e 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -374,11 +374,11 @@ static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
>  }
>
>  static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
> -                                              s64 TAdut, s32 Fa, s32 Fb,
> +                                              s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
>                                                s32 Ga, s16 Ha, s16 Hb,
>                                                u16 emissivity)
>  {
> -       s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
> +       s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
>         s64 Ha_customer, Hb_customer;
>
>         Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
> @@ -393,30 +393,35 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
>         Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
>         Alpha_corr = div64_s64(Alpha_corr, 1000LL);
>         ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
> -       TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
> -               (div64_s64(TAdut, 10000LL) + 27315) *
> -               (div64_s64(TAdut, 10000LL)  + 27315) *
> -               (div64_s64(TAdut, 10000LL) + 27315);
>
>         return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
>                 - 27315 - Hb_customer) * 10;
>  }
>
> +static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
> +{
> +       return (div64_s64(TAdut, scale) + 27315) *
> +               (div64_s64(TAdut, scale) + 27315) *
> +               (div64_s64(TAdut, scale) + 27315) *
> +               (div64_s64(TAdut, scale) + 27315);
> +}
> +
>  static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
>                                      s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
>                                      u16 tmp_emi)
>  {
> -       s64 kTA, kTA0, TAdut;
> +       s64 kTA, kTA0, TAdut, TAdut4;
>         s64 temp = 25000;
>         s8 i;
>
>         kTA = (Ea * 1000LL) >> 16LL;
>         kTA0 = (Eb * 1000LL) >> 8LL;
>         TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
> +       TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
>
>         /* Iterations of calculation as described in datasheet */
>         for (i = 0; i < 5; ++i) {
> -               temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
> +               temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
>                                                            Fa, Fb, Ga, Ha, Hb,
>                                                            tmp_emi);
>         }
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
