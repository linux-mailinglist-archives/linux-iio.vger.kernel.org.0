Return-Path: <linux-iio+bounces-26833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F87CAAA77
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D7E3022AAC
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65B2FC877;
	Sat,  6 Dec 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kneAz/sm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6E79DA;
	Sat,  6 Dec 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765039203; cv=none; b=BYpw1niKbkcWHpzeOAIUg+PSEXcJRbPS2ciWxxehZuxSJTdk+kt2w+cvcaWs7wcoGEzO9GGXTLXd7JcxDXbfhbbG9lYpAcJxNonh636SJQ/5gsE2T4WwjvLkF4zteTZJoJiroyKOTz5/sFbIrHBKJCXtL5oEdIxnwuGTt/Px/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765039203; c=relaxed/simple;
	bh=nDyiQgWzVr5xrxezFIqVJ+LMCfjhgCRDxxrrb2v8FM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiOX4M0kV5aDEyr6/b7WHhbH2BacU100FRUIy8RBEjI0pbkPPT3M1iFSWDvPZpWsszGQH5BjiahQmqci0y0bDcSIQV7r+vxFOPHIe4efShFx8E7m7+AzNZBbb+GYU0Z+aLf8+weEZobuZgUWVfBsbkfNFs5xUYj22pXhLYer5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kneAz/sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA96C116B1;
	Sat,  6 Dec 2025 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765039202;
	bh=nDyiQgWzVr5xrxezFIqVJ+LMCfjhgCRDxxrrb2v8FM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kneAz/smE0fNqN9flFMEfL6pxRk+9ecl8m3G15aIrv8hn065sN/+G9AN4N4e4q4qD
	 t5zmrdFdkfR2FmzJwvPdGbvkYJ4CGWkJR/p22eCS6PUZfqZgkesI58RpRCV21uLau5
	 5LBppxIaDjTnXd4uO0RtFSDiy0xgb9J3VMw05o8WYr+PSKnXvZm6hePSWMe0eau0of
	 AzxyS/SP0+OO5HhuC8pbgKASCjSiTqqlV37q8dltDBEX6BxiVyOK7/B5o2L7nWmb6o
	 hNvXKFMEbibTymgqDWqN9A7gSdOnjS4iNwSMsJVEXe8ah70E9xZQMyluxPOTszhjXm
	 O6EMFhr4rTmfw==
Date: Sat, 6 Dec 2025 16:39:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <20251206163950.545da8cc@jic23-huawei>
In-Reply-To: <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
	<20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
	<aSQxiSoZcI_ol3S5@smile.fi.intel.com>
	<aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 12:40:00 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:  
> > > The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> > > register (SAR) analog-to-digital converter (ADC) with low-power and
> > > threshold monitoring modes.  
> > 
> > ...
> >   
> Hi Andy,
> > > +#define AD4062_SOFT_RESET	0x81  
> > 
> > The grouping seems a bit strange. Haven't you forgotten a blank line here?
> > Ditto for other similar cases.
> >   
> Ack.

Side note. For efficiency, if you agree with something just delete that
block of the thread and don't say so.  Reviewers should be safe to assume
that anything the author agrees with will just be fixed in the next version.

That lets us focus in very fast on the key discussions.

> >   
> > > +struct ad4062_state {
> > > +	const struct ad4062_chip_info *chip;
> > > +	const struct ad4062_bus_ops *ops;
> > > +	enum ad4062_operation_mode mode;
> > > +	struct completion completion;
> > > +	struct iio_trigger *trigger;
> > > +	struct iio_dev *indio_dev;
> > > +	struct i3c_device *i3cdev;
> > > +	struct regmap *regmap;
> > > +	u16 sampling_frequency;
> > > +	int vref_uv;
> > > +	int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
> > > +	u8 oversamp_ratio;
> > > +	union {
> > > +		__be32 be32;
> > > +		__be16 be16;
> > > +		u8 bytes[4];
> > > +	} buf __aligned(IIO_DMA_MINALIGN);
> > > +	u8 reg_addr_conv;  
> > 
> > Can't we group u8:s to save a few bytes of memory?
> >   
> Sure
> 
>   struct ad4062_state {
>   	// ...
>   	union {
>   		__be32 be32;
>   		__be16 be16;
>   		u8 bytes[4];
>   	} buf __aligned(IIO_DMA_MINALIGN);
>   	u16 sampling_frequency;
>   	u8 oversamp_ratio;
>   	u8 reg_addr_conv;

Unless my assumption is wrong and those 3 values are passed
as buffers for DMA (or otherwise very carefully protected
against access racing with the DMA buffers) then this is very wrong.
Refresh your memory on why we do the __aligned(IIO_DMA_MINALIGN) and
exactly how that works.

Short answer, nothing must come after it in the structure as it
only forces the start of the buffer, not it's end and hence the
following data ends up in the same cacheline and fun data corruption
is the result.

>   };

