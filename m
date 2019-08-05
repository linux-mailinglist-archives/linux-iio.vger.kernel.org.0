Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39E81F72
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfHEOto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:49:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED152147A;
        Mon,  5 Aug 2019 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016583;
        bh=vPNiOt+GDDmU46ajo65v+Aee4U/12W7qVpSXefpesBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jmMXm3h9bBFl3EnrIiQ3RFJf1KKblNwrN4LEVMgkfal8WgmTXEWJt8t6/n8zRwEho
         ZEokRWiMBSgWUYUxehC56u/Kn4crlkzLbgFdm1Dvw5fteW8eKvdRQAjBtr/iWELfgC
         WmJPtf0u/THFm4mcZ+7hntTV2EtoztB5yXeYZe+w=
Date:   Mon, 5 Aug 2019 15:46:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio:gyro: preenable/postenable/predisable fixup
 for ST gyro buffer
Message-ID: <20190805154655.2190b24e@archlinux>
In-Reply-To: <f1d17225c26696b6f311e5b412fe3ebdac124b03.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
        <20190731214900.15380-3-denis.ciocca@st.com>
        <f1d17225c26696b6f311e5b412fe3ebdac124b03.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 08:22:00 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-07-31 at 14:48 -0700, Denis Ciocca wrote:
> > [External]
> > 
> > This patch is trying to cleanup for good the buffers operation functions.
> > There is no need of using preenable, all can be done into
> > postenable. Let's also use logical sequence of operations as
> > already done in accel driver.
> > Finally also rename the goto label using operation to perform and not
> > where it fails.  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

J
> 
> > 
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> > ---
> >  drivers/iio/gyro/st_gyro_buffer.c | 49 +++++++++++++++----------------
> >  1 file changed, 24 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> > index 21360681d4dd..c6ddfecc1fc3 100644
> > --- a/drivers/iio/gyro/st_gyro_buffer.c
> > +++ b/drivers/iio/gyro/st_gyro_buffer.c
> > @@ -29,62 +29,61 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
> >  	return st_sensors_set_dataready_irq(indio_dev, state);
> >  }
> >  
> > -static int st_gyro_buffer_preenable(struct iio_dev *indio_dev)
> > -{
> > -	return st_sensors_set_enable(indio_dev, true);
> > -}
> > -
> >  static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *gdata = iio_priv(indio_dev);
> > +	int err;
> >  
> >  	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
> >  				     GFP_DMA | GFP_KERNEL);
> > -	if (gdata->buffer_data == NULL) {
> > -		err = -ENOMEM;
> > -		goto allocate_memory_error;
> > -	}
> > +	if (!gdata->buffer_data)
> > +		return -ENOMEM;
> > +
> > +	err = iio_triggered_buffer_postenable(indio_dev);
> > +	if (err < 0)
> > +		goto st_gyro_free_buffer;
> >  
> >  	err = st_sensors_set_axis_enable(indio_dev,
> > -					(u8)indio_dev->active_scan_mask[0]);
> > +					 (u8)indio_dev->active_scan_mask[0]);
> >  	if (err < 0)
> > -		goto st_gyro_buffer_postenable_error;
> > +		goto st_gyro_buffer_predisable;
> >  
> > -	err = iio_triggered_buffer_postenable(indio_dev);
> > +	err = st_sensors_set_enable(indio_dev, true);
> >  	if (err < 0)
> > -		goto st_gyro_buffer_postenable_error;
> > +		goto st_gyro_buffer_enable_all_axis;
> >  
> > -	return err;
> > +	return 0;
> >  
> > -st_gyro_buffer_postenable_error:
> > +st_gyro_buffer_enable_all_axis:
> > +	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> > +st_gyro_buffer_predisable:
> > +	iio_triggered_buffer_predisable(indio_dev);
> > +st_gyro_free_buffer:
> >  	kfree(gdata->buffer_data);
> > -allocate_memory_error:
> >  	return err;
> >  }
> >  
> >  static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> > +	int err, err2;
> >  	struct st_sensor_data *gdata = iio_priv(indio_dev);
> >  
> > -	err = iio_triggered_buffer_predisable(indio_dev);
> > +	err = st_sensors_set_enable(indio_dev, false);
> >  	if (err < 0)
> > -		goto st_gyro_buffer_predisable_error;
> > +		goto st_gyro_buffer_predisable;
> >  
> >  	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> > -	if (err < 0)
> > -		goto st_gyro_buffer_predisable_error;
> >  
> > -	err = st_sensors_set_enable(indio_dev, false);
> > +st_gyro_buffer_predisable:
> > +	err2 = iio_triggered_buffer_predisable(indio_dev);
> > +	if (!err)
> > +		err = err2;
> >  
> > -st_gyro_buffer_predisable_error:
> >  	kfree(gdata->buffer_data);
> >  	return err;
> >  }
> >  
> >  static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
> > -	.preenable = &st_gyro_buffer_preenable,
> >  	.postenable = &st_gyro_buffer_postenable,
> >  	.predisable = &st_gyro_buffer_predisable,
> >  };  

