Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58329A7ED
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895622AbgJ0Jdg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 05:33:36 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40177 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409223AbgJ0Jdf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 05:33:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id l2so449834pjt.5;
        Tue, 27 Oct 2020 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkZwWmEjwnHpFL1m8Vlri/WHg1rK6VrvoHhQzru19fk=;
        b=F63punD+sBQMMAWuFo7w5++PvO3lG9p1IGHfYkS9RxNL75WFDH8vSt4MxpA9cCjla8
         yg4l5U9NQyriHJ12H+oL2uSOurxy4l4dJhfWrclWNLoyANZz3eNAA7HXoMGNjSZ3kXsQ
         iYSHmMfaDauN9y62UlTv7VeBK5o68x2Y9/n5egTdHlm8kDrL87ps3SmRMoLU4MRBTuIy
         GxlvH+f7sdYypflcdVv35n3/TLok6xum7t4+zgqQsyhuxx84O/OvHdKp3mVg/t3eQ5ye
         ec3GGT8xw7BMamtZePIGarvTagbDGauXimf+cQK91Z6nHeCFaXTT1piH/8kJovLHPWbO
         0wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkZwWmEjwnHpFL1m8Vlri/WHg1rK6VrvoHhQzru19fk=;
        b=JzUqg1Z4yIaRqIYXfJQCU+1Y0wK0iLXMAmp4Vl4fGNSMN4iCN3rIwyt7dYRDLtMnon
         E55KB7Z1fbYoOdYFcDU8Fiyo8e05PUXf6Qp0ylqtWR/e8acnt2NQknFd7VKi+qdJf9As
         Gnqy+0WPN1M53PEiCkCO1JaJs2ANdxA3sud7YJGaxiRIGkvjyGtMbnzqvMR1bptGG7Yl
         TjLn5WtfEjoAP8iFIF62fSlj/11lFUjs52Ct1MNS22z1bZwuhru5ix3E7OHSBB8dEI8j
         YmMYLYDRPxK9dQEtmxvCA18whSRKJixJvS3xJKz8Lb2lOyNpzN4aKvy2oyOI9pc33Grv
         Kv1w==
X-Gm-Message-State: AOAM533LmdAoq0I6e4TSkIIhosDMNe12knS5pV1VA1nOBQqbMgzNxkGE
        cjSuyFUu/6t4g+Z3h9iZhxmrGouWfwMen2XFzI0=
X-Google-Smtp-Source: ABdhPJz3bXjuvtcCTEmhQwwCWxLGdJKGh3B5VbvWy8djXjLd1KBydfkoT1N4IxO+HZUx4ocGS26ynCYRPjiN3uE6bFg=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr1259988pjb.228.1603791213713;
 Tue, 27 Oct 2020 02:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-3-brgl@bgdev.pl>
In-Reply-To: <20201026133609.24262-3-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Oct 2020 11:33:17 +0200
Message-ID: <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of
 kfree() + kcalloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 26, 2020 at 4:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We now have devm_krealloc() in the kernel Use it indstead of calling
> kfree() and kcalloc() separately.

Which is completely lawful when size > previous_size (I mean, the
additional patch you sent previously seems not related to this).

> -       kfree(xadc->data);
> -       xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
> +       xadc->data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> +                                  n * sizeof(*xadc->data),

I think you need to use something from overflow.h instead of explicit
multiplication here.

> +                                  GFP_KERNEL | __GFP_ZERO);

-- 
With Best Regards,
Andy Shevchenko
