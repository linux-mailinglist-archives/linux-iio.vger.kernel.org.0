Return-Path: <linux-iio+bounces-26856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7BCAAD49
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D03F30057A4
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433022D9EC2;
	Sat,  6 Dec 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwv5CbKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388F2777F3;
	Sat,  6 Dec 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053008; cv=none; b=gFFP57uJ1H/rH/OjXQG3utffVC5N3bOrAcAvsnN9chsO2f0pi8UKYMZwR08oIQhcijB0SOY6+D42uajRU/j3wWqJUe3Kje3ty8XjK9ypJC4QChoASSablwqADey49iPUHYr6eSy1eFrUbGVa6Xskb0SFlbpPK8AZAAq4QbzDzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053008; c=relaxed/simple;
	bh=AeG6CyeTLBhqYw8ko0SkGA8H0Eq6FPxbf3NnCjokSUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUf0MiOiAZkQn42wdyLFuwpDx5FPFw+j9L6qtjJeFL1RV4yCdP9ihRuoaIdGYp5o2XrHRL9PdZsbPWwTZHGVjbPfqHflh1j5PuQ3n5rl3TvoK9E2uQm1Vklf6EXvvasU3JCLDR0/RUCDjjGKpzmwsnvt9R7QCnvxjji3R445HFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwv5CbKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B911C4CEF5;
	Sat,  6 Dec 2025 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765053007;
	bh=AeG6CyeTLBhqYw8ko0SkGA8H0Eq6FPxbf3NnCjokSUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwv5CbKN75LeakBVV6ProcmYSiN3n9pYG6up5jGXq1KlOaEpbAUWdV33LalVqztaj
	 gOZkhUy5CH2s2qXY5ZJXIAhou2b3POgKgpGSpTgcsQ7IwvPWqWjYiagL/n0ZGAHUWF
	 kGTg/VqVDvWQRp72BXJPvyQsCqKbLpwAbtQNABMPF3FYyqrTfYKGiqFZxyBaPXjvAY
	 8siWNYqGo9pNXLhHmHdhTInN8f0vMVU9HlcjPXS90JKLo6d4WhptR5s/bueKtLL99Q
	 jd3Lsx1ZD5hIT2dpfuA0Y9exNwo5w5/oFytmDrILR5KEDZngOwHR9XSxOV7gbKcKdC
	 bShRdAM4TSDoA==
Date: Sat, 6 Dec 2025 20:29:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno S? <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <20251206202959.084b8b3f@jic23-huawei>
In-Reply-To: <aSgNuVyyA6AtxtKs@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
	<20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
	<aSRF-DL3rKjyFleg@smile.fi.intel.com>
	<aSSV4lxzatAFds5e@lipo.home.arpa>
	<aSSm3JMY3DSg1Nns@smile.fi.intel.com>
	<aSTJML3fxp0sSeCq@lipo.home.arpa>
	<aSTiFxAolJ0JeUTj@smile.fi.intel.com>
	<aSf3RUeghPcC80VG@sunspire.home.arpa>
	<aSgNuVyyA6AtxtKs@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > We have drivers in the kernel with two buffers in the same structure.  
> > 
> > yup. some __align twice just like in my example, some __align just once, some use
> > a simple buffer placed on the stack with no apparent alignment when sending the
> > data.
> > 
> > I've been told during an older review that both buffers need to be aligned due to
> > DMA-related requirements.  
> 
> Correct, and this should be done for the buffers that are subject to DMA, PIO is
> fine without that. Consideration of Tx/Rx split varies, indeed. And I'm not sure
> that the authors of the drivers fully understand when and what alignment is
> required. Jonathan once explained to me why only a single alignment is good and
> second is not needed, but I forgot that, can't reproduce right now. It's
> available on lore archive somewhere.

The logic behind this __aligned(IIO_DMA_MINALIGN) is all about who can mess with
stuff in a given cacheline whilst DMA is ongoing.

There are DMA masters that, when only actually using a small part of a cacheline
will copy the whole thing to local storage, run the DMA and update the bits they
are using before copying the whole cacheline back again.  Note there are other
DMA master designs that don't do this - so you may never see it!
IIRC I only hit this once many years ago - it is very very hard to debug though!

So if anyone else (e.g. the CPU running something parallel) touches other data in the
cacheline (64bytes or so) it will be overwritten with the stale values.

The iio_priv() structure embedded in the larger allocation has forced alignment
to allow us then to use an embedded __aligned(IIO_DMA_MINALIGN) to force padding
between other elements of iio_priv() structure and the start of our new buffer.

We have to be careful to not put anything that might be concurrently from a different
element (e.g. CPU) after these. E.g.
struct bob {
	int a;

	u8 rx[4] __aligned(IIO_DMA_MINALIGN);
	int vitaldata;
}
could result in stale values in vitaldata.

The assumption behind being able to do

struct bob {
	int a;
	u8 rx[4] __aligned(IIO_DMA_MINALIGN);
	u8 tx[4]; //no marking
}
is that both rx and tx are handed to the DMA engine for an operation (some lock
or similar protects them anyway) and DMA engine that managed to corrupt data in
the copy of the cacheline that was entirely in its control is horribly broken anyway
and it's up to the SPI layer or similar to bounce buffers if that's the case.  Short
of randomly writing stuff it never should touch in it's own local copy of the cacheline
I have no idea how this would happen. 


Jonathan

