Return-Path: <linux-iio+bounces-17664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B4A7CDB5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B283B26A5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6641A5B9C;
	Sun,  6 Apr 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol0NP3JS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D1EACD;
	Sun,  6 Apr 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938520; cv=none; b=Wacue5OGS5rU+KUKc60i6FuPb5uwvcwFklTcJsZGitN8OnP1sJsWrBEv8FGtHwbr2sgM2ahHm5Rht4g21gVVt+du3lvdyXdwJCLAWlrZHle1F0eiKCRl/ZcaNl1Ih8LKD3kJRSmya/R0ogQ7F8Kzw7LhopdRrjzKPJ0CagGe6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938520; c=relaxed/simple;
	bh=zSQaDNIJ1DRttfroFvief95V6kGoB7qxB07DmG7MXwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UarP5QUjs9U/bmhWem53u06gXVOTxH4baieW0anVKCKA77FPB/C+vlX7hjuGEmWXaL2GIpP69BBoFZRqjPAWT1a8ltSLqRZcbGqryP0+il00pdSIyD+FluoE6W8X9syUOdTYHUrLY0Va1/qiUGZuDKojEkRsJZBoAF4vyy5idHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol0NP3JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C070DC4CEE3;
	Sun,  6 Apr 2025 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743938519;
	bh=zSQaDNIJ1DRttfroFvief95V6kGoB7qxB07DmG7MXwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ol0NP3JSDLsvnzCLnoeh1FsKNdVuDwAtIpZYMZQZqzXh5D4y0Dwlj354jEZV4p3tV
	 C0M3X1MVlTPQbgyTpe4wJC372XjeE754qBP8Po+NQ2CAnFnJ1n0aFgGUKRNiIdSsL5
	 +nazWm7N9tpJBIp+FQP5YD7v7XC5ATGB8JaooW32B+rVoWOcWu+hQEAH712JTpVn5t
	 LJhUVc1pQHTMCDkduxNpspBWJcIPDeuSKgUtE3/1W92xLp0f3F/5C1VDllGSsBfxNP
	 2PFuxCULgYDQ1+MqXPejl6U8rbO7fpQYMT1LXJo+HGVQJkprtXypbqu+J4igncUrJs
	 e/92qV4U5L23w==
Date: Sun, 6 Apr 2025 12:21:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250406122151.1b2a6f8a@jic23-huawei>
In-Reply-To: <CAKbEznvnTzvv7GtdF0JNbsya0iW4fN3VFH9bEGNDrXWOfm3ELA@mail.gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-5-gye976@gmail.com>
	<20250404125155.0000738d@huawei.com>
	<CAKbEznvnTzvv7GtdF0JNbsya0iW4fN3VFH9bEGNDrXWOfm3ELA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +
> > > +static const struct iio_chan_spec mhz19b_channels[] = {
> > > +     {
> > > +             .type = IIO_CONCENTRATION,
> > > +             .channel2 = IIO_MOD_CO2,
> > > +             .modified = 1,
> > > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),  
> >
> > I'm curious. We have a range control in your custom ABI, but no scale.
> > So what units is this in?
> >  
> The unit is ppm. and as far as I understand, co2 input(processed) unit
>  is percentage concentration.
> so In this device, the scale is a constant value (0.0001), regardless
> of the range.
> Is my understanding correct?

Yes.



