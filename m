Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3013D483F
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGXOdh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 10:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXOdg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:33:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE51960E0C;
        Sat, 24 Jul 2021 15:14:04 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:16:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Subject: Re: [PATCH] iio: accel: fxls8962af: fix i2c dependency
Message-ID: <20210724161635.479e5238@jic23-huawei>
In-Reply-To: <CAK8P3a3SMGHvj2cywrPVQchJTmhvwq9ERsPDmV0E0K6zC0St5w@mail.gmail.com>
References: <20210721151330.2176653-1-arnd@kernel.org>
        <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
        <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
        <CAHp75VfQLGX4ir8XxMZBMkPaK2SoazJwr3axsk-5p1ok6uf6jg@mail.gmail.com>
        <CAK8P3a3SMGHvj2cywrPVQchJTmhvwq9ERsPDmV0E0K6zC0St5w@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Jul 2021 20:40:30 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> On Wed, Jul 21, 2021 at 7:34 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jul 21, 2021 at 7:12 PM Arnd Bergmann <arnd@kernel.org> wrote:  
> > > On Wed, Jul 21, 2021 at 5:52 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:  
> > > > On Wed, Jul 21, 2021 at 6:13 PM Arnd Bergmann <arnd@kernel.org> wrote:  
> >
> > ...
> >  
> > > > >  config FXLS8962AF
> > > > >         tristate
> > > > > +       depends on I2C || !I2C # cannot be built-in for modular I2C  
> > > >
> > > > Can you enlighten me how this will not be a no-op?  
> > >
> > > This part does nothing, it only causes a warning when FXLS8962AF
> > > gets selected =y when I2C=m.  
> >
> > This is something new to me. But shouldn't the other chunk guarantee
> > that warning won't happen?  
> 
> Correct, it works without that, but if that fails after something changes,
> this version would provide better diagnostics than the FXLS8962AF
> core driver causing a link failure, and I found it documents better
> why the other driver needs the dependency.
> 
> Let me know if you prefer me to resend the patch without this hunk.
> 
>       Arnd

Hi Arnd,

I didn't think of this particularly combination when we dealt with
last build issue the workaround brought in.  I've applied this to the
fixes-togreg branch of iio.git as an immediately solution, but longer
term we should think about just using a function pointer to allow us
to move this into the i2c specific module.  If we do that we can
drop this complex build logic later.

Thanks,

Jonathan


