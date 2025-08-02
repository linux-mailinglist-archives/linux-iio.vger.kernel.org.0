Return-Path: <linux-iio+bounces-22191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACBB18E40
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82876AA4032
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011821504E;
	Sat,  2 Aug 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVXQnPlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9A199934
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135189; cv=none; b=sobthE+3fU03A8xUdOQ7Ni9F5LdmDur8hYz1YdANRALnkhF5DseZKv0+S3KxsxCg3SKya+2PM9ZeNgancdn5XAoLAUJAPEv77s0g96h5iq3x4cxwXOCS9D4p9Aqblw54GIufYyFHLk9K/4s8m4u25Ja1AKflksLjhbQzjdT/G/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135189; c=relaxed/simple;
	bh=WM/p2F3gZhOyHf//X3QRBUv54dFGFi1hPoirtCEm0U0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZBeiUYRFbpnm8Ug39tsGyrsbh9iXNG3bhs8CNHmAI6iWYR2p5MmaZI1dPzvfwx9tpoD1jGFPVMk9VjxNiMqvW0xzmZiQe5OwEO5rwqHWBpccpEVidWxT3uDgl14kLw9HAoSlawBaPkevMou7XdlqvwQPH75F6fDVS5Se7/DfV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVXQnPlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A164C4CEEF;
	Sat,  2 Aug 2025 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135188;
	bh=WM/p2F3gZhOyHf//X3QRBUv54dFGFi1hPoirtCEm0U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VVXQnPlvrYhhIwkNwEWcp13V1kmIEf/H96Rk17GEDMR2TcYliCrxCHcHAOYxXdoT+
	 roZmNZDtL6qR4rHSnXxh7sHW81dTNsjofrRSOmKVNqnlld2jsLHJjJzo+a+Dj+ZHqk
	 rHe9dL+6H/gHnCEDV3ykiiWZpHUsCrWjD0L6omXGeldMp+gx9o/cnTOf3aWToYGRD5
	 gY+M5zJEqlXiFoA3Zo9xaXHR+8Ntxuggd+85Xze+VF9+WensrXok+vijkXZQt5hIuC
	 Y9prbRd6ULYXR/zyL/nX6GPL3/5VxJE00jscG4hrLJkU829euzBjS6pF2KrQpdB8dr
	 saMziybkL94gw==
Date: Sat, 2 Aug 2025 12:46:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, Hans de Goede <hansg@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC
 driver
Message-ID: <20250802124621.66d7cf81@jic23-huawei>
In-Reply-To: <20250731121255.000025c5@huawei.com>
References: <20250727210639.196351-1-hansg@kernel.org>
	<20250727210639.196351-3-hansg@kernel.org>
	<9536f598-1d49-4742-92e3-0d2603c5267e@baylibre.com>
	<20250731121255.000025c5@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 12:12:55 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 29 Jul 2025 12:50:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 7/27/25 4:06 PM, Hans de Goede wrote:
> > 
> > ...
> >   
> > > +static const struct iio_chan_spec dc_ti_adc_channels[] = {
> > > +	{
> > > +		.indexed = 1,
> > > +		.type = IIO_VOLTAGE,
> > > +		.channel = DC_TI_ADC_VBAT,
> > > +		.address = DC_TI_ADC_DATA_REG_CH(0),
> > > +		.datasheet_name = "CH0",
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > > +				      BIT(IIO_CHAN_INFO_PROCESSED),
> > > +	}, {
> > > +		.indexed = 1,
> > > +		.type = IIO_TEMP,
> > > +		.channel = DC_TI_ADC_PMICTEMP,
> > > +		.address = DC_TI_ADC_DATA_REG_CH(1),
> > > +		.datasheet_name = "CH1",
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +	}, {
> > > +		.indexed = 1,
> > > +		.type = IIO_TEMP,
> > > +		.channel = DC_TI_ADC_BATTEMP,
> > > +		.address = DC_TI_ADC_DATA_REG_CH(2),
> > > +		.datasheet_name = "CH2",
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +	}, {
> > > +		.indexed = 1,
> > > +		.type = IIO_TEMP,
> > > +		.channel = DC_TI_ADC_SYSTEMP0,
> > > +		.address = DC_TI_ADC_DATA_REG_CH(3),
> > > +		.datasheet_name = "CH3",
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +	}
> > > +};    
> > 
> > Question for Jonathan: If we don't know the scale on these
> > temperature channels, should we implement IIO_CHAN_INFO_SCALE
> > and just always return an error? My understanding is that
> > by not implementing it, the scale is assumed to be 1, which
> > likely isn't correct in in this case.  
> 
> Good question.   We have quite a bit of precedence of just
> not providing scale in these cases.  The docs for the main block of _scale
> do say
> 
> "If known for a device, scale to be applied to <type>Y[_name]_raw
>  post addition of <type>[Y][_name]_offset in order to obtain the
>  measured value in <type> units as specified in
>  <type>[Y][_name]_raw documentation. "
> 
> Rather than trying to fix all those, shall we tweak the docs
> to say that scale is assumed to be 1 if offset is provided?
> 
> If neither is there, the channel can be _PROCESSED anyway.
> 
> Your suggestion of returning an error would have been somewhat neat
> long ago, but now I think it will just be too confusing for userspace.
> 
> Jonathan
> 
Just a quick note.  I looked through the driver again the other
day and other than the bug (and request for tests) that David had
on patch 1 this looks good to me.

I completely missed that bug so thanks David!

Jonathan


> > 
> >   
> 
> 


