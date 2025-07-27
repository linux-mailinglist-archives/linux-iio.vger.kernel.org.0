Return-Path: <linux-iio+bounces-22054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB8B13035
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505EC174A8D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878A21B9F0;
	Sun, 27 Jul 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsQKsuZa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4A7E9;
	Sun, 27 Jul 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631741; cv=none; b=O6lCqIngjzpxcRqXtb9gDvlxadoaFND4SfenyL5P9jcdEMQwQPyoJNQZg7WyMcfBiLg1KBlvvyh9rSHFSQ5yE1bcIRCVRnZye9sayONDNT82xGv2Zgzd05hPDYqXVEIxt0PleyCX10d2ixLW3njDicqcz3UWd1XcIayh/0HfKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631741; c=relaxed/simple;
	bh=4E/KRtZYGRkw/On1zyg435iCeUBt3QLAeXe84TnbRzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zzq1eeNGbjaRVixl1GLA8mp1N4w6gKw+SKj3erVGEp1Tgs69spQICbMuEC/3JXLoNredv0wYUkUv7fnttPal+zM8ANulyeoISI+JUKuiSIJOd4HU1mf4U5419u9B3uk0/TWrcaCIkNgyGrFuscBgn3pyMoTFnTlPNXKNZiQFJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsQKsuZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B730C4CEEB;
	Sun, 27 Jul 2025 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753631741;
	bh=4E/KRtZYGRkw/On1zyg435iCeUBt3QLAeXe84TnbRzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UsQKsuZaJ3Fid87NzhJinDZGxvZaYIp30vjkpopcFkJXlDO5sqLui6Z5ih5hFEKkO
	 FRvef05NdoLKNnk1VaLqbvFh/AEv63RLmttMvorGRtJfplsnSkR26oQ5GqKw0+T3FO
	 r/busCDMVzVmTCO0yZQu7byR0fCxt/zbM9MhQ5PaJ41ZvArGC+K/cRNbLZYafdrJC3
	 eHNkyssceRIcYlMUnHQ9AdAztspVjDGGlq4R76cmWEu3T0toahadNtwkVsGAey6o0i
	 4zOLYRbpKDN6/9fiZgS4TPDegYIXSQhs/J2hro/zWCCK/Jp6xH+nCJk65GNlymZ3Ma
	 g8lkJmfdoRL5g==
Date: Sun, 27 Jul 2025 16:55:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
Message-ID: <20250727165534.6756b052@jic23-huawei>
In-Reply-To: <f180b5ac-131f-474a-be5e-70787972a772@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-3-sean.anderson@linux.dev>
	<aHYOuzdQ_jSKA898@smile.fi.intel.com>
	<8bb7d291-f94a-4e96-b3ec-93fbe06c8407@linux.dev>
	<aHdwzFk-688ASRx2@smile.fi.intel.com>
	<f180b5ac-131f-474a-be5e-70787972a772@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 12:42:13 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 7/16/25 05:28, Andy Shevchenko wrote:
> > On Tue, Jul 15, 2025 at 11:42:05AM -0400, Sean Anderson wrote:  
> >> On 7/15/25 04:18, Andy Shevchenko wrote:  
> >> > On Mon, Jul 14, 2025 at 09:20:18PM -0400, Sean Anderson wrote:  
> > 
> > ...
> >   
> >> >> +EXPORT_SYMBOL_GPL(iio_event_mode);  
> >> > 
> >> > Can we move this to namespace? Otherwise it will be never ending story...
> >> > Ditto for other new APIs.  
> >> 
> >> Never ending story of what?  
> > 
> > Of converting IIO core to use exported namespaces.  
> 
> What's the purpose?

Aim here is in general to reduce the massive exposed ABI by applying some
namespaces so that only drivers that opt in to specific functionality
can use particular symbols.

We've used it extensively for groups of related drivers and to some
libraries and the DMA buffers, but so far not pushed it into the IIO core.

I'd be fine with these new functions all being under IIO_CONSUMER or similar.

Quite a bit of feedback on this set will be of the lines of don't do it
the way we did it before as now we know better!

 
> 
> >> >> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
> >> >> +				raw64 = processed / (int)scale64;  
> >> > 
> >> > Do you need the casting? (I mean if the compiler is dumb enough to not see this)  
> >> 
> >> AIUI 64-bit division is not available on 32-bit platforms. The cast
> >> ensures we get 32-bit division.  
> > 
> > I put specifically a remark in the parentheses. So, the Q is if the compiler
> > doesn't recognize that. Can you confirm that 32-bit compilation without cast
> > is broken?  
> 
> inkern.c:(.text.iio_write_event_processed_scale+0x14c): undefined reference to `__aeabi_ldivmod'
> 
> >> >> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);  
> >> > 
> >> > You already have similar approach here...  
> >> 
> >> Well, I can spell it 0x7fffffffLL if you'd like...  
> > 
> > Nope, I like to have named constants instead of magics, but actually are those
> > castings needed for the clamp()?  
> 
> Apparently not. The checks in __clamp_once are only for matching signedness. And
> the ints are promoted to s64s when the comparison is made.
> 
> --Sean


