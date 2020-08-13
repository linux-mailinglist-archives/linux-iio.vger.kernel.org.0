Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613A243910
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMLDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMLDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:03:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1264C061757;
        Thu, 13 Aug 2020 04:03:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 189so2000103pgg.13;
        Thu, 13 Aug 2020 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTQj+uQ+XFr43of0MRF5pj59wre6v1Z6MIsC8pgQqYU=;
        b=LT8fOYfAoab479yrA2Z7cYsNUq1O1Df6t/EJNDUvsTSNUfLhNuOKTZbdBRzFR1EH/X
         E6tFwzd3vk/1g5/nLDD8xCShzBL0CZltrBn+kdKg+fOT/OlwE+gcR2DwJDdABFOkGu9h
         Bybg1uVz+7M7tQo10HMmfxnbP/KI/ThwszqwYpdD5gGuKjpbLCh3uSaUgbWt+X2TNIGW
         8wwcsowf+rXgKlesEBTxcG9pJvGpGnmBmsgc9EJGhKNqV6cr3RCLZjGorIOBY/odvsdr
         7pc9xZCWyEBTdb5av9527aWelEcIeJ8rkvCo0bEbFrY9BAt1w3MArQuLiMoHyQf/sEtY
         F40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTQj+uQ+XFr43of0MRF5pj59wre6v1Z6MIsC8pgQqYU=;
        b=O6IwPsd7rnaHwzqwPkk8ybSWosJDtOuPg7tRH/oGRSTdaIkNImFFs/nraVBbCeP12v
         OSAecQU0AJ/pUQrS5kSXUe891ATMux1fSml2QN1jIZ5h6Tb6/boHyQxOuFD2helqZE2n
         pgGhmW1W0LMda4KeI/VsJEFZ6z0StA2nG3Av7qBf05FF9Edi5ZWanoRPNQH7Iq4GXMuj
         cS9cWPnAhWWzYjUbkamF1yOJltypNJg9chhWhwXZgnmbSa+9Taowgfu8I2zJ7sjlRHJF
         oWnLxoOD2YrdP5L1u1qHBf5M75lM2veEtjcewEkm1zzzpsL9IN2/Az41qEXJ/nelouBh
         k+WA==
X-Gm-Message-State: AOAM533mU6ImgQnNIWkTkzFpncIocLwX1xK4C6DidM3loqXbRfK4pKAy
        pDrkbySCsJCs8OZsTKBIYQzrCvFu6rubFF2p/9k=
X-Google-Smtp-Source: ABdhPJyQkyD+E6nnJtkbI6eqgCYW/6+xdw7c0Q4UFWZcS27WX3FlENl5EIdlYnSa6x59tewg4Mz5S2pDf/JpTtSPJRA=
X-Received: by 2002:a62:158e:: with SMTP id 136mr3871380pfv.36.1597316621064;
 Thu, 13 Aug 2020 04:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
In-Reply-To: <20200813075125.4949-4-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 14:03:25 +0300
Message-ID: <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while
 loop to do-while
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
>
> Reduce number of lines and improve readability to convert polling while
> loops to do-while. The iopoll.h interface was not used, because we
> require more than 20ms timeout, because time for sensor to perform a
> measurement is around 10ms and it needs to perform measurements for each
> channel (which currently is 3).

I don't see how it prevents using iopoll.h. It uses usleep_range()
under the hood in the same way you did here, but open coded.

...

> -       while (tries-- > 0) {
> +       do {
>                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
>                                   &reg_status);
>                 if (ret < 0)
>                         return ret;
> -               if (reg_status & MLX90632_STAT_DATA_RDY)
> -                       break;
>                 usleep_range(10000, 11000);
> -       }
> +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
>
>         if (tries < 0) {
>                 dev_err(&data->client->dev, "data not ready");

-- 
With Best Regards,
Andy Shevchenko
