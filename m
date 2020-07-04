Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443C2214728
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGDP7r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 11:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgGDP7r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 11:59:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C693206DF;
        Sat,  4 Jul 2020 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593878387;
        bh=RoMbegGixTxWjgFw7I8MF8yRcXEvGPK2ia/HjtQbe2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1A24cAx08z4iIXTmlEJqOUatsgf4Ftd5EIsfrKuLsE2BqLLO8Zlu8V63y2UHmhW2
         l2Eeq16QmCx2Miiaiw0Sl2jKGAsDzdb08ZkbuMuQ7AZnyyyXNlaHaWMxlgPmAEjDLf
         rhf+frXFwLcnX6t4w/LHyXWBPi9aSsXEIihBL4AI=
Date:   Sat, 4 Jul 2020 16:59:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH 22/23] iio:adc:bcm_iproc: Drop of_match_ptr protection
 and switch to mod_devicetable.h
Message-ID: <20200704165943.4a6c0f5f@archlinux>
In-Reply-To: <CAHp75Vf7vfEo9vrL3GseZNfSZWugQtKrks+eCvR+z0NKMgMzAA@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-23-jic23@kernel.org>
        <CAHp75Vf7vfEo9vrL3GseZNfSZWugQtKrks+eCvR+z0NKMgMzAA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:25:24 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst it's unlikely that this driver will ever be instantiated from
> > ACPI PRP0001 there is little advantage in using the of_match_ptr
> > protection.  The switch of header is because we only use of_match_id
> > in here and that is defined in mod_devicetable.h not of.h.
> >
> > Note the main reason for this patch is to avoid providing instances
> > of of_match_ptr being used in IIO that might get copied into new drivers.
> >  
> 
> Commit message is misleading. The change won't help with ACPI due to
> syscon_regmap_lookup_by_phandle() call.

I'd missed that.  I'll drop this one.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> > ---
> >  drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
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

