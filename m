Return-Path: <linux-iio+bounces-9819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA1988FC5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AE61C20EB9
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91711B947;
	Sat, 28 Sep 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOL4aNrC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FF168C7;
	Sat, 28 Sep 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535327; cv=none; b=YJcybgMVw32Bc6yC4xc4U1QoCGPpQtd3AKfrT1g4xf9NWkjrHoyJyvi5pvBx/su52Vkic/5GNwM6ZDWGxCuxc9YlG0tpv/+f8cK9rhkqnVj/kbjUvhf+AEfxzmAAWbRmVcL6aGlNo8ROzF61mgH+RR30vXJsuKlzTVPco/eGYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535327; c=relaxed/simple;
	bh=/XBuEmGWh41GCpXYfLKTvhCysEsaxQHPOmWufH3r+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rr7HrwtUX++mbk5AKJVNmlK3YuMzuBivZB7aN74h8bahvQ1SYXFXx1J1rSGreUUGEijM6kl20u6zRcw1DwkAEMO6vv5KUefJirBU5SiSK+VkrH4wzJAVAZQaIFMtGczqZAEbiK1D2jNnHCT/xRbicktqxVvE0P5M+Bjr69KCxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOL4aNrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619D3C4CEC7;
	Sat, 28 Sep 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727535327;
	bh=/XBuEmGWh41GCpXYfLKTvhCysEsaxQHPOmWufH3r+zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOL4aNrCKXQ41Ty55vgq168EKvzBTjU1GmOG3VMGjf7pMZHBFl/QOcpR6X4f0/Jlo
	 uutHN8yOFnKs9CnwcSldLjzjqVGxDMSaR11vpeqXlE7qhaGbYAKG5SdKHjY2aTQ4xG
	 wIQ+MhsRjvCcgUki/6dY1wzkuoh8izXJoQXV7qIIWeE/OLuoxaX+3tuVNc+33wcFta
	 Tw4882I/eenFkdQ8YTzujHpBeCFSimQoAYvYIhC8/SGaUaIr+u/zwT5PMMflHnotwz
	 3KFsEBluXyeFQnPpLXHNH8T/9uSJmctRhltqR5YMofOMteWavWoVlT8Nl9dO7SYJoS
	 +mCx8IBHmETSQ==
Date: Sat, 28 Sep 2024 15:55:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
Message-ID: <20240928155519.1112f995@jic23-huawei>
In-Reply-To: <20240922110721.GA439861@vamoiridPC>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
	<cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
	<20240921200759.GA400156@vamoiridPC>
	<609fdda9-fcf4-426f-84c8-411a59ed5fab@gmail.com>
	<20240922110721.GA439861@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Sep 2024 13:07:21 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Sep 22, 2024 at 12:44:15PM +0300, Matti Vaittinen wrote:
> > On 9/21/24 23:07, Vasileios Amoiridis wrote:  
> > > On Sat, Sep 21, 2024 at 12:23:39PM -0700, Lars-Peter Clausen wrote:  
> > > > On 9/21/24 11:19, Vasileios Amoiridis wrote:  
> > > > > The iio_validate_own_trigger() function was added in this commit [1] but it is
> > > > > the same with the below function called iio_trigger_validate_own_device(). The
> > > > > bodies of the functions can be found in [2], [3].
> > > > > 
> > > > > [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
> > > > > [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
> > > > > [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752  
> > > > 
> > > > The signature of the two functions are different, the order of the
> > > > parameters is switched. So you can't just swap them out for the
> > > > `validate_trigger` callback since the signature is not compatible. But maybe
> > > > you can update the implementation of one of the functions to calling the
> > > > other function.
> > > >   
> > > 
> > > Hi Lars,
> > > 
> > > Hmm, I see what you mean. Still though, do you think that we could do some
> > > cleaning here? I can see 3 approaches:
> > > 
> > > 1) One of the 2 functions calls the other internally and nothing else has
> > > to change.  
> > 
> > I would go with this. Changing the signatures to be the same would be (in
> > my, not always humble enough, opinion) wrong. The different order of
> > parameters reflects the different idea. One checks if device for trigger is
> > the right one, the other checks if the trigger for the device is the right
> > one. Thus, the order of parameters should be different.
> > 
> > Calling the same implementation internally is fine with me. Maybe Jonathan
> > will share his opinion when recovers from all the plumbing in Vienna ;)
> > 
> > Yours,
> > 	-- Matti
> > 
> > -- 
> > Matti Vaittinen
> > Linux kernel developer at ROHM Semiconductors
> > Oulu Finland
> >   
> 
> Hi Matti!
> 
> Thanks for your comment! Well, I still think in my eyes is better to
> have one function do one thing instead of multiple. Also, I didn't
> think of this argument with the order of arguments, it makes sense.
> My experience is quite limited to how things should be in such a
> large project so I trust your opinion. I would still like to see
> what Jonathan has to say on this though, maybe he had some
> reasoning behind!!!
> 
No to changing the signatures. It removes the difference
in meaning of the callbacks even though they happen to have
the same implementation in this very simple (and common case).

In the trigger first one, that is the subject.  We are asking the
question 'is this trigger ok being used for this device'.
In the other the device is the subject and we asking the
question 'is this device ok to use this trigger'

When we are checking the combination you have here, sure they
become the same thing but there are devices where it
matters that the trigger is not used to drive other devices
(typically because it's a hardware line that goes nowhere
else, so no interrupts etc) but other triggers can be used
to drive this device (often by software triggering the scan).
We have the opposite case as well but that's often
a shortcut when it just happens to be really complex to get
the trigger to reset (often requires reading all the data
or similar) - that condition can almost always be relaxed
but sometimes it's a lot of code for a niche case.

So fine to change the implementation of one of these
checks on tightly coupled device and trigger to call the other
but don't touch the callback signatures as to that breaks the
logical parameter ordering.

Jonathan

> Have a nice day!
> 
> Cheers,
> Vasilis


