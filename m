Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1507DCCABB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfJEPMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPMF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:12:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4377220867;
        Sat,  5 Oct 2019 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570288324;
        bh=S7qIxww7lPt/3fAevCcxLJdZiPnpm3aTVQzilJPTFV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1dcm2Mxz0YAbkI00OmGR9Xv5GkAOraAQmfAjTPpkJTGvSzPk0gPx9u2OYbF5z9HaX
         yW29lYTbK47PZm2na4FO5h+KClUk/UAiFG+VSxqNc7sQAT6ZnFksqnI12Udwo+jwdA
         pA+xIyE5Omk3p03BI2Qyrm19Nx0EnKFcNxvm5CIs=
Date:   Sat, 5 Oct 2019 16:12:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Message-ID: <20191005161200.0a82943e@archlinux>
In-Reply-To: <9e05f129826ad4ddc723a655d712bb6ae41a1259.camel@analog.com>
References: <20190920073122.21713-1-alexandru.ardelean@analog.com>
        <9e05f129826ad4ddc723a655d712bb6ae41a1259.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Matt! Looking for your input on this one if possible.

Thanks,

Jonathan


On Fri, 20 Sep 2019 07:37:56 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2019-09-20 at 10:31 +0300, Alexandru Ardelean wrote:
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> > 
> > The iio_triggered_buffer_predisable() should be called last, to detach
> > the
> > poll func after the devices has been suspended.
> >   
> 
> I just noticed this is a RESEND.
> The original is here:
> https://patchwork.kernel.org/patch/11032569/
> 
> I did not think that I probably already sent it before sending it again.
> 
> > The position of iio_triggered_buffer_postenable() is correct.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c
> > b/drivers/iio/chemical/atlas-ph-sensor.c
> > index 3a20cb5d9bff..6c175eb1c7a7 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev
> > *indio_dev)
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

