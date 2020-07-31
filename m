Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2E234B25
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 20:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgGaSfa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 14:35:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CDC061574;
        Fri, 31 Jul 2020 11:35:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so16459441pgg.10;
        Fri, 31 Jul 2020 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uPbLYEc3IE3xvGVWE7eVveI/WSw9PvenumczRVCi68=;
        b=EJjCRbjgAzAp7WoiBsch0EchH5/33DCllbcP1OKa3mz0aFYizO8yiFYmiMGqevRSFw
         di49dpI3OfdTe8cCvbBJz5DI5IhU71Og8X6/1UsJM2b9+qZ1XOkO1uIzxU9cWSv1QenN
         BqzA2IYjwJvIoNaBARlRr1HtTxFkLfx3GmclbnTLQjoVlBJy4hFRIxR7yg4RtF00CCyw
         LtOx4R5Rv49Q+/1gVc9kk4mv+mhVMX3N/l6jK4m8MEQsa9+6IDTSOWjdhNeCvh/q9fvM
         G3Cgz/Bxbj757gysNZMXrpQ16zbt8fh/Imx7h1TK7RGMzepyEeykpezXSYwI8jTLl4RP
         M60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uPbLYEc3IE3xvGVWE7eVveI/WSw9PvenumczRVCi68=;
        b=TBn2KetnWrRM4sdrNMzmMDWtyHKW6Ux0L09LlUMfCDDgcGE87loOuhqDVTEMpJWACh
         6lIuUCcPJGMYfFaBTVKD+zbRV1sbYkw6UkRE4NMS3w609r5/dvh5suY97F3dzMUIrH42
         5d7hDIO/mZWqCNqXFomrw4JeWcj5HO5oHSpq8M6xCW3HGGCt71Zm9ClRpldActMTs3aE
         W0qq0yrz51+lQIWSNDWTaCyAegnQPu0Z8PF5qjyeopFPjOtax8EnXiTLwo0CGCwdQoKn
         EC8kYm3rJT+C18uJIGBnXvxD+harD5sFdQipk41rbs/Q6lxbzVOGFtps89/c/seL1S/j
         AnkA==
X-Gm-Message-State: AOAM532/1SZSzOgYKaq+EfhIIBdaS+E0JOATac4qbS0kHVTxLxh2f1sL
        BNBmNRHcCQC6RJOUOmuJBLrn5uMyHvuwEfr2xZ0=
X-Google-Smtp-Source: ABdhPJzyUPSRBxW207ilij7va2l3+pEgmV0Eo+vJRDpZefHXSYnAxLeyl5A9w/nUfeo4J3X/2drjcQ4habfC0HyaPgE=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr4876597pgn.4.1596220529070;
 Fri, 31 Jul 2020 11:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
In-Reply-To: <20200731104555.v3.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 21:35:12 +0300
Message-ID: <CAHp75Vd=fU9O19DGjBGOcf3im_MVz4rAasTB87KgAfkRA-uMgA@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] iio: sx9310: Fix irq handling
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 7:49 PM Daniel Campello <campello@chromium.org> wrote:
>
> Fixes enable/disable irq handling at various points. The driver needs to
> only enable/disable irqs if there is an actual irq handler installed.

...

>  static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
>  {
> -       return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
> +       if (data->client->irq)
> +               return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
> +                                         irq);
> +       return 0;

Wouldn't it be better to insert rather
if (!irq)
  return 0;
than disrupting the entire function?

>  }
>
>  static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
>  {
> -       return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
> +       if (data->client->irq)
> +               return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
> +                                         0);
> +       return 0;

Ditto.

>  }



-- 
With Best Regards,
Andy Shevchenko
