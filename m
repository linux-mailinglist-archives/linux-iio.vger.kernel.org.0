Return-Path: <linux-iio+bounces-21578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C79B0221C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E31C8677E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABAB2EF289;
	Fri, 11 Jul 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSAO+6ps"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55D2EF280;
	Fri, 11 Jul 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252288; cv=none; b=XHjp3s5bWs7bB8LyndHfe4GmZKd4lQwaXe3CMxcZeVWoUGDB/KcUZEM39+fUy/95F4+bq/njPhHKu/37mZwhjuIc6bGiHl2k+W1YCCwsiAIGcxQ3sLEEDCW49+ghNMaLSPOpUeyXH/schyrSvCXnVse8ctLwjkzlpsHLfiF38ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252288; c=relaxed/simple;
	bh=J/wSSjMm8CxdiwEmnnLt5dvpGV73mYdkYp5bsa3f6Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEV6ooJx/5vxyaqbpo9DUXceJNuLvnAPs8YuJtKAS2efWimrwc5R5jTg3rwlacuehlSSk6w5FMflhH8pKxn5zMEv5P9YCxOw1gXPx7QsUatIlTUBwhWkaz6H+4mfOzYsu53vRH9//8mu8gD1O4HtAejRZiuGUPJyAl9AasZt4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSAO+6ps; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252288; x=1783788288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/wSSjMm8CxdiwEmnnLt5dvpGV73mYdkYp5bsa3f6Fw=;
  b=fSAO+6psBlg2tRuj1Fi9OCGrxbgvxeLdDOWIJU17VIPedLyRnrUEPXFf
   DyelprtGZC8uw0V/RTeJrm/0Nod0+FRscD/VszpxZxcujseLoWqATeSWj
   4la+HM64YfxZo/uyoMsJouno7z1nVn/WZ/JjU35DRpoMFzUX5WABpoQhs
   NwNkW1hevCFACi9xwDUxDIsLnW7PNZRyUe5p8pStTczws1TgHueAih0ZG
   jSnh8tOV2OOrgDjCAP71JWOtrQNVq1v9aA1lzDiB2diweQDC+zn6GClhO
   3RS7bl9feugW70v7gU2Kc3D0b0Sf3QdTl1gvB9Dgc0KVDdJ1gzMjP4Qv1
   A==;
X-CSE-ConnectionGUID: 7BtNrwcuSBemlYhcut656A==
X-CSE-MsgGUID: C03uk0/9QSeLtpZiKvKD5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77096292"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="77096292"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:44:47 -0700
X-CSE-ConnectionGUID: P+rwcfqfSWWgGnrpitheng==
X-CSE-MsgGUID: LfDpuI03TTmDwnABrdIe+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="161978212"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:44:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaGrZ-0000000EaN3-2hqG;
	Fri, 11 Jul 2025 19:44:41 +0300
Date: Fri, 11 Jul 2025 19:44:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
Message-ID: <aHE_ecZNTgRW79VU@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:07:20AM -0500, David Lechner wrote:
> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
> scan buffer isn't used outside of this function and doesn't need to be
> DMA-safe, it doesn't need to be in struct srf08_data. We can also
> eliminate an extra local variable for the return value of
> srf08_read_ranging() by using scan.chan directly.

Why not with macro?

-- 
With Best Regards,
Andy Shevchenko



