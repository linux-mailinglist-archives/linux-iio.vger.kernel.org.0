Return-Path: <linux-iio+bounces-16872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207AAA63170
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8E3B843E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDA205511;
	Sat, 15 Mar 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgOOtrJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F02045A8;
	Sat, 15 Mar 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063052; cv=none; b=NDLPnheT46q54OsCPnJOLTvwYx1Romg/ybqHoOLDVYkCO8F64Ymb+qNW83QH9ozwRqwjOjYcoIKArnrilH1jr+9T9z1cNYNGpnlad7JrRAtq3SkJmV1Mr0h3vpcZCz5FyIcAzGzAOOAEZsdq6yjdRZ98mGN2ckZQyGVW/4axif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063052; c=relaxed/simple;
	bh=1OSMH1Qhc2HVIdN9lUo5EIcgC/VQXR5nLtIJGdwCXyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIljA+domFYOb9RJrQ0UIvPobpVQ8nQYeeRkiDuZ9A9PpAhYv+oFBLiw++mlfSP7jBGDVbVTbij8Gjs+kQl6G77EBNTgugsXueIAkwl3DDV9a3M61fV9XvmAfTKR/C60whME1j0B5chgIeQLWYN97q1yXsoPigc5mZq5u8aud28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgOOtrJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BFAC4CEE5;
	Sat, 15 Mar 2025 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063052;
	bh=1OSMH1Qhc2HVIdN9lUo5EIcgC/VQXR5nLtIJGdwCXyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GgOOtrJ04G5i3Wfl+n9/xw1Wu/Brh1HvHBRaiKd9qDbcT1gNslP1tCFL8CRSKn4Ek
	 pehiJ4/thFy4b6YlCtwdrKwF6cj25sLYkRxXRLK+4cuIIBZr1Rc8Lrrcf1bhafu/wb
	 V3VThXpOznoB+1eByBZ6Yhc07WRkiEPkCCeeAFULv+QTN95P5+Walvvu0q+mBieMmM
	 m5yPoLCqT+uSh1ezDG8WhS7eiUODnWPUddqcT68qU86/wRf+hziYzrQH/FQH6N66fs
	 YgGkrKs5jPBC4noCSX7RqPJvckiqeSL38xcK9omvFH2ZWyY9ExsLHTvGCQAonn9meE
	 n/uRtIKbDMbXg==
Date: Sat, 15 Mar 2025 18:24:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <20250315182402.59f3ccf4@jic23-huawei>
In-Reply-To: <27kqar3ugxjzwss7hzxil2hz3kxaunnkpaaas3nnzemhssf6mo@65xknov7jh7k>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
	<CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
	<e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
	<6ca1eafd-276d-421b-8d35-bd3e363803d1@baylibre.com>
	<20250310195629.47ca023f@jic23-huawei>
	<27kqar3ugxjzwss7hzxil2hz3kxaunnkpaaas3nnzemhssf6mo@65xknov7jh7k>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 18:34:46 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> On Mon, Mar 10, 2025 at 07:56:29PM +0000, Jonathan Cameron wrote:
> > On Mon, 10 Mar 2025 09:31:45 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> > > On 3/9/25 3:49 PM, Jorge Marques wrote:  
> > > >>> +   * - ``sample_rate``
> > > >>> +     - Device internal sample rate used in the burst averaging mode.
> > > >>> +   * - ``sample_rate_available``
> > > >>> +     - List of available sample rates.    
> > > >>
> > > >> Why not using the standard sampling_frequency[_available] attributes?    
> > > > Because sampling_frequency is the sampling frequency for the pwm trigger
> > > > during buffer readings.
> > > > sample_rate is the internal device clock used during monitor and burst
> > > > averaging modes.    
> > > 
> > > I haven't done a chips with a monitor mode yet where we aren't reading
> > > the samples, so hopefully Jonathan will chime in here on the usual way
> > > to handle that.
> > > 
> > > For the burst averaging mode, I understand the need for a separate attribute
> > > now. I would suggest to call this the conversion_frequency rather than
> > > sampling_rate since IIO already defines "sampling" to be the data read
> > > from the chip to Linux even if it is an averaged value, it still counts
> > > as one sample.  
> > 
> > I should have read on.  I'd like this more closely associated with oversampling.
> > As per other reply we use sampling_frequency in the events directory for
> > the monitoring frequency case.  One of our very first drivers did this
> > (max1363) so it's been in the ABI a long time!
> >   
> 
> I get the idea but maybe the datasheet sample rate as conversion_frequency
> and stored as a channel attribute (iio_chan_spec.ext_info) is clear enough.

It's not standard ABI. So no standard userspace code will be aware of it.
we can add to standard ABI, but only if we can't support a feature with
what is already defined. Event then we need to keep it consistent with
existing ABI.

Note that the first step on any ABI is to write documentation for it in 
Documentation/ABI/testing/sysfs-bus-iio-*
That can help people understand what is being proposed and allows discussion
of how to generalize any new ABI to be useful across many drivers.
> 
> The datasheet sample rate affects both the burst averaging mode (oversampling) and
> monitor mode (threshold events).

True, but are both occurring at the same time?  My reading of the situation was
that they weren't but I could be wrong.  If they aren't then just rewrite the register
to a cached value when you change mode.

> 
> The max1363 stores as an event attribute (iio_info.event_attr) and requires iio/sysfs.h include.
> A last option is to store as a general purpose device attribute (iio_info.attrs).
> As a channel attribute, the driver logic is slightly simpler by using the macros.

Agreed that non standard event attributes are a bit trickier to deal with.  They
have never been common enough for us to fix that.  However the ABI exists
and is documented, so that's almost certainly the way to go.

Jonathan
> 
> Jorge


