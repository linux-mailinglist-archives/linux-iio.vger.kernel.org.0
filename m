Return-Path: <linux-iio+bounces-9281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B079702AF
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C8C1C219E7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663515B552;
	Sat,  7 Sep 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KboRx5w8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F13D3B3
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725719227; cv=none; b=QB0pkPRx7knVqm2zMCr3+nKqzWuhykUlwOz3XEo3TQr13nzJVOTLWUEz8hH8zN0cnNe28/MVAp8b1ojXVmWsUJVfKEbgN1RmqBv2gpn3vqgh+3Rykqsz3xYkQg4suNE3jk/zfuA9HjaJxx/9p3u2iHv9AvwYcb15muCbFNyIL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725719227; c=relaxed/simple;
	bh=kImaRNMMuijAhqpz9R15E4qkG6DioBH3mcJyB2zgUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuLjzun0GX6jweMaeadcBi+AufzZD5V3jzlsfP6N58mJNRTHuulcIIfXCa80nyRmj0QR1vlGLJx4wBj/PFljPtEJO3KbTkmNuHYCUO7YBNdYo7P+Lj5dr0JLXEb9vxoQQm8vHEjpW5fMHypNBgQBnnl9XB4DfGkqrx1c4y2r0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KboRx5w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66FC4CEC2;
	Sat,  7 Sep 2024 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725719227;
	bh=kImaRNMMuijAhqpz9R15E4qkG6DioBH3mcJyB2zgUyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KboRx5w8NDweoRE94VbyqnZI3SaNdLTKORR6ZYnleyO3HJES2iXFClpv6Bzv5VweT
	 fJZzKAeN5JNfSN7zAreKdfC0gWtYOPPaHr08EgnHfqQlhAYIirfQyy/RqZ65SzkVLz
	 S6kehTvjZvkcx248daIRgSbbkf0YOHzZ99voJ3rZX4cGVldvpZzpkuCsF83J56h400
	 ExjPipvioIlbXfMjHyitAsZEJ9uiAswAgB5OEsExIf/sli9UYe0d2IM7Abvz4yCbqZ
	 O28TnJpIw0IAbKaR6ItlfoVVfG0BSXBsJzjsbTrq/WWYoosDnKyOB3alD4Ke2rkX0A
	 j1dlMsVxVsnIg==
Date: Sat, 7 Sep 2024 15:26:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>, Denis Ciocca
 <denis.ciocca@st.com>, Rui Miguel Silva <rui.silva@linaro.org>, Linus
 Walleij <linus.walleij@linaro.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/15] iio: imu: bmi160: use irq_get_trigger_type()
Message-ID: <20240907152656.111f96cc@jic23-huawei>
In-Reply-To: <ZtWlcLfPyf-29kBJ@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
	<20240901135950.797396-9-jic23@kernel.org>
	<ZtWlcLfPyf-29kBJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 14:45:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Sep 01, 2024 at 02:59:43PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Use irq_get_trigger_type() to replace getting the irq data then the
> > type in two steps.  
> 
> ...
> 
> >  {
> > -	struct irq_data *desc;
> > -	u32 irq_type;
> >  	int ret;
> > -
> > -	desc = irq_get_irq_data(irq);
> > -	if (!desc) {
> > -		dev_err(&indio_dev->dev, "Could not find IRQ %d\n", irq);
> > -		return -EINVAL;
> > -	}
> > -
> > -	irq_type = irqd_get_trigger_type(desc);
> > +	u32 irq_type = irq_get_trigger_type(irq);  
> 
> Hmm... You broke the reversed xmas tree ordering.
> Anyway, can we actually
I put this back.
> 
> >  	ret = bmi160_config_device_irq(indio_dev, irq_type, pin);  
> 
> 	ret = bmi160_config_device_irq(indio_dev, irq_get_trigger_type(irq), pin);
> 
> instead?
Nope. irq_type is passed into the probe_trigger function outside the context
we can see in the patch.

Jonathan
> 
> >  	if (ret)  
> 


