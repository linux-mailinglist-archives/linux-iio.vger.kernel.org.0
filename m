Return-Path: <linux-iio+bounces-15807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD5A3C987
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928593AE4E6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837822E406;
	Wed, 19 Feb 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLwKh1NL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD08214A64;
	Wed, 19 Feb 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996418; cv=none; b=KFRyc+3PRqdFpFxZOkCl/ntqFdH/RTyaIHg/2JJ3TDJvEWpUaLLGMor1FHa5RbFvvoraMYQ6KqyuHb6WoHnhBvZ1BwTmW0G13I7dt2w0LBAJjfYXB4nAdPyhbxgP+/AhXSFvVascJBWVtYAKFm9kVsfHOkCzdYsbStIT1E8U2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996418; c=relaxed/simple;
	bh=oUcnF6wLVy+xmj8OVpUmP+faVLotvjxceq1mY3aO/So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/zQ/A0bIyWu4LjDD47WXHvMm3T4TNlgLwzf+whOWyJ3DOmcoLZNtKfzto844waj2yrEQCyB5nqSJj6Ve0qYzTvo/muJul4stmXTgrPI3+cB/WQEJjvE09//DC2NIctO+7Da97+S6yvi6tZMgV66q5OMQZ3uddCSARGsWqbpZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLwKh1NL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739996417; x=1771532417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUcnF6wLVy+xmj8OVpUmP+faVLotvjxceq1mY3aO/So=;
  b=SLwKh1NL1DwE6Bj7EkPzEWWHnZ0KNUFjPfvHKxAuG7IqiystVLTWdbn/
   rnDyD894CWXt8rVWQ18z1So5L6Mbzvnlso26EENVou/e24qQQah4rys88
   NAIsUWaotMENr/haVsROKSTm0n6rm6PL9Uzu6x83WNuPdsCzbNJonMTTf
   eXhgHV8jBn0+5WBHobiYFTuzuAlMtyw4zL0zYctl1sW29UQjf4cwPY/cU
   Itn0paSTooeI/1hvAnXpT52niLFGPD4D8opWJt/tCWRVhZYAXlF1Ra6TQ
   77eEORrX1tUPKw3GSoMFXu/9EiWuTDh27nR5E2LhAV8zT21E+G4MLoaZ/
   w==;
X-CSE-ConnectionGUID: 4A3KExFrQn6NS+91mav+fA==
X-CSE-MsgGUID: 6nSjkFk1QjSXFYaqHLfh/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50966657"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50966657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:20:13 -0800
X-CSE-ConnectionGUID: pBlNVsujSvyr6QenP15SOg==
X-CSE-MsgGUID: Nq+u8uC3QQy+wHa6XfpUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115020364"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:20:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkqY8-0000000D7d9-2wZe;
	Wed, 19 Feb 2025 22:20:04 +0200
Date: Wed, 19 Feb 2025 22:20:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
Message-ID: <Z7Y89AI8me_MFsEV@smile.fi.intel.com>
References: <20250218132702.114669-3-clamor95@gmail.com>
 <202502192343.twEQ3SSs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502192343.twEQ3SSs-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 12:02:51AM +0800, kernel test robot wrote:
> Hi Svyatoslav,
> 
> kernel test robot noticed the following build errors:

It a second time you send not even compiled code.

-- 
With Best Regards,
Andy Shevchenko



