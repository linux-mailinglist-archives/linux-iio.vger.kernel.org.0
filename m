Return-Path: <linux-iio+bounces-15158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F336A2D62A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED81F188CB70
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E74246325;
	Sat,  8 Feb 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSKEXooN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925071A3157;
	Sat,  8 Feb 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739019966; cv=none; b=eblLOU/cHYHqT2qR8HmM90xC5MZTXnbTnnJnkmzCjrFKM0By7dE0d6InqplzKH5XVRrbAGp5Xt2EFK6ffMIkpomwQQ/9G5Es+FHWS7AQCV9jmGoyyIizoUNjjXlizLNO/BPT9F686NTyR4YmTPKJ7AWbTgc4gky767hLsv/fQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739019966; c=relaxed/simple;
	bh=4m+fjvYnMTw8m/GFUn7AygY7TZuZfLP4HcjfZAbijqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRx1uQveRvXalPHlxzPI8Kcr37TlJSoxYnv0jExPuxopYNDmctOxSBn0vcqSnMvT1TF5GnDve5I1bgV58mXgNDDAF0h+190Q+aQAHFnWaZD/Ioff/nHQryMg6LmkW1FMufQ2JipXT4WCObFeWTOz2Aw7/eaKY8fRiPdiHaY1UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSKEXooN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFD5C4CED6;
	Sat,  8 Feb 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739019966;
	bh=4m+fjvYnMTw8m/GFUn7AygY7TZuZfLP4HcjfZAbijqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSKEXooNqGxSW9P8Hy6jz4w18ev/7gr++fnxONeo67uJIzaClpQ4rR8adgfgNtbaS
	 2P1hB+Halu7RGGReYS+Xs2y7OH6w0Jh8kFqSqTYZsXiEny4NpknL5YxZhaR+HLemts
	 IC4m6QME1tYzgYl88j/1ZlUBRJLsdsN6GbJMxMUOgLkRnrXCepFVxs+q9yweQ83DfU
	 DX4LpXtHXSvtkFRDRNJ8aOgMKAM4sb+9IvdlRFucHhMCUTb8h2ehTpTH6fm4yGZWlD
	 +dmE/P2Lm9zneqRVdn/T+/fb18cvsc3IMpJAndH5N2TnyquDhXU4qV5nJTVs2S1nk+
	 oxFnIBKyr/RGA==
Date: Sat, 8 Feb 2025 13:06:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: si7210: fix magnetic field
 measurement scale
Message-ID: <20250208130600.4bf562d7@jic23-huawei>
In-Reply-To: <20250204192454.55489311@jic23-huawei>
References: <20250202100709.143411-1-apokusinski01@gmail.com>
	<Z6CLw5h5EwDGanl-@smile.fi.intel.com>
	<20250203193920.stcb5mhrt4vgmbae@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
	<20250204192454.55489311@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 19:24:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 3 Feb 2025 20:39:20 +0100
> Antoni Pokusinski <apokusinski01@gmail.com> wrote:
> 
> > On Mon, Feb 03, 2025 at 11:26:27AM +0200, Andy Shevchenko wrote:  
> > > On Sun, Feb 02, 2025 at 11:07:10AM +0100, Antoni Pokusinski wrote:    
> > > > Applying the current scale value to the raw magnetic field measurements
> > > > gives the result in mT.
> > > > 
> > > > Fix the scale by increasing it 10 times, so that the final result after
> > > > applying the scale is in Gauss.    
> > > 
> > > No objections against this change, just wondering since these are
> > > the ABI changes (correct?) how should we really handle them in case
> > > some of the user space stuff already relies on 'bad' values?
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > >     
> > 
> > Just to clarify: yes, this patch makes the output values compliant to
> > ABI (Documentation/ABI/testing/sysfs-bus-iio). According to the ABI, the
> > output values for the magnetic field should be in Gauss, but during
> > the driver development I missed the fact that I return values in mT
> > instead... (1 Gauss = 0.1mT)
> > 
> > BTW I see that the patch cb29542a178f ("iio: magnetometer: si7210: add
> > driver for Si7210") is still on the "testing" branch only, so perhaps
> > it's still not too late to apply the fix?
> >   
> Ah. I'd not registered that.  Definitely makes life easier.
> This will just get queued up behind it and land upstream at the same
> time.
> 
> Jonathan
Applied.
> 
> > Kind regards,
> > Antoni
> > 
> >   
> 
> 


