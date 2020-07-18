Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEE224C29
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGRPAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPAv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:00:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC172065D;
        Sat, 18 Jul 2020 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084451;
        bh=26CBZjL7uvp6pS4YJG28uV1EtS6Ger0+vvpXKdu430E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c6y2Jzwsq9GEB8orElY1PDFiEzojam1SOGInKYWRa3q0d78aF8VaE0+yxfyQ4NAGP
         forLr72tGJa/59KF+SPTU9j0rdR2+04BJeUxAyI0phuq85OrMH1QK3kh7vhsJ3bjhc
         OzgYJ56E9U3yCpBOYGfwJfIpsvxlZMQBkap/jH28=
Date:   Sat, 18 Jul 2020 16:00:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 15/30] iio: dummy: iio_dummy_evgen: Demote file header
 and supply description for 'irq_sim_domain'
Message-ID: <20200718160046.5d1c8abb@archlinux>
In-Reply-To: <CAMpxmJU1NZniOOofWykaHmpJDD=ZDw2HpRofDHHF01fvr_JZfA@mail.gmail.com>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-16-lee.jones@linaro.org>
        <CAMpxmJU1NZniOOofWykaHmpJDD=ZDw2HpRofDHHF01fvr_JZfA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jul 2020 11:24:40 +0200
Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> On Thu, Jul 16, 2020 at 3:59 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > File headers are not good candidates for kerneldoc.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/iio/dummy/iio_dummy_evgen.c:30: warning: Cannot understand  * @regs: irq regs we are faking
> >  on line 30 - I thought it was a doc line
> >  drivers/iio/dummy/iio_dummy_evgen.c:42: warning: Function parameter or member 'irq_sim_domain' not described in 'iio_dummy_eventgen'
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/iio/dummy/iio_dummy_evgen.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> > index ee85d596e5284..1febbbff0ded6 100644
> > --- a/drivers/iio/dummy/iio_dummy_evgen.c
> > +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > -/**
> > +/*
> >   * Copyright (c) 2011 Jonathan Cameron
> >   *
> >   * Companion module to the iio simple dummy example driver.
> > @@ -27,11 +27,13 @@
> >  #define IIO_EVENTGEN_NO 10
> >
> >  /**
> > + * struct iio_dummy_eventgen

Good to say what this structure is.  Perhaps "event generator specific state"

> >   * @regs: irq regs we are faking
> >   * @lock: protect the evgen state
> >   * @inuse: mask of which irqs are connected
> >   * @irq_sim: interrupt simulator
> >   * @base: base of irq range
> > + * @irq_sim_domain: irq domain  
> 
> To be even more clear: this could say: "interrupt simulator domain".
> 
> Bartosz
> 
> >   */
> >  struct iio_dummy_eventgen {
> >         struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
> > --
> > 2.25.1
> >  

