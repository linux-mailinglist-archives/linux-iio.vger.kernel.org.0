Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8446B3D1380
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 18:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhGUPcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 11:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhGUPcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 11:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFB461285;
        Wed, 21 Jul 2021 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626883961;
        bh=OjnFHZ8tdmpFhM3TyxvTpt1xji4qPhtT6r0B5g9F2TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uLL2+FyOgUssjsJ17p080HjdTceX4B9krTDb4ORTf8rTc4VIfsUXVkIiZeR6Gi7Tg
         MvWwvQVFlGyUIloVJ/noUH+g2m65+iSD8jC8VGs0z/8IsOdhn+dY84/a2UWJUJVGJX
         nPskLj65zu105YQI48iSdB/s4GQIkGlfezlbmpgR12yEqjYqtVd0xOGXVR2YVjDoTN
         nuX9GVWvJieUGI3qo4pIuLWCblt7bKBKSTlOwGA7gxc2UF1FruKMUsZ28w8WTsqlHS
         VIpRqCWuYQpvJUzi1xKYpIHn22Qgw/DgtDCTJbg+RrmfVMaonpC5v2mnjDjLRFnmtB
         gL/mpuufmNWtg==
Received: by mail-wm1-f45.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so1301063wmq.0;
        Wed, 21 Jul 2021 09:12:40 -0700 (PDT)
X-Gm-Message-State: AOAM530Aste2YynBYWcUdtRbuKodXX+f/3M/MHyTaCFobIGE0B1c7d7v
        ALvmazr29Siawyu1iia+3AgFRNoX3OoWvtn6CDs=
X-Google-Smtp-Source: ABdhPJxHifDXVmGV21hQ5eHmehAkXgkPK6Cej1JQLV4gpyFKa8nFobfzfOWutBculOCs4b4nEwCBsJ8/s1mDIYBzO/s=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4905098wmb.142.1626883959581;
 Wed, 21 Jul 2021 09:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151330.2176653-1-arnd@kernel.org> <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
In-Reply-To: <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Jul 2021 18:12:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
Message-ID: <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: fix i2c dependency
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 21, 2021 at 5:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 21, 2021 at 6:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > With CONFIG_SPI=y and CONFIG_I2C=m, building fxls8962af into vmlinux
> > causes a link error against the I2C module:
> >
> > aarch64-linux-ld: drivers/iio/accel/fxls8962af-core.o: in function `fxls8962af_fifo_flush':
> > fxls8962af-core.c:(.text+0x3a0): undefined reference to `i2c_verify_client'
> >
> > Work around it by adding a Kconfig dependency that forces the SPI driver
> > to be a loadable module whenever I2C is a module.
>
> ...
>
> >  config FXLS8962AF
> >         tristate
> > +       depends on I2C || !I2C # cannot be built-in for modular I2C
>
> Can you enlighten me how this will not be a no-op?

This part does nothing, it only causes a warning when FXLS8962AF
gets selected =y when I2C=m.

The important bit is the other hunk that adds the same dependency
to the FXLS8962AF_SPI symbol, which enforces that either I2C
is completely disabled, or treated as a dependency that prevents
the user from setting FXLS8962AF_SPI=y when that would cause
a link failure.

The effect is similar to a 'depends on SND_SOC_I2C_AND_SPI',
except we only need it on the SPI symbol here because the SPI
core cannot be in a module itself.

        Arnd
