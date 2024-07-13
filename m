Return-Path: <linux-iio+bounces-7581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C239F9304DB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B324283380
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3B49628;
	Sat, 13 Jul 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa7QJcZl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CB3BBF6;
	Sat, 13 Jul 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720864857; cv=none; b=Lit4qlfX2nQ6rPWh1z0Qf8gR+vdWybIWNHengVtI3V05sLCiwV7MGkiMsguap1ccxcl5leYeX3VYCNum9bMWb95JwEJ4o/11D6M7JDZxN8L96HwGBZ98Jha9/De9e5miizklMK3A5+RWDwPC9rILK03Gtlfkmv7dx/3RwJeRzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720864857; c=relaxed/simple;
	bh=idyUk9ZtJX1vHPXtvkpkZLR4cazmN4eepwtEay7goy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4VcAk5vxrgsfo8guYYOX75n2zgLp1CLfCQqarWpy0sDFAuGIknNoydmJlhp1L8ZVcEB1pakn5DP85n1yXFlkZVzf87ubalgCyfIkO0/4Y3NU5PEWg9u6HwUeipEDqgfSE0sCOG9kkDxgXe2lqe8atRrUYg83V4UGWfxQOxHPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa7QJcZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E553C32781;
	Sat, 13 Jul 2024 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720864856;
	bh=idyUk9ZtJX1vHPXtvkpkZLR4cazmN4eepwtEay7goy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pa7QJcZl9MEjhffNq2LVQ/AsXYx1Vggs78CMzQyXC1oV1gh2wI+n8n3K9KkidvkHP
	 VyavftI/GTM5/CoEbztx8wxofskyS9k83f7f2oc6fQoWzlqJ495re+C0BRyiiUUof2
	 g8YBv2M5eisw9bPQqnvhTdIqaSzxair2S+f+AOMnbKHvGfvBkrIGMDQMs6BSFzEzSH
	 I0Ge5/yP6zCzZANwwySb8iygImEsgKn5VrtdjTUvtPiyJqOmW+tNqLUcePyBSGKjBi
	 pauKvDV6fqDPkhXP7liR8l2mpPSbn7pXpAydDr1muZ9/uID/GZOXwygNWLXSbEEBEH
	 TKPvmSamUy2mQ==
Date: Sat, 13 Jul 2024 11:00:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, petre.rodan@subdimension.ro, mazziesaccount@gmail.com,
 ak@it-klinger.de, ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 tgamblin@baylibre.com, ajarizzo@gmail.com, phil@raspberrypi.com,
 579lpy@gmail.com, andriy.shevchenko@linux.intel.com,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] iio: pressure: bmp280: Minor cleanup and
 triggered
Message-ID: <20240713110046.30118a9c@jic23-huawei>
In-Reply-To: <20240630202754.GB185141@vamoiridPC>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
	<20240630112342.4ab1f021@jic23-huawei>
	<20240630202754.GB185141@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 22:27:54 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Jun 30, 2024 at 11:23:42AM +0100, Jonathan Cameron wrote:
> > On Fri, 28 Jun 2024 19:17:23 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Changes in v9:
> > > 
> > > Patch 1/3:
> > > 	- In bmp580_temp_coeffs, instead of *1000/2^16, now we have *125/2^13
> > > 	  to avoid overflows, as it was proposed.
> > > 	- Type casting to (s64) to temperature read in the read_raw_impl
> > > 	  function was removed as well as it is no longer needed.
> > > 
> > > Patch 3/3:
> > > 	- Renamed "buffer_handler" to "trigger_handler" to keep consistency
> > > 	  with the rest of the drivers.
> > > 	- Added new iio_channel_spec for bmp580 in order to use IIO_LE and
> > > 	  real_bits = 24.
> > > 
> > > v8: https://lore.kernel.org/linux-iio/20240617230540.32325-1-vassilisamir@gmail.com/  
> > 
> > This seems fine to me now, but I'd like a final 'we didn't break anything' from
> > Adam before i pick it up.  Once bitten, twice shy and all that ;)
> > 
> > J
> >   
> 
> Hi Jonathan,
> 
> Perfect! Let's see what Adam has to say as well.
> Thanks for the very helpful reviews :)
> 
Adam, if you could take a look that would be great.  There is no
huge rush given the merge window opens tomorrow, so this is 6.12 material but
none the less good to tick it off!

Jonathan

> Cheers,
> Vasilis
> 
> >   
> > > 
> > > Vasileios Amoiridis (3):
> > >   iio: pressure: bmp280: Generalize read_*() functions
> > >   iio: pressure: bmp280: Add SCALE, RAW values in channels and
> > >     refactorize them
> > >   iio: pressure: bmp280: Add triggered buffer support
> > > 
> > >  drivers/iio/pressure/Kconfig       |   2 +
> > >  drivers/iio/pressure/bmp280-core.c | 643 +++++++++++++++++++++++++----
> > >  drivers/iio/pressure/bmp280-spi.c  |   8 +-
> > >  drivers/iio/pressure/bmp280.h      |  34 +-
> > >  4 files changed, 589 insertions(+), 98 deletions(-)
> > > 
> > > 
> > > base-commit: 3341d69268accb5294b569ec37e55212a8a28ac5  
> >   


