Return-Path: <linux-iio+bounces-6783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E9913D19
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71649B21298
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923318308F;
	Sun, 23 Jun 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfX1EsSJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13233C38;
	Sun, 23 Jun 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163127; cv=none; b=E2LNXt3+bXdzcTxIEIJ6rmbjAblSXXbjcJUsLqbym3T6cWjFGhVJ8nWjypXXcTRESyRamJkl7/lmtos2WZQd+dj4OLSUoh4N2N/hEWr80zqq+UqrsWC0B6bAPxzzdUuZ9wscTCBc6JdWamccVruuJ67gsYzOtUc4VNx6hXa7EYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163127; c=relaxed/simple;
	bh=Danc8q2QvFyv5/kvEt/2o3XdOBDSkM6Ompn4CudHeBs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRLGjJ/9a6csEbRalKw29YVWAoTzjHrfnsu8HZqrCvUCQhX8UKuSdgBMAmI84YaBPRs301NPQGZkVgBFV+32tJjk0ja2lagLZ2FW3pqjc7ILef+u7MiR3sB2eBkGu0qMlH5PZ4wHfn7c4kTW6OG2nWxsuXs6vj+X7ffAlKOzA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfX1EsSJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b4f1218so58290166b.2;
        Sun, 23 Jun 2024 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719163124; x=1719767924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6alJTKPzb1GbDnTWjpn6qoSeSAnp1M+mnjyOmGelEw=;
        b=IfX1EsSJ5SuPyie6iYalMxDis7yV6lJdJFMTZDPBJNjGlQ+vIUDOvLtS7e7iG9/8zN
         tGP/CU81YbaEQVq/imqN2SzaWGX2lGQwK/+ItrgbCf75+9Fo1nLADUYs4bhPEp7yxxnH
         nh1Aj1OI07lWWFhl7nJKRGy5U/UqN6INOu38szSi6wne6Y964c6G6ZKk2olFQ/nsuGS1
         XG1NAA7eSobEhC4uInP31Zi4OPjrVUj2oNBt74z43ARRyiRdklqd9ZlMJHctXiUedaBX
         eyaRf4BQ4cUQ/dBaKpHw0so5R7IpLSTNvLvk/4+waRFIneahuZRKhrM8xOTfQE1oeJa+
         NpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719163124; x=1719767924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6alJTKPzb1GbDnTWjpn6qoSeSAnp1M+mnjyOmGelEw=;
        b=tznkMsBavD0NJKyORA2ae7ggRDQ7TILfjrRle9dnnP+Az1wXIhta2P0sTTspNE9FtJ
         QHS1JwbnXt0hL2r8f6lYaVVV4joWfpiTAHfdSTyZsExRQy2OW2WH4FPjLozVVqeOH8CB
         EEGtVPUu1MxtMy1B2HP2CwVb1SY7tTw7g+KgJrKR14W/hj+Dw3w1sOT4YSsxmdb0gJkj
         sQdpC3YgDdmC9o2xO4jR3iBGXc5P0Mwm/Kb8KBkGXklouP9r4Yb9N1nsdkbJwYLPrDD3
         4rnoo12nSAiJIi98XBHSzmFL0cWsIhreF8RUMn24ym3uVA7XHuO+hSVeV77sUgD/tKwu
         mSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCRZyRHThb+DHbnZ8rJGDP4o//llx5vWnW5rhQoQ6viLIDTabTnOtclhBdcfHGNjGmRGbksnuYkuFCq62qWsOXa6Hp19GvQMe/qgD1rQKI+kANNI0mtVT8nKwIUX4SrTjAAj62+Pf6
X-Gm-Message-State: AOJu0YwBiVuAAhwZydCtsUxxeUjKpGw7F1CROE+xREtvsXTNv+/EAScf
	Fz+kd51p5hYchP+I51JR2FK+6wbpsItVWONLFsh8NB0DpUplLD2z
X-Google-Smtp-Source: AGHT+IE4npnN9erTqkiFG1WWkqimO7B/dEboV+Xy4purBA8KH6lHYPQaSOzFutFwXkkJ25WKEelw5w==
X-Received: by 2002:a17:906:2a15:b0:a6f:33d6:2d45 with SMTP id a640c23a62f3a-a7242dbc036mr179660466b.60.1719163123653;
        Sun, 23 Jun 2024 10:18:43 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:ebc6:e177:f5e2:6440])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a6bfsm320529566b.4.2024.06.23.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:18:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 23 Jun 2024 19:18:41 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, ak@it-klinger.de,
	phil@raspberrypi.com, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, petre.rodan@subdimension.ro,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240623171841.GA202685@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
 <20240617230540.32325-2-vassilisamir@gmail.com>
 <20240622102826.2ba446d9@jic23-huawei>
 <20240622121918.GA123707@vamoiridPC>
 <20240623172330.0f94cae9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623172330.0f94cae9@jic23-huawei>

On Sun, Jun 23, 2024 at 05:23:30PM +0100, Jonathan Cameron wrote:
> On Sat, 22 Jun 2024 14:19:18 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sat, Jun 22, 2024 at 10:28:26AM +0100, Jonathan Cameron wrote:
> > > On Tue, 18 Jun 2024 01:05:38 +0200
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > Add the coefficients for the IIO standard units and the IIO value
> > > > inside the chip_info structure.
> > > > 
> > > > Move the calculations for the IIO unit compatibility from inside the
> > > > read_{temp,press,humid}() functions and move them to the general
> > > > read_raw() function.
> > > > 
> > > > In this way, all the data for the calculation of the value are
> > > > located in the chip_info structure of the respective sensor.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > > Does this incorporate the fix?  I'm a little confused looking at
> > > what is visible here, so I'd like Adam to take a look.
> > > 
> > > Btw, you missed cc'ing Adam.
> > >   
> > 
> > Ah, I only used the output of get_maintainer...
> 
> always be careful to sanity check that :)
> 
> > ...
> >   
> > > > @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> > > >  	case IIO_CHAN_INFO_PROCESSED:
> > > >  		switch (chan->type) {
> > > >  		case IIO_HUMIDITYRELATIVE:
> > > > -			return data->chip_info->read_humid(data, val, val2);
> > > > +			ret = data->chip_info->read_humid(data, &chan_value);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +
> > > > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > > > +			*val2 = data->chip_info->humid_coeffs[1];
> > > > +			return data->chip_info->humid_coeffs_type;
> > > >  		case IIO_PRESSURE:
> > > > -			return data->chip_info->read_press(data, val, val2);
> > > > +			ret = data->chip_info->read_press(data, &chan_value);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +
> > > > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > > > +			*val2 = data->chip_info->press_coeffs[1];
> > > > +			return data->chip_info->press_coeffs_type;
> > > >  		case IIO_TEMP:
> > > > -			return data->chip_info->read_temp(data, val, val2);
> > > > +			ret = data->chip_info->read_temp(data, &chan_value);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +
> > > > +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;  
> > 
> > This is the first difference with the previous version where I incorporated
> > the typecasting to (s64).
> 
> On a 32 bit platform that will then get pushed into a 32 bit int and overflow
> I think.  Back when IIO got started everything was 32 bit so it didn't make sense
> to make these 64 bit or indeed to worry about forcing the size.
> 
> Jonathan
> 

Well, I use a 32-bit platform, (BeagleBone Black) and the negative values are
handled gracefully with this code. Also, how is that different from the previous
code? Instead of doing the typecasting to (s64) in the bmp580_read_temp()
function, we do it here. I feel that it is the same piece of code, just in
different places. What I can do though, for your peace of mind is the following:

Since the problem with overflow comes when we multiply by 1000 in order to have
milli-Celsius, what I can do, is to "force" the division with 2^16 to happen
first. In this way, they divided value cannot be overflowed. The division will
happen inside the bmp580_read_temp() function and let the multiplication happen
later by the IIO code. Then we can drop the (s64) from here.

How does that sound to you?

Cheers,
Vasilis

