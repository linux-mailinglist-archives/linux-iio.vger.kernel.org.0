Return-Path: <linux-iio+bounces-6776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EF913CBD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E18B21852
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A431822F6;
	Sun, 23 Jun 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARVmTKJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCD7D405;
	Sun, 23 Jun 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159819; cv=none; b=L6RnznddhwN7t3+A0eqhR32ASU1fcgCltNrIYnGQZ0VRv9mEBpQkiWl0C9YFLG2T5b4qPPz0AUb97LbjJWjB6sKWqL/imJYwyZqIJSVg90qdx/HjOOpDDbc90vj/BfdSJmU2Fi2qizRIGy0Ujq5GhkvAhQWdyvP45wrFDqKmm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159819; c=relaxed/simple;
	bh=5t/92gk7pP2AWmNZV31QSJEMxzT4LghwhHjHBQXLMwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEWV3cOpMBCjCFWbaw/0WRitWdFWW0N14bcjKhFvvKHJmnItSw2JlRChEzGaWrI/yaLz/Zn65cfv7zYNqtQlWjqCF4ETuugYYljBmwggtRW5JOK+R849KyPIwoWXMBzuhL00OlpjpihsEMZX2JYvH0XVNiQO9ryTpC9tFIf9Exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARVmTKJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4FAC2BD10;
	Sun, 23 Jun 2024 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159818;
	bh=5t/92gk7pP2AWmNZV31QSJEMxzT4LghwhHjHBQXLMwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARVmTKJDAiLEIw18spOp4H1qWvUljqhjgXpKS/4DvnjQORkR4lCg5co/2bUaC4W1j
	 aGZxjqjqnKh85/A7zHVPCZrZj2Y8uBf70WD66lBe9mkNOulDb9qQwXZyi2DdE4c6iw
	 iFcwwGFvEE3r+yu6skvJJ6FgodcAt1MAOt3GvWI82PpHbwkSL4F79Bujk9EvBlODVx
	 d8RxFfAGPtjZYoD3a8K/gizz8VPqPKKAFHNL6kAks0wFLaMUPZRtDjtAesnNBzPc2v
	 8ZtBaj8Ig1D3AEsLvtUC/PbsBLmqlCv61jhUNCtFCFv/BCJCigLszXYtACsN9X2g4T
	 uFMEelqKcz8Gw==
Date: Sun, 23 Jun 2024 17:23:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, ak@it-klinger.de,
 phil@raspberrypi.com
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
 petre.rodan@subdimension.ro, 579lpy@gmail.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240623172330.0f94cae9@jic23-huawei>
In-Reply-To: <20240622121918.GA123707@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
	<20240617230540.32325-2-vassilisamir@gmail.com>
	<20240622102826.2ba446d9@jic23-huawei>
	<20240622121918.GA123707@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 14:19:18 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Jun 22, 2024 at 10:28:26AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Jun 2024 01:05:38 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Add the coefficients for the IIO standard units and the IIO value
> > > inside the chip_info structure.
> > > 
> > > Move the calculations for the IIO unit compatibility from inside the
> > > read_{temp,press,humid}() functions and move them to the general
> > > read_raw() function.
> > > 
> > > In this way, all the data for the calculation of the value are
> > > located in the chip_info structure of the respective sensor.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > Does this incorporate the fix?  I'm a little confused looking at
> > what is visible here, so I'd like Adam to take a look.
> > 
> > Btw, you missed cc'ing Adam.
> >   
> 
> Ah, I only used the output of get_maintainer...

always be careful to sanity check that :)

> ...
>   
> > > @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> > >  	case IIO_CHAN_INFO_PROCESSED:
> > >  		switch (chan->type) {
> > >  		case IIO_HUMIDITYRELATIVE:
> > > -			return data->chip_info->read_humid(data, val, val2);
> > > +			ret = data->chip_info->read_humid(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > > +			*val2 = data->chip_info->humid_coeffs[1];
> > > +			return data->chip_info->humid_coeffs_type;
> > >  		case IIO_PRESSURE:
> > > -			return data->chip_info->read_press(data, val, val2);
> > > +			ret = data->chip_info->read_press(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > > +			*val2 = data->chip_info->press_coeffs[1];
> > > +			return data->chip_info->press_coeffs_type;
> > >  		case IIO_TEMP:
> > > -			return data->chip_info->read_temp(data, val, val2);
> > > +			ret = data->chip_info->read_temp(data, &chan_value);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;  
> 
> This is the first difference with the previous version where I incorporated
> the typecasting to (s64).

On a 32 bit platform that will then get pushed into a 32 bit int and overflow
I think.  Back when IIO got started everything was 32 bit so it didn't make sense
to make these 64 bit or indeed to worry about forcing the size.

Jonathan


