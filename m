Return-Path: <linux-iio+bounces-17994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53075A86C7F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C674E7A86AB
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A71A83FF;
	Sat, 12 Apr 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5s9VgC0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6D5339D;
	Sat, 12 Apr 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744453740; cv=none; b=StfrH4jlN8dcSNcI3jxaxjuABTXpvIpGML6sZ0XJ8IhmLfgPWoOQx8qxsQG+wzTtdxOVJFclHiq+Wky7shhLqK8qq9xxyDpVuoex5YSv817wVoRjZM3seTJTxCuRWI4qKSyfKHXkrhHH94UVgoxm1ocUJef9IcdAOpZX2LJZcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744453740; c=relaxed/simple;
	bh=rTZue6TIWXirhiH6eYRqm8lVBetcgKb0L2l3SJ0K36Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFOUyEskjN95HJ63rDkMEwmxztX+VTk5Vwx6cZx9hlfaOEqogeSXD6LbFyQb0GF0hpVi4qAzHttRGy9mHTQSHI7nxCGJyceUYykg1OhrKB3R+5OLMSPucKij8yLcYDGR0HptCrd3Un8BFJVddlvoZcMoOTZfENU5b5c5RSEn0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5s9VgC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7B1C4CEE3;
	Sat, 12 Apr 2025 10:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744453740;
	bh=rTZue6TIWXirhiH6eYRqm8lVBetcgKb0L2l3SJ0K36Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5s9VgC0vKBUxU8c4kQLOuBDb/fKbCyDB7xZ6x8aZsoQpgEyOXUx/L2hyinnhiTx7
	 95y2pCneoLIL5YXTsCfgoIHU2+aso84xHbXy6rD3zLfAF8gKWZc18xT4E5PFcYqShy
	 7pt6BTGNhoXDDo+mk3PxlD5q+SO2UYu+ltj5WX985GuLh/7iRW3exHPt8J1v03YtbX
	 ca5zZ4pGAm4HoEfNAdndS7a5lmtrpFBIIXseieCoGGtgZQlu3njvzKnUFVD3Ibo3ZU
	 FrH8TLrdUq5XLI5XRJluuv7mT1KnLYI4sKpeVprrhb0dDfNviuAlUH7A6Bpc7FYXCm
	 FVGGvb629Q4gQ==
Date: Sat, 12 Apr 2025 11:28:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, corbet@lwn.net
Subject: Re: [PATCH v4 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <20250412112852.19eacac3@jic23-huawei>
In-Reply-To: <Z_fe69bn90oVjPNk@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
	<386ce043a0e3fc9e8ff71f17aef8de128ce5869e.1743110188.git.marcelo.schmitt@analog.com>
	<97d0cc16-cdd4-449c-87f5-f62e0515de97@baylibre.com>
	<Z_fe69bn90oVjPNk@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 12:08:27 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 04/09, David Lechner wrote:
> > On 3/27/25 4:24 PM, Marcelo Schmitt wrote:  
> > > FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> > > The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> > > SPI-Engine to execute transfers to poll data from the ADC. That allows data
> > > to be read at the maximum sample rates. Also, it is possible to set a
> > > specific sample rate by setting the proper PWM duty cycle and related state
> > > parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> > > trigger) is used in combination with SPI-Engine.
> > > 
> > > Add support for SPI offload.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---  
> > 
> > I think I spotted a bug. With that fixed...
> > 
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> >   
> > > @@ -690,6 +942,15 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> > >  
> > >  	xfers[1].rx_buf = &st->scan.data;
> > >  	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);  
> > 
> > Now this needs to be:
> > 
> > 	xfer->len = chan->scan_type.realbits > 16 ? 4 : 2;
> > 
> > Otherwise when there is SPI offload, this could read 2 words because
> > storagebits is always == 32.  
> 
> I've just tested both versions with ADAQ4003 and with AD7687.
> There's no practical difference between the suggestion and what already is in
> IIO testing. I don't mind sending a patch with the change, but don't think it
> fixes anything.
If it is an unnecessary over read in some cases, probably sensible to either
reduce the length or add a comment on why we don't care.

Jonathan

> 
> Thanks,
> Marcelo


