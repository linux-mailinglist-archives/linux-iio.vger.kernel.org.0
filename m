Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5718437FBC3
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEMQrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhEMQry (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:47:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89E1613C5;
        Thu, 13 May 2021 16:46:42 +0000 (UTC)
Date:   Thu, 13 May 2021 17:47:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 14/28] iio: adc: stm32-adc: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513174750.695a2454@jic23-huawei>
In-Reply-To: <68dbe680-ff35-91d8-55f7-a3e0e65f29e7@foss.st.com>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-15-jic23@kernel.org>
        <68dbe680-ff35-91d8-55f7-a3e0e65f29e7@foss.st.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:30:14 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  drivers/iio/adc/stm32-adc.c | 24 ++++++++----------------
> >  1 file changed, 8 insertions(+), 16 deletions(-)  
> 
> Hi Jonathan,
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can find anything we missed.

Thanks,

Jonathan

> 
> Thanks for the patch,
> Regards,
> Fabrice
> 
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index c9d36c88ee6a..5088de835bb1 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -1158,11 +1158,9 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
> >  
> >  	adc->bufi = 0;
> >  
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	/* Apply sampling time settings */
> >  	stm32_adc_writel(adc, regs->smpr[0], adc->smpr_val[0]);
> > @@ -1364,11 +1362,9 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
> >  	struct device *dev = indio_dev->dev.parent;
> >  	int ret;
> >  
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
> >  
> > @@ -1413,11 +1409,9 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
> >  	struct device *dev = indio_dev->dev.parent;
> >  	int ret;
> >  
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	if (!readval)
> >  		stm32_adc_writel(adc, reg, writeval);
> > @@ -1537,11 +1531,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> >  	struct device *dev = indio_dev->dev.parent;
> >  	int ret;
> >  
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
> >  	if (ret) {
> >   

