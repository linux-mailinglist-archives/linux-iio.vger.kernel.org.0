Return-Path: <linux-iio+bounces-24032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F8B555E4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A738F5C53DE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C232A818;
	Fri, 12 Sep 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKP1+jFV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B06302CB2;
	Fri, 12 Sep 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700626; cv=none; b=nsV6TdAHBGqYtwCNKXQ9H7LSc5DfgP9ddbtBpPRrl1z1HZKa4+ebdAUb3W9lKpRlrpGBUf37crM60wCblmPQIxHeWnToU5sNRAwnQ83TJrXUM2tkvCeukee/DY+/aHYKZWtDLY4w66C8xQcu4IcZTogAPP0bw78rie2LqpCxsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700626; c=relaxed/simple;
	bh=3iBbJ1LBmr3DhMVbBeBTSBV3nnM7ZsbQKxA8chRWBv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCAZdYEN9RNFjA3QUNJXw9E8Yd44dpQz4pGb70VRnaYZOQp3AB9P9Q9xGTFV9SG7VktMQWpw6ssF9y0lzEAvL6dDFzIVPcFKUAN33Kz8n4GyDEhpF25N+utc7gYTl1y0xPiR2MJuCqi91hfz3hxwpCMqEQxIq/TROi6eDzx3Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKP1+jFV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700625; x=1789236625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3iBbJ1LBmr3DhMVbBeBTSBV3nnM7ZsbQKxA8chRWBv0=;
  b=gKP1+jFV0sXE4jESCbrIGDqxVyFYXquZ7pYnFnz/Dz4OO6/YXxHYDjEC
   haLrJf5XleQoc9ej+g9SPBMcqtngkhm8Su6cNn+GjO/J2Z2EDF7ZzmwdA
   6hrecF7ENkHKdOwKS1X9V0weMuf2Cbb9xc1p3GY0DTt3Ri+xd+Gk610kw
   yipzpUxVjJe/3sxVc1ZC5d4BXvMpT2ItMtQuBW26T2Cs/UxzXbarQfI/1
   Q0AdISyvycGgpogPompBPrANGXvnyKPGiKz3Wo50u+gCJ0MQs9vL3AjED
   hDBWRpVTmPufsRrXbrz8G5Oh3c4CushleeBoi2ogsQOh2G7aKIaMc2cTP
   g==;
X-CSE-ConnectionGUID: dDrKyevLRuCST5SeZW1agw==
X-CSE-MsgGUID: aQNN9Q/WRm+J4R4Hz0VLlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="59092654"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59092654"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:10:23 -0700
X-CSE-ConnectionGUID: /mZKwNGmRjOIduQ26g3gAQ==
X-CSE-MsgGUID: uLi8s0bFSMSZPNbZ9JLkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173185872"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:10:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ux8Dy-00000002T1s-27ld;
	Fri, 12 Sep 2025 21:10:18 +0300
Date: Fri, 12 Sep 2025 21:10:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/7] iio: buffer: iio_push_to_buffers_with_ts_unaligned()
 might_sleep()
Message-ID: <aMRiCvmGt27JEYBz@smile.fi.intel.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
 <20250912-iio-doc-push-to-buffers-context-v1-2-c4aad013d96e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-2-c4aad013d96e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 12, 2025 at 11:05:53AM -0500, David Lechner wrote:
> Call might_sleep() in iio_push_to_buffers_with_ts_unaligned() since it
> can allocate memory, which may sleep.

It can or does it always do?
If the first one is correct, better to use might_sleep_if().

-- 
With Best Regards,
Andy Shevchenko



