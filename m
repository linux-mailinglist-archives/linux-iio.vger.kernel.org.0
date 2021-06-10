Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26343A2BF5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFJMwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFJMwi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:52:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC06C061574;
        Thu, 10 Jun 2021 05:50:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e1so951601pld.13;
        Thu, 10 Jun 2021 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8sn9TWDmYSC8Gwzfmp4jacvlGMmaJ2rWBOjSTmgzgw=;
        b=ipmSFbE+ibBnoAshHULZ0xr0KnuAvv1GGD7lzsp8jf0dB+xdZ+66qQyFJl9JZ0iC4M
         wJqKymiZj0iT9nfqGjUCRouUEM8ctrTwPQSHjj3iz2ea7SRzDuaIvYaBlRIOlz5zGu+e
         A8pyvNQzVX1vDNxOZo4lMEMa9pxdhbeordtpU4xDZe6VXXimZ6Od5/7pTeMjBVWdlqGf
         7Jr0h9H3MevwKGJSdn4Rquarrdv+sOYr0rYGGPdd7J+KqNIutFsyNCYKSf/4w961udGm
         XaFj73iexOGbslcPQeJ7Mr/Z6ERf0UyI2pY/yhuE0M3FDoTsNuENoGLrAeldgLopHQGx
         CyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8sn9TWDmYSC8Gwzfmp4jacvlGMmaJ2rWBOjSTmgzgw=;
        b=nVXsfA6t/y79+8HaQ2gnPySRHONkZhvzTlmzhQYYOpwTxVgsDYwuXDEkTUUCTi3Vjw
         HN2pJdx7jBxHUuaOaAyd7Qqiok7mjOWPFm2cectVTbx4ftUDYB9q7jbqLYM+ds3l1o50
         NhUheNmp3qiKSwAlJqyfVAL04Z5Kku2CyFj6zFJUm5otyihr2hJxiSKYEl8LpHd7dT5B
         hgarhNTf677oziaBOcTGeLerm8mYB+kdflhi6C2dvfQoDXLfjbZKitbMoA5lnUbUX/bV
         6VI0e7aGWWwtysZsXPC4wK3VdGE6jw1kfSODxsQJu8aWJggB9gN4IVy5ziqQDDOhncaV
         4kdw==
X-Gm-Message-State: AOAM531G2LPLwb8i9zK+WtWjf6oQR8XMNc+ZfJzoFeX6OYr8vSLyfj8q
        +Lq4nJrAgY5jUlJvy5TBq0Zdw/Q/MLO1GC88fTU=
X-Google-Smtp-Source: ABdhPJzfcATEJKA4uze8oWxtxgE4e4hmArevA5/txm7z9xtEUcFeZpQb50ieLBQeycdd5HED2TYJTHsho38dEcnAqIM=
X-Received: by 2002:a17:902:c784:b029:104:9a21:262a with SMTP id
 w4-20020a170902c784b02901049a21262amr4634378pla.21.1623329441555; Thu, 10 Jun
 2021 05:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210610122126.50504-1-stephan@gerhold.net> <20210610122126.50504-5-stephan@gerhold.net>
In-Reply-To: <20210610122126.50504-5-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:50:25 +0300
Message-ID: <CAHp75Vee9+RU8zRH-QtoKmw4K-O-SjiGnpxJRnYT2Aat3qKtfw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] iio: accel: bmc150: Sort all chip names
 alphabetically / by chip ID
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
>
> Right now all the device IDs are listed in seemingly random order,
> make this consistent by ordering those alphabetically. Also, order
> bmc150_accel_chip_info_tbl by chip ID for the same reason.

Thanks!
My comments below, after addressing them,
Reviewed-by: Andy Shevchenko <andy.shevhcenko@gmail.com>

...

>         select BMC150_ACCEL_SPI if SPI
>         help
>           Say yes here to build support for the following Bosch accelerometers:
> -         BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> +         BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.

Thanks!

> -         This is a combo module with both accelerometer and magnetometer.

> +         BMC150 is a combo module with both accelerometer and magnetometer.

BMC150 is only one from the list. Previous message applies to all
listed components, so is this not true anymore for the rest?
Or all the rest is not a combo? Please, clarify that in the commit
message, or if this is a wrong change, drop it.

>           This driver is only implementing accelerometer part, which has
>           its own address and register map.

-- 
With Best Regards,
Andy Shevchenko
