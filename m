Return-Path: <linux-iio+bounces-16557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D873A57B25
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE918942A8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153601D79A5;
	Sat,  8 Mar 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nihm99Wb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17612CD96;
	Sat,  8 Mar 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444968; cv=none; b=sBNlHDc2p4yEroeIGNuN7eqtLqyQ2v6sWCWDjbiibtW4Hwo4uV5agzNCo9YM1qTGhQttDVZIlYjNblr824SFtaQ5qkTYRmkxW5+tyxJkt3TXpkVmtwb32UAdScVCV4kBHe4u91Bo6IvDrmsTNQ+4N/Bk2MjRb/SWxujKTzL8BLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444968; c=relaxed/simple;
	bh=iRml3O3SX8wu/4XsLhsUV0h5mtBebUWsiYQM8fdBpJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgpemhDt67vSlexLG1TBQN6vyCA7bqzI6UWuBo5HR/aFpovi5p1w4I0G9uMRWTzSzGcRVF2/Y3WQUmDwjbwVUdeUNV7TuihW45kb61zz5PlPiunJPMfSzdUTMvNSlPlvD0+nZCXx6D6l474R2tMO0gf2l6FEERPDmiSSfCBZ+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nihm99Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F22C4CEE0;
	Sat,  8 Mar 2025 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741444968;
	bh=iRml3O3SX8wu/4XsLhsUV0h5mtBebUWsiYQM8fdBpJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nihm99Wbz3VM5EXlbh176D7pK4Hb+vEgG8Suu49lO8RSnGMb5C10shyc73Ip1ifDS
	 UYymF+7TWjAhxtlZ/22w2cUvwHf54y2iqFkfm6d2tU3DphMk01XEaoMuC2V3M3bUSh
	 BTIWtSSmEbuHrR3q4GdNYpUN0J6GVsjk2CNCgfyXiCa+ikgCzggGjpjso9A7zRfMhj
	 CH8Gz0JSXzLkF5feeedX6a+QMBbVB0BR2VjhU6JbOkspqPGVfcsfv+pe530ImeHVVW
	 1xUoYPqW+I05an/8J9Eyxn/R0Hw0pUs7D46K+F3Lj9EhfZVDF5rD2MMjEpLPW6KLM2
	 kJUw55MJyKdHQ==
Date: Sat, 8 Mar 2025 14:42:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Saalim Quadri <danascape@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [RFC]: Getting ADIS16203 out of staging
Message-ID: <20250308144239.0442f1a7@jic23-huawei>
In-Reply-To: <Z8pozuvS1a3sa039@debian-BULLSEYE-live-builder-AMD64>
References: <20250306002645.1555569-1-danascape@gmail.com>
	<Z8pozuvS1a3sa039@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 00:32:30 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Saalim,
> 
> On 03/06, Saalim Quadri wrote:
> > ADIS16203 and ADIS16201 are very similar in functionality whilst the
> > major difference between the accuracy in ADIS16201, I wonder if they
> > can be merged together into single driver, whilst also implementing
> > platform_device support in them.
> >   
> From quick datasheet comparison, yes, I think the drivers could be merged.
> 
> > I want to work on this, provided some opinions for me to work with
> > or to have a separate driver for both of them.  
> 
> I often look at two things when assessing if two or more devices can be
> supported by the same driver, the protocol and internal register structure. For
> IIO devices, the protocol is usually I2C or SPI. Though, even between devices of
> same protocol, there may be differences on how the data is structured in
> read/write commands. Also, if internal registers have very different addresses
> or meanings, it makes it harder to reuse code because the configuration
> procedure for each distinct design/device will tend to require specific
> handling.
> 
> That said, ADIS16201 and ADIS16203 SPI read/write commands seem to be the same,
> and ADIS16203 registers seem to be a subset of ADIS16201's. That's why I think
> it may be worth merging the drivers. I didn't read the datasheets thoroughly,
> though.

> 
> > 
> > I see that there has been some discussion regarding the same at [1].
> > 
> > [1]: https://lore.kernel.org/linux-iio/20230124094450.0000272b@Huawei.com  
> 
Yes.  I never did get around to merging them after that was pretty much the conclusion
of the reviews of that attempt to get the driver out of staging.

So if you are willing go ahead.  One challenge is testing where you need one of:
1. Test devices.
2. Someone willing to test who has them.
3. Emulation of enough to verify that nothing broke.  Assumption more or less
   being that current driver is 'correct' so it's a case of emulating the
   device then tracking forwards that it continues to function as you modify
   the driver.
4. Really simple changes where we rely on review alone.

Jonathan


> Git tends to rename/move files when we move a file from one directory to another.
> IIRC, Jonathan prefers the drivers to be completely removed from staging to then
> be added under iio directory to sort of make it clearer that something is
> being added to official (not staging) IIO drivers. To accomplish that, we
> use --no-renames flag (e.g. git format-patch --no-renames ...).

Kind of more about providing a convenient place to check that we are happy with
the state of the driver as part of the series that moves it.  That move patch
results in a full driver review, similar to what we'd do for a new driver.
Good to point this out though, thanks

Jonathan


> 
> > 
> > Sincerely,
> > Saalim Quadri
> >   


