Return-Path: <linux-iio+bounces-16986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EBA65792
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD31884985
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BA1991CB;
	Mon, 17 Mar 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBMdYlUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E0191F6A;
	Mon, 17 Mar 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227514; cv=none; b=CdDLlufetzOCa7J/93CkfZ+gWsUDBLSB8NjQhd9SXIB4YlIAoxHc4Rc1kLlTXceJCvGHiPv9UWp5cnZjKgAW/MSC0tn03Y7Gx+4WkfQ7bCu27jWNiR1UPmI6j+8bxUeXN0GJfuX5FcABdx6T2NWuVnr9DebfvJI6USxrApiXMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227514; c=relaxed/simple;
	bh=gBan3RY0LoNCVgD61lrCi1GDyG/NWfQNDeRXn9WrIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4BfFAzrftVz7K2s+ULnatUjj0U0C5RZAsGCnujFhiuc1Giz6209yef4DeIDoQqKIVe98ZRlMiu5cZUr7Et6u/PxzQM5ZHHQIHUliZ1mUuA8W/2qBcga2U3htWvn5Fjn+VaPnN0NkYrHrTaWY1iPjE7ZoTvYXphkjHVWFywXUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBMdYlUx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742227513; x=1773763513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gBan3RY0LoNCVgD61lrCi1GDyG/NWfQNDeRXn9WrIYQ=;
  b=JBMdYlUxAk4NVPFYi9zdUlFtPrXS9M8Vp7vDCU8Ee6SmqCELljP94SIr
   ZIIdm+LsxXT1iUHqnfsHtChjUnOziwEZCbuYfDFNUBrUrYlHe2CN0/tbk
   pUB0ZuK5LNOrp0Qxrv56w/I7UIonOAcGshANP2FDyJ9W2igLbH9z6geuu
   JGQuPearqtRgg8pM2RB7tCIzIsXi3V2GIrlcRfqN3dTB5Z3OSuPNshKyE
   PFxKUyFR9mHPNjhdMUQumAq/Alh/cb1fXGSNDMrV3iuSDP3+276ptrg8w
   JloGJAVCgROGRjcQxF4eZ95W52adAgrlwQi5YHSL3nFtNjFpQbT3fQvxs
   g==;
X-CSE-ConnectionGUID: 6Gzq/ysERRGdVW7asneDeQ==
X-CSE-MsgGUID: xOZc9VsISIyiMU1HAOM3kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43240988"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43240988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:03:13 -0700
X-CSE-ConnectionGUID: CVPcKQ0jRjW7UNLmHtaUbQ==
X-CSE-MsgGUID: mhtgn21rSZuwusaAqIQDYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122470767"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:03:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuCvd-00000003LyD-3atp;
	Mon, 17 Mar 2025 18:03:01 +0200
Date: Mon, 17 Mar 2025 18:03:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v8 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <Z9hHtTzUQ4CE8AB_@smile.fi.intel.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <78d33ea9a795abdb2c5a4c606d48593e827ca59e.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d33ea9a795abdb2c5a4c606d48593e827ca59e.1742225817.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 05:51:14PM +0200, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> help drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -properties to channel identification numbers, used in the struct
> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the in-tree .dts seem to have
> channel IDs between 0..num of channels.
> 
> Use the new helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



