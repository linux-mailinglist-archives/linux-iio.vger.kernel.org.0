Return-Path: <linux-iio+bounces-7049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F139E91CE69
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B281C20F9C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2212FF65;
	Sat, 29 Jun 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX1WcE3q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF311E878;
	Sat, 29 Jun 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683454; cv=none; b=LevtmgDGxCnwTbbiP17HqFx4Rf85nriKpc/aXwDNCSXaRXIKdermwZ62+DH18qMXmKrmT4PehyyqEootLOhM0E0agoZNdu2UAm/6Yqy8zoR4C/9q1N4m77BPaRJz/BMUNRZzxo+fJEsh0yG1/eLJ+JGBG0j7vgysdu4IdyDC2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683454; c=relaxed/simple;
	bh=ITDBg+BM/o2RD6OiOLTIdk8OthQXA0HiROBqsQ/2j+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWzR94Hf11pcrw+Vv5XEWON/1ZA31fNdVbkyUxvsF7+X6MTrigRWP3GRgLETmQGEeNnZWdzT7ryevOWqPX4gNJu6RVnbnDeMR9I/+EmdqPyirOCe3CXbK/PwV139Yu/X9Y2iQGEanYUgx3aSwTwco+DZ6tHIpFE/xQw8ZK9rtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX1WcE3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B676C2BBFC;
	Sat, 29 Jun 2024 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719683453;
	bh=ITDBg+BM/o2RD6OiOLTIdk8OthQXA0HiROBqsQ/2j+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WX1WcE3qdgX8tiHmWgQro3VCUKU161VJDb4nMrowDYUovFtdLuQLI0cd3gWrbuYN3
	 FPCY3k2XFnayFfVuwolHwGUK5S6mQgG2YrVNvHymqdgRq09wVdq5UWD14U+m50jq6v
	 oh07X3Oqu3YHUEaQIZPuODywMRmyS3NpmECMCjjd8msFONr+8LQh+SAgSNCQgJi2od
	 1704BJ+zLk/92qIFxDdmAtslyrM4eNV0rb2SEA+sdlaLHoC3r2he5gemCheSaxhpAM
	 bVc8U0elNF+d3+njHdjTlR7Ii8gSUCk65z4DNKapZVmpHV3WbCiB8D5lCDZfc0U+XL
	 hQPQkOV3uNNhg==
Date: Sat, 29 Jun 2024 18:50:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240629185046.290c7d81@jic23-huawei>
In-Reply-To: <66122c40-9c69-471c-8f59-cfb1c9b0b6ec@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
	<20240625220328.558809-2-muditsharma.info@gmail.com>
	<20240628203701.507c477c@jic23-huawei>
	<66122c40-9c69-471c-8f59-cfb1c9b0b6ec@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 10:10:19 +0100
Mudit Sharma <muditsharma.info@gmail.com> wrote:

> On 28/06/2024 20:37, Jonathan Cameron wrote:
> > Hi Mudit,
> > 
> > I'd failed on previous reviews to notice the odd trigger in here.
> > What is it, because it doesn't seem to be a dataready trigger as the device
> > doesn't seem to provide such an interrupt?  
> 
> Hi Jonathan,
> 
> Thank you for your review on this.
> 
> I've incorrect called it as a dataready trigger, I missed this as part 
> of my initial cleanup - apologies for the confusion caused by this. I 
> should potentially call it 'threshold' or 'dev'. Please suggest what you 
> think would be appropriate here.
> 
> The sensor has an active low interrupt pin which is connected to a GPIO 
> (input, pullup). When the sensor reading crosses value set in threshold 
> high or threshold low resisters, interrupt signal is generated and the 
> interrupt gets handled in 'bh1745_interrupt_handler()' (interrupt also 
> depends on number of consecutive judgements set in BH1745_PERSISTENCE 
> register)

This isn't really a trigger. Just report the event and don't register a trigger at
all. 

In theory we could have a trigger with these properties (and we did discuss
many years ago how to do this in a generic fashion) but today it isn't
something any standard userspace will understand how to use.

> 
> > 
> > Various other comments inline.  
> 
> Will address all for v7
> >  
> ...
> >> +static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
> >> +{
> >> +	struct iio_dev *indio_dev = p;
> >> +	struct bh1745_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +	int value;
> >> +
> >> +	ret = regmap_read(data->regmap, BH1745_INTR, &value);
> >> +	if (ret)
> >> +		return IRQ_NONE;
> >> +
> >> +	if (value & BH1745_INTR_STATUS) {
> >> +		guard(mutex)(&data->lock);
> >> +		iio_push_event(indio_dev,
> >> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, data->int_src,
> >> +						    IIO_EV_TYPE_THRESH,
> >> +						    IIO_EV_DIR_EITHER),
> >> +			       iio_get_time_ns(indio_dev));  
> > 
> > What is happening here.  You always push out the event and use that as
> > a trigger?  This is an unusual trigger if it's appropriate to use it for
> > one at all.  You've called it a dataready trigger but it is not obvious
> > that this device provides any such signal.  
> 
> When an interrupt occurs, BH1745_INTR_STATUS bit is set in the 
> BH1745_INTR register. Event is only pushed out when the 
> BH1745_INTR_STATUS bit is set.
That bit is fine. My confusion is more about the trigger.  I think
the short answer is drop the next line and indeed all the code registering
a trigger as this device doesn't provide appropriate hardware.

> >> +
> >> +		iio_trigger_poll_nested(data->trig);
> >> +
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}  
> 
> Best regards,
> Mudit Sharma
> 


