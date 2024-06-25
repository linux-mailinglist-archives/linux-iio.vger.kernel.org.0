Return-Path: <linux-iio+bounces-6920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A069172A1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F391F22A77
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673F17D883;
	Tue, 25 Jun 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSoxOjae"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9954C6E;
	Tue, 25 Jun 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348289; cv=none; b=mbD7RT6j7wek+4beT/irDv0TMjTLofA2uI4XI1wJkfUDmrdZMvFEuPL6lbkM91RptwB7dgoiQoRBi3rIyM+9WCwid5ptc2ta7g01qAB9TBBvAjLI+m3g/n6JZzXlqJZENwsvn8B92geZ3Iv+C7u64yz8TUTtB0ZgsvVxZxdejD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348289; c=relaxed/simple;
	bh=7CM1uNcMRbL2WWi9t6emNIXATfxoTn5T2uQeAyRyOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBK63Xi4Cgfj/vRhe1YEvtAR0iAJal3ObRYCYVTXbXQxWHVkZMZOw9CPum2uvz+/7juxYbL1u+uNBeCOUlAWfQjoEZE9hTTUfMXsl+7A7F+a/yoIIJVRH1QfkAC1n+3cfVszHxTp6MLJy05/LjiraFmS+93uospYLMlo5iwLj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSoxOjae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E320EC32781;
	Tue, 25 Jun 2024 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719348289;
	bh=7CM1uNcMRbL2WWi9t6emNIXATfxoTn5T2uQeAyRyOpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSoxOjaePp0utIpAiGZ5HHrFRjLeJqUIrPR0INpfQh/LeNfsk6mNhLyjNM1Aa1QRS
	 +42svbe0+KLxVrWW1yfZSWquZsAxDBl/HcOcj3uyJUiO+lYUrH6xoC57069D8+bpwO
	 OKKpHr4Kh+MaL3cGvFwa6ob5+5dJWWGQPuoenCRbk7jO9JNoM0fkKIsUYuIhxl8yw7
	 lF8+ZmWxv8e+/RVY1KwiMbE6x5m+Gueh4SGrte5YbTDFlI82pWR/LRk30MV1xhaMiV
	 ep/DqQwzTkIRtRRdO63v0pB69Etk5nmYqRJoeYzWqBmRu0GghME9g+FaIrZ3KUqq1m
	 w+OYi6H6Aff/Q==
Date: Tue, 25 Jun 2024 21:44:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: ak@it-klinger.de, phil@raspberrypi.com, lars@metafoo.de,
 andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
 mazziesaccount@gmail.com, petre.rodan@subdimension.ro, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Rizkalla
 <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240625214439.245ae81a@jic23-huawei>
In-Reply-To: <20240623171841.GA202685@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
	<20240617230540.32325-2-vassilisamir@gmail.com>
	<20240622102826.2ba446d9@jic23-huawei>
	<20240622121918.GA123707@vamoiridPC>
	<20240623172330.0f94cae9@jic23-huawei>
	<20240623171841.GA202685@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 19:18:41 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Jun 23, 2024 at 05:23:30PM +0100, Jonathan Cameron wrote:
> > On Sat, 22 Jun 2024 14:19:18 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > On Sat, Jun 22, 2024 at 10:28:26AM +0100, Jonathan Cameron wrote:  
> > > > On Tue, 18 Jun 2024 01:05:38 +0200
> > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > >     
> > > > > Add the coefficients for the IIO standard units and the IIO value
> > > > > inside the chip_info structure.
> > > > > 
> > > > > Move the calculations for the IIO unit compatibility from inside the
> > > > > read_{temp,press,humid}() functions and move them to the general
> > > > > read_raw() function.
> > > > > 
> > > > > In this way, all the data for the calculation of the value are
> > > > > located in the chip_info structure of the respective sensor.
> > > > > 
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>    
> > > > Does this incorporate the fix?  I'm a little confused looking at
> > > > what is visible here, so I'd like Adam to take a look.
> > > > 
> > > > Btw, you missed cc'ing Adam.
> > > >     
> > > 
> > > Ah, I only used the output of get_maintainer...  
> > 
> > always be careful to sanity check that :)
> >   
> > > ...
> > >     
> > > > > @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> > > > >  	case IIO_CHAN_INFO_PROCESSED:
> > > > >  		switch (chan->type) {
> > > > >  		case IIO_HUMIDITYRELATIVE:
> > > > > -			return data->chip_info->read_humid(data, val, val2);
> > > > > +			ret = data->chip_info->read_humid(data, &chan_value);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +
> > > > > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > > > > +			*val2 = data->chip_info->humid_coeffs[1];
> > > > > +			return data->chip_info->humid_coeffs_type;
> > > > >  		case IIO_PRESSURE:
> > > > > -			return data->chip_info->read_press(data, val, val2);
> > > > > +			ret = data->chip_info->read_press(data, &chan_value);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +
> > > > > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > > > > +			*val2 = data->chip_info->press_coeffs[1];
> > > > > +			return data->chip_info->press_coeffs_type;
> > > > >  		case IIO_TEMP:
> > > > > -			return data->chip_info->read_temp(data, val, val2);
> > > > > +			ret = data->chip_info->read_temp(data, &chan_value);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +
> > > > > +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;    
> > > 
> > > This is the first difference with the previous version where I incorporated
> > > the typecasting to (s64).  
> > 
> > On a 32 bit platform that will then get pushed into a 32 bit int and overflow
> > I think.  Back when IIO got started everything was 32 bit so it didn't make sense
> > to make these 64 bit or indeed to worry about forcing the size.
> > 
> > Jonathan
> >   
> 
> Well, I use a 32-bit platform, (BeagleBone Black) and the negative values are
> handled gracefully with this code. Also, how is that different from the previous
> code? Instead of doing the typecasting to (s64) in the bmp580_read_temp()
> function, we do it here. I feel that it is the same piece of code, just in
> different places.

The problem, I think, is the storage between those two places is too small.
It's not about negatives, but rather use that in the extremely large value
case it might not fit in the 32 bit int behind val so casting that back up
to 64 bits later won't recover the lost most significant bits.

> What I can do though, for your peace of mind is the following:
> 
> Since the problem with overflow comes when we multiply by 1000 in order to have
> milli-Celsius, what I can do, is to "force" the division with 2^16 to happen
> first. In this way, they divided value cannot be overflowed. The division will
> happen inside the bmp580_read_temp() function and let the multiplication happen
> later by the IIO code. Then we can drop the (s64) from here.

See Adam's reply - that should avoid overflow and preserve accuracy which you
tend to loose with divide then multiply.

Jonathan

> 
> How does that sound to you?
> 
> Cheers,
> Vasilis


