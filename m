Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA11F06F3
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFFO00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFFO00 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:26:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832B62073E;
        Sat,  6 Jun 2020 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591453585;
        bh=F1nHPq3X9RQbi/97Daf6xDhCdpiGKoVqb9h1Vn5ISUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fG84cNlOkS//66ghfaLNnlTJed53+jqmd/1pmlvZ1mP8jr32P7t0uCHNsPr3y0lyU
         9ICAFBRDX8bqP+gV6xZl9C2/JIyMQFDxicPCvjIGIbA8ujYgo5FYWXhi8LlLGoWY40
         Lw8tnxQWx+KKZwZ0mcrFpLc74UyNLLf2W6h2ac6c=
Date:   Sat, 6 Jun 2020 15:26:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH] iio: Kconfig: at91_adc: add COMPILE_TEST dependency to
 driver
Message-ID: <20200606152620.4c3bc9a2@archlinux>
In-Reply-To: <20200602060650.vlfx26qb57sewcjw@sekiro>
References: <20200525102744.131672-1-alexandru.ardelean@analog.com>
        <20200531154017.04fc727f@archlinux>
        <20200602060650.vlfx26qb57sewcjw@sekiro>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Jun 2020 08:06:50 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Sun, May 31, 2020 at 03:40:17PM +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, 25 May 2020 13:27:44 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > Since changes can come from all sort of places, it may make sense to have
> > > this symbol as a dependency to make sure that the 'make allmodconfig' &&
> > > 'make allyesconfig' build rules cover this driver as well for a
> > > compile-build/test.
> > >
> > > It seemed useful [recently] when trying to apply a change for this.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > Makes sense.   Given this sort of change can expose weird an wonderful
> > dependencies that were previously hidden, I'll be wanting an
> > ack from at91 people.  
> 
> Agree.
> 
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks,

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can find any problems with relaxing
this.

Thanks,

Jonathan

> 
> Regards
> 
> Ludovic
> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/adc/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index c48c00077775..c1f4c0aec265 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -294,7 +294,7 @@ config ASPEED_ADC
> > >
> > >  config AT91_ADC
> > >       tristate "Atmel AT91 ADC"
> > > -     depends on ARCH_AT91
> > > +     depends on ARCH_AT91 || COMPILE_TEST
> > >       depends on INPUT && SYSFS
> > >       select IIO_BUFFER
> > >       select IIO_TRIGGERED_BUFFER  
> >   

