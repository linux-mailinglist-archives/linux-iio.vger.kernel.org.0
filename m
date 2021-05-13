Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07C37FBC4
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEMQsv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhEMQsu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:48:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C935161438;
        Thu, 13 May 2021 16:47:36 +0000 (UTC)
Date:   Thu, 13 May 2021 17:48:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 15/28] iio: adc: stm32-dfsdm: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513174846.6e1a2485@jic23-huawei>
In-Reply-To: <b5ee8190-1659-f5ca-def1-6f77069870e5@foss.st.com>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-16-jic23@kernel.org>
        <b5ee8190-1659-f5ca-def1-6f77069870e5@foss.st.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:31:33 +0200
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
> >  drivers/iio/adc/stm32-dfsdm-core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)  
> 
> 
> Hi Jonathan,
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied, thanks

> 
> Thanks for the patch,
> Regards,
> Fabrice
> 
> > 
> > diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> > index bb925a11c8ae..a627af9a825e 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-core.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> > @@ -135,11 +135,9 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
> >  	int ret;
> >  
> >  	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> > -		ret = pm_runtime_get_sync(dev);
> > -		if (ret < 0) {
> > -			pm_runtime_put_noidle(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret < 0)
> >  			goto error_ret;
> > -		}
> >  
> >  		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
> >  		clk_src = priv->aclk ? 1 : 0;
> >   

