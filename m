Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A373A2BFB
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJMyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFJMyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:54:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113AC061760;
        Thu, 10 Jun 2021 05:52:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so2674876pjb.0;
        Thu, 10 Jun 2021 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk4fyyDAhmMtxrINDtAEvw1F97XWKPoUARJY7fMalVw=;
        b=k+e3MP6iz1iQjsiVg9C6dsTnnLrbQrAKKMfK3fc56GSovOZwZzouoMB5p7wAVuaLpX
         SXYGslSaHsipKd1D3aV4Go5vS611hppkRR6GjRR5wNjmOXKf4pOz+CowbzHYVxq+oI2b
         G7VX6zrHfDLjHxCW+tpqmBvJmMbUI8PQeKV4fMYPx6m/9iNX4cW+XSAwYyqoWIiMyRDG
         ryO7ocQlJJGum5SHnyoNH1GhpQEeGmN+trs8U9jeI9nOVuBGw0m54S/Mp4y8l7Odudiu
         rHSGZKQxJ1F3d0xPFuJKkQGGuZek0vkhqJ+J2Ksn2snc/lyupojhvFKcbFWtabU+2Umq
         a3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk4fyyDAhmMtxrINDtAEvw1F97XWKPoUARJY7fMalVw=;
        b=K/dt8O+elbGZV8xnHorFxy/I9KMg+/+RIdHmVfn03ivmbEg8v66foEA8//bkA79bNF
         L6Th/39vv/2Gu9dELoqwK4IgkdsSmD/5HoHxy0nLBpayr2cQwtNAKJf3ItHVJGx9tjzP
         30oubJSGn04m48KIbio0ZGkQg4kpCGQ+neBp5BjZH3WXU8DAMUDVYVQT9JOQedyADBO+
         AszkDoqIC9T+vcjZjRWuyxj5TIRBPZXcEaEwhvU1pB0qtK+X5ypffKFZT5XedvggXda+
         f4G9hutNRBQnOf5oe1CjjxOyFvrQDzn5udKIwIMqcb/GK0xr0FzuU9p476cEgOewRd4e
         TpYg==
X-Gm-Message-State: AOAM532YzOBoQhJLV5VGchEubNAA149gJADy9z6S6ax9IOc2P+9OtfQ2
        BfHL+jjcs12gdcrrT0rTHrQUG3/lzemUnKQ65RM=
X-Google-Smtp-Source: ABdhPJzD9Myv22FijPkPjOvvWXNDMFdKRdnoIRawi3+2jOqJp4IVsG0jKfnMbiYZfZKMk3FkUQe1WcAroGbqYIR5vOg=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr3285421pjw.129.1623329522542;
 Thu, 10 Jun 2021 05:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210610122126.50504-1-stephan@gerhold.net> <20210610122126.50504-7-stephan@gerhold.net>
In-Reply-To: <20210610122126.50504-7-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:51:46 +0300
Message-ID: <CAHp75VdutqFuhTnZsi79ZgcVcL+o7M1k+cOFUKRB_vUUXiWJgA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] iio: accel: bmc150: Add device IDs for BMA253
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> BMA253 is mostly like BMA255 and has exactly the same register layout
> as used by the bmc150-accel driver as far I can tell. Making it work
> is as simple as adding new device IDs for it since it has the same
> chip_id = 0xFA (250) as BMA255 and others.

...

> -               .name = "BMC150/BMI055/BMA255",

Somehow this is unsorted.

> +               .name = "BMC150/BMI055/BMA253/BMA255",

So does this.

--
With Best Regards,
Andy Shevchenko
