Return-Path: <linux-iio+bounces-9017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2F968D40
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2EA28367E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ECA19CC0B;
	Mon,  2 Sep 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXjK7Lgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2819CC02
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301177; cv=none; b=WFPf8TshtN+7XeeWTmZMzV/77joQcEGmI2upji/dDUiN0Rq8RmAPtugW6X5sixeQZ1aXtcik0T7CkDNDHSgKOH5s6nCrUpskbl0Pq5WzKXCAPpyrsCFu9faBt4kd38jKxTf9SEzGpnp4SW6tj5OqApghGFfOSNeaXX1beuV+OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301177; c=relaxed/simple;
	bh=0xgCAqwBCwIxHsI0MzPA2hqflJQTifJ6xMoaHM3h280=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opktwgeg51GSI9JvVb6iB0DQ9pYNgIItb6/9XXOq+ncunU2PPvWHtiS9HXTdl3t/J4Z+3DW8A401pL62ALRSzmGMSFSSuQdeui/0esZCO4G9Bd0kqC5a+FVEVuKYB2zR5r2pIGMY1Ez6q3PSbcmQfMMnU+rx8Gi4gu7eDR6cz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXjK7Lgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC365C4CEC8;
	Mon,  2 Sep 2024 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301175;
	bh=0xgCAqwBCwIxHsI0MzPA2hqflJQTifJ6xMoaHM3h280=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXjK7LgjjeA5bVLb6w72z9nfIJwo4C4Gg6IuHNKTUWnCckfnx4fSAq631isvXgY3r
	 2M+SyQg/xh1rdxjR3DS58Fb93ayN5PtPqvOmtvY2gFEmf9MY3hOP3wx8j4LjokQ/5c
	 7wM/vQ4cx1bHv+l2uHpcP7nj4ABKeihsEKwJHjm8MNp/HsK1BNVUGLjCLHB9dncSTQ
	 QfiwQZMpXty6NH5nzMKHegNBQI2O2Wiqg3eTxZIcPvZheaOuGwee1kgKE8CJ1SokX9
	 EvFLwKsbMPrjEXklYML9dFfsOdvZ/jR8o23XvQ7M3zQ9yK1p68RLh1lcf3rCnjyhGR
	 hkSWyBMXWkMOA==
Date: Mon, 2 Sep 2024 19:19:26 +0100
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
Subject: Re: [PATCH 13/15] iio: light: st_uvis25: use irq_get_trigger_type()
Message-ID: <20240902191926.3df37a68@jic23-huawei>
In-Reply-To: <ZtWl7zdWGwDHJfL3@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
	<20240901135950.797396-14-jic23@kernel.org>
	<ZtWl7zdWGwDHJfL3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 14:47:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Sep 01, 2024 at 02:59:48PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Use irq_get_trigger_type() to replace getting the irq data then the
> > type in two steps.  
> 
> ...
> 
> > -	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> > +	irq_type = irq_get_trigger_type(hw->irq);  
> 
> >    
> 
> No blank line?
> 
Might was well roll it into the switch now you mention it!

Jonathan

> >  	switch (irq_type) {
> >  	case IRQF_TRIGGER_HIGH:  
> 


