Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751F04361ED
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUMl4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhJUMl4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 08:41:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26AC06161C
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:39:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v127so520802wme.5
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qy0sPAv4isL9P+q4ZcubYksRWO0eeMIFOdlsDnj3bCk=;
        b=eu/ng4B44wMnxNVqqDp7nah+tTgX6f+yBqw5DK3lFlrJu194/y9xhkpAvBMZrsMksG
         T6Gm9UOPQKtTdyUAmES8GMCZ3zYPzBW7tIWFZKB4V/spf1bsO9IjzgOUbVNy8ESCyJB4
         WleyYpmL9eVE1bY+p1KRblRK/1U/YRP2AKqm4uOtNUnqUHFLoTd1MMVVGqgx/xpdl/Eh
         9iH+GPp04EqY1Rme5IGspPEwjVeuIGMQoESrGfpELIq/Vy7ZSctBQBkr0Pox5M5VYBxG
         7A0+CZSVOgnalBDS8cSWm4GBr/LT0qEpQVTi8c8xRyt2f52INCWpWghE0J6N70lSY59s
         qcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qy0sPAv4isL9P+q4ZcubYksRWO0eeMIFOdlsDnj3bCk=;
        b=wt/xgVJpE+0jVAcfC3IfaG5EnQdgU+ERVbccPJ0gEyVGfT8f1BTq4ZxNymrzCEH46U
         9T4cOA2mn8YP9iJ5ujohoNUURZ/3K3d/gm0REGThn8HZUEFfA8txVoU6GVbctOk/6fQs
         LB7hk0rkpGvLUvouHztyDFhXIc6YQNPGzvyA9aLugW339IiNRIjkQdgs+i73sRz04VA+
         r3RE05oITwJ29xiDeeNt/Tm+LMUsD2Xndl/FFuP4HmcWngWB7McwSO0xfkA1Bv0wOczR
         hFi71yul5QM4rJO335MccfGqOyVZoxqZhxdn4dOPZlBdjOKEkV9hs9tlV+EDLt3n+GFW
         PP1A==
X-Gm-Message-State: AOAM532F+Xvlwg8L3V8W1xkJlM/gWDQaBaOQlqigv5rPhZnue/K3AGu6
        okJkJngtq6fiBS7MY9iVeC6fr6+iT+HkUxVmY4dJkCFwt5RK1w==
X-Google-Smtp-Source: ABdhPJzly/Cf+YLt/zxEggeKYiXmvI2kRULbUvZiZFGhmYaVLhKenSDUhiKP3o8vTsN//VY87WnI/aCsRymSjlsVUow=
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr6715457wmg.195.1634819978472;
 Thu, 21 Oct 2021 05:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211021121042.1372803-1-siyanteng@loongson.cn>
In-Reply-To: <20211021121042.1372803-1-siyanteng@loongson.cn>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 21 Oct 2021 14:39:01 +0200
Message-ID: <CAKv63uvBkC+n_1DBNwc9e+GoEGrEGKirAFgd6QxSnNYMMo0gMg@mail.gmail.com>
Subject: Re: [PATCH] iio/mlx90632: restyle mlx90632_calc_temp_object_iteration
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     Johnathan Iain Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yanteng Si <siyanteng@loongson.cn>,
        Linux Iio <linux-iio@vger.kernel.org>, sterlingteng@gmail.com,
        chenhuacai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Yanteng Si,
Why did you limit yourself to restyling just one function in the whole driver?

If you decide that we should restyle the driver, then please separate
the words with underscores to provide some more meaningful variable
names because name of variable for calculated Ks coefficient for
Temperature Object is kinda more meaningful than calcedksto without
any split or capitalization. Same goes for Ha_customer and Hb_customer
which are coefficients, capitalized in datasheet (hence retained
capitalization in driver) and we want to maintain some sort of
resemblance to the datasheet.

This patch is introducing a strange mix where coefficients from
datasheet are capitalized, but local variables referencing/expanding
them are not and all in just one function.

Best regards,
Crt Mori


On Thu, 21 Oct 2021 at 14:11, Yanteng Si <siyanteng01@gmail.com> wrote:
>
> ref: Documentation/process/coding-style.rst:
> C programmers do not use cute names like ThisVariableIsATemporaryCounter
>
> so,restyle mlx90632_calc_temp_object_iteration()
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/iio/temperature/mlx90632.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 608ccb1d8bc8..03257da92db4 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -547,24 +547,24 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
>                                                s32 Ga, s16 Ha, s16 Hb,
>                                                u16 emissivity)
>  {
> -       s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
> -       s64 Ha_customer, Hb_customer;
> +       s64 calcedksto, calcedksta, ir_alpha, alpha_corr;
> +       s64 ha_customer, hb_customer;
>
> -       Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
> -       Hb_customer = ((s64)Hb * 100) >> 10ULL;
> +       ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
> +       hb_customer = ((s64)Hb * 100) >> 10ULL;
>
> -       calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
> +       calcedksto = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
>                              * 1000LL)) >> 36LL;
> -       calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
> -       Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
> -                               * Ha_customer), 1000LL);
> -       Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
> -       Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
> -       Alpha_corr = div64_s64(Alpha_corr, 1000LL);
> -       ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
> -
> -       return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
> -               - 27315 - Hb_customer) * 10;
> +       calcedksta = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
> +       alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
> +                               * ha_customer), 1000LL);
> +       alpha_corr *= ((s64)(1 * 1000000LL + calcedksto + calcedksta));
> +       alpha_corr = emissivity * div64_s64(alpha_corr, 100000LL);
> +       alpha_corr = div64_s64(alpha_corr, 1000LL);
> +       ir_alpha = div64_s64((s64)object * 10000000LL, alpha_corr);
> +
> +       return (int_sqrt64(int_sqrt64(ir_alpha * 1000000000000LL + TAdut4))
> +               - 27315 - hb_customer) * 10;
>  }
>
>  static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
> --
> 2.27.0
>
