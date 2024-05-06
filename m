Return-Path: <linux-iio+bounces-4837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0718BCE6F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A45B26010
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178443AAD;
	Mon,  6 May 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7CaRqUK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2835280;
	Mon,  6 May 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999822; cv=none; b=K1xZ4mP5EzOTqmwH3sK2GkHq+MhYMuMVQ7ViWmkqENODSYO2jxsBNUNkL45qt4zp/XW4YnL7re7NMrA5/g5ncRxJqj/bGZDTp+AVQJgxyCT/lrrtN5+D8HTM9Dhqk0H5d9c3+Bwu+/RyJ6u2YWvJkF5tgnqz1q8gKDe9xZHBlfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999822; c=relaxed/simple;
	bh=gH5EX8v31IKKWG02ARJDY+jbpfB5szxfgpICF1R0z5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjvotH9ZGLoYgcvMtxw1tcxG2z/bcCaNU5iQIZTy27RgCyBw6LLAsSQoTOI6uzCUnLahxzFSKhlAEuerbtL6GAmmL2V78uItoTsdwVdNjKwE+BhA50xs9RRvQZGoN1QVFVRT+rPwKOSuUBjdeSw16ZHsi7ffgyG09hAHFXV2ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7CaRqUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A7AC116B1;
	Mon,  6 May 2024 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714999822;
	bh=gH5EX8v31IKKWG02ARJDY+jbpfB5szxfgpICF1R0z5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7CaRqUKBWaHOY4aLBhLpE6y/nk6SLYueNsm6kBkRo2p6qCYnMN7dCgv//NERYNuD
	 uB530fyyCqHx4j/yrSiIyp1R+DLpxQxCULrhGPJExIfNDoxDqo9tgEOIdREq/Tu03W
	 gc+Ha5mt3z6PYmM1gA3PIktMa6pPhv/2xi0WRY+fzZjO2QQxnyY3jY2oohkrBEuiil
	 dX3SQrEo9u03XKyFbWeGP//DbbrQ+TxNC8fDvqcm1hTkjLnPPGzwTuo1ii2IygeUPm
	 OjCkSvOV2HA/EqFe8CVUQVQYA5T+dWa2nxNEtsM2sSAs9uID7IK692D/L8BYvKuR2L
	 s1bS/Ti0li9Bg==
Date: Mon, 6 May 2024 13:50:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240506135010.5f7de250@jic23-huawei>
In-Reply-To: <20240505235755.GC17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-11-vassilisamir@gmail.com>
	<20240505203456.0c4c0c90@jic23-huawei>
	<20240505235755.GC17986@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 01:57:55 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, May 05, 2024 at 08:34:56PM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Apr 2024 21:00:46 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > > temperature, pressure and humidity readings. This facilitates the
> > > use of burst/bulk reads in order to acquire data faster. The
> > > approach is different from the one used in oneshot captures.
> > > 
> > > BMP085 & BMP1xx devices use a completely different measurement
> > > process that is well defined and is used in their buffer_handler().
> > > 
> > > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > Hi Vasileois,
> > 
> > Just one question on this inline. (patches 8 and 9 look good to me)
> > 
> > For v6, only need to send the patches that I haven't already applied.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > >  
> > > +static irqreturn_t bmp180_buffer_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct bmp280_data *data = iio_priv(indio_dev);
> > > +	int ret, chan_value;
> > > +
> > > +	guard(mutex)(&data->lock);
> > > +
> > > +	ret = bmp180_read_temp(data, &chan_value);
> > > +	if (ret < 0)
> > > +		return IRQ_HANDLED;
> > > +
> > > +	data->sensor_data[1] = chan_value;
> > > +
> > > +	ret = bmp180_read_press(data, &chan_value);  
> > 
> > So I 'think' that after all the refactoring you end up reading the temperature
> > twice.  To avoid that you need to pull the read_temp() and read_press()
> > function implementations here and only do the (currently duplicated) steps once.
> > 
> > You seem to have done this for the other case, but missed the bmp180?
> > Maybe I'm missing some reason it doesn't work for this one!
> >   
> 
> Hi Jonathan!
> 
> So, I didn't miss it. This is an old sensor and in order to get data out, the
> procedure is much more constrained. As you can see in the datasheet [1] in page
> 11 there is a well defined process on how to read the data out. It's not
> possible to make a burst read here. Hence, the strange bmp180_measure() function
> in order to wait for an EOC before reading the values. Indeed I am reading the
> temperature 2 times which is not optimal but in order to read both of them I
> would have to:
> 
> a) either get the temperature out of the bmp180_read_press() function
> (which would ruin a bit consistency with the other bmpxxx_read_press() functions)
> 
> b) make a bmp180_get_sensor_data() which would look like bmp180_get_press() but
> also gives temperature (which won't look that good).
> 
> That's why I didn't touch it. If you think it makes more sense to do it, I can
> follow one of the 2 approaches, whichever you think would make more sense.

Ok. As you say, old sensor so fine to not optimize it. If anyone else cares
they can do it ;)

Jonathan

> 
> Cheers,
> Vasilis
> 
> [1]: https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> 
> > > +	if (ret < 0)
> > > +		return IRQ_HANDLED;
> > > +
> > > +	data->sensor_data[0] = chan_value;
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > > +					   iio_get_time_ns(indio_dev));
> > > +
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}  


