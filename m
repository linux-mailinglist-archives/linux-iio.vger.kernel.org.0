Return-Path: <linux-iio+bounces-27441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D48CEC5AB
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E367C300A348
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950723EA85;
	Wed, 31 Dec 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3ociSuV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC1290F;
	Wed, 31 Dec 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201354; cv=none; b=bl2YdrRf3IMU3keUZ7Fgy1X6XCSFkwJRruSQTLoypUzofdBGXHhpC5yzNdzTq/LPmlTAVhgYA/qI4Z7QtGfCrcR79h0XOZJgbsq+F1lwnSIWzvNFeMN90eZjR/0xr1XCivgIIiVyOZprrxRAIeOeth1BicUCyOGwQv21A9QRSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201354; c=relaxed/simple;
	bh=B0YJiHbYrV4E5sZVPrdt1+99lvzPMDfT5ZjnV4y+TRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxC4F74nTklI7ehCFFtrfrnV9RK5erxQ84Hz5kK7JBLGhbMRTP30fAy7ekvmT2nLyh8+FaRyac1Plq9t2Vp2OCJ4ZlQHZBUD2oE6BuOjhrp6WOS4rI+64Ml4Vd0QhbodxexmHmRUlLMzeZRcf8qlxV7wBknjqJYtgpa5vlY5PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3ociSuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD16C113D0;
	Wed, 31 Dec 2025 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201354;
	bh=B0YJiHbYrV4E5sZVPrdt1+99lvzPMDfT5ZjnV4y+TRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3ociSuV1yHQSmiTZkIgUXE7kF7DGQ6ud4Gb545T69X8StqDkfUyNcuqdDstGGXFe
	 PUHa5KlMWssrhU9q6pTHsNhxfP8OKHCDPbzDnxK2OT/k9KJg1zd9VLX0v4ExhOqjek
	 Ic7TM4mBNVkuqs8Z5G1wwcLR8YeJPOHyTq2x2NkuhEvWb8L9ERTaumbq1GHZE4mLPC
	 jcjA6xaBD2EaLxy+6Y/Ejzv+4Id/N78G1ugr7vYDBf593e8ZcSeerJgsOUi/BEXFtd
	 jHYO6I2npHn7wdMBzRaqm5mvhsPbaFrc9rcOsqIS7PNFoO9y8JRP4EW7CVWY2Jt5Kn
	 MaMARTpFuCE7w==
Date: Wed, 31 Dec 2025 17:15:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alper Ak <alperyasinak1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Fix signedness bug in
 gp2ap020a00f_get_thresh_reg()
Message-ID: <20251231171545.2231c7c2@jic23-huawei>
In-Reply-To: <aU_0nv6yYjwCsK_Y@smile.fi.intel.com>
References: <20251226154523.89215-1-alperyasinak1@gmail.com>
	<aU_0nv6yYjwCsK_Y@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 17:00:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Dec 26, 2025 at 06:45:21PM +0300, Alper Ak wrote:
> > gp2ap020a00f_get_thresh_reg() returns -EINVAL on error,
> > but it was declared as a u8.
> > 
> > Change the return type to int and update callers to use int type for
> > the return value and properly check for negative error codes.  
> 
> ...
> 
> >  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);  
> 
> > +  
> 
> This blank line is redundant.
> 
> > +	if (thresh_reg_l < 0) {
> > +		err = thresh_reg_l;
> > +		goto error_unlock;
> > +	}  
> 
> And entire code can be rewritten in a shorter way
> (in this case the type not needed to be changed):
> 
> 	err = gp2ap020a00f_get_thresh_reg(chan, dir);
> 	if (err < 0)
> 		goto error_unlock;
> 	thresh_reg_l = err;
> 
> but this one is up to maintainers as I know Jonathan likes the clear naming
> to be assigned to (however when written as above it clear to me what's the
> semantics of the non-negative returns).

This pattern is absolutely fine.  I don't mind using an err, ret or similar
briefly like this as the real meaning of the successful value is right there
2 lines down

Jonathan

> 
> ...
> 
> Ditto for the other function.
> 


