Return-Path: <linux-iio+bounces-21576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A6B02211
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18DD188FC49
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF82EF2A3;
	Fri, 11 Jul 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nak8GQGc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B917A2EB;
	Fri, 11 Jul 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252154; cv=none; b=ZT+vO5+y+q0S9L6cCsLC2kuepzJjX6kdhsOIlpv3JUL/d/XzZgkH2/icFLSAs3aBZEF6KaGwhPgv8BWAg97Y9v1rQIUvp6XNlJwE2dq5XuKi4vNQjt+Nw8dFrDpmkL+wYU1KXE4CBHiy374732EYMuVY3I/2k4CKeAbltv7HyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252154; c=relaxed/simple;
	bh=h4zPent/IXrKYrTksxsvRNxl/wVoLAu+4qLjiY7iKuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbVCZlb67ourTkD9AOMn8kxfcF06h7s22uc9JQKzihr4xXtcXH026j9rZV4VyGeYI10BPGEkLSivOP75+dsaTqgFnxjMTLkmWiWW+97bGkdmY3EW8S5Ki9Tefx4pwdw+Niii4tudPm6RMHJfjeHk82Z3Fj43acKM0UbNUnB3IQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nak8GQGc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252153; x=1783788153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h4zPent/IXrKYrTksxsvRNxl/wVoLAu+4qLjiY7iKuI=;
  b=Nak8GQGc7CFNtxaZQii5BsF+GiWYrHSAbQJ6cuyYtz/YwnPTm1t5xrkG
   na29fOLUKwO7WfyXZ3Euv4bdw7MoLQUl9jWbn5zUsG+1E0E2QuIPyvcwM
   S83T7MdjA5KrvP24QKyxzyscTAo99Wwhla7IYsM76VXkC6hR4frN4Nq+k
   J3PkyMGJuXCZwASuZ1swVoDNOwNsSFZagHs6ZyHn6SRgCKgUHiw5IXacL
   JAiNxWjj4xaxy7BvKYl0rAEUYP39biBJYNOgqHAAlUWStk1RH8hnsd6cJ
   t5dWIzHXtY7eELw2EhLfSOEkYmq36lA9hYsvTDyNMykm+mozV1J6Y1a/V
   A==;
X-CSE-ConnectionGUID: H9gay2qaQsO4jENQY6dA8Q==
X-CSE-MsgGUID: /kIdOlbBQPmOdZDRjnBqbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54494260"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54494260"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:42:32 -0700
X-CSE-ConnectionGUID: 9rM04/EvTCuTtzFgYuwTGg==
X-CSE-MsgGUID: YjNroAviR0K9x36JsenduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156747643"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:42:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaGpN-0000000EaKt-242A;
	Fri, 11 Jul 2025 19:42:25 +0300
Date: Fri, 11 Jul 2025 19:42:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
Message-ID: <aHE-8VDgQ7WuoA_y@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 10:47:57AM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> in sx9500_trigger_handler(). Since the scan buffer isn't used outside
> of this function, it doesn't need to be in struct sx9500_data.
> 
> By always allocating enough space for the maximum number of channels,
> we can avoid having to reallocate the buffer each time buffered reads
> are enabled.

Ag ood one!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



