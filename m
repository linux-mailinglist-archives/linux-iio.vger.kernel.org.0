Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256D618E9E5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVPzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVPzA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:55:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F2620722;
        Sun, 22 Mar 2020 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584892499;
        bh=bUaS1no88iUEEU7/gDqwncAVOF2oPiDcBG6aHYYgUl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cVET3hIVABIZKKpquH+IPWI7pl5Qq1Irs+fxRbhT0bn/uKT9Cix/VpJ4DFdH8bmJx
         MPurAe9KZDcVuwzELNPZSHW+Uzy/JYeaTKFl+PKtJd22+mEr0QgiEZJq8ALjEFtfZQ
         DG1F0kS5UGaumlrrbhWnmKd6xB/fiqMtbeqt971Q=
Date:   Sun, 22 Mar 2020 15:54:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Tachici <tachicialex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: accel: adxl372: Add support for FIFO peak
 mode
Message-ID: <20200322155455.18573976@archlinux>
In-Reply-To: <7a86c39a-1653-1e06-88df-a7cd15477ecc@metafoo.de>
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
        <20200318110958.8621-2-alexandru.tachici@analog.com>
        <7a86c39a-1653-1e06-88df-a7cd15477ecc@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 11:10:10 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/18/20 12:09 PM, Alexandru Tachici wrote:
> > From: Stefan Popa <stefan.popa@analog.com>
> > 
> > By default, if all three channels (x, y, z) are enabled, sample sets of
> > concurrent 3-axis data is stored in the FIFO. This patch adds the option
> > to configure the FIFO to store peak acceleration (x, y and z) of every
> > over-threshold event. When pushing to iio buffer we push only enabled
> > axis data.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >   drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 73 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > index 67b8817995c0..90c37d6f10d3 100644
> > --- a/drivers/iio/accel/adxl372.c
> > +++ b/drivers/iio/accel/adxl372.c
> > @@ -133,6 +133,9 @@
> >   
> >   /* The ADXL372 includes a deep, 512 sample FIFO buffer */
> >   #define ADXL372_FIFO_SIZE			512
> > +#define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
> > +#define ADXL372_Y_AXIS_EN(x)			(((x) >> 1) & 0x1)
> > +#define ADXL372_Z_AXIS_EN(x)			(((x) >> 2) & 0x1)
> >   
> >   /*
> >    * At +/- 200g with 12-bit resolution, scale is computed as:
> > @@ -253,6 +256,7 @@ struct adxl372_state {
> >   	struct iio_trigger		*dready_trig;
> >   	enum adxl372_fifo_mode		fifo_mode;
> >   	enum adxl372_fifo_format	fifo_format;
> > +	unsigned int			fifo_axis_mask;
> >   	enum adxl372_op_mode		op_mode;
> >   	enum adxl372_act_proc_mode	act_proc_mode;
> >   	enum adxl372_odr		odr;
> > @@ -264,6 +268,7 @@ struct adxl372_state {
> >   	u8				int2_bitmask;
> >   	u16				watermark;
> >   	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> > +	bool				peak_fifo_mode_en;
> >   };
> >   
> >   static const unsigned long adxl372_channel_masks[] = {
> > @@ -522,6 +527,22 @@ static int adxl372_get_status(struct adxl372_state *st,
> >   	return ret;
> >   }
> >   
> > +static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
> > +{
> > +	__be16	axis_sample[3];
> > +	int i = 0;
> > +
> > +	memset(axis_sample, 0, 3 * sizeof(__be16));
> > +	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
> > +		axis_sample[i++] = sample[0];
> > +	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
> > +		axis_sample[i++] = sample[1];
> > +	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
> > +		axis_sample[i++] = sample[2];
> > +
> > +	memcpy(sample, axis_sample, 3 * sizeof(__be16));
> > +}
> > +
> >   static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> >   {
> >   	struct iio_poll_func *pf = p;
> > @@ -553,8 +574,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> >   			goto err;
> >   
> >   		/* Each sample is 2 bytes */
> > -		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> > +		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> > +			/* filter peak detection data */
> > +			if (st->peak_fifo_mode_en)
> > +				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
> >   			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > +		}
> >   	}
> >   err:
> >   	iio_trigger_notify_done(indio_dev->trig);
> > @@ -722,6 +747,43 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
> >   	}
> >   }
> >   
> > +static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
> > +
> > +	return sprintf(buf, "%d\n", st->peak_fifo_mode_en);
> > +}
> > +
> > +static ssize_t adxl372_peak_fifo_en_set(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct adxl372_state *st = iio_priv(indio_dev);
> > +	bool val;
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = kstrtobool(buf, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->peak_fifo_mode_en = val;
> > +
> > +	iio_device_release_direct_mode(indio_dev);
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(hwfifo_peak_mode_enable, 0644,
> > +		       adxl372_peak_fifo_en_get,
> > +		       adxl372_peak_fifo_en_set, 0);
> > +  
> 
> Rather than going with a non-standard attribute, I'd register a IIO 
> trigger for the peak mode and switch between peak and normal mode by 
> assigning the corresponding trigger.
> 
> At least that's how I understand how this mode works. Data capture is 
> triggered by exceeding a threshold.

I wondered about that, but my reading of the datasheet suggests this isn't
simply a trigger that runs when data is above a threshold but rather
specifically the highest value that occurs between crossing the threshold
on the way up and crossing it again on the way down.

We could still consider it a trigger though, be it a very strange one.

There is another mode where it moves out of lower power mode into
high power mode at the first crossing of a threshold.  That one I can't
see how to implement as a trigger type really as it wouldn't jump back
into low power mode without some form of user intervention.

Confusing device...

Jonathan



> 
> - Lars
> 

