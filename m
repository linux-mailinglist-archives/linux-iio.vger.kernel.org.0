Return-Path: <linux-iio+bounces-19745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A6ABE404
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 21:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704704C2489
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728FF262D14;
	Tue, 20 May 2025 19:49:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB32157487;
	Tue, 20 May 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770555; cv=none; b=ZHRUHy0Mu7rmgVXuhfY+KM1OS83TFe2A1FMqkpq98Xem0Emddw12SSZCpArEI2gMSVkFGwqnfJ1LduXoNRg/DNwLVzndpKo8SbQIy3yMxS9+S7z5iP8g5ZGkHcnAO39xblF3JlZnyH7+VgwrtrOQm3aNKdrP7mLN0NLSkh2f+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770555; c=relaxed/simple;
	bh=1tzGZcKwkoir6NZZhVk7qpPRhCTL48Sf9Au3BYNZfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMVsvSwrB8Z20sxVmhcnxwtMB534oH8kShknUp2+nqLiTr9xh5ZiTVAtVd0GNfJ3sJEeeU9xdh8Eoy6sNwCwycVMH3z84MvnDFUz0GM/pRQROmN6kTrcnjDDtPdxb8Duv+T3izNZDlRbOeIcZAlEXAkoRyRU3dWPoazUaKFu7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: adkY8KTMSkmO5r+KlmWN8Q==
X-CSE-MsgGUID: iCEvoSlXQ/GAtivKiL748Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="75124751"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75124751"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 12:49:12 -0700
X-CSE-ConnectionGUID: 8W+OoyMcSwCgH8u2jRwtJA==
X-CSE-MsgGUID: hxgK8sU9T0iuFbTG92XQMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140319501"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 12:49:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uHSxW-00000003Pa8-2YdM;
	Tue, 20 May 2025 22:49:06 +0300
Date: Tue, 20 May 2025 22:49:06 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/12] iio: accel: adxl313: prepare interrupt handling
Message-ID: <aCzcskqKEXpM2jui@smile.fi.intel.com>
References: <CAFXKEHYe_LBV=95Rm75UXF97oUU5CTYzDdwXJZ=cr+4fGOf80g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXKEHYe_LBV=95Rm75UXF97oUU5CTYzDdwXJZ=cr+4fGOf80g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 20, 2025 at 09:32:18PM +0200, Lothar Rubusch wrote:
> Hi Andy, I forgot to put my mail addresses as well. I copied your answer
> now from the mailing list archive. Hence, sorry for the bad formatting
> of this mail.
> 
> One question / remark down below.
> 
> > On Sun, May 18, 2025 at 11:13:15AM +0000, Lothar Rubusch wrote:
> > > Evaluate the devicetree property for an optional interrupt line, and
> > > configure the interrupt mapping accordingly. When no interrupt line
> > > is defined in the devicetree, keep the FIFO in bypass mode as before.

...

> > > +        ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);
> >
> > Don't you want to use regmap_assign_bits() or something like this to have
> > the above ternary be included?
> 
> Thank you so much. I guess this is a function I was looking for quite
> a while and I know several places where to use it.
> 
> Anyway, I saw, my hardware test setup still runs on an older kernel
> w/o regmap_assign_bits().

You are going to upstream the driver, right? So, we don't care about old
kernels as there was no such code at all, and since it's not a fix for
backporting I see no impediments to use the modern APIs.

> So, I kindly liked to ask if you have any objections against leaving
> regmap_write() for now? Actually I'd prefer first to see the
> activity/inactivity stuff in, in case this will need some more
> modifications and I need to verify them on hardware. I think, leaving
> regmap_write() here would make that easier for this patch set. Please,
> let me know?

Ask maintainers. I will not object if they agree on your justification.

-- 
With Best Regards,
Andy Shevchenko



