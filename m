Return-Path: <linux-iio+bounces-27615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE8D0EFB3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1EA3004BBC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC833EB02;
	Sun, 11 Jan 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayyp50it"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A95733E;
	Sun, 11 Jan 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768138271; cv=none; b=kKHqqdXC96Jbg9QSN05bQI0qTdFYC6Pw/eAXgfJ8dwkRVJuYFg5fAVfbi8pbxYO2zFPEsE35HJY+Z/JUc/kxHVSAp9M5iCcg8M5habVrBcoRNC+rK1K5yfyKl5wNS4yXvapEm985Sk9hrInpJpX893+dEMdGBgAhE3z4LS2d9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768138271; c=relaxed/simple;
	bh=uJTd7kFm97ysrHbAQxlYp70ciFdNweAT92HwAYaSzBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr0Hag2kbe88PYaILQLssNv1HP09XbQUFenh49LrMDx2knnQN5l7RZIn24WQyut8gIR7hKi25HrBP425muwOIj7xjagUfR/vzxG5QrCHJuGeCDFnehMXtDG4FDZDRFqFKNvq0C4C3suCmdksvqbiZJ/94/rEw8tXlt+lML8ii/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayyp50it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F9EC4CEF7;
	Sun, 11 Jan 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768138271;
	bh=uJTd7kFm97ysrHbAQxlYp70ciFdNweAT92HwAYaSzBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayyp50itSwYXQw8Sd/9sGJuZ+v2Z5H00ftnmiwRFRXBD03QAUZWsGsLVWGt3ygh52
	 2K/CcWPTxkRHse2XLDvLq5HubAm5eweuk06VmgvhJ23GD+owi+b2XdX32O7IvUPEk8
	 X/HZdJMmznGL7WUvpzvRmV+lSFLTnqVYYqfgucQSZaLgu8vyH4Xvtq9FMwMlKSPWSG
	 oP71FgVXghtnOyAHj0gINcT9lB0aMb1Jls9dEIHoNRBtpCTmeSnoJxVveCUWtea1el
	 u31UAEp/lmeq4tu/Qok4yAjLjD/KYhW+2T73i04sD0dpbVem7SNgN480wSaelBXfiu
	 gpwhAiCv4tG0w==
Date: Sun, 11 Jan 2026 13:31:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, tomas.melin@vaisala.com,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 2/2] iio: adc: Initial support for AD4134
Message-ID: <20260111133100.373d9b92@jic23-huawei>
In-Reply-To: <aV6IP3T3Q3z3aTVa@smile.fi.intel.com>
References: <cover.1767795849.git.marcelo.schmitt@analog.com>
	<6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com>
	<aV6IP3T3Q3z3aTVa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 18:22:23 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 07, 2026 at 11:47:59AM -0300, Marcelo Schmitt wrote:
> > AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> > analog-to-digital converter (ADC). The device can be managed through SPI or
> > direct control of pin logical levels (pin control mode). The AD4134 design
> > also features a dedicated bus for ADC sample data output. Though, this
> > initial driver for AD4134 only supports usual SPI connections.
> > 
> > Add basic support for AD4134 that enables single-shot ADC sample read.  
> 
> I have been on a few weeks leave and do not remember much, but it looks like
> this version has all my previous comments being addressed.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
I tweaked to drop the explicit bits.h include and applied to the togreg
branch of iio.git, initially pushed out as testing.

thanks,

Jonathan

> 
> ...
> 
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>  
> 
> > +#include <linux/bitops.h>  
> 
> > +#include <linux/bits.h>  
> 
> No need, as bitops.h implies (and guarantees) that BIT()/GENMASK() are provided
> with it.
> 
> > +#include <linux/clk.h>
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/units.h>  
> 


