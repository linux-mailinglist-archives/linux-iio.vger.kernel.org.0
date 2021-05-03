Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2393713D0
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhECKwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 06:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233142AbhECKwo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 06:52:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABA26108B;
        Mon,  3 May 2021 10:51:50 +0000 (UTC)
Date:   Mon, 3 May 2021 11:52:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        "Olivier MOYSAN" <olivier.moysan@foss.st.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: Fix docs wrongly marked as
 kernel-doc
Message-ID: <20210503115243.4c2b9c9e@jic23-huawei>
In-Reply-To: <20210429102253.00004100@Huawei.com>
References: <20210428192612.147524-1-jic23@kernel.org>
        <03045348-8edd-7a93-cdb4-2cb412ff5cd9@foss.st.com>
        <20210429102253.00004100@Huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Apr 2021 10:22:53 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 29 Apr 2021 10:16:00 +0200
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
> > On 4/28/21 9:26 PM, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > W=1 highlights these two cases that are obviously not in kernel-doc
> > > format.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>    
> > 
> > Hi Jonathan,
> > 
> > I've been a bit surprised but I finally found out the checks have
> > evolved [1].
> > [1] https://lore.kernel.org/linux-next/87pmzlvi0y.fsf@meer.lwn.net/T/
> > 
> > It seems it's exposed by commit:
> > 52042e2db452 ("scripts: kernel-doc: validate kernel-doc markup with the
> > actual names")  
> 
> Good detective work.  I wondered why this one hadn't appeared before
> yesterday but was too lazy to check :)
> 
> > 
> > You can add my:
> > Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>  

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if we missed anything.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > Fabrice
> >   
> > > ---
> > >  drivers/iio/adc/stm32-adc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > > index 922af2d75c1e..5088de835bb1 100644
> > > --- a/drivers/iio/adc/stm32-adc.c
> > > +++ b/drivers/iio/adc/stm32-adc.c
> > > @@ -449,7 +449,7 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
> > >  	.smp_bits = stm32h7_smp_bits,
> > >  };
> > >  
> > > -/**
> > > +/*
> > >   * STM32 ADC registers access routines
> > >   * @adc: stm32 adc instance
> > >   * @reg: reg offset in adc instance
> > > @@ -851,7 +851,7 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
> > >  	return 0;
> > >  }
> > >  
> > > -/**
> > > +/*
> > >   * Fixed timeout value for ADC calibration.
> > >   * worst cases:
> > >   * - low clock frequency
> > >     
> 

