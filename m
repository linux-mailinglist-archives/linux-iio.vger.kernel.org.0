Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230D489114
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfHKJ2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 05:28:42 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49060 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKJ2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 05:28:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4DA739E75CE;
        Sun, 11 Aug 2019 10:28:38 +0100 (BST)
Date:   Sun, 11 Aug 2019 10:28:36 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Message-ID: <20190811102836.24e72761@archlinux>
In-Reply-To: <20190707130106.00001740@huawei.com>
References: <20190705134355.19493-1-alexandru.ardelean@analog.com>
        <20190707130106.00001740@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jul 2019 13:01:06 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> +CC Matt as it's his driver.  His latest email is in .mailmap.
Bump for Matt.  Please give this one a quick look.

Thanks,

Jonathan

> 
> Jonathan
> 
> 
> On Fri, 5 Jul 2019 16:43:55 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> > 
> > The iio_triggered_buffer_predisable() should be called last, to detach the
> > poll func after the devices has been suspended.
> > 
> > The position of iio_triggered_buffer_postenable() is correct.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> > index 3a20cb5d9bff..6c175eb1c7a7 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
> >  	struct atlas_data *data = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	ret = iio_triggered_buffer_predisable(indio_dev);
> > +	ret = atlas_set_interrupt(data, false);
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = atlas_set_interrupt(data, false);
> > +	pm_runtime_mark_last_busy(&data->client->dev);
> > +	ret = pm_runtime_put_autosuspend(&data->client->dev);
> >  	if (ret)
> >  		return ret;
> >  
> > -	pm_runtime_mark_last_busy(&data->client->dev);
> > -	return pm_runtime_put_autosuspend(&data->client->dev);
> > +	return iio_triggered_buffer_predisable(indio_dev);
> >  }
> >  
> >  static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {  
> 
> 

