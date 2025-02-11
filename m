Return-Path: <linux-iio+bounces-15326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DFA306FE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A06161E0C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401A1F151D;
	Tue, 11 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DItwODFp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F291F12ED;
	Tue, 11 Feb 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266061; cv=none; b=sk70+mS5B7P+ZqTSTqP4MGVqm+ECj5O0sNoymnS0Bzato47h5b4GCr31AeDJqOhH1naEgdvqofj+K8G3E87RJ3hbARSVKCECKaAvzA1C2ImM6slMu82+oK9o0kFcG/fbJR1EEmXmPy3RYJz43OmIH23Cm9XPFtVINWloFeyFAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266061; c=relaxed/simple;
	bh=2RCq9ghRVTkmfN4A7dFDaEQ2QNjkz/H5tvfKNfB13eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haoh4n0nOn7dCCnjTASVZ6E1MbVuJa0fPnBSAKXl+GAss/uS5gfzhb4+2cujkPA6gHcbBuL/T1nHaWXZdJUqexjDNI5BvKb/G9ITjfgdZ2YxDD3W2e8K4turxAteqOR5s2voI2pObNV9MKi6oXzkBn4JpjYB20qRwTgUq+/gcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DItwODFp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739266060; x=1770802060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2RCq9ghRVTkmfN4A7dFDaEQ2QNjkz/H5tvfKNfB13eU=;
  b=DItwODFpqCni3mJII1u7kUdaB/bFR02L7lUKFB6E/59ZFIa4K9O38+d/
   UpauAdUIH8vXocDt8Ek6ukWMvvLjBz7/W6UWGhzg4dtIqi3ORqf8aGXzT
   m15qnQL+H08lniZ5AaNzX1cNsNf0Ptok6PQ5S+crKmTamqh2XG7suwG+d
   ra2SGr3S/d0ijZZlM0dsOBlUhfusUUglIFrXAHqSQTaJN9PDRRr0SbIJW
   rNOAuc51uTQ8cQQvAV0RLEH57NwSPoQzdZqh5g9WKkNZAGwbL6X/QDTkd
   7Q0/6wdY80TAiOJWK3UgzRXC6itJdTtI1SzInDo3ZmlaKApXNAaLPU4Dv
   Q==;
X-CSE-ConnectionGUID: 5RdVWg9yR6Ks6J0PnmW5ZQ==
X-CSE-MsgGUID: FpJRw5pWSP6PahaSG1bLdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39793016"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39793016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:27:39 -0800
X-CSE-ConnectionGUID: Pr/8aBGuQweEYzaNj0jMlw==
X-CSE-MsgGUID: y0A1/oeOSyyoww7IQv5H7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143360490"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:27:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thmYF-0000000ASOG-1dII;
	Tue, 11 Feb 2025 11:27:31 +0200
Date: Tue, 11 Feb 2025 11:27:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 08:36:47AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 10, 2025, at 16:23, Andy Shevchenko wrote:
> >
> > TBH I have no quick idea how to address this. It seems that io.h 
> > includes device.h
> > for no reason (but I haven't checked that carefully). OTOH, we need only
> > IOMEM_IS_ERR() definition which can simply be moved from io.h to err.h 
> > as the
> > former includes the latter and the definition depends only on 
> > compiler_types.h.
> >
> > Arnd?
> 
> Removing linux/device.h from asm/io.h is probably the right step,
> it really has no business in there and no other architecture
> includes it. I don't see an IOMEM_IS_ERR() definition, do you 
> mean EEH_POSSIBLE_ERROR?

The definition is in the generic header and patch here relies on
that definition to fix the sparse warning. The simplest solution
is to add another patch that simply moves the macro from
linux/io.h to linux/err.h.

> Most of asm/eeh.h probably shouldn't be included by asm/io.h
> either, my guess is that we can get away with the
> eeh_{s,}{b,w,l,q}{_be} helpers, eeh_memcpy_fromio() and
> eeh_check_failure(), which have no dependency on 'struct
> device' in the header.
> 
> Removing a giant header inclusion from another one likely causes
> build regressions in drivers that should have included the
> header (linux/device.h or something included by that) themselves,
> so ideally there should be some separate build testing of
> powerpc kernels.

I believe this might be far out of scope for this series due to potential
fallouts here and there. But would be good to have it separately.

Raag, I think if you have time and motivation you can create that patch,
but send it separately. And this series can be fixed with the move of the
macro.

-- 
With Best Regards,
Andy Shevchenko



