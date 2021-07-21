Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5F3D12D4
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhGUPLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhGUPLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 11:11:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA05C061575;
        Wed, 21 Jul 2021 08:51:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u14so2266990pga.11;
        Wed, 21 Jul 2021 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1VIjNzkDhcdHULzHXhZn5BarB3Ic4K2qWgFJwSJo8M=;
        b=Pjk37e+TScnfp+zN/Ucsx501pNQ/nUyBSEbsDTZmd8cTcgFCHyJZno6W361bQk93Sw
         o5fxX/t88CUByLG7TqShq1yp9gzxxXLR+apzQMa8hn5opPCOj+SQoKkwDh695TpXBxwb
         intQ/i2OeYRH05kMIKHI0icbTwjP7hGs7pH13rlvj6mUhiamzQSZgWmzu+5bdJ94Y5W4
         XRyJyxfdHEl5NOuQ/uYYLH5Yy24azCPawG9Ptm1Ncbz8UxlH0Eyijf5Ulj3rEk6jK+Gw
         FDl7hzeaGEYP8utHET0raqhxbGgGD6EzOqGPleM1Wtv/wdf8mMA+tR0Qk3SX9Nq2rwYe
         BRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1VIjNzkDhcdHULzHXhZn5BarB3Ic4K2qWgFJwSJo8M=;
        b=RZUlHLsUnX85QmyqeahF8ATRsOIhEm6OXTzD0+cmN05lbZYJUBcqb//MvJHWkTyCQy
         HbjOx5i8b9naqT3okav4kl3fkX1ZOXAP5+ZmDHd9ufhCYLeBWGd2kkUViVfpQAGD+jMr
         LTQkQVJBO2eod7PIFfZQkKImw4VNzQicPZlDxkx964tAAyy2rndjSEY6Lij3LcSnV1jO
         6dHK1iMUC46LTZF5yifXQV/hGSOe+tpXV8dHJJIAXGtRRfpps5di+7kWm/rJ6VtlpKM+
         /I/rhT+og5OtmHXoKM1qiij08hNtND9abax8U87/wyB2Qug45iP1VhlBFJHZ3ajPR8dP
         K3cQ==
X-Gm-Message-State: AOAM531qhLjLJSVnUvyboxN1JUAiKwpduNmQM7w3X3sBObG1jw2MlMqz
        ZklPyF8QM7Fl9DUl4aELnHOPRhX77bMKR93oExg=
X-Google-Smtp-Source: ABdhPJxgAmJ97BiwYlbrace15TU9RcrFJFEoM5gAMH6o9Axz+luMgUxTZFnHuIo09vphUGLwR9lhNeAR9PkC2SfM47g=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr1828741pgg.4.1626882699629;
 Wed, 21 Jul 2021 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151330.2176653-1-arnd@kernel.org>
In-Reply-To: <20210721151330.2176653-1-arnd@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jul 2021 18:50:59 +0300
Message-ID: <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: fix i2c dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 21, 2021 at 6:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With CONFIG_SPI=y and CONFIG_I2C=m, building fxls8962af into vmlinux
> causes a link error against the I2C module:
>
> aarch64-linux-ld: drivers/iio/accel/fxls8962af-core.o: in function `fxls8962af_fifo_flush':
> fxls8962af-core.c:(.text+0x3a0): undefined reference to `i2c_verify_client'
>
> Work around it by adding a Kconfig dependency that forces the SPI driver
> to be a loadable module whenever I2C is a module.

...

>  config FXLS8962AF
>         tristate
> +       depends on I2C || !I2C # cannot be built-in for modular I2C

Can you enlighten me how this will not be a no-op?

-- 
With Best Regards,
Andy Shevchenko
