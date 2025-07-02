Return-Path: <linux-iio+bounces-21234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A03AF1567
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414847AF3EA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF38274659;
	Wed,  2 Jul 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxVSZt+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F01264F8A;
	Wed,  2 Jul 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458559; cv=none; b=pnvGinhLdjmjFEob2JPff75aumqA1KXXrs8vEHr4RScEVrsR7WoVnoE0gDv723dFZaMQwhsdkoo2otmS/3L+RjvCQ1cQT/1abyDqe94d5ZhmnRQPlkhAsxv/CSCXF+ymGSHslnHGNm2YhyS6lF+0n4asEBQh8QyeqjZxjJrChGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458559; c=relaxed/simple;
	bh=H7f/0HhF6bi70fjqZ5YqMeABusSJvQvwmnvNfoqGHw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBtCLmRSMyVvPSCDUqLAKxgwY0OuwNS6IOYrrWu5J+QhRYopvat0BIbDQ5GQIuTcPCI1ZRZ0890DNEE/KQ0okm4b1sCSkSyDjcUE62rSPNo6qsPydL6dSoAir95wMBXrGrPivNMtr8SZRpWEwxo8bqQlE5a5e0MqQS7kwboSTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxVSZt+x; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751458559; x=1782994559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H7f/0HhF6bi70fjqZ5YqMeABusSJvQvwmnvNfoqGHw8=;
  b=KxVSZt+xDYge8n/qDPBLp3xVlkuGhlmx0hMXtvhl1kQ44uxc4r99viCd
   pVQZHKKyUWpLx2TrIN8tVvoJz25vmLD9PHuItuVjQY6Yjl25yhP18olWV
   6FmQuuFEDpuMd/mVlh7mj0Bwrwrmxfa3qFJol823a2qdQnplVMXRUVQO4
   ajwH0XME86Kw8L9s9UB3fCThqiIYux79uqR3ZkKnA0RTI03QFngkQ5iaN
   dH4+9GAGG9hDcaOuQc+v+dJX0dpXXCsyXpVTYlB6PiiG41a8jcLgKmOpg
   yfxPrCZnrYk6uXBsLzVTU0UIDctNBV5P/fyldYIIppBNscySkrFd0rgOH
   A==;
X-CSE-ConnectionGUID: 17wQb5CaTo+q1bJ/HKbfhA==
X-CSE-MsgGUID: 0NobnaFXQMaD9UuSNscTwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="63995004"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="63995004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:15:51 -0700
X-CSE-ConnectionGUID: 6h2EqwByTs2HfWDaWsAkEA==
X-CSE-MsgGUID: o3DHRwUOQPCqGQJFxsVhaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154132374"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:15:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWwNL-0000000Bui3-10OS;
	Wed, 02 Jul 2025 15:15:43 +0300
Date: Wed, 2 Jul 2025 15:15:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Message-ID: <aGUi7r2dgnbqLOAH@smile.fi.intel.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
 <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
 <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 09:00:42AM -0300, Marcelo Schmitt wrote:
> On 07/02, Andy Shevchenko wrote:
> > On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:

...

> > >  6 files changed, 3601 insertions(+)
> > 
> > This is weird. At least patches 11 & 12 have '-' lines...
> > 
> Yeah, sorry about that. These ADCs are fancy such that the base driver is about
> 1500 LoCs due to channel setup handling and support for multiple combinations of
> voltage references and channel setups.
> 
> About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
> patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
> after patch 7 and I think it would lead to '-' lines if coming before patch 10
> since both increment the number of IIO channels. Anyway, I'll see how to further
> reduce the number of lines being removed.

My point is that the above statistics is mangled and I don't know how I can
trust the contents of this series if it already lied about that.

-- 
With Best Regards,
Andy Shevchenko



