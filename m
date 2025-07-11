Return-Path: <linux-iio+bounces-21562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD80BB01396
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C3D1C2232B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C01DE4FC;
	Fri, 11 Jul 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY9KDizh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BB1DE3B7;
	Fri, 11 Jul 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215367; cv=none; b=hw1+XKBJzIIRVIpcZVVtc514rbFILzm/jS5v8/qLIBa5lOaMNCsxdxEi2WMAS8U7mCxzhl8lVO5hJoIJSRWA8JWcnoDMok/mgqY+OdoM1F7Am6sDaftI3vcdIW406coRDQWabL/Ash9JOUshDnLj1jvw2gS0DPWFHa0sCNrYJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215367; c=relaxed/simple;
	bh=MHa1Y3V4zkTo+04EK3/Ac7PRtZ8VpUwI0WOK/fJ3Idk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt7OcO4dkdz+VuKf6X473znZFeXbXIil7vTz3ZDfdTaqUW1U4e3zQ1DvHzeHn5S8f5xa4/vkE2MDe+nwaV8aniYp3nKCBPJ2LxYSMMJNcmmZuT8SUQa+a2+WOzIYhajXphuIM5+cRS4n4cFKE9xEHiZLrLfuvOJk1qxyoPm1i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY9KDizh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752215366; x=1783751366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHa1Y3V4zkTo+04EK3/Ac7PRtZ8VpUwI0WOK/fJ3Idk=;
  b=IY9KDizh8fcajzJDoCxQC5c2/UhlsfqtjT/95NPDEvpHVTtkat8TuSrG
   DHtAO/YOSkLpWBwHfbYoW13i9hz1x/w3GUMMOVtW6g4sVGxuvLbsUTKEh
   BVU6CJXDHeZ1KurpcCIpUPJqe4qNNeROm7yIzrU0L9ZrkigoIUetDgP0a
   pZ+3tnXxBEqCH6OV8CW8PNG+aaBy8jeOr++i71UXFQAv37pvkiC/1TOIc
   46JRnWExOSi/WS8keJTtQnj4zyYy/DeMPd9hhUhtf6BRjqahmMybTMgjZ
   kcbqLwr+u4+LgvQ1yCUYVKUhsYPLN6tL42y+Ymao5XU8FZTPPtT86U/BR
   Q==;
X-CSE-ConnectionGUID: 2II1uJi4TOyQc9KF62550A==
X-CSE-MsgGUID: Hzhpx9YSQlqOruwhhI950w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54663438"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54663438"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:29:25 -0700
X-CSE-ConnectionGUID: hXds7d/YQzmcffA8sKfhUg==
X-CSE-MsgGUID: 8Dw7aOx1Q4W1xxKHqprWaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155706519"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:29:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ua7G4-0000000ERDO-0wE4;
	Fri, 11 Jul 2025 09:29:20 +0300
Date: Fri, 11 Jul 2025 09:29:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: use stack allocated buffer for scan
Message-ID: <aHCvP7O2PRI3WE0P@smile.fi.intel.com>
References: <20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 06:00:05PM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> in bma180_trigger_handler(). Since the scan buffer isn't used outside
> of this function, it doesn't need to be in struct bma180_data.

LGTM as we don't use scan buffer directly in IO, we just assign a value
from somewhere else which is already on stack.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



