Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081D6107EE7
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKWOmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOmM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:42:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A412071B;
        Sat, 23 Nov 2019 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574520131;
        bh=74L6XuaIgHVSmOMQIWyiLLmzfOVshxQvfgxUdgttRJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uq8oBHdErcvl5NtOjTBRHj2BHdKVzf84coEOYAwZXkwwullhHzVX1YAYvf3rI4zIe
         /xH3PQV92tBBr9IFcyU8TwAWfcml4UEwosOla4jaCg3raP2UXIbnQjpwfIGK7TRvMA
         rWDqIdN1itHV0BhQAHQfZrRliAZ5yhr5ffG2CUKs=
Date:   Sat, 23 Nov 2019 14:42:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: intel_mrfld_adc: Allocating too much data in
 probe()
Message-ID: <20191123144206.7d3e5bd4@archlinux>
In-Reply-To: <20191119102332.GC32742@smile.fi.intel.com>
References: <20191119062124.kgwg7ujxe6k2ft3o@kili.mountain>
        <20191119102332.GC32742@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Nov 2019 12:23:32 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Nov 19, 2019 at 09:21:24AM +0300, Dan Carpenter wrote:
> > This probe function is passing the wrong size to devm_iio_device_alloc().
> > It is supposed to be the size of the private data.  Fortunately,
> > sizeof(*indio_dev) is larger than sizeof(struct mrfld_adc) so it doesn't
> > cause a runtime problem.
> >   
> 
> Ah, indeed, thanks for fixing this!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the fixes-togreg branch of iio.git.

I'll wait until after the merge window now to send a pull request for this
one so will be rc2ish before it's in.

Thanks,

Jonathan

> 
> > Fixes: a7118662734a ("iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/adc/intel_mrfld_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> > index 67d096f8180d..c35a1beb817c 100644
> > --- a/drivers/iio/adc/intel_mrfld_adc.c
> > +++ b/drivers/iio/adc/intel_mrfld_adc.c
> > @@ -185,7 +185,7 @@ static int mrfld_adc_probe(struct platform_device *pdev)
> >  	int irq;
> >  	int ret;
> >  
> > -	indio_dev = devm_iio_device_alloc(dev, sizeof(*indio_dev));
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mrfld_adc));  
> 
> Many drivers use sizeof(*adc) form, but I'm okay with either.
> 
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > -- 
> > 2.11.0
> >   
> 

