Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729C2380501
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhENIVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 04:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENIVw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 May 2021 04:21:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA94561408;
        Fri, 14 May 2021 08:20:39 +0000 (UTC)
Date:   Fri, 14 May 2021 09:21:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 19/28] iio: light: pa12203001: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210514092149.0cbc34d1@jic23-huawei>
In-Reply-To: <20210514093513.1d973db5@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-20-jic23@kernel.org>
        <20210514093513.1d973db5@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 May 2021 09:35:13 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:45 +0100
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

Thanks,

Applied to the togreg branch of iio.git.

Jonathan

> 
> > ---
> >  drivers/iio/light/pa12203001.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> > index bfade6577a38..a52b2c788540 100644
> > --- a/drivers/iio/light/pa12203001.c
> > +++ b/drivers/iio/light/pa12203001.c
> > @@ -186,9 +186,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
> >  	}
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(&data->client->dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(&data->client->dev);
> > +		ret = pm_runtime_resume_and_get(&data->client->dev);
> >  
> >  	} else {
> >  		pm_runtime_mark_last_busy(&data->client->dev);  
> 
> 
> 
> Thanks,
> Mauro

