Return-Path: <linux-iio+bounces-26861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05334CAADCD
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E109306290E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1D2D8791;
	Sat,  6 Dec 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9qYzBgW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0EF9C0;
	Sat,  6 Dec 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054703; cv=none; b=Ft3YDVjTUEJzWdrfI9/TySwl0S4Epvn6teAbVezYoIchhl0y7iZ1M//pEvELNqjc1wbAxQdk1rnq/a7YYYElZ1xskO23CkuL9ZHF8zzJhYaSbzy+zXkUhZU+6D7qlcHvBFyTqdJ9uc1nvxydqE0ci+C1v10u0vifn00EXIPGK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054703; c=relaxed/simple;
	bh=M1fyzEM6lnvQik68yNYxE7O3IKlO46Axly+TrkvgKok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgtGtI5xlEoC90f+l5wYHhvftjSTpv2+DIRuonajvarKaBhLvZLEUZTm6N0ROJFalBJdrCFRIGd60zBURsSs7sNr8b9c3eWtIqXVZmFfV8Sw2o8ZJJqLvgrP77XQwHISFZpsdsHFOPRux5sedNjWSpb8FRxWhja4O4A121mfGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9qYzBgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A5CC4CEF5;
	Sat,  6 Dec 2025 20:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765054703;
	bh=M1fyzEM6lnvQik68yNYxE7O3IKlO46Axly+TrkvgKok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9qYzBgWP0bcaerck+QB5s0EdJfr3Zn4ya1XYuTWnWlKc4LDJF1kemKlf6Ew7C7/k
	 n9aKMBcwwHOgkVpkpi/+xWu8OFXWnk2EjSeel1OTnLjbzajQLHJUbJ6LsZHbxYe8O6
	 6qbwOAdDsNGGa6LyfeT2ApMR25w4+cWgJplVciFgHuRv69OUaHSsEEZGx8I724D3eE
	 Iagf1o0XVmd4ZbJ/JLURY7zt+V3AqEg3rRmuY0aDZwNOcGtsClscOCwVNoeu8vB888
	 dI25nFTRt1KMY3mQ84v332nsmiyMzSsbq8jCjvUPlfdvjEbi9+bOrTChssDmAHgcCl
	 MEUnuVosTxXwQ==
Date: Sat, 6 Dec 2025 20:58:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: add support for ad9211
Message-ID: <20251206205813.08542093@jic23-huawei>
In-Reply-To: <aTF7qbjbtYqZCR95@smile.fi.intel.com>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
	<20251204-add-ad9211-v2-2-a1561f977ee5@vaisala.com>
	<aTF7M7NAFJM1OpWl@smile.fi.intel.com>
	<aTF7qbjbtYqZCR95@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Dec 2025 14:16:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Dec 04, 2025 at 02:14:49PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 04, 2025 at 08:01:04AM +0000, Tomas Melin wrote:  
> > > The AD9211 is a 10-bit monolithic sampling analog-to-digital
> > > converter optimized for high performance, low power, and ease  
> 
> Also just noticed that this paragraph is visible shorter than the last one,
> can you make them approximately the same line length?
> 
> > > of use. The product operates at up to a 300 MSPS conversion  
> 
> Is it megasamples? Then MSps?
> 
> > > rate and is optimized for outstanding dynamic performance
> > > in wideband carrier and broadband systems.  
> 
> > > The scale table implemented here is not an exact match with the
> > > datasheet as the table presented there is missing some information.
> > > The reference presents these values as being linear,
> > > but that does not add up. There is information missing in the table.
> > > Implemented scale table matches values at the middle and at the ends,
> > > smoothing the curve towards middle and end.
> > > Impact on end result from deviation in scale factor affects only software
> > > using it for scaling. All the possible hw-settings are also available with
> > > this implementation.  
> > 
> > 
> > Some amendment in the headers would be nice to have,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> 
> ...
> 
> > + array_size.h
> >   
> > >  #include <linux/delay.h>
> > >  #include <linux/gpio/consumer.h>
> > >  #include <linux/of.h>
> > > +#include <linux/units.h>
> > >    
> > 
> > You can drop one blank line here.  
> 

I have nothing to add from a quick read.  I thought about fixing up Andy's
comments and applying but meh, it's early in the cycle and beer o'clock,
so please do a v3 tidying those up.

Thanks,

Jonathan

