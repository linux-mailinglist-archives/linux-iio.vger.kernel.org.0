Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACF581F5F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHEOqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfHEOqm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:46:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9A020644;
        Mon,  5 Aug 2019 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016401;
        bh=udpYfEBs5Fni0kSVxlf8MtXZ882qu9sgAMr0OnCSHiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NB3anR8qnDYnBTHTxBibpYH6K0l2WhMuvxxFGQyrS9oblB1ZCLMegnlkOp0c1qx4U
         UXI5/Zwa639joIhqq2smG0Iilz4otphGgQNTFMK44h5RkpurkWiCqk6RFOeDgS9+4B
         Cyo4IYqNMM1KZwZq0cQuSmF2H9m6JAySy5rWuQKE=
Date:   Mon, 5 Aug 2019 15:46:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio:accel: preenable/postenable/predisable fixup
 for ST accel buffer
Message-ID: <20190805154638.405f7375@archlinux>
In-Reply-To: <122928ec4e082f1ec089dc8dfdf7b2acb9380b40.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
        <20190731214900.15380-2-denis.ciocca@st.com>
        <122928ec4e082f1ec089dc8dfdf7b2acb9380b40.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 08:21:53 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-07-31 at 14:48 -0700, Denis Ciocca wrote:
> > [External]
> > 
> > This patch is trying to cleanup for good the buffers operation functions.
> > There is no need of using preenable, all can be done into
> > postenable.
> > Let's also rename the goto label using operation to perform and not
> > where it fails.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,

J
> 
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> > ---
> >  drivers/iio/accel/st_accel_buffer.c | 45 +++++++++++++----------------
> >  1 file changed, 20 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> > index 05f9aea431e2..59dcef02ec19 100644
> > --- a/drivers/iio/accel/st_accel_buffer.c
> > +++ b/drivers/iio/accel/st_accel_buffer.c
> > @@ -29,56 +29,52 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
> >  	return st_sensors_set_dataready_irq(indio_dev, state);
> >  }
> >  
> > -static int st_accel_buffer_preenable(struct iio_dev *indio_dev)
> > -{
> > -	return st_sensors_set_enable(indio_dev, true);
> > -}
> > -
> >  static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> > +	int err;
> >  
> >  	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
> >  				     GFP_DMA | GFP_KERNEL);
> > -	if (adata->buffer_data == NULL) {
> > -		err = -ENOMEM;
> > -		goto allocate_memory_error;
> > -	}
> > +	if (!adata->buffer_data)
> > +		return -ENOMEM;
> >  
> >  	err = iio_triggered_buffer_postenable(indio_dev);
> >  	if (err < 0)
> > -		goto st_accel_buffer_postenable_error;
> > +		goto st_accel_free_buffer;
> >  
> >  	err = st_sensors_set_axis_enable(indio_dev,
> > -					(u8)indio_dev->active_scan_mask[0]);
> > +					 (u8)indio_dev->active_scan_mask[0]);
> >  	if (err < 0)
> > -		goto st_sensors_set_axis_enable_error;
> > +		goto st_accel_buffer_predisable;
> >  
> > -	return err;
> > +	err = st_sensors_set_enable(indio_dev, true);
> > +	if (err < 0)
> > +		goto st_accel_buffer_enable_all_axis;
> > +
> > +	return 0;
> >  
> > -st_sensors_set_axis_enable_error:
> > +st_accel_buffer_enable_all_axis:
> > +	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> > +st_accel_buffer_predisable:
> >  	iio_triggered_buffer_predisable(indio_dev);
> > -st_accel_buffer_postenable_error:
> > +st_accel_free_buffer:
> >  	kfree(adata->buffer_data);
> > -allocate_memory_error:
> >  	return err;
> >  }
> >  
> >  static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> > -	int err, err2;
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> > -
> > -	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> > -	if (err < 0)
> > -		goto st_accel_buffer_predisable_error;
> > +	int err, err2;
> >  
> >  	err = st_sensors_set_enable(indio_dev, false);
> >  	if (err < 0)
> > -		goto st_accel_buffer_predisable_error;
> > +		goto st_accel_buffer_predisable;
> > +
> > +	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> >  
> > -st_accel_buffer_predisable_error:
> > +st_accel_buffer_predisable:
> >  	err2 = iio_triggered_buffer_predisable(indio_dev);
> >  	if (!err)
> >  		err = err2;
> > @@ -88,7 +84,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
> >  }
> >  
> >  static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
> > -	.preenable = &st_accel_buffer_preenable,
> >  	.postenable = &st_accel_buffer_postenable,
> >  	.predisable = &st_accel_buffer_predisable,
> >  };  

