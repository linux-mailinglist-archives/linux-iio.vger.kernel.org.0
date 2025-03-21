Return-Path: <linux-iio+bounces-17170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F48A6BB92
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCD53AEF78
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CA1EA7C1;
	Fri, 21 Mar 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxGPUk3X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166D1F03C9;
	Fri, 21 Mar 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562982; cv=none; b=kUx7W54ZEQbDTau+CM2LUNZHvmEEWnQ8/x9Tvr5YTG6Y/hJ7+AzftHn+ViIYU+59cQqjEvxJyI0vFBU4zRNc0VF0bqzFIe5xtrGFZEYJ5tVNbkju3ictywUkvjpZjY9+wwujA0Etgi/SpulSrPDb6vAAWn3ql9rxCAVvyyxZVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562982; c=relaxed/simple;
	bh=Ugp7KnuqqE1AI0abVptpCHpr/xh4BmWNniBpCuTUAjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faSD0B5/u43jRemlvYbQE8tDq6X2MwJ6+o0Yd+TEp1PlopnUIJSWX/d9rBhEm4COOUL3BO7YQthVgPAgSTMxbGzs27GUbExcd2xaTmPr1jXvbPAVeCv/osR+pUrWlzXsG7uHmKIiVq8x0nrx6p+t9a3+N/WGgHtS1Vb7vBhbfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxGPUk3X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742562981; x=1774098981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ugp7KnuqqE1AI0abVptpCHpr/xh4BmWNniBpCuTUAjU=;
  b=TxGPUk3XQB69zab7sbYDWxKVIAcbMyu8BOUoIDc3N01Nqw5Sv5RyTamm
   A0nqVwwm59YvAtXSZg60eyUdEUvYgcZkE8Ox6eKKwsGwQOq8R4fWqCKZ8
   bfaDUZuX8rC431uTd5AJRsGsWb22AuEpdqR9pXzuMKNbrqAmP+JBFRyGK
   3WTAQeyNyyhMVzHd0vRPN3cg1GvzHgYnewicckFbqOyZXp+Wzpir81YMi
   kDKEFtWXRbMcaPobm5KS5IlJ7KYv/b19W0f7ukOvMwRps0epUxmek/DMB
   qELX72xBXXg00WB+njNvDjESZa2KLC9cRsa20fmegJI40VQMLCaT1J0wu
   w==;
X-CSE-ConnectionGUID: 3HZnCMUVSFGqstL5afAK5Q==
X-CSE-MsgGUID: wV2tOE+uSYuY1WvWnXv22Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="55211545"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="55211545"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:16:20 -0700
X-CSE-ConnectionGUID: +LiptlnOTHO1QgXZk70NfQ==
X-CSE-MsgGUID: kyolm/aOTbyw7mIWjRdieA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124344157"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:16:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvcEO-00000004WKF-3vbJ;
	Fri, 21 Mar 2025 15:16:12 +0200
Date: Fri, 21 Mar 2025 15:16:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z91mnHP9V0yRZ2js@smile.fi.intel.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
 <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
 <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 02:17:16PM +0200, Matti Vaittinen wrote:
> On 21/03/2025 14:06, Andy Shevchenko wrote:
> > On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
> > > On 20/03/2025 15:16, Andy Shevchenko wrote:
> > > > On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
> > 
> > You can get rid of all of these by simply using __le16. I do not understand why
> > it's not used so far. I thought that bits are mirrored, that may explain the
> > case, but now I do not see any problem to use __le16 directly.
> 
> This discussion is going in circles now. That was discussed in the RFC
> review with Jonathan, which I did also tell to you during the v7 review:

Yes, because I think we all were confused by the bits representations,
but now I see it clearly and I do not understand why should we go the way
you suggested as it makes things a bit tangled in my opinion.

Jonathan, do you still think the two separate bytes are better than __le16?
If so, what are the pros of this solution?

-- 
With Best Regards,
Andy Shevchenko



