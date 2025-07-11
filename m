Return-Path: <linux-iio+bounces-21579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5352B0221E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0ADA65997
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854202EF66F;
	Fri, 11 Jul 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq6eBX7o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64411D61B7;
	Fri, 11 Jul 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252305; cv=none; b=QrVwfZ4HhLQpv24Z+p94N7y80rY+VM9h718tDtPNZpNYq1FBMYPQsxQvQ3yztgUR1ORvVz5OtYvenN+0gNiVQy4QCfSYGy9ToJQNhwCFuE0iuCtfr6Q0KIgiRe172sSz3qQoex/mnthhjhEESIMFiSTnorV066nfNZZhkrZ3DRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252305; c=relaxed/simple;
	bh=UUOYwYEJlozi8Wzv5q3rBswbp7/b1XkC3JtvE7Rfze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX9TCSxlXJg61WnpDzjcYL/zsj+LgaXsW8L9ndiR5XyWWdjYRbzCPNEvCNpNFleUnCiFY3ink9KCnye0mdSD7Oq80tq23Q7Q/Tw5p5BVuNhsc2aDIg885QMf+OR1ihAIL9jbSlPt4ShkzRjLmTbYXzQ6b0FupzSWSev73Ehzlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq6eBX7o; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252304; x=1783788304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUOYwYEJlozi8Wzv5q3rBswbp7/b1XkC3JtvE7Rfze4=;
  b=Oq6eBX7oeXejsX2YFdQukQbpXQiAsXydPOb3uRaE9w7GPN2+uGTg7lVS
   IqfUAdD1z66NTTzRfQCzfYeDmybygkxtZdI3ZbpxFHDNzvmmDCBxkWN7t
   r7q7B5k3ey74TY1l9sknFBpu9T9mzm/CHvfydh9zoJbiOhtIs0J1rFc0o
   3jOZYlYtRIZtITWMwXFbhBdtnkTR0TiTqKujU9DLL+JA/zyz5HB3o8GhB
   6fGXYOe2QlQcYmO6clwqfuerVW5K8M4FPYC9X4APErl+GxR6eFc7m8Rq2
   nTOV2wB8DlF6PlnCExR9ncr5ENAcEFryLF63R4CUvjBTv/2GxpSvKEAY4
   g==;
X-CSE-ConnectionGUID: 7nFXQWMhQyGQ6kVMrIgGjQ==
X-CSE-MsgGUID: /eSimsObSMOhRJru6ZZKEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77096301"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="77096301"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:45:04 -0700
X-CSE-ConnectionGUID: qtvDpmFEQYWLt22VuooJ7g==
X-CSE-MsgGUID: Gykpny7/Rm2rtjuPAEIyew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="161978280"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:45:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaGrq-0000000EaNE-3FO8;
	Fri, 11 Jul 2025 19:44:58 +0300
Date: Fri, 11 Jul 2025 19:44:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: isl29501: use scan struct instead of
 array
Message-ID: <aHE_iq0G6pYMIvRb@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:18:13AM -0500, David Lechner wrote:
> Replace the scan buffer array with a struct that contains a single u32
> for the data and an aligned_s64 for the timestamp. This makes it easier
> to see the intended layout of the buffer and avoids the need to manually
> calculate the number of extra elements needed for an aligned timestamp.

Same Q, why not macro?

-- 
With Best Regards,
Andy Shevchenko



