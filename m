Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2337FBCC
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhEMQv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhEMQv4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:51:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A78361186;
        Thu, 13 May 2021 16:50:44 +0000 (UTC)
Date:   Thu, 13 May 2021 17:51:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 20/28] iio: light: us5182: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513175153.70fd5738@jic23-huawei>
In-Reply-To: <20210512163533.2039253e@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-21-jic23@kernel.org>
        <20210512163533.2039253e@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:35:33 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:46 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
Applied.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/us5182d.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> > index 393f27b75c75..96e4a66ddf28 100644
> > --- a/drivers/iio/light/us5182d.c
> > +++ b/drivers/iio/light/us5182d.c
> > @@ -367,9 +367,7 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
> >  		return 0;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(&data->client->dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(&data->client->dev);
> > +		ret = pm_runtime_resume_and_get(&data->client->dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(&data->client->dev);
> >  		ret = pm_runtime_put_autosuspend(&data->client->dev);  
> 
> 
> 
> Thanks,
> Mauro

