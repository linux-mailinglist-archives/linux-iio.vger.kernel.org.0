Return-Path: <linux-iio+bounces-17494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817AA76D7E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 21:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23AB3A9D45
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C21DE2C6;
	Mon, 31 Mar 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="aQPvP/ce"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F12114;
	Mon, 31 Mar 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449459; cv=none; b=Ob0cluFKc61HntPgUrp7BKe/IJperFbvBCN1BF5qzZmopSSC3TrwN1tprKsxUAUEXuAmOuPcYwX0ZIH4847+gPDvfeTVQ5lI+4z74l6C49XM7og+rzBRHaLIqS5pHZkyHndToGWbcTc9mRkindxkGWioEAbrGYcg7BLJayBoDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449459; c=relaxed/simple;
	bh=5fDvWYlmklSJIuIH3nKjwJPHW4lF+afHO6be9jzEMOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIEkoLD5KcWl77EeHLQ98d6j/mrWi+CvHhMUQ0HcWOlQ9Q4ZFG4HCKrci2voMaFkOwvLeBiG3JMkxagjWAcdNxGpI4QDXYCype013hXlp/csdbI5okba492DK+XcrGafkHeCZAnfHJuWRCUg7CKQMfTdVPJLQ64YjRlh+q6gPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=aQPvP/ce; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZRLp13Wdcz9sNx;
	Mon, 31 Mar 2025 19:30:49 +0000 (UTC)
Received: from MTA-13.privateemail.com (unknown [10.50.14.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZRLp067Mtz2Sd0R;
	Mon, 31 Mar 2025 15:30:48 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
	by mta-13.privateemail.com (Postfix) with ESMTP id 4ZRLp04kqvz3hhXJ;
	Mon, 31 Mar 2025 15:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743449448;
	bh=5fDvWYlmklSJIuIH3nKjwJPHW4lF+afHO6be9jzEMOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQPvP/ceXuB3n2EoUlKP/9KyjbFSJYLfUBIXSa04DucEv39456vr1eXW7oHXPDua1
	 5G3YldXC5O2YTc7ZKw8XM2ZUtQsNwGCg6HVcQ5O0LUJz3n67yRDlymGykMU2n7jvnY
	 t298jQktcfrm9W263IJmslM2mklfsYUeYKjd/BzV8Kmcay/uTYBNijXx4CEeEk1+/R
	 J8twU46j9LR0ptxLG8tGqFjBLUr5IpZ6/pb9qfl+Dc5bg80oytgdNLP47HOmEF5sIG
	 0HfFaWsayI/j6tUzvQ3HOUcOOCq1Kt3n3YwhCyuMZ7ul56I9Diuf/dH7/Lm0DgDtnY
	 tKw5IOyFP0L/Q==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-13.privateemail.com (Postfix) with ESMTPA;
	Mon, 31 Mar 2025 15:30:35 -0400 (EDT)
Date: Mon, 31 Mar 2025 15:30:37 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	bpellegrino@arka.org, Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v8 0/6] Update auto corner freq calculation
Message-ID: <npxfioo7wvjaduggdlk765uwna2umnwhmndgmk3mcwcjyi3jwd@wi6mbnfpvmss>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
 <20250330162300.4c318897@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330162300.4c318897@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sun, Mar 30, 2025 at 04:23:00PM +0100, Jonathan Cameron wrote:
> On Fri, 28 Mar 2025 13:48:25 -0400
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > From: Sam Winchenbach <swinchenbach@arka.org>
> > 
> > v1: Initial submission
> > v2: Cleaned up wording of commit message
> > v3: Add DTS properties to control corner frequency margins
> > v4: Fixed wrapping
> >     Added maintainers to CC
> > v5: Remove magic numbers
> >     Break out patches into features
> >     Small coding style fixes
> > v6: Converted dts property from hz to mhz
> >     Removed blank lines in dts binding documentation
> > v7: Updated author/sign-off address
> >     fixed patch path description
> > v8: Added missing Reviewed-By tag in v7
> > 
> > Brian Pellegrino (1):
> >   iio: filter: admv8818: Support frequencies >= 2^32
> Applied to the togreg branch of iio.git and initially pushed out as testing.
> 
> I thought about splitting off the fixes and sending them a faster path, but that
> last fix is rather large for that so I haven't.
> 
> Shout if you think I should try to get the fixes upstream quickly and
> I can move them to my fixes branch.
> 
> Jonathan

This sounds fine to me. I don't understand the differences between the branches
so I am more than happy to defer to your expertise.

I don't believe these fixes are critical, although the behavior is incorrect.

Thank you, happy to see patchset making some progress.
-Sam

> 
> > 
> > Sam Winchenbach (5):
> >   dt-bindings: iio: filter: Add lpf/hpf freq margins
> >   iio: filter: admv8818: fix band 4, state 15
> >   iio: filter: admv8818: fix integer overflow
> >   iio: filter: admv8818: fix range calculation
> >   iio: core: Add support for writing 64 bit attrs
> > 
> >  .../bindings/iio/filter/adi,admv8818.yaml     |  20 ++
> >  drivers/iio/filter/admv8818.c                 | 224 +++++++++++++-----
> >  drivers/iio/industrialio-core.c               |  12 +
> >  3 files changed, 202 insertions(+), 54 deletions(-)
> > 
> 

