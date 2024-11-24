Return-Path: <linux-iio+bounces-12589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDE9D76E3
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37FD28377F
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB37DA88;
	Sun, 24 Nov 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F91amEzn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041641746;
	Sun, 24 Nov 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470624; cv=none; b=ZykKgAgDRdpY8XQTlBC0cXQxhUn1z13cUStS9L3oPQoc3qtXQVIGnwqX7SORMhNE3++zNahToX1j37ZCIZuXdj8ZH8YPwqh5wH+5hfLWhsLEG1MuV7mSaBzRbbDOm++9hECeYoiY1byetQykC3WOeSgRqxnykK/294DLkeHqTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470624; c=relaxed/simple;
	bh=6vOrt32oKvYs9GLXgwzgX+yjwI0Xilni1o2lV9+Q/70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGkGJlKo+1Pm9+RVL12at5rnAEFtW5uTu5syIV7GYIvIz22tg1CZGAuClEzMI+sNAHApQ94kIG+C0SCuJrAVjARELR8yrMWVBzDZinKM5QB+QlwV++4IvZDtzSDWmIRaCIqQVmL1JGw6vKt/3P5Yd9XEDrzOrPJ/YdpP07Cz0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F91amEzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A15C4CECC;
	Sun, 24 Nov 2024 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732470623;
	bh=6vOrt32oKvYs9GLXgwzgX+yjwI0Xilni1o2lV9+Q/70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F91amEznREet/hyOSgn7E4yHyCS2xDp8sn/F5N6Cm/ptbGRd+t0hj2xExgXk64lvC
	 9g4HVQIfEceQKL1WZAyYPrFNSAA3XHfnbiSKckLFzfujxeGONz6Q0kVgU5LlOh9y92
	 r9L1+8M9OLWD8ABwxcHWueZkIH1S9aytu62SwO1+EADPylI9YJi887l3NsaRhVH6fr
	 KH7HUGTnVyel1Vr0AC4aG1G/elVw49F59OGRPjJuQqzbfVFhga/7i7bQhuVl7xBkbz
	 vW7qDjE25XelySdAj6s6DAeEXUQcSk/z7oRWkpwOCbBzxkkBH5T52ADnVSlw6nv8pk
	 ozjD0cTHcM4UA==
Date: Sun, 24 Nov 2024 17:50:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: veml6030: add support for triggered
 buffer
Message-ID: <20241124175018.101452fb@jic23-huawei>
In-Reply-To: <101820df-d6c6-4032-8e1e-d3d8b85720c4@gmail.com>
References: <20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com>
	<20241123151634.303aa860@jic23-huawei>
	<1f5d62d0-42af-4eda-846d-cd0d57b5c6d5@gmail.com>
	<20241124124320.4237c67e@jic23-huawei>
	<101820df-d6c6-4032-8e1e-d3d8b85720c4@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 15:47:23 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 24/11/2024 13:43, Jonathan Cameron wrote:
> >>>> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
> >>>> +{
> >>>> +	struct iio_poll_func *pf = p;
> >>>> +	struct iio_dev *iio = pf->indio_dev;
> >>>> +	struct veml6030_data *data = iio_priv(iio);
> >>>> +	unsigned int reg;
> >>>> +	int ch, ret, i = 0;
> >>>> +	struct {
> >>>> +		u16 chans[2];    
> >>> There is a hole here...     
> >>>> +		aligned_s64 timestamp;
> >>>> +	} scan;
> >>>> +
> >>>> +	iio_for_each_active_channel(iio, ch) {
> >>>> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),
> >>>> +				  &reg);
> >>>> +		if (ret)
> >>>> +			goto done;
> >>>> +
> >>>> +		scan.chans[i++] = reg;    
> >>> This fills in at least 1 channel, but maybe not the second.    
> >>>> +	}
> >>>> +    
> >>> So this leaks random stack data I think.
> >>>
> >>> Upshot, when holes are involved or not all the channels are set, need
> >>> memset(&scan, 0, sizeof(scan));
> >>> for the structure on the stack which will zero the holes as well as
> >>> both channels.
> >>>
> >>> Ancient article on this: https://lwn.net/Articles/417989/
> >>>
> >>> We get away with it when they are in the iio_priv space because they are
> >>> kzalloc + if we do leak data due to changes in configured channels it's
> >>> just old sensor data which is (I think) never a security problem!
> >>>     
> >>>> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
> >>>> +
> >>>> +done:
> >>>> +	iio_trigger_notify_done(iio->trig);
> >>>> +
> >>>> +	return IRQ_HANDLED;
> >>>> +}
> >>>> +
> >>>>  static int veml6030_set_info(struct iio_dev *indio_dev)
> >>>>  {
> >>>>  	struct veml6030_data *data = iio_priv(indio_dev);
> >>>> @@ -1077,6 +1145,12 @@ static int veml6030_probe(struct i2c_client *client)
> >>>>  	if (ret < 0)
> >>>>  		return ret;
> >>>>  
> >>>> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> >>>> +					      veml6030_trigger_handler, NULL);
> >>>> +	if (ret)
> >>>> +		return dev_err_probe(&client->dev, ret,
> >>>> +				     "Failed to register triggered buffer");
> >>>> +
> >>>>  	return devm_iio_device_register(&client->dev, indio_dev);
> >>>>  }
> >>>>  
> >>>>
> >>>> ---
> >>>> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
> >>>> change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce
> >>>>
> >>>> Best regards,    
> >>>     
> >>
> >>
> >> Hi Jonathan,
> >>
> >> thanks a lot for your explanation and the link, it makes perfect sense.
> >> By the way, when I moved this struct from the iio_priv to the function,
> >> I took a look at some existing code, and a couple of them might have the
> >> same issue:
> >>
> >> - temperature/tmp006.c: it also has a hole between the two 16-bit
> >> channels and the timestamp (aligned(8)), but it is not set to zero.
> >>
> >> - adc/ti-ads1119.c: the scan consists of an unsigned int and the
> >> timestamp (aligned(8)). I believe there is a hole there as well.
> >>
> >> I did not go over all drivers (most of them store the scan struct in the
> >> iio_priv space anyway), but at least those two look suspicious.
> >>
> >> Should I fix (e.g. memset) those two I mentioned?  
> > 
> > Please do.  Thanks!
> > 
> > Jonathan
> >   
> 
> Ok, I will take a closer look to check if there are more drivers leaking
> uninitialized data. By the way, would you tag the fixes for stable? This
> becoming an attack vector might be a bit theoretical, and I don't know
> the consensus about the danger of passing uninitialized data to userspace.

Yes. Stable would be appropriate for these. Thanks for looking into it.
Your patch had me adding checking this to my todo list but I'm very
happy to have you do it instead! :)


Jonathan

> 
> Thanks again,
> Javier Carrasco


