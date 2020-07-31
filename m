Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30D234BB9
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 21:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGaTrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaTrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 15:47:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CBC061574;
        Fri, 31 Jul 2020 12:47:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so12570453plz.10;
        Fri, 31 Jul 2020 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCtzz/ikDkJ40Y/Or+xxVZzqpUQAfxOSoGmmOXHGcF0=;
        b=kZgyyXZzlTSotlgAD3426upKCbCWC8tIK3CDvULUFCFRt2C5J8Y60BGLkoyLmbrwDB
         1bKOcMzeCkT7P71wRZMeodZQbczAFXiTr5o4wVPCeHqoZ35KjV9xsG/WBA1ikQfZQnjR
         yQBqIfYq4jE9tm1TG0vQpVa5qKTSSDO2PQgqPl5IF6yopJLXKk+ncUkx9VdXHw4ULV/C
         +tvmnTVjCnbSpDB2vcHkSIIk+V52ulaIis8UqN6K2a/TE96jg5dOLnnI5R+fwC1dJkmy
         Ubh4Ym97N9r3mk+lctxG2p2gY0Pdpn5LcG8gwSn0LRF+JAw/3/YpCMr4lo3mKS8ezwH6
         T68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCtzz/ikDkJ40Y/Or+xxVZzqpUQAfxOSoGmmOXHGcF0=;
        b=AXPTRC6ktOvjf/WHvEtq7zBSzR5vXixaufCBAVhB3s8eRznyeVxd++0KPC8gFdBvnZ
         4FRw45B/WVWphlkHARfVmee99DVbzDvXNzSFr/hLUCu+R/tiuHhzzIVXXO91uDdyCB/y
         az35DVMBwBQcEzaT3eYd+FCWXT/Uj5ELLPMO/rofjx/Ir3q55fzfHw5gp1Qa2af1iz6j
         Om5pFKINEEK6OABf+xLomD/N38IzVoRgGexY8jiCouYykbaSualxhfci+bf9HuODl5Bz
         p8d4xNnz9fNF4Yo7w8OLEKO31O6eHXTTxDRBGyoRgkUw9hoXR23NkU87NCSdONxd9ui6
         GDhg==
X-Gm-Message-State: AOAM530Lhf8WGEVa0cRdqinTNbo/Lstn12qRREpr9bQrjy75ifLJtN41
        Z2hKxfhpzzy2FATqNNZJHsJ8WOmHV44IY6QWSrA=
X-Google-Smtp-Source: ABdhPJyDJn9A53QZee7pWSd5gmobL0PoAUBAt3fINUbvQ28dAdLqpDrPWrPnlfdzaRiwkcEDasBWqEIKqNkA4AZ84m0=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr5729991pjb.129.1596224832360;
 Fri, 31 Jul 2020 12:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
In-Reply-To: <20200731104555.v3.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 22:46:55 +0300
Message-ID: <CAHp75Vcyv_sbgEWEzFeSnmoMzQqrS+obogKJhjPajX1FDutF4w@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] iio: sx9310: Use irq trigger flags from firmware
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 7:49 PM Daniel Campello <campello@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> We shouldn't need to set default irq trigger flags here as the firmware
> should have properly indicated the trigger type, i.e. level low, in the
> DT or ACPI tables.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
> Changes in v3:
>  - Added irq trigger flags commit to the series.
>
> Changes in v2: None
>
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index a20cd6a4dad729..c41fa7f6558e3f 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -951,7 +951,7 @@ static int sx9310_probe(struct i2c_client *client)
>                 ret = devm_request_threaded_irq(dev, client->irq,
>                                                 sx9310_irq_handler,
>                                                 sx9310_irq_thread_handler,
> -                                               IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +                                               IRQF_ONESHOT,
>                                                 "sx9310_event", indio_dev);
>                 if (ret)
>                         return ret;
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


-- 
With Best Regards,
Andy Shevchenko
