Return-Path: <linux-iio+bounces-26505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA21C8CFB2
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 08:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A602734B4DA
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967A311940;
	Thu, 27 Nov 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="XbMBNU6o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD133239594;
	Thu, 27 Nov 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764226904; cv=none; b=fncV5g1MwJAJm76g7+HwTGNJw5/crp63tJlABGzE9dcVrcZmkBM4wl4CuKR9xVu/F5LuJtiogw00pJIA3JOwAsDWu4grIyhod94ulXUeO/FX2U3lxiVMSFopT8oSwqp0F6iuaUIZiC+68kuPIF0azf6/4grZdI/o2KTbxkAf/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764226904; c=relaxed/simple;
	bh=xJntNp333wIrlXlF1W6tEXDtaFj5tPMTABREK15za5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjFCEndGjb9bL0vKVakMsSiDkcp6zpoUl6hxb3kOet1yk2bXnfOezXRso6JnsY36CZzl4v3DPCz57B+VDlqTWYtrYB49vB8UQ8qvijYzhvInLtLWSIUTPblEdVb2POxPdsQ83R6bS0H68eco50f8e/helfmKi86iKEsxRR7ig3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=XbMBNU6o; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2026E160209;
	Thu, 27 Nov 2025 09:01:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764226892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDqCVSZBPA8RkhRJu8iKL0VJie16tBT0LwVuOI/kbT4=;
	b=XbMBNU6oFFRy5aPcrEUQ4w05eumbDnXWRc/+fTGSGa7lxsQlNEV0Nx43FkiiU9tEyS3JoO
	/O9eWHQfZweU+q4jrscLBa5yjuKyCxZdeeqwCTgZxrsSH4ne2YpPjgglIffuqH5r62GqcO
	Jq+wRuM2m9dRZ2e6qCZCvXtvNcJ6cJZpOciL+wtChQvGtTzzj0uMcJa9tDwOeZBZRORX1R
	7KblokBaE2o90WM0HdH7lP5mRMQRsJyFt0jdXZ0+jlI4S9rJi4hWopir/Qga1ODsF9mW5c
	gwMjazjTjWuSUjbGeVeF9a9K+vKl8l1h9RtpwFtc2VG4/lF5X4sAT1u3Sjie6g==
Date: Thu, 27 Nov 2025 09:01:25 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno S? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSf3RUeghPcC80VG@sunspire.home.arpa>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
 <aSSV4lxzatAFds5e@lipo.home.arpa>
 <aSSm3JMY3DSg1Nns@smile.fi.intel.com>
 <aSTJML3fxp0sSeCq@lipo.home.arpa>
 <aSTiFxAolJ0JeUTj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTiFxAolJ0JeUTj@smile.fi.intel.com>


Hello Andy,

thank you for your feedback thus far.

On Tue, Nov 25, 2025 at 12:54:15AM +0200, Andy Shevchenko wrote:
> > > > > So, why can't regmap SPI be used?
> > > > 
> > > > there are no registers, no memory map, just a 'start conversion' and the
> > > > equivalent of a 'read conversion' command.
> > > > any reason one would use the regmap API in this case?
> > > 
> > > At bare minimum the commit message should have a justification for the choice
> > > explaining all this.
> > 
> > I had the justification in the cover letter instead, my bad, will include it in
> > the commit message instead.
> 
> It's good to have in both.
> 
> > > Ideally, try to find a way how to use regmap API. We have several weeks of
> > > time for this exercise.
> > 
> > you did not mention why use an API designed for devices with registers and a
> > memory map on an IC that has neither.
> 
> The regmap provides several facilities that we would like to use in the drivers:
> - the generic interface to access to the HW

in general I agree that having bus functions behind an abstraction layer can lead
to cleaner and less duplicated code in the driver.

however, afaict in this case I still have to use the exact same low level i2c/spi
accesses and hide them behind a regmap_bus instead of an _ops struct.
plus there seems to be duct tape to make things seem to be what they are not.
so the complexity would just go up a notch.

sorry but I feel that this regmap iayer would not be a clean implementation.
I might change my mind in the future of course.

> - the common locking schema that allows to share the same regmap among
> different drivers (depends on the functionality of the parts of the HW)

is it a good idea for anything external expecting a real regmap to interact with
a driver that was made to mascarade using one, lock notwithstanding?
everything about this particular driver is standalone.

> - debugging facilities are available out-of-the-box

in these cases I just use a signal analyzer and compare with the driver's output.
just out of curiosity, you got any pointers on a non-blocking (asynchronous) bus
transfer debug facility?

> We have drivers in the kernel with two buffers in the same structure.

yup. some __align twice just like in my example, some __align just once, some use
a simple buffer placed on the stack with no apparent alignment when sending the
data.

I've been told during an older review that both buffers need to be aligned due to
DMA-related requirements.
as I mentioned before, in my case the SoC's spi driver always uses PIO mode even
if DMA is also implemented. so testing my code always works no matter the alignment.

> > #define ABP2_MEASUREMENT_RD_SIZE 7
> > 
> > struct abp2_data {
> > 	struct device *dev;
> > 	const struct abp2_ops *ops;
> > 	s32 pmin;
> > 	s32 pmax;
> [..]
> > 	struct {
> > 		u32 chan[2];
> > 		aligned_s64 timestamp;
> > 	} scan;
> > +	u8 spi_tx_buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> > 	u8 buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> > };
> You told you read books about C language...
> 
> Alignment is a property of a single member and a data type in general. Each
> field of each data type may have it's own (non-default) alignment along with
> the object alignment.

I have a hard time following this paragraph so I'm forced to use my 'sorry
English ain't one of my first languages' excuse.

I tried the code above, printk-ed the pointers of those arrays (and the timestamp)
and they all get nicely 64byte aligned.
since I've been told in the past both buffers need to be aligned, I guess this
is the code you require?

best regards,
peter

