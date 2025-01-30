Return-Path: <linux-iio+bounces-14743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472ACA23393
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD313A5FA6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB651F03D7;
	Thu, 30 Jan 2025 18:08:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A01EF091
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260532; cv=none; b=OyyPnjsi6ccEau8enjZK0vKZSibCPtbCU+M+ZZ1x2sxcgZ66lt3MLQLhWDbAvg/cYUXxR4DLcIGEIPQEl9gBOa+hnDBGaDcbOpieGXoyXY7bMvXEUcC/1GgYWOWfE/tje47obMTNtbH5vYBzW4Dsmgx71Wgs5UuV8ifC1i1CYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260532; c=relaxed/simple;
	bh=nSeKpHL57w/3iWZk2ZaRB6lxTg2WOeFKDBEz0BWHWFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwDvjbN9XesE4alwDwsfMOSyPXR4dovq5/vqq8WxLp8mtuqxj3AHrAdzXN5cfcSUdE2M1DaiRjAtcHTE6AXjqcV6Dh4Mi1RB9uslChb7UfXpwb7JQsiswLVDhFFG6V47D95ODjRcteL+xdoEBXBGxr9CQSHc8WwPT8ZvNQrWDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: h7uNVsd1SXC/X+64KlWOOQ==
X-CSE-MsgGUID: ZBpjNnRyQDK4e9W7+GrX5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="61291476"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="61291476"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:08:51 -0800
X-CSE-ConnectionGUID: 2jEiC9IeSF+6bAALDe0Q6Q==
X-CSE-MsgGUID: 93QO0uN0TMmtBR0wHfK2Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="114407032"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:08:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tdYy5-00000006kAx-1UBX;
	Thu, 30 Jan 2025 20:08:45 +0200
Date: Thu, 30 Jan 2025 20:08:45 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
Message-ID: <Z5vALe4nv5VK_6dM@smile.fi.intel.com>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
 <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 30, 2025 at 06:45:01PM +0100, Uwe Kleine-König wrote:
> Checking the binary representation of two structs (of the same type)
> for equality doesn't have the same semantic as comparing all members for
> equality. The former might find a difference where the latter doesn't in
> the presence of padding or when ambiguous types like float or bool are
> involved. (Floats typically have different representations for single
> values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
> at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> true, but memcmp finds a difference.)
> 
> When searching for a channel that already has the configuration we need,
> the comparison by member is the one that is needed.
> 
> Convert the comparison accordingly to compare the members one after
> another. Also add a BUILD_BUG guard to (somewhat) ensure that when

Why do you use BUILD_BUG_ON() instead of static_assert()?

> struct ad4130_setup_info is expanded, the comparison is adapted, too.

-- 
With Best Regards,
Andy Shevchenko



