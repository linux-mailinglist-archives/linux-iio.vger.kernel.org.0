Return-Path: <linux-iio+bounces-14901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9EA256FE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E190E3A5220
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8230200BB9;
	Mon,  3 Feb 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8ItnX1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1B70809;
	Mon,  3 Feb 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578853; cv=none; b=kAtQRjphXcfOhZpl+TcSacgy+YYFY5AReBelKVVoHxBtt2lOJMQZVuieloN4r4fUbnUl7s5wu44SXdMoGu1p0A8bDVCSNSVaUtgdfpWcbMZY7irv63dV9NqdwEjHgtsqDnVsylb0JTx3vcgsUpfes9sks+rKtAGNPPVrckPR0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578853; c=relaxed/simple;
	bh=uSP3FZGaYgB1Er254idTwB7j/p+pfihDDklq8RXpqDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY0sjm11WRI7Aa8qMsMWrq23K1iMofI7XeFQQzzn8/LOnQYKVRg55pAhFCcVJePRmeZ3FqQjNprxRLGDfioO2NUu7sJpLxpXREhrKJUTqtVmCGj0ekfe1kjyXq0Wku8Hjb4WkUdkOy3MIjy6XfY8DYnxUL/RpaSSjTkGc75uYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8ItnX1b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738578852; x=1770114852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSP3FZGaYgB1Er254idTwB7j/p+pfihDDklq8RXpqDY=;
  b=V8ItnX1bF97TaddkGth7+JiAUFHUuoLbJF17TjkjHlSs0++WGvf/QTgo
   zRNtxmqmcfE3XN79wir34i91hV9xLPpWWeMIOEeUcotV2nOYXkTGmXRMm
   sZwErn9HisRhYjCPgVl5GWsYSGodzcMWx4VEIQtMMjqojhJ+hZO9FM+Go
   uHP3SFqlhG8aE3cJ6Q1sDdCkELBPeMlU1jkooj2AlCIc8oFQtZYwqUkI1
   ieV59Z8XoFiBt5CeaRRJxnoqMnaMW+z0zlilMBuVre7t2yGm09p4Z8EGz
   cMDs2Ifsz7zxr0cMqvpqMV0W4kGJammJXNPbd+RM6gkzrT84+MsPb8ing
   g==;
X-CSE-ConnectionGUID: ffHgfInsQTab2kahgY63gA==
X-CSE-MsgGUID: 8BdOZRnjT7KtLMPAWqwxew==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="42722111"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="42722111"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:34:11 -0800
X-CSE-ConnectionGUID: mAtv9XmoS/GK/ej27d7W2Q==
X-CSE-MsgGUID: DOC0sd2ERJ2eWClI1z6NAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="141123795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:34:07 -0800
Date: Mon, 3 Feb 2025 12:34:03 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z6Cbm3XAG-8XPvoU@black.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <Z6CRBDpXpPha07mf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CRBDpXpPha07mf@smile.fi.intel.com>

On Mon, Feb 03, 2025 at 11:48:52AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 03, 2025 at 01:38:42PM +0530, Raag Jadav wrote:
> > This series
> > 
> > 1. Splits device/devres.h for the users that are only interested in devres APIs.
> >    Original work by Andy Shevchenko:
> >    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> > 
> > 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
> >    across drivers.
> > 
> > The idea behind embedding both work into a single series is to reduce conflicts
> > and dependencies while merging.
> > 
> > v2: Use size_mul() for multiplication (Dmitry)
> >     Update commit message (Dmitry)
> > 
> > v3: Embed devres.h work by Andy
> 
> >     Add more users of devm_kmemdup_array()
> 
> I understand the desire to cover as much as possible, but it becomes much
> harder to coordinate.

I have a few more patches which I'm delaying to reduce dependency.

Raag

