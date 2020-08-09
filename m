Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F823FEA9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIOF7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgHIOF6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 10:05:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BF1206E9;
        Sun,  9 Aug 2020 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596981957;
        bh=E8pdcQefksj6ezRyMJ4aaYsCS2+ceUhuLgL1ee3DFTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndKbxIXzrRjuFpfTAQANn9uLoChEyhUG/5P4oA0C5ZECIDyXc0zO2emYk+obny1tr
         QKH7hP5RM9jPFOymxw68MEelUNsTbtLPviHCkYPO4R7AYXLu48ZgMRuaWuI7yAXiMV
         s4rmod9X9qBfy+qhbiBYIU2gO6/PiKFc4Xvde+JQ=
Date:   Sun, 9 Aug 2020 15:05:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH v2 5/5] iio:adc:bcm_iproc: Drop of_match_ptr protection
 and switch to mod_devicetable.h
Message-ID: <20200809150554.167e9ec2@archlinux>
In-Reply-To: <CAHp75VftkmabMn1qdJy4Pp0dQPsX1Fcia84PjTAv-xr1BdJStQ@mail.gmail.com>
References: <20200721171444.825099-1-jic23@kernel.org>
        <20200721171444.825099-6-jic23@kernel.org>
        <CAHp75VftkmabMn1qdJy4Pp0dQPsX1Fcia84PjTAv-xr1BdJStQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 21:34:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This driver cannot be instantiated from ACPI due to it's use of
> > syscon_regmap_lookup_by_phandle() but in the interests of clearing
> > this anti pattern out of IIO, let us switch to an explicit
> > check in kconfig and remove the protections on the of_match_table  
> 
> Kconfig
> 
> > The switch of header is because we only use of_device_id
> > in here and that is defined in mod_devicetable.h not of.h.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> > ---
> >  * Use Kconfig change to make it explicit you can build the driver
> >    without OF, but it won't do anything terribly useful.
> >  drivers/iio/adc/Kconfig         | 2 +-
> >  drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 66d9cc073157..f495d01a79b9 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -340,7 +340,7 @@ config AXP288_ADC
> >
> >  config BCM_IPROC_ADC
> >         tristate "Broadcom IPROC ADC driver"
> > -       depends on ARCH_BCM_IPROC || COMPILE_TEST
> > +       depends on (ARCH_BCM_IPROC && OF) || COMPILE_TEST
> >         depends on MFD_SYSCON
> >         default ARCH_BCM_CYGNUS
> >         help
> > diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> > index 936da32faa9d..44e1e53ada72 100644
> > --- a/drivers/iio/adc/bcm_iproc_adc.c
> > +++ b/drivers/iio/adc/bcm_iproc_adc.c
> > @@ -4,7 +4,7 @@
> >   */
> >
> >  #include <linux/module.h>
> > -#include <linux/of.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/io.h>
> >  #include <linux/clk.h>
> >  #include <linux/mfd/syscon.h>
> > @@ -617,7 +617,7 @@ static struct platform_driver iproc_adc_driver = {
> >         .remove = iproc_adc_remove,
> >         .driver = {
> >                 .name   = "iproc-static-adc",
> > -               .of_match_table = of_match_ptr(iproc_adc_of_match),
> > +               .of_match_table = iproc_adc_of_match,
> >         },
> >  };
> >  module_platform_driver(iproc_adc_driver);
> > --
> > 2.27.0
> >  
> 
> 

