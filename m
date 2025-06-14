Return-Path: <linux-iio+bounces-20649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE6AD9CE3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9B13B7D9D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5E2D12E5;
	Sat, 14 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjGT9X4c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157C16A395;
	Sat, 14 Jun 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749907632; cv=none; b=SvqIblDC4zIk7+WdXnyr1Z9wWJWEu0wEN+9UJcwL86cklaPC+3lNEcTbpOSKihuQ0O3bO0nVjnv0NnCQf0PcO0UC0OdfQaorOAmYprLAO+GSEKfTc8/btuS+o5rb0xlTOyLyEju4D0dAHwk7dHDEs7QU90WCBzu8WgkwKbd09bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749907632; c=relaxed/simple;
	bh=i13ROvwBLCJb3hjMnOgUYhlbr7hf3UnJjuXDlsncs6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5ifZHHB0d7O6A6SgUxNKUSWt7YbXwoO7vhLUbYSeSKfttRGPXZt+wV4h1zFbh+tl6rixt6XRjoi2bIUhVF+lnS/hzhkU/1nqGFw/DwafVhgk0/IxviG/6yJZRONOUsKUQkspE4iTyBZFg7eXlGSTThW6dH34rLRrTttrxrUlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjGT9X4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1215C4CEEB;
	Sat, 14 Jun 2025 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749907632;
	bh=i13ROvwBLCJb3hjMnOgUYhlbr7hf3UnJjuXDlsncs6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TjGT9X4c3RzQMjBhhFICHHbcYvyAVVM9mFs0SdMg9dBoqSwkn16JjwwkboJkhHr3y
	 4MRicgTAH6e2p6KKOmJSPcFR0kZIXVRj4MKpl4XWt2HfXzGgTWWuEdU1b0FNdlMeDT
	 myc7lK4ggjT9fKfRn/mzltK03hIk2I95LE2ycsI0OJlR4Q7awSpQVaEeRX+4Vp6Kv1
	 f40+uGEZh3hC2jDRaaGeWQOmdSz4d2LUeUK6c+6mByqWV41ZNUagrtpLzsQj1WVB9W
	 S8h4gM9pNyyKUaii9hyMEawqb+sU+piiq5sXYBhSZzt9H7UlHPRg2w6zzn4DkJ4/AW
	 45wBEjPHM4PMQ==
Date: Sat, 14 Jun 2025 14:27:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250614142704.3c07e453@jic23-huawei>
In-Reply-To: <20250614141837.06d6e82f@jic23-huawei>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
	<20250613130207.8560-3-victor.duicu@microchip.com>
	<20250614141837.06d6e82f@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +
> > +static const struct i2c_device_id mcp9982_id[] = {
> > +	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9933_chip_config },
> > +	{ .name = "mcp9933d", .driver_data = (kernel_ulong_t)&mcp9933d_chip_config },
> > +	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config },
> > +	{ .name = "mcp9982d", .driver_data = (kernel_ulong_t)&mcp9982d_chip_config },
> > +	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9983_chip_config },
> > +	{ .name = "mcp9983d", .driver_data = (kernel_ulong_t)&mcp9983d_chip_config },
> > +	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9984_chip_config },
> > +	{ .name = "mcp9984d", .driver_data = (kernel_ulong_t)&mcp9984d_chip_config },
> > +	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9985_chip_config },
> > +	{ .name = "mcp9985d", .driver_data = (kernel_ulong_t)&mcp9985d_chip_config },
> > +	{ }  
> David mentioned the other day that there is an effort to remove the need for
> the kernel_ulong_t here but it relies on
> 	{ "mcp9985d", &mcp9984d_chip_config },
> style entries.
Oops. Still need the cast.

> 
> https://lore.kernel.org/all/1c7946f1-d712-4baa-8243-be6a55eec528@baylibre.com/
> 
> I wasn't aware of that effort but seems sensible to me!
> 
> 
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mcp9982_id);  
> 
> 


