Return-Path: <linux-iio+bounces-21195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52944AF0201
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4CF17727C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE727D770;
	Tue,  1 Jul 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldDt/K40"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8F4A0F;
	Tue,  1 Jul 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391413; cv=none; b=e8vKOufwwJWPYoJmwiiTLMczeSbMG0JrtK40jVnBZ1qgIgfbVWgSYD5yChsdVJvrQkyOCP48p418E355gobRo525lgU9umiAoE44qyiY7OW8+aCZpcmFSlXBvPfib5ZN7alsToD+h8pdbaV9EhgmKpZHU4i09U7VAY05DK5hNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391413; c=relaxed/simple;
	bh=mklzVQ7qXfitMEfKoIFTeR99bfWpQsZiRO6zbf9zQY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd13emR4RAZ8NO2HB2nX3Ugz4OUMcX5QcjnTDoP5DFH4gcaUIyovBXPh455y6ZzIsiwUM88jft196hldvtRFPvIuWPR/7vizw1v+GqsiUrjhPp1oS1dNO0zMJnRu48taFZK11706RnkqU+IdVeSyaLovrGiguqHxPe66vtsidPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldDt/K40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35756C4CEEB;
	Tue,  1 Jul 2025 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751391413;
	bh=mklzVQ7qXfitMEfKoIFTeR99bfWpQsZiRO6zbf9zQY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ldDt/K40tjdGjzFN6ne/KfXbRBQN5qtVZsDfBx0cUZwWyR6RfYFatK7oHDeu96GEU
	 hOsME42+ZkBxpHQrdeDldxmX0+5H3MW7sl0GcAkan8/5+pIlvmjwK10ZcpbIOs/Zte
	 NPOPTz8hWFvPjkfUh9b6omgec6BI4Qezmwy4YbpzRMoXQyyBxqnFQ9TSpfsLmtix5d
	 oVqlIIDbwjhC0G6/WUqZCtAe9W3hpCVsf+t5PmPRyPXsXAMb80/HsmLBiBzu/aYJul
	 4wFJDDEz0BVE8Pau+4HfwFP3rafU3cVjc3gK5rJ7CDyoaPxKhkAqNjcgy3pqxUZJoR
	 S/LgVuiZSVMgA==
Date: Tue, 1 Jul 2025 18:36:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Message-ID: <20250701183618.43ccb548@jic23-huawei>
In-Reply-To: <aGPm1td5sEqp5R9H@smile.fi.intel.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
	<20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
	<20250628155643.7c18e023@jic23-huawei>
	<aGJR_YyW5tCMjxUD@smile.fi.intel.com>
	<e4c7296d-6afe-4edb-b26f-44218e660a80@baylibre.com>
	<aGPm1td5sEqp5R9H@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 16:47:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 30, 2025 at 08:33:59AM -0500, David Lechner wrote:
> > On 6/30/25 3:59 AM, Andy Shevchenko wrote:  
> > > On Sat, Jun 28, 2025 at 03:56:43PM +0100, Jonathan Cameron wrote:  
> > >> On Fri, 27 Jun 2025 18:40:00 -0500
> > >> David Lechner <dlechner@baylibre.com> wrote:  
> 
> ...
> 
> > >>> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
> > >>> +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);  
> > >>
> > >> Ah. You do it here. Fair enough and no problem wrt to patch 1 then.  
> > > 
> > > Hmm... Should the second 8 be something like sizeof(unsigned long lone) for
> > > semantic distinguishing with 8-bit bytes?  
> > 
> > Yeah, I considered to use sizeof(s64) to match the next line, but it
> > it seems like a separate change, so in the end I decided against doing
> > it in this patch and it seems too small of a thing for a separate patch.  
> 
> The problem in not the size of the change, the problem is that semantically
> those 8:s are _different_ and code readability will be much better if we make
> them so explicitly.
Agreed. It's not so bad once we are down to just one magic 8 (ball :) but
definitely makes sense to give them both explicit meaning.

A tiny follow up patch, or rolling it in here with a comment in the patch
description would both be fine.

Jonathan

> 


