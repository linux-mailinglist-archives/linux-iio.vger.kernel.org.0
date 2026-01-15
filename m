Return-Path: <linux-iio+bounces-27819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE940D233D6
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E71F5301BDE4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCB311C19;
	Thu, 15 Jan 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUocwgXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249033358C4;
	Thu, 15 Jan 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466628; cv=none; b=G01Nb2ZjuZKkfdZb0toG2ln6/NDpJyZItVDto1uaUFucH3yV9q2ptcdcoR54uM7sRYbY3Mfg9RNi8gjAMjAAvm3YphgS2iPlbdaNgzS6ZlW3qBTqOLkBagbf+E3S2za3YkHdhY6Rucyn+jYOoWWnRBC7oaps/EqEDTATb4zzFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466628; c=relaxed/simple;
	bh=ptWUaNlici8SBGXKdCRew/hqq86HMoCsd1htiyaWuoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmT9+7/Di7wJz2AM4iazoHZ0coBqkh91zrrcixdfGLxo+s93cguVUinfojRr4O7lMIaWTJy7kotR4d6IV7HOIgshfKCLJviVm5dU8EPTKYBBYqDSVW8oB7LEbth2pKhS30X9VzJa2gVwBPdUEHeUdtzgneHaaENnWyMdtFvdt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUocwgXF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768466628; x=1800002628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptWUaNlici8SBGXKdCRew/hqq86HMoCsd1htiyaWuoQ=;
  b=CUocwgXFpPVsyDKZYesd3feW6f4DQd6B0vK0LdNSZYFWs8mvTYd23exT
   m4QkmLAO3w+CjCZ7Clb1D+Tim5LLYkyqTUzwnjYECixWolvOnde6a9Jo5
   pKc4IkR5V9q8dSSA9L59/zTMVC5muIaWbtIT1z2UIxSLIGZAw7oy2n2+o
   xqDtYzx7qklW6TfJbgiw2KjvNDPbmoA2+L9KxyUR1JlIwRyNRLFyOgvO9
   exM9JrjpbTOqFJZcQZJdqvBc8fr+IRA+Fno7dkadjXGcK7AXg8c83KLIs
   ONIpN+lfh+bw+PuDOYRWIqVHYyWQtOyTe5oF/zW/7YRdTjsFQkmBzD4mM
   g==;
X-CSE-ConnectionGUID: ef95VhyPSrueI31i+tLpAw==
X-CSE-MsgGUID: MWUKnVR4RsGzojdEl55XWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="92439235"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="92439235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:43:47 -0800
X-CSE-ConnectionGUID: 0atAEu8vQ0y+STmeYTXpsQ==
X-CSE-MsgGUID: Av+lgORPQoGh9SxmTzWh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204110199"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:43:43 -0800
Date: Thu, 15 Jan 2026 10:43:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: proximity: rfd77402: Document device private
 data structure
Message-ID: <aWiovW6h4B0zcMg6@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-5-594eb57683e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-rfd77402_v5-v5-5-594eb57683e4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 01:57:41PM +0530, Shrikant Raskar via B4 Relay wrote:

> Add kernel-doc style comments for struct rfd77402_data to describe
> the purpose of each member.

It's not a kernel-doc.

...

> +/*

This marker is of the regular comment.

> + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> + * @client: I2C client handle
> + * @lock: mutex to serialize sensor reads
> + * @completion: completion used for interrupt-driven measurements
> + * @irq_en: indicates whether interrupt mode is enabled
> + */

It should be done before the patch that adds new members to the data structure.

-- 
With Best Regards,
Andy Shevchenko



