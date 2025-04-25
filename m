Return-Path: <linux-iio+bounces-18621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DBA9C07E
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620FD3AC950
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15FC233158;
	Fri, 25 Apr 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpDbdWt9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4C635
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568664; cv=none; b=cuxZlOsKAUiL25+qOhZG4Ct6G8nd+7lOZW2/2VQFQTVsYFbK92NnvAGaYDUVbCYVa8xEphIt/PL0jJSvxpdRCbIj29cssUarLW7mhlfAVSUvY8IhFG+oSdCL/ekEDZ9ET9ujP1LW++y6kKnq8NGsUbrFrCZaSg7+OIO+EfQaqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568664; c=relaxed/simple;
	bh=O6XaS5DjlL3DMhT+eGMR+Jmi8fJLLD4ov9XtkImmI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuQ0pIKkGhNqYYLVD8XqUOLCvtMQLiDZJCkVgtM+I5sThAYxttV+1ZhKZCq4ykrNdzROa5E4hT7Nb4evzZTHYW/r7jHprAGw/OQDicSMUzhX7raabfkJJsLFRqibZp65at7yKh+NlfZaajHEGyzTjcM7G4MhbTAf487E/mioxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpDbdWt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1E3C4CEE4;
	Fri, 25 Apr 2025 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568664;
	bh=O6XaS5DjlL3DMhT+eGMR+Jmi8fJLLD4ov9XtkImmI6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpDbdWt96WCUvlhWU6F9avl7kshlkGQ9eDpTPB7KOSb3aujMpPI6ooP/liGgQpC8G
	 m5gWR3+VVqfrrOvLzBbGqzd/V6ma27g4M6lPveHEFsyFYHZKwkcyc76t+cUvDvjXQS
	 YaurjXrjFfj1GEACJpIFb/AwJXUBD5hzk6gLBadfcf3Zn0bCNlkjKmRQzbP4WoteTa
	 0SJWdkILsoqU3dQdPJni9DZ8HLkCLm80g3wgLbhvUDfT3hucT2dO27X1pHIZfqDhzd
	 pvT0buHpqDAWkgLZCHH4GMA7/6Nhqq6RsRJeztdhd6hSJ8Z7gwx/s+OBPWlArADI/2
	 JtiNZNOGDEeRQ==
Date: Fri, 25 Apr 2025 09:10:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, nattan
 <nattanferreira58@gmail.com>, lucasantonio.santos@usp.br,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <20250425091056.709883e8@jic23-huawei>
In-Reply-To: <aAZZXKkZxmuYXZl0@debian-BULLSEYE-live-builder-AMD64>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
	<c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
	<20250420211706.GB5621@francesco-nb>
	<20250421142359.11fb483f@jic23-huawei>
	<aAZZXKkZxmuYXZl0@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 11:42:36 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> ...
> > For debug access it 'depends'....
> > 
> > Some cases are easy reasons to add this protection
> > 1) Accesses can't happen at all because to talk to the device and read
> >    registers etc requires some mode change (e.g. recent drivers that
> >    can only access config registers when the bus is operating in particular
> >    modes, or where we have to use a slower SPI bus rate).
> > 2) There are register banks involved. So a single write can leave the
> >    driver talking to the wrong registers...
> > 3) Driver uses multipart reads / writes (similar to register banks)
> >    In most cases this is a device specific thing and should use a local
> >    lock to serialize accesses.  On occasion that is too complex to make
> >    work with debug so we restrict debugfs access in general.
> > 
> > Other cases are less obvious.
> > 1) Bus traffic in general might slow down a transfer and break things
> >    because of timing. I.e. missed samples.  That can happen for all sorts
> >    of reasons anyway so should only be a momentary problem.
> > 2) They might changes settings.  
> 
> Does the case of configuration/setting change apply to IIO device properties?
> Let's say for example a device starts running a buffered capture with some
> certain input gain configuration and goes filling IIO buffer with the data
> from the device. At some point while the buffered capture is running, the
> user uses debugfs to change the gain configuration. The _scale attribute
> will not correctly convert all buffer data to mV units. Would cases like that
> be something to prevent? Or we consider those to be fine since a debug feature
> was used?
Fine.  This isn't really any different to them changing the scale when using
non buffered capture.

The debug interfaces in general are optional and I've always wondered if we should
have gated them more strongly.  Maybe a CONFIG_IIO_DRIVER_DEBUG or similar
to hide them all on production systems and remove the footguns.

Jonathan
 
> 
> Thanks,
> Marcelo
> 
> > 
> > These less obvious things are a case of thinking it's a debug
> > access. We tend to not prevent actual deliberate state changes as that's
> > someone shooting them selves in the foot and they get what they deserve.
> > 
> > So what is the case we are protecting against here?  The description
> > definitely needs more information to justify this patch.
> > 
> > Jonathan
> >   
> > >   
> > 
> >   


