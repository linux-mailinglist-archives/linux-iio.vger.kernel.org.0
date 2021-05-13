Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89F37FBC6
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhEMQto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhEMQtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:49:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CE3613C5;
        Thu, 13 May 2021 16:48:31 +0000 (UTC)
Date:   Thu, 13 May 2021 17:49:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 16/28] iio: dac: stm32-dac: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513174939.578788cb@jic23-huawei>
In-Reply-To: <20210512162026.22e8bb3e@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-17-jic23@kernel.org>
        <20210512162026.22e8bb3e@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:20:26 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:42 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied.  Thanks

Jonathan

> 
> > ---
> >  drivers/iio/dac/stm32-dac.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > index a5b0a52bf86e..dd2e306824e7 100644
> > --- a/drivers/iio/dac/stm32-dac.c
> > +++ b/drivers/iio/dac/stm32-dac.c
> > @@ -69,9 +69,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> >  	}
> >  
> >  	if (enable) {
> > -		ret = pm_runtime_get_sync(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  		if (ret < 0) {
> > -			pm_runtime_put_noidle(dev);
> >  			mutex_unlock(&dac->lock);
> >  			return ret;
> >  		}  
> 
> 
> 
> Thanks,
> Mauro

