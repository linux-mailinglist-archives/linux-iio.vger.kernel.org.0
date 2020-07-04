Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3685D2147C0
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGDRfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDRfO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:35:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B1C206BE;
        Sat,  4 Jul 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593884113;
        bh=+Wzni7Tj9g/sNgEd1GtTBSm4q+QeFRqIvXomvEqIes4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LUGMYNY8r+DtxpxJK8zntoNoRH9LlDhTrTy2S2tVuDp7iAYvgiPSvIAStc4NhLS2K
         iI0uLG5Y3L6fogIaMhaaUZIjGr421VoMloqK4xpCtMPwi1r2OvvBFQ9CWUbdyjHW8q
         XwZuPxx4AH0VtGffKey+UZ//cJxtsDr280GTrmdk=
Date:   Sat, 4 Jul 2020 18:35:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/23] iio:adc more of_match_ptr and similar removal
Message-ID: <20200704183510.119e157a@archlinux>
In-Reply-To: <CAHp75VeXWF1VuWeh=-S26=zn8bqXRZFuvQxUEy8Ez8oxxrWAjQ@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <CAHp75VeXWF1VuWeh=-S26=zn8bqXRZFuvQxUEy8Ez8oxxrWAjQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:27:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Continuation of slow process to try and remove use of of_match_ptr
> > to supress asignment of the of_device_id table when !CONFIG_OF.
> >
> > Usual argument that it prevents ACPI being used with these drivers
> > via PRP0001 in DSDT.  Perhaps more usefully we are cutting down on the
> > number of places it can be cut and paste from into new drivers.
> >
> > This is just the low hanging fruit.  I'm not yet sure if it makes
> > sense to expend the effort to use generic firmware properties etc
> > for some of the remaining drivers as it is unlikely they'll ever
> > be used with anything other than device tree. There are 4 current
> > ADC drivers in this more complex category.  
> 
> For the non-commented,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Commented with LGTM also can have Rb tag.
> The rest, please consider to address.
> 
> Thanks for a nice clean up!

Thanks for your hard work going through all these.

I've applied all the good ones and will respin the others.

Thanks,

Jonathan

> 
> >
> > Jonathan Cameron (23):
> >   iio:adc:lpc32xx: Drop of_match_ptr protection
> >   iio:adc:axp20x: Convert from OF to generic fw / device properties
> >   iio:adc:hi8435: Drop unused of_gpio.h header
> >   iio:adc:hi8435: Drop of_match_ptr protection.
> >   iio:adc:max1363: Drop of_match_ptr and use generic
> >     device_get_match_data
> >   iio:adc:max1027: drop of_match_ptr and CONFIG_OF protections
> >   iio:adc:ltc2496: Drop of_match_ptr and use mod_devicetable.h
> >   iio:adc:cpcap-adc: Drop of_match_ptr protection and use
> >     device_get_match_data
> >   iio:adc:ltc2497 drop of_match_ptr protection
> >   iio:adc:max11100: Drop of_match_ptr protection / add mod_devicetable.h
> >     include
> >   iio:adc:max1118: Drop CONFIG_OF / of_match_ptr protections
> >   iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr protections
> >   iio:adc:mcp3422: remove CONFIG_OF and of_match_ptr protections
> >   iio:adc:sd_adc_modulator: Drop of_match_ptr and tweak includes
> >   iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
> >   iio:adc:ti-adc0832: drop CONFIG_OF and of_match_ptr protections
> >   iio:adc:ti-adc084s021: drop of_match_ptr protection
> >   iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
> >   iio:adc:ti-adc128s052: drop of_match_ptr protection
> >   iio:adc:ti-adc161s626: Drop of_match_ptr protection.
> >   iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr protections.
> >   iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to
> >     mod_devicetable.h
> >   iio:adc:ingenic: drop of_match_ptr protection and include
> >     mod_devicetable.h
> >
> >  drivers/iio/adc/axp20x_adc.c       | 10 +++++-----
> >  drivers/iio/adc/bcm_iproc_adc.c    |  4 ++--
> >  drivers/iio/adc/cpcap-adc.c        | 22 ++++++----------------
> >  drivers/iio/adc/hi8435.c           |  6 ++----
> >  drivers/iio/adc/ingenic-adc.c      |  5 ++---
> >  drivers/iio/adc/lpc32xx_adc.c      |  5 ++---
> >  drivers/iio/adc/ltc2496.c          |  4 ++--
> >  drivers/iio/adc/ltc2497.c          |  4 ++--
> >  drivers/iio/adc/max1027.c          |  5 ++---
> >  drivers/iio/adc/max11100.c         |  3 ++-
> >  drivers/iio/adc/max1118.c          |  7 ++-----
> >  drivers/iio/adc/max1363.c          | 11 ++++-------
> >  drivers/iio/adc/mcp320x.c          |  5 ++---
> >  drivers/iio/adc/mcp3422.c          |  6 ++----
> >  drivers/iio/adc/sd_adc_modulator.c |  5 +++--
> >  drivers/iio/adc/ti-adc081c.c       |  6 ++----
> >  drivers/iio/adc/ti-adc0832.c       |  7 ++-----
> >  drivers/iio/adc/ti-adc084s021.c    |  3 ++-
> >  drivers/iio/adc/ti-adc108s102.c    |  5 ++---
> >  drivers/iio/adc/ti-adc128s052.c    |  3 ++-
> >  drivers/iio/adc/ti-adc161s626.c    |  3 ++-
> >  drivers/iio/adc/ti-tlc4541.c       |  5 ++---
> >  22 files changed, 54 insertions(+), 80 deletions(-)
> >
> > --
> > 2.27.0
> >  
> 
> 

