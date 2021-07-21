Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0623D1684
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhGUSAM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 14:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhGUSAL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 14:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1341F61245;
        Wed, 21 Jul 2021 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626892848;
        bh=fxLeBTcwtMJIq5IP6YeqeOIxzqsNUv8gWvGoGXAJrbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PuBf9zUl9zaieOwjHvaSL3SVhSvoN7b/TIy7zskis+GdFB+eTVhcUlp+YO856DlQ1
         xiERYgp1Xwg4YZ4Ces+NGVqkm85uCBlnsynF5qiEr/+SzibE2wktMyGg82uDLyhTXE
         6CWGZT3YbIrXK3ynRTtPodQnczHPIZupIXt1VaIm+a8oJZfan2c9v7C8B5X/ONNoVV
         r3tM2dGlUYgeAOfbusiswOarEFKLmRRiooz7K9eCSXVYpJxYKM8FhntzV2QV9EAksc
         82teJ11dGhgiMOQSl9xLWJMj6OipTHP4BghDfZ0roi1SGSmhExu6oFVqImXPtLse9U
         dlS/lZaP+rlqw==
Received: by mail-wm1-f46.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1525129wmj.4;
        Wed, 21 Jul 2021 11:40:47 -0700 (PDT)
X-Gm-Message-State: AOAM533FHnZaDZ4d542ZTht9lLjQoFOL/79wkoemE7TQ95rPZg1oj328
        b24IztKAiTlJRT7sf0Sg2ww/QmseuGMuDa8z2XM=
X-Google-Smtp-Source: ABdhPJyapcX0UTSpkQnyUJxtKZP9YohAvMD132I/yNBSutw/CQX+i9Vgh62dwOdJNBBw/Q6obQMBD9Za3zCC73pL+dc=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr5478526wmb.142.1626892846710;
 Wed, 21 Jul 2021 11:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151330.2176653-1-arnd@kernel.org> <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
 <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com> <CAHp75VfQLGX4ir8XxMZBMkPaK2SoazJwr3axsk-5p1ok6uf6jg@mail.gmail.com>
In-Reply-To: <CAHp75VfQLGX4ir8XxMZBMkPaK2SoazJwr3axsk-5p1ok6uf6jg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Jul 2021 20:40:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3SMGHvj2cywrPVQchJTmhvwq9ERsPDmV0E0K6zC0St5w@mail.gmail.com>
Message-ID: <CAK8P3a3SMGHvj2cywrPVQchJTmhvwq9ERsPDmV0E0K6zC0St5w@mail.gmail.com>
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

On Wed, Jul 21, 2021 at 7:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 21, 2021 at 7:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Wed, Jul 21, 2021 at 5:52 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Jul 21, 2021 at 6:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> ...
>
> > > >  config FXLS8962AF
> > > >         tristate
> > > > +       depends on I2C || !I2C # cannot be built-in for modular I2C
> > >
> > > Can you enlighten me how this will not be a no-op?
> >
> > This part does nothing, it only causes a warning when FXLS8962AF
> > gets selected =y when I2C=m.
>
> This is something new to me. But shouldn't the other chunk guarantee
> that warning won't happen?

Correct, it works without that, but if that fails after something changes,
this version would provide better diagnostics than the FXLS8962AF
core driver causing a link failure, and I found it documents better
why the other driver needs the dependency.

Let me know if you prefer me to resend the patch without this hunk.

      Arnd
