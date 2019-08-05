Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8381F71
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfHEOtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:49:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0603520644;
        Mon,  5 Aug 2019 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016581;
        bh=mnzijCPDJoILlTIeupEi2RdKNqQcV+mFHcThkQJA7NQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2lxJMuhPIPAtqgAIXZz9Dn/EFWf2peZUbdQlCXjc0yrLQEfXDaBWOJIrtuviO75Yv
         nd/hg+tL/EdrBM4SfErHy952OQTg/pOnAwyltWqmQjA2x+ZxCozzb7ul0inpIPkSEB
         RLmtKITcFO5GWnth+/EJaMiybgvScN5xeYXXdEAg=
Date:   Mon, 5 Aug 2019 15:47:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio:magn: preenable/postenable/predisable fixup
 for ST magn buffer
Message-ID: <20190805154753.7a2b7c2f@archlinux>
In-Reply-To: <7afb7f9115903663a4da41add9b4d8419ef981ec.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
        <20190731214900.15380-4-denis.ciocca@st.com>
        <7afb7f9115903663a4da41add9b4d8419ef981ec.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 08:22:07 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-07-31 at 14:48 -0700, Denis Ciocca wrote:
> > [External]
> > 
> > This patch is trying to cleanup for good the buffers operation functions.
> > Let's rename the goto label using operation to perform and not
> > where it fails.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I'm not overly keen on the if (!err) block, but not significant enough
to not take this and get this issue tidied up.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

J
> 
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> > ---
> >  drivers/iio/magnetometer/st_magn_buffer.c | 30 ++++++++++++-----------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> > index 9dba93539a99..658d627dad8e 100644
> > --- a/drivers/iio/magnetometer/st_magn_buffer.c
> > +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> > @@ -31,40 +31,42 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
> >  
> >  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *mdata = iio_priv(indio_dev);
> > +	int err;
> >  
> >  	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
> >  				     GFP_DMA | GFP_KERNEL);
> > -	if (mdata->buffer_data == NULL) {
> > -		err = -ENOMEM;
> > -		goto allocate_memory_error;
> > -	}
> > +	if (!mdata->buffer_data)
> > +		return -ENOMEM;
> >  
> >  	err = iio_triggered_buffer_postenable(indio_dev);
> >  	if (err < 0)
> > -		goto st_magn_buffer_postenable_error;
> > +		goto st_magn_free_buffer;
> > +
> > +	err = st_sensors_set_enable(indio_dev, true);
> > +	if (err < 0)
> > +		goto st_magn_buffer_predisable;
> >  
> > -	return st_sensors_set_enable(indio_dev, true);
> > +	return 0;
> >  
> > -st_magn_buffer_postenable_error:
> > +st_magn_buffer_predisable:
> > +	iio_triggered_buffer_predisable(indio_dev);
> > +st_magn_free_buffer:
> >  	kfree(mdata->buffer_data);
> > -allocate_memory_error:
> >  	return err;
> >  }
> >  
> >  static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *mdata = iio_priv(indio_dev);
> > +	int err, err2;
> >  
> >  	err = st_sensors_set_enable(indio_dev, false);
> > -	if (err < 0)
> > -		goto st_magn_buffer_predisable_error;
> >  
> > -	err = iio_triggered_buffer_predisable(indio_dev);
> > +	err2 = iio_triggered_buffer_predisable(indio_dev);
> > +	if (!err)
> > +		err = err2;
> >  
> > -st_magn_buffer_predisable_error:
> >  	kfree(mdata->buffer_data);
> >  	return err;
> >  }  

