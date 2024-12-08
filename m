Return-Path: <linux-iio+bounces-13251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DB9E874F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A971645A7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06351189B85;
	Sun,  8 Dec 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvHLdgEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB6145324;
	Sun,  8 Dec 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682809; cv=none; b=CzjN+o/gyROxAD38lpDG+W/uNv0mE5c9H1A8WmqDv4tb4i8oiWvnJLH3B2zRsy3RWNjfljW7mKZ7tXH/tzuDdhCcNYbuzL4VQk11kqhs1SecmU90WVrAUKItThbuQmrbHXKAfZYCDnvEHDClc46SQDcjm5iknFWyZ0y+2CEgaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682809; c=relaxed/simple;
	bh=8WGe0AoB3HqrlhZ2W628Rphuq9x2/QtN8G/n54zTxSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmku2mX+yBNlebSxmBBIclU92mWsJ1pAy+rsbwo14ql/Al8vndzwg4+L0uByK9RTpBj4KgdR4BanWbRmU3DjEjU8+Tkf0SinbVA45sf0apEeQMSGvn/dyh2FADs94PMZVT44zsf5Ztcfnr6fz9gRG1uMCw+7XMHamNg17IhZLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvHLdgEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F8C4CED2;
	Sun,  8 Dec 2024 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733682809;
	bh=8WGe0AoB3HqrlhZ2W628Rphuq9x2/QtN8G/n54zTxSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FvHLdgEbN+ygVE3zV2r58d75LxSiKAg8YKt6NpAGzVklOfRTJPwLzqhojCJkVZSMb
	 uHQzdncaJEX01CWtgnvjOesJVsGv4efzGXoKCiXG2dePfSS6zjYC1pA9bdoprdaXAu
	 /EUqcxUvsqGo3No4mahTegDsLvbEgra+MQ1iOqUyypSUhK0kA2Lc8rIZlH1XJb7V2X
	 nIZblpB0N6VGEav+lq/JJ7rATfA2kOevH8LYBJOa6lkPjzCvdq95WLG39/ViegjtA+
	 8Lj8ZGN2ziOkfDg8cMnQElw9W1YyPESBuuHO32YG04zsCS9a7E7IJqr8HbXB02iSSh
	 5gp92T46y2Wdw==
Date: Sun, 8 Dec 2024 18:33:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Fabio Estevam <festevam@gmail.com>, lars@metafoo.de, dmurphy@ti.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Message-ID: <20241208183321.6b973450@jic23-huawei>
In-Reply-To: <Z1SVNlBHz12-OP7j@black.fi.intel.com>
References: <20241122164308.390340-1-festevam@gmail.com>
	<20241201130356.3bf4c693@jic23-huawei>
	<Z1SVNlBHz12-OP7j@black.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Dec 2024 20:34:30 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Dec 01, 2024 at 01:03:56PM +0000, Jonathan Cameron wrote:
> > On Fri, 22 Nov 2024 13:43:08 -0300
> > Fabio Estevam <festevam@gmail.com> wrote:  
> > > Using gpiod_set_value() to control the reset GPIO causes some verbose
> > > warnings during boot when the reset GPIO is controlled by an I2C IO
> > > expander.
> > > 
> > > As the caller can sleep, use the gpiod_set_value_cansleep() variant to
> > > fix the issue.
> > > 
> > > Tested on a custom i.MX93 board with a ADS124S08 ADC.  
> 
> > Hmm. Could be considered a feature, but fair enough as the change is
> > trivial and you are setting it on a real board.
> > 
> > Applied to the fixes-togreg branch of iio.git.  
> 
> ...
> 
> > > @@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
> > >  	struct ads124s_private *priv = iio_priv(indio_dev);
> > >  
> > >  	if (priv->reset_gpio) {
> > > -		gpiod_set_value(priv->reset_gpio, 0);
> > > +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> > >  		udelay(200);  
> 
> Obviously if you allow that change, you should switch to fsleep() here.
True, that would be a nice follow up tidying up.

Jonathan

> 
> > > -		gpiod_set_value(priv->reset_gpio, 1);
> > > +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > >  	} else {
> > >  		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
> > >  	}  
> 


