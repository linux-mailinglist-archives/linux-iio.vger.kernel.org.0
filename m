Return-Path: <linux-iio+bounces-3789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704288B134
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FFF29C4A0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0864085A;
	Mon, 25 Mar 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX48fFzF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3AFC01
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398090; cv=none; b=LFDYrdAhOnjyFc7oAQiv0032XQFelmF7CC69v2Lo9wjphYYrPHqtAnCJCgGnN7WLvBzp3DKO2dzpC03jbaSbS1GtQqQpI+2wc6OysjdqksOlblGMG3W6Dr8lpLNsNq9+BOJq7Mj6kO+xy4YUf7lauKV36zcZY9XXIx4y3y5SAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398090; c=relaxed/simple;
	bh=D/esCVEn91AU6/5Wuz3Wp1GAZSdd5s1IlOkrZtAVhVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj/6PYr034LFYSVrk+MD65NsH2cuZlCOo4VMgYGPmEaEbwIn8SHLS6GtEfePH1XhM0U5TEaUOBlZsAIHGU2Ee+vjJ57swRSjaeTpjnkCcR02xImeNwRK4xLNdvyMN0CykbB87VSPRmxzJiYMO7xvNkJv8go5zb3AavGr4Ta+xPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX48fFzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A128AC433F1;
	Mon, 25 Mar 2024 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398090;
	bh=D/esCVEn91AU6/5Wuz3Wp1GAZSdd5s1IlOkrZtAVhVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kX48fFzFY3PQgbP10kzTwQLkNXuxkZBY4UwIrAlGNJg2GIDoJV1RR1RIIzWaz1DZw
	 vAXlIfeKsVIjMk/B/s3fQDJ6eLwyt8F0Uzii+D5HJRwgGs9fCR9chlJTXbde8PQh16
	 9dSgGMM13wGLkHM//TpiqhqoJkizJTUlcqdQbfFOlxXu9ULE3dAJrkJXkvNmHESEfz
	 l4wpy9/BkkjRQbRb7rlUV0vHtroDjTnaYYJ2BEOqUAF33k5NRzJgYw47wNdN9jHW1q
	 ViOT69livCjEHjWpjdB327rPmXApXZxLm8hcWFJD4ERIj3ewxdeVN6qRZr3Ypom5+G
	 v7ez6UEq0+jHw==
Date: Mon, 25 Mar 2024 20:21:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set for 6.9 - cleanup.h handling of
 fwnode_handle_put() related (not ordered wrt to PULL 2)
Message-ID: <20240325202117.4bd0c080@jic23-huawei>
In-Reply-To: <20240303114137.194421b1@jic23-huawei>
References: <20240229202300.3321cc11@jic23-huawei>
	<2024030239-gift-cabdriver-266b@gregkh>
	<20240303114137.194421b1@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > 
> > > ----------------------------------------------------------------
> > > Jonathan Cameron (16):
> > >       device property: Move fwnode_handle_put() into property.h
> > >       device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> > >       device property: Introduce device_for_each_child_node_scoped()
> > >       iio: adc: max11410: Use device_for_each_child_node_scoped()
> > >       iio: addac: ad74413r: Use device_for_each_child_node_scoped()
> > >       iio: dac: ltc2688: Use device_for_each_child_node_scoped()
> > >       iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
> > >       iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
> > >       iio: adc: ad7124: Switch from of specific to fwnode based property handling
> > >       iio: adc: ad7292: Switch from of specific to fwnode property handling
> > >       iio: adc: ad7192: Convert from of specific to fwnode property handling
> > >       iio: accel: mma8452: Switch from of specific to fwnode property handling.
> > >       iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
> > >       iio: adc: hx711: Switch from of specific to fwnode property handling.
> > >       iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
> > >       iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()    
> > 
> > You are mixing the two different handlers in this series, right?  How
> > about 2 different ones, one for each?  Or do they start to conflict?  
> 
> It's one handler in here but two usecases so they are dependent.
> First the basic __free(fwnode_handle) then the device_for_each_child_node_scoped()
> which uses it internally..  The patches that mention DT are conversions over
> to fwnode_handle that incorporate using device_for_each_child_node()
> 
> As for the ltc2983, there are users of just the __free(fwnode_handle) but in
> IIO at least, far more users of it via device_for_each_child_node_scoped().
> So not that useful to split the series :( 
> 
> The device tree equivalent is a separate series not included here.
> That just got the necessary DT maintainer tags RB from Rob Herring today.
> If we get a little more time (i.e. an rc8) this cycle, it would be
> good to get that in place as well - I'll queue it up for linux-next today.
> This is the DT series.
> https://lore.kernel.org/linux-iio/20240301223942.GA3179769-robh@kernel.org/T/#t

Given there were no issues raised with the DT equivalent patches that Rob took,
I think I was being overly cautions.  Ah well, I'm sure I'll veer the other way
next time :)

Anyhow, I'm going to put these at the top of my tree (based on v6.9-rc1) so
that I can tag the first couple for anyone who wants them for other trees.
(a lazy way to get an immutable branch given I'm rebasing the togreg tree anyway)
Note that means I'm retiring the two separate feeder branches and going back to
togreg alone (the one linux-next picks up). 

So please ignore this PULL request as it will be superseded by a fresh one for
6.10.

For those that want it (who happen to be reading this thread)
im-tag-device_for_each_child_node_scoped() and includes patches 1-3 of this
pull request.

Thanks,

Jonathan

> 
> Jonathan
> 
> 
> > 
> > thanks,
> > 
> > greg k-h  
> 
> 


