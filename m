Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C43A295F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJKcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:32:53 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39597 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJKcw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:32:52 -0400
Received: by mail-pg1-f180.google.com with SMTP id z1so17784pgj.6;
        Thu, 10 Jun 2021 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Av975tbq4bCG+JCVcbrt/ynidkhIEdiwRfZUAg6OCU=;
        b=e5yW6h45UshFYnq2yTjlIBtZcoJbsjRiq71i+gu2uDrPugxEyEoy27bW9JdtKzNGH1
         3K7xhjtxZoQs3BtLzaz2Unu3WOec3EdPxB6TASpYMmln7FaBpJV229SqQqea6PophoPB
         7P/PPQ46cG7BuWIKHGvOcY04OyjhwrvdJJVv5Y6Px1NFwdBn6GAOs9UB5KAvMAkEVMq8
         xPW0JVc8pwntPtpGqgC9Hc/TIuLJ75iB+t48IT4Pd7arv95KFKHCm3p8nvA0kkHgd8b2
         zcuCgiRmPStYhNu4C3amvkHm7P45N2xrabyAMKI53zNsGHCURi8bFdmiaROhtBa/Z/8U
         3NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Av975tbq4bCG+JCVcbrt/ynidkhIEdiwRfZUAg6OCU=;
        b=JNcEJkeYhLHnZgQjaMR0HLW5t3m9XGk0HWMO2AHXjGUvhd06BpUp3oQXxBT7TYAnfh
         Vw5uNdbjVdlFYqYVVxSVRPF5DI9xLKPGfqYc/gMCO2ATHVLUbTg7cNygB36OQoqbDHIr
         x8QCzuN/66n1lq4QVefY5nIx1m67k5SAcx+XzS7prY5lZDop39/+PpZ8iGJ/46pCB0Zm
         GW1wrqb4TvYFSwEhLAGNbL0cTticTOEibO4Tl8B6qWB7ER6uTBZnKo/izAcqtBwR/9MT
         3AMFKFRhS2g4WHSXy5GjZK94+nuVsSMt8urdvNwocoKqJX4p9AqtGFsmh7rdV1D3HNHk
         Evig==
X-Gm-Message-State: AOAM531qFgcUuwcGyNxYVAtqfcVhZGNMl98PDzQWrLtpNpAkKYmVwAJg
        5SFKxH4znk3UVQulfvWtRtoJKwW8sxDL/+qQoow=
X-Google-Smtp-Source: ABdhPJyR7C/YBgAPtjBUZ8AM3Rqj50eKhN7v7X/r7g+G1SYmtmnNj5PUqhGVm+69nZnaaBeUJpYOscJwkGQS8Bcgyx4=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr2356813pfh.73.1623320982825; Thu, 10
 Jun 2021 03:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210610095300.3613-1-stephan@gerhold.net>
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 13:29:26 +0300
Message-ID: <CAHp75Vc2c3GX5jESbGexnwJ-WUtZHCjVNsqTVykCrViCjH77+Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] iio: accel: bmc150: Add support for BMA253/BMA254
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 12:56 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
> The current situation is very confusing: BMA254 is supported by the bma180
> driver, but BMA255 is supported by the bmc150-accel driver.
>
> It turns out the bma180 and bmc150-accel drivers have quite some overlap,
> and BMA253/BMA254 would be a bit better supported in bmc150
> (which has support for the motion trigger/interrupt).
>
> This series adds BMA253 support to bmc150-accel and also moves BMA254
> over to bmc150, removing some unnecessary code from the bma180 driver.
>
> I asked Linus Walleij to test these patches on BMA254 a while ago
> and he suggested that I already add his Reviewed-by.

I add


After addressing comments per patch 1, feel free to add my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to the series.

And I guess you can drop Laurentiu Palcu email because most of those
sensor drivers were done by an Intel team that is not at the company
anymore for a few years.

> Stephan Gerhold (6):
>   iio: accel: bmc150: Drop misleading/duplicate chip identifiers
>   dt-bindings: iio: accel: bma255: Document bosch,bma253
>   iio: accel: bmc150: Add device IDs for BMA253
>   dt-bindings: iio: bma255: Allow multiple interrupts
>   dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
>   iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
>
>  .../bindings/iio/accel/bosch,bma180.yaml      |  3 +-
>  .../bindings/iio/accel/bosch,bma255.yaml      |  9 +-
>  drivers/iio/accel/Kconfig                     |  6 +-
>  drivers/iio/accel/bma180.c                    | 91 +++----------------
>  drivers/iio/accel/bmc150-accel-core.c         | 36 ++------
>  drivers/iio/accel/bmc150-accel-i2c.c          | 34 ++++---
>  drivers/iio/accel/bmc150-accel-spi.c          | 31 ++++---
>  drivers/iio/accel/bmc150-accel.h              | 10 --
>  8 files changed, 67 insertions(+), 153 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
