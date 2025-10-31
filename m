Return-Path: <linux-iio+bounces-25750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E1C2516D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908C94F5697
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB2348864;
	Fri, 31 Oct 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqpsvIkH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA0318157;
	Fri, 31 Oct 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914869; cv=none; b=dJsbOo6DqbcNx6zc4FDFF15BsL47e+PpgnBoP8uSQsyrhJjArDnvTxNYPKFbmmZzK2oBcLTu34RpH86SLElV5Emsu/9pokc5NhtTFVWERg8cAF0YON/Mz1+HhG48WedxOLnSj9LmHWv/21u1UyJMYxv9ZPzbcAI7o3gvNXjn/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914869; c=relaxed/simple;
	bh=Wr5WkAhQ1P4UtW5zWzRR9PdNLDhmoSwH1Ltzzq+g+z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhAkAzYU5FU3i8FWLPiwpWp7ef7xP+I6R1lhEbWqHICWVWFjsTQBNcXL/UfK3xxl53HSIIKyupLiGKojJsRTJQjqoCOiImauQYMhYGFE+FmWPI9gtRsj8TrKAtGJKddn4ENZcXbIMt5e29ysmxvzlfZfOIm2erCyMtQOojPw9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqpsvIkH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761914868; x=1793450868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wr5WkAhQ1P4UtW5zWzRR9PdNLDhmoSwH1Ltzzq+g+z0=;
  b=bqpsvIkHZFq3DF2tREsVa2FRzL6gEhSD0Me046JEx2ReyDB/voRKDCrz
   bVihwzr9xA4aUD/HjvM4/jfxeyI3CsT994znw+YBM/oCZQmxrkWLVFcjx
   ljsXbFh12XQtXG6ET4ltTvee7C7Seu4J2a8E10OCCEB8XEi4g1z0544WF
   qheVhaxToZWfik3KyIsFdjEv7c/31mtDdxtuE6CP+buqiJy1+lrf10PSk
   UhOoTQBY28qhVyLIGMiBLnqxQ1n/ePUEY1dxqf0paImRM/ioCak6pYUWd
   1GUVXwoiiBguoI3rn2wv7tMa1DviZjNgD0Jw7/qRhKMefGUBJoQSVgk6a
   w==;
X-CSE-ConnectionGUID: dkcy/tn8S5um1rXfz2oB7A==
X-CSE-MsgGUID: /+YdE7wCSBWo7KAGtAKDjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63279641"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63279641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:47:47 -0700
X-CSE-ConnectionGUID: emTcr4y+SmCGbNclHg31kw==
X-CSE-MsgGUID: bOohS8kzSOGSoMtaG4dXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186106036"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:47:45 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEoXc-00000004GQm-1Q9y;
	Fri, 31 Oct 2025 14:47:40 +0200
Date: Fri, 31 Oct 2025 14:47:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Message-ID: <aQSv6xM6j-lpTzdb@smile.fi.intel.com>
References: <20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 10:58:02AM +0000, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>

Sorry, but you must write the commit message.

> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> ---
> The sleep variable in inv_icm45600_buffer_postdisable could be used without being
> assigned in case f error. It must be initialized to 0 by default.

Why is this in the comment and not in the commit message? Also, can you spell
out the real compilation warning or so?

Otherwise the code might look okay, depending on the context. Again, usually
it's recommended to assign as late as possible to avoid subtle mistakes when
the same variable might be reused in the (future) code.

-- 
With Best Regards,
Andy Shevchenko



