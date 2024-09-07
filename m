Return-Path: <linux-iio+bounces-9280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5C9702AD
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F6D282DE5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13451E867;
	Sat,  7 Sep 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVlAsPdI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8B611E
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718786; cv=none; b=jXpR5M59Vs3y2pcA0eKD8iq1xna1gn930C9rBTvJxMmuXIvqvDQg+RdROtkLbyx+D4oKotzu467EuMg+CO5Twq4KkOiVcFtN6rxE5NwtsNTKsXoaGa8b9HFPnJze2hszg+lblGm+t4QZPduYgLBI7uKWQinUInqMykyrDa13azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718786; c=relaxed/simple;
	bh=oHtXoI4IqUl0moK907Orqm6EPP2ldFptm6VpuniNf6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NumDH7yGBpj33iDgH5emoGnKrlP9fcDnW9pVMc6qs5oljOasuN3GGame1csdbJ4e2HW27u3RTGlB39z6fZqjb6U8rhTPOEbRSQL99QS68uReMdzueqRYIlgusf1VGZpt165jRvPHhFqA6KYHK326E2mNuMOqgBHbcutyTgtfxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVlAsPdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5AAC4CEC2;
	Sat,  7 Sep 2024 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725718786;
	bh=oHtXoI4IqUl0moK907Orqm6EPP2ldFptm6VpuniNf6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVlAsPdIvx+pmyk6YHD8ib1UkVsNEsK/RuPCtVvR0Zb2xmWkJg5clqxa4N06Pxp3c
	 KbVQ0KyWaHeKYdCgmYINyIogAzjE6yolQa0V+aAI16e6KstJKnwfN3s/1w1/+sn4xa
	 UuFCzdIwVV9scyfMI/4ka+1dZnPLf5m88dg7bGGUi3OGJYLv7WUhz/ZTIaDWArHuuw
	 RvEWWiBcO8YL52wWaA/g3dBNETk4qRTbWZxy7w4hysZpgwEGLuYTRnsugBp5a62RpW
	 E6cfHKP57VXEtFiDEK26uHh4Oeqsokz3gbiM0gUWtwWn97hiKCyrzkC7g2Al8R8bZ0
	 /zCNlxpzGh3mw==
Date: Sat, 7 Sep 2024 15:19:37 +0100
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
Subject: Re: [PATCH 04/15] iio: common: st: use irq_get_trigger_type()
Message-ID: <20240907151937.72b42938@jic23-huawei>
In-Reply-To: <ZtWlBvNLUmR6HQZb@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
	<20240901135950.797396-5-jic23@kernel.org>
	<ZtWlBvNLUmR6HQZb@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 14:44:06 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Sep 01, 2024 at 02:59:39PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Use irq_get_trigger_type() to replace getting the irq data then the
> > type in two steps.  
> 
> ...
> 
> > -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
> > +	irq_trig = irq_get_trigger_type(sdata->irq);  
> 
> Usually I think the
> 
> 	/* ...comment on flow... */
> 	foo = bar();
> 	...something with foo that is commented above...
> 
> is slightly better as after reading the comment we immediately see where the
> foo comes from.
> 
> >  	/*
> >  	 * If the IRQ is triggered on falling edge, we need to mark the
> >  	 * interrupt as active low, if the hardware supports this.  
> 
> But, it's not a big deal.
Agreed it makes sense.

This just goes to show how little I looked at surrounding code
when putting this set together.

I've reordered and added a note on that to the description.
> 


