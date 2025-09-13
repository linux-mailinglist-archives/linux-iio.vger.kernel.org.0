Return-Path: <linux-iio+bounces-24042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404AB560A8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A2B1B24CDB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC422ECD0E;
	Sat, 13 Sep 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2x5DhhU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE42EC573;
	Sat, 13 Sep 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766170; cv=none; b=k21gA9eP9vwPzWmI93AGhxumogt8GXW70QkPjpAnxh3zfnK31BiDSTWdZlutGGBsNYOf1R02nCl+g8tlmOufXZaIZMYC1RafUQqi6j3S7/Cmz4XqgDFGn7gKu0LQIeL4IGuTyef6HLROv0wyiu8QHKBz7FlQ7HlaoQh3XFccXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766170; c=relaxed/simple;
	bh=z0sFtHeP/KuEGcrHcbfYqU2tVN3HyUc6UcNhLNDNyDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns9/mpUE8Bkub3zYjqDDY2zJnF57mlIQAhoCPwwqd8laXiULUjF/hzJjAf8RMgfYw51+bCn+o1xvi3bl0NtYXaSaCRHPonPD0dwQndHMojt1h2ic8dBAAkMTbNjWO4d7cl2OMi8Wk9n0QGklIOs8eYWDS31txBznAopEuU1sJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2x5DhhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E7EC4CEEB;
	Sat, 13 Sep 2025 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757766170;
	bh=z0sFtHeP/KuEGcrHcbfYqU2tVN3HyUc6UcNhLNDNyDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2x5DhhUeI3xEtFSeZxSvF18v2NoUNgu00zLRW4VJPuLySG0y1cCyF0+MfEnzFMWN
	 Nmmi92um57a/EvrmemLJPs9M4/gRVfSbPvGP0Jhwdf4Dz9ZOvB0fqGZ5QAbTT9GMPg
	 F6AY6k9XZwrBjgIq65X3/cZO+HleLB+KKfpuIhDdzzTEVG4gIz4YQAAu00dJ6/48r2
	 1M0ZBserZeKX4U0ogZRaihfST0J1tbFqUuTrPQOLyTTZ/QdlJpErU0mz08ZNlARj5s
	 6oHCaSE3MJgpzDkPIXCH8SfS74V42mRn1ug4zFM/bfDoVuF7uDi3n/hfVS/zio/nzr
	 gTXzkyxrouh+g==
Date: Sat, 13 Sep 2025 13:22:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] iio: accel: bma220: migrate to regmap API
Message-ID: <20250913132241.0047e93b@jic23-huawei>
In-Reply-To: <aMQ0JlbqIuMwDBpQ@sunspire>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-8-e23f4f2b9745@subdimension.ro>
	<20250910191225.43a89a1f@jic23-huawei>
	<aMQ0JlbqIuMwDBpQ@sunspire>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 17:54:30 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hi Jonathan,
> 
> On Wed, Sep 10, 2025 at 07:12:25PM +0100, Jonathan Cameron wrote:
> > On Wed, 10 Sep 2025 10:57:13 +0300
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Switch to regmap API.
> > >   
> > There are a few things in here that seem unrelated to the regmap change
> > and should be in separate patches where we can review and discuss them more easily.
> > 
> > Thanks,
> > Jonathan
> >   
> > > diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c  
> > >>  static irqreturn_t bma220_trigger_handler(int irq, void *p)  
> > >  {  
> [..]
> > >  	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> > > -				    pf->timestamp);  
> > 
> > Why the move to grabbing timestamps in the thread rather than the top half?
> > 
> > I don't necessarily mind that change but doesn't feel appropriate to have
> > it in the same patch as the regmap change.  
> 
> one of my unit tests [1] fails when using the original code (all timestamps are
> 0 when reading the IIO buffer with iio_generic_buffer)
> 
> would be easier to just split modification into new patch instead of debugging
> the old code :)
> 
> [1]: https://codeberg.org/subDIMENSION/lkm_sandbox/src/branch/main/bosch_bma220/unit-tests/permanent_latch/test.sh

Ah. So this is the problem we've had various attempts to fix of not all triggers
have a top half.  Definitely wants to be a separate patch with an explanation of
why you are making the change.  Hopefully someone will get time to finish of
fixing this up more generically but I don't mind papering over it in a particular
driver in the meantime because the generic fix is rather complex.

Jonathan

> 
> best regards,
> peter


