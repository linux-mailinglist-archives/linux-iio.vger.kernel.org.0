Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3C22329
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfERKXe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 18 May 2019 06:23:34 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46302 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfERKXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 06:23:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id D88A59E7DE3;
        Sat, 18 May 2019 11:23:31 +0100 (BST)
Date:   Sat, 18 May 2019 11:23:30 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 2/5] iio: adc: ad7606: Add software configuration
Message-ID: <20190518112330.2a9167b2@archlinux>
In-Reply-To: <20190518110749.080c7a04@archlinux>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
        <20190516143208.19294-2-beniamin.bia@analog.com>
        <20190518110749.080c7a04@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 11:07:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 16 May 2019 17:32:05 +0300
> Beniamin Bia <beniamin.bia@analog.com> wrote:
> 
> > Because this driver will support multiple configurations for software,
> > the software configuration was made generic.
> > 
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>  
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
As with patch 1, I've backed this out for now as it doesn't make sense
with the later.  For reference please add.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7606.c | 40 +++++++++++++++++++++++++++++++++++++---
> >  drivers/iio/adc/ad7606.h |  2 ++
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index c66ff22f32d2..aba0fd123a51 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -140,7 +140,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
> >  			   int *val2,
> >  			   long m)
> >  {
> > -	int ret;
> > +	int ret, ch = 0;
> >  	struct ad7606_state *st = iio_priv(indio_dev);
> >  
> >  	switch (m) {
> > @@ -157,8 +157,10 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
> >  		*val = (short)ret;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> > +		if (st->sw_mode_en)
> > +			ch = chan->address;
> >  		*val = 0;
> > -		*val2 = st->scale_avail[st->range[0]];
> > +		*val2 = st->scale_avail[st->range[ch]];
> >  		return IIO_VAL_INT_PLUS_MICRO;
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >  		*val = st->oversampling;
> > @@ -233,7 +235,9 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_SCALE:
> >  		mutex_lock(&st->lock);
> >  		i = find_closest(val2, st->scale_avail, st->num_scales);
> > -		ret = st->write_scale(indio_dev, chan->address, i);
> > +		if (st->sw_mode_en)
> > +			ch = chan->address;
> > +		ret = st->write_scale(indio_dev, ch, i);
> >  		if (ret < 0) {
> >  			mutex_unlock(&st->lock);
> >  			return ret;
> > @@ -616,6 +620,36 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> >  	st->write_scale = ad7606_write_scale_hw;
> >  	st->write_os = ad7606_write_os_hw;
> >  
> > +	if (st->chip_info->sw_mode_config)
> > +		st->sw_mode_en = device_property_present(st->dev,
> > +							 "adi,sw-mode");
> > +
> > +	if (st->sw_mode_en) {
> > +		/* After reset, in software mode, ±10 V is set by default */
> > +		memset32(st->range, 2, ARRAY_SIZE(st->range));
> > +		indio_dev->info = &ad7606_info_os_and_range;
> > +
> > +		/*
> > +		 * In software mode, the range gpio has no longer its function.
> > +		 * Instead, the scale can be configured individually for each
> > +		 * channel from the range registers.
> > +		 */
> > +		if (st->chip_info->write_scale_sw)
> > +			st->write_scale = st->chip_info->write_scale_sw;
> > +
> > +		/*
> > +		 * In software mode, the oversampling is no longer configured
> > +		 * with GPIO pins. Instead, the oversampling can be configured
> > +		 * in configuratiion register.
> > +		 */
> > +		if (st->chip_info->write_os_sw)
> > +			st->write_os = st->chip_info->write_os_sw;
> > +
> > +		ret = st->chip_info->sw_mode_config(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> >  					  indio_dev->name, indio_dev->id);
> >  	if (!st->trig)
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index 143c30163df9..d8a509c2c428 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -43,6 +43,7 @@ struct ad7606_chip_info {
> >   * @range		voltage range selection, selects which scale to apply
> >   * @oversampling	oversampling selection
> >   * @base_address	address from where to read data in parallel operation
> > + * @sw_mode_en		software mode enabled
> >   * @scale_avail		pointer to the array which stores the available scales
> >   * @num_scales		number of elements stored in the scale_avail array
> >   * @oversampling_avail	pointer to the array which stores the available
> > @@ -71,6 +72,7 @@ struct ad7606_state {
> >  	unsigned int			range[16];
> >  	unsigned int			oversampling;
> >  	void __iomem			*base_address;
> > +	bool				sw_mode_en;
> >  	const unsigned int		*scale_avail;
> >  	unsigned int			num_scales;
> >  	const unsigned int		*oversampling_avail;  
> 

