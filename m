Return-Path: <linux-iio+bounces-26872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B3CAB511
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19586305958E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A8270552;
	Sun,  7 Dec 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcyfrkXd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8D258CD0;
	Sun,  7 Dec 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112661; cv=none; b=uRjwIJIcVYdNy8/2FDF9ukF6baLi+xi53FnTrUOr5iLFD2X2CSKRmeXaUdqNIraDfabFrzpAEsbggFIbFfY/l5FCkLFAwOtVorBqLNlq+wN5mPKhi2qNfVwLihI2A7KXR6fCUZpkSHSxtmJAXzB2wyhteMAh2Tw29n3vniNfERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112661; c=relaxed/simple;
	bh=NG8AZ59BvxDnDGnldyrX84vKVhO5p8DjyUamRyYRs94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G64ZQ7ZrkM60UCPsp4Rhm5tDsZhkSzOq2UyWR2UYH4yhl6pQGv4GBXfonOn+SW43VndoabgWKmn8SF+VQonOfrCRdUVf3cJfqlzDfXWSwkJtGbPWYd7q2o3tIxUOYStNn4uLI/vM3nvPuIvtyzDvKh19VAf5diYJ85Lvw05QYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcyfrkXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD94C4CEFB;
	Sun,  7 Dec 2025 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112660;
	bh=NG8AZ59BvxDnDGnldyrX84vKVhO5p8DjyUamRyYRs94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcyfrkXdfjdwfw9uQ7GprG0GVkuJdj5yLIV1nIjjdBN1LslWtk6j39HVg8tnQoSiU
	 /Qj09Ae51EasP/Kd9bAwGFT0zQG6Sr9xC8Wgi2csPFys51lqMBWF3Bw/II7/vW/yOS
	 EnqHdXb9kon/83rCXD5m7ccMk6Kik+9f6I0iM82yuJ3X9UgFN+Cr/A64bTtPt1xv5m
	 DdstAjkon162jVptRagLgEKXayWGdj72j+paQnYKGPUheh7ike/ZizgmzAGCqv9qOU
	 eQfk1znZiDZ3CrS7YIJBTEJ2G6Z9HEGaHQqKTl97FnjGkzeKASAfwf+DC59l7ilkRZ
	 HPTlLsl2+cj4A==
Date: Sun, 7 Dec 2025 13:04:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
Message-ID: <20251207130411.5b0d7a0f@jic23-huawei>
In-Reply-To: <aS_9CB9sQc2s1LMI@smile.fi.intel.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
	<20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
	<aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
	<c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
	<4a64c388-f141-4998-96e0-f6840d70f139@vaisala.com>
	<aS_9CB9sQc2s1LMI@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Dec 2025 11:04:08 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Dec 03, 2025 at 09:28:23AM +0200, Tomas Melin wrote:
> > On 02/12/2025 17:01, Tomas Melin wrote:  
> > > On 02/12/2025 16:11, Andy Shevchenko wrote:  
> > >> On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:  
> 
> ...
> 
> > >>>  static const struct iio_chan_spec ad9434_channels[] = {
> > >>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> > >>> +	{
> > >>> +		.type = IIO_VOLTAGE,
> > >>> +		.indexed = 1,
> > >>> +		.channel = 0,
> > >>> +		.info_mask_shared_by_type =
> > >>> +		BIT(IIO_CHAN_INFO_SCALE) |
> > >>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > >>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),  
> > >>
> > >> Wrong indentation.  
> > > 
> > > Can you please provide example of your preferred indentation for this
> > > particular case? This is used in several places around the code and
> > > seemed like one of the more readable.  
> > 
> > Would this be the preferred indentation?  
> 
> Almost LGTM, thanks.
> 
> > {
> > 	.type = IIO_VOLTAGE,
> > 	.indexed = 1,
> > 	.channel = 0,
> > 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > 				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > 				    BIT(IIO_CHAN_INFO_CALIBBIAS),
> > 	.info_mask_shared_by_type_available =
> > 		BIT(IIO_CHAN_INFO_SCALE) |
> > 		BIT(IIO_CHAN_INFO_CALIBBIAS),  
> 
> 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |
> 					      BIT(IIO_CHAN_INFO_CALIBBIAS),
> 
> It's still less than 80.
> 
> _OR_
> 
> rake the style consistent with the second one
> 
> 	.info_mask_shared_by_type =
> 		BIT(IIO_CHAN_INFO_SCALE) |
> 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> 		BIT(IIO_CHAN_INFO_CALIBBIAS),
> 
> But I dunno which one is preferred. These two are fine with me.

For the record, either of these is fine with me too. 
Pick one option and use it consistently for similar elements.

> 
> > 	.scan_index = 0,
> > 	.scan_type = {
> > 		.sign = 's',
> > 		.realbits = 12,
> > 		.storagebits = 16,
> > 	},
> > },  
> 
> > >>> +		.info_mask_shared_by_type_available =
> > >>> +		BIT(IIO_CHAN_INFO_SCALE) |
> > >>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),  
> > >>
> > >> Ditto.
> > >>  
> > >>> +		.scan_index = 0,
> > >>> +		.scan_type = {
> > >>> +			.sign = 's',
> > >>> +			.realbits = 12,
> > >>> +			.storagebits = 16,
> > >>> +		},
> > >>> +	},
> > >>>  };  
> 


