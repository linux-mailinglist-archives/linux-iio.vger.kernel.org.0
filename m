Return-Path: <linux-iio+bounces-14989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA3A27B23
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619FF162181
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B48219A67;
	Tue,  4 Feb 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULIWSolG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF7216380;
	Tue,  4 Feb 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697103; cv=none; b=n/wKA4g592EWNYslesqPIb/7z/fyb85AVQWjfbCij16X5i0TQgNyU9fBmAlS/zyJIGW8qRlyONwFXrOk57aJhSAYiUZ+GWLEA+umrzVo1X2RrULtDpelTpgcc0NeE4kt3pxoKEkVFD5SzrU1Urs9E21LD+Xo8yvZcyaA4OzyQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697103; c=relaxed/simple;
	bh=GzF7xaJ05szlQXtPQNiQwvan/2FH6BxXYXCcN3A3y/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgZRhb8aQBXp0XxqijEEVDYRXYlu5G2O8xxMOsDizOCDDKQu13YAXJwWHZaUrs/Ff9t2nHOjUJ/UtAlEJMrZwqYp80MA9EMiJfl6/GK9HrBmVFUjHea0pvsREmEzGJQBTATCmZYcvUWme2hhouz12+2+MS819LRCyH85iaD7dWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULIWSolG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033DFC4CEDF;
	Tue,  4 Feb 2025 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697102;
	bh=GzF7xaJ05szlQXtPQNiQwvan/2FH6BxXYXCcN3A3y/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULIWSolGeN7h+VU3dQwRKNr5vdFm24qNGRdAoGkSqUIDLvZQ5Q+/FLHXkayel88J1
	 L8jdkk3KOX2K2b1NfMIhTPrGW/zOfV1IemxVdinY8Wi2cS1hjGpvCtdPlCTrzzeYc1
	 ZhD1O74Bvt03ZVCti2rDTgUW5MvnLZXIcgqryImDAZf3kYQBWl9kcHFE6zetkqqXCH
	 /FPQpPCKvarCk5fytiNLrVi+fWMcKMTPz+OCivvYOHxaujwD3bOoN9qXXwkLm1uO7Z
	 gnuDWuNHRxbnbGMZpmtBvtOQzHpiZnCEHR3HRQdOTlTTJUhNzmp4+ixkXJt7d/JRKN
	 1yoGAVq9IjhGg==
Date: Tue, 4 Feb 2025 19:24:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: si7210: fix magnetic field
 measurement scale
Message-ID: <20250204192454.55489311@jic23-huawei>
In-Reply-To: <20250203193920.stcb5mhrt4vgmbae@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250202100709.143411-1-apokusinski01@gmail.com>
	<Z6CLw5h5EwDGanl-@smile.fi.intel.com>
	<20250203193920.stcb5mhrt4vgmbae@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 20:39:20 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> On Mon, Feb 03, 2025 at 11:26:27AM +0200, Andy Shevchenko wrote:
> > On Sun, Feb 02, 2025 at 11:07:10AM +0100, Antoni Pokusinski wrote:  
> > > Applying the current scale value to the raw magnetic field measurements
> > > gives the result in mT.
> > > 
> > > Fix the scale by increasing it 10 times, so that the final result after
> > > applying the scale is in Gauss.  
> > 
> > No objections against this change, just wondering since these are
> > the ABI changes (correct?) how should we really handle them in case
> > some of the user space stuff already relies on 'bad' values?
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> Just to clarify: yes, this patch makes the output values compliant to
> ABI (Documentation/ABI/testing/sysfs-bus-iio). According to the ABI, the
> output values for the magnetic field should be in Gauss, but during
> the driver development I missed the fact that I return values in mT
> instead... (1 Gauss = 0.1mT)
> 
> BTW I see that the patch cb29542a178f ("iio: magnetometer: si7210: add
> driver for Si7210") is still on the "testing" branch only, so perhaps
> it's still not too late to apply the fix?
> 
Ah. I'd not registered that.  Definitely makes life easier.
This will just get queued up behind it and land upstream at the same
time.

Jonathan

> Kind regards,
> Antoni
> 
> 


