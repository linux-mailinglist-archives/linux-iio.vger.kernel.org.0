Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4887381F74
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfHEOuE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOuE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:50:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5876F2147A;
        Mon,  5 Aug 2019 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016603;
        bh=09a9eWbz5lzOueyvOwq48iSPnxq2CRp3YeIWTYwVr1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bosJ2+GPUOOaPSPqcd0Oso22zBEH+4r85OKOoa/XN459J8oCaMMikz/1yvO5WehzD
         vlDb8KxTuQ8Yy+LRTuWoDGLlA12+5JC7fKzED/rmRH6zz2cWC4M3gsmDrXyvLD01GU
         ngQIeI1L7mzEjWd25sQdO8Sl3eHdw0RDr9P5T1n8=
Date:   Mon, 5 Aug 2019 15:49:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio:pressure: preenable/postenable/predisable
 fixup for ST press buffer
Message-ID: <20190805154959.58d56544@archlinux>
In-Reply-To: <c6ea32319e4d2dc0e8e2b7854cbdf903841bbeb2.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
        <20190731214900.15380-5-denis.ciocca@st.com>
        <c6ea32319e4d2dc0e8e2b7854cbdf903841bbeb2.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 08:22:16 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-07-31 at 14:49 -0700, Denis Ciocca wrote:
> > [External]
> > 
> > This patch is trying to cleanup for good the buffers operation functions.
> > There is no need of using preenable, all can be done into
> > postenable. Let's also use logical sequence of operations as
> > already done in accel driver.
> > Finally also rename the goto label using operation to perform and not
> > where it fails.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied

Thanks,

Jonathan

> 
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> > ---
> >  drivers/iio/pressure/st_pressure_buffer.c | 38 ++++++++++-------------
> >  1 file changed, 17 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> > index f21b630abaa0..77cb2d862f19 100644
> > --- a/drivers/iio/pressure/st_pressure_buffer.c
> > +++ b/drivers/iio/pressure/st_pressure_buffer.c
> > @@ -29,53 +29,49 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
> >  	return st_sensors_set_dataready_irq(indio_dev, state);
> >  }
> >  
> > -static int st_press_buffer_preenable(struct iio_dev *indio_dev)
> > -{
> > -	return st_sensors_set_enable(indio_dev, true);
> > -}
> > -
> >  static int st_press_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *press_data = iio_priv(indio_dev);
> > +	int err;
> >  
> >  	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
> >  					  GFP_DMA | GFP_KERNEL);
> > -	if (press_data->buffer_data == NULL) {
> > -		err = -ENOMEM;
> > -		goto allocate_memory_error;
> > -	}
> > +	if (!press_data->buffer_data)
> > +		return -ENOMEM;
> >  
> >  	err = iio_triggered_buffer_postenable(indio_dev);
> >  	if (err < 0)
> > -		goto st_press_buffer_postenable_error;
> > +		goto st_press_free_buffer;
> >  
> > -	return err;
> > +	err = st_sensors_set_enable(indio_dev, true);
> > +	if (err < 0)
> > +		goto st_press_buffer_predisable;
> > +
> > +	return 0;
> >  
> > -st_press_buffer_postenable_error:
> > +st_press_buffer_predisable:
> > +	iio_triggered_buffer_predisable(indio_dev);
> > +st_press_free_buffer:
> >  	kfree(press_data->buffer_data);
> > -allocate_memory_error:
> >  	return err;
> >  }
> >  
> >  static int st_press_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> > -	int err;
> >  	struct st_sensor_data *press_data = iio_priv(indio_dev);
> > -
> > -	err = iio_triggered_buffer_predisable(indio_dev);
> > -	if (err < 0)
> > -		goto st_press_buffer_predisable_error;
> > +	int err, err2;
> >  
> >  	err = st_sensors_set_enable(indio_dev, false);
> >  
> > -st_press_buffer_predisable_error:
> > +	err2 = iio_triggered_buffer_predisable(indio_dev);
> > +	if (!err)
> > +		err = err2;
> > +
> >  	kfree(press_data->buffer_data);
> >  	return err;
> >  }
> >  
> >  static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
> > -	.preenable = &st_press_buffer_preenable,
> >  	.postenable = &st_press_buffer_postenable,
> >  	.predisable = &st_press_buffer_predisable,
> >  };  

