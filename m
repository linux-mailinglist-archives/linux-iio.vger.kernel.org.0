Return-Path: <linux-iio+bounces-20630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B809AD9C43
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350057AE2B6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD124A061;
	Sat, 14 Jun 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2nnUiGD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5771714C6;
	Sat, 14 Jun 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898389; cv=none; b=QeCX/9O8FZn3TKY9cvzr7i5V3X+lK9cqjf6HkILnhbvUldvKYq7ksbkAe9uOu1bObN1RXbYLb9SkavEexO2nWZJu2mD/woIoE7RDHvdNnoBjzvoPXSV8u1waiPXJoYTVKRWyI5WCAL+jngzqmYUw2tbLdPpbnzt0sytCodOmlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898389; c=relaxed/simple;
	bh=Eu2OSNlsIbtir4QIfKAgj6Oqne8ML7YrTT4Nm6VP84w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+3hZlVqKvmtW4QGcsUDavBNqmCjCnr5ygYL11bSaNF+KBPQcO7LNyjiIhJochYQo6NvQcNHbPztjs39rerN2D6epyKV4Xue3b8i1FQl2BR8moQUTtT+gPuWYgROOTibMgx6YZp3U53hlSsFoILkHHMBUGIwUgJ1gmaSxZmETpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2nnUiGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD50AC4CEEB;
	Sat, 14 Jun 2025 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749898388;
	bh=Eu2OSNlsIbtir4QIfKAgj6Oqne8ML7YrTT4Nm6VP84w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2nnUiGDKzEIGz7H2o27zlJMQMpqsz2fLSFL1+b5pgO2nkoxl1CoKkm+/y8QFxik2
	 Mp/ohd+GEy0hYzdD0HIKw0UhQagqqKj/P+Ve1YVicIi2LaghwPPlfEpijjSluyMlhN
	 T09wxV08Xvhfe/wf7b7lMIEYSTCdXsYWEM6o43FgBCGVclxqX4qgmYv7E4nKqBHgKB
	 XJFblMkix/oO0TietI8sHPLdLerEhcTFDyILrMb0jINAxH7Y2HESc8ONOizPR6MKvf
	 0LWc24ZlQgj1XiNsdOuLX6HMHdymmOlGu/uDV1gYg5BzGXzp9KK9Jzz/bUb9z5gzOq
	 wWXe1dEHIuPqA==
Date: Sat, 14 Jun 2025 11:52:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <20250614115258.29a281c9@jic23-huawei>
In-Reply-To: <aErMgh6AKVStF4rQ@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
	<48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
	<aEifWXPV1nsIyWbT@smile.fi.intel.com>
	<aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
	<aErMgh6AKVStF4rQ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 15:48:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 11, 2025 at 06:04:49PM -0300, Marcelo Schmitt wrote:
> > On 06/11, Andy Shevchenko wrote:  
> > > On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:  
> 
> ...
> 
> > > > +	return spi_write(st->spi, st->tx_buf, size + 2);  
> > > 
> > > ... + sizeof(reg) ?  
> > 
> > The size of the specific ADC register is stored in the size variable.
> > The result of sizeof(reg) can be different on different machines and will
> > probably not be equal to the size of the register in the ADC chip.  
> 
> Hmm... But shouldn't we have a variable type that respects the sizeof() of the
> register in HW to keep it there? 2 is magic.
> 
> ...
> 
> > > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > > +{
> > > > +	/*
> > > > +	 * The use of static_assert() here is to make sure that, if
> > > > +	 * struct ad4170_setup is ever changed (e.g. a field is added to the
> > > > +	 * struct's declaration), the comparison below is adapted to keep
> > > > +	 * comparing each of struct ad4170_setup fields.
> > > > +	 */  
> > > 
> > > Okay. But this also will trigger the case when the field just changes the type.
> > > So, it also brings false positives. I really think this is wrong place to put
> > > static_assert(). To me it looks like a solving rare problem, if any.  
> > 
> > I think it is unlikely that struct ad4170_setup declaration will ever change.
> > The fields match the registers that are associated with a channel setup and
> > the their types match the size of the respective registers. So, I do agree
> > that triggering this assert would be something rare.  
> 
> Yep, which thinks to me as an unneeded noise in the code, making it harder to
> read and maintain (in _this_ case).

This whole thing with static asserts was a compromise in the original drivers.
I'm fine with just dropping it (here at least) and relying on review to pick up
changes to these structures.

Jonathan


