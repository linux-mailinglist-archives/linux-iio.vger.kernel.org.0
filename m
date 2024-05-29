Return-Path: <linux-iio+bounces-5453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8C8D3A6C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BB128698E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB017DE0D;
	Wed, 29 May 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvSFcX9I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142315A861;
	Wed, 29 May 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995608; cv=none; b=h6BlP/qYcpQFas3ZbE2wIU2JQ3nC6Whd5r/U2QyKCj6EHUwv5bj6j7uzZtSpOG4XL+WKkzVcxQZ6aC3IyrKBiQJGEnT7HM4wqxqM8T+kVgv4TVtCpRDN8+SU9oJdQ5USzlA3gnE/fQSKdD4Y5J7rRX2tGeXKmoIP1SEfKn2FICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995608; c=relaxed/simple;
	bh=LfO2VE1DcbHJJI4IuLnOrkKQoeKXpZuhsxgvIST8Fas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMbJtVTlTm/kxKZP2vI5uNI8lC8HJBGcvn1s8EXBGAyqcJqNqz4qT8Q5xUFdLS13c+JCXLlHr63s3vwOP57Z7mfQqra4hI1I0QRq0U31ckbtnvoS29bs8fiBIj9DFPTWcrE8J4lsiK/sUVQFY/8gduZNNRt5Gu6RW3BuZC778+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvSFcX9I; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995608; x=1748531608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LfO2VE1DcbHJJI4IuLnOrkKQoeKXpZuhsxgvIST8Fas=;
  b=TvSFcX9IvQhYMk8Hg3W7CXkMRv+o+dl4ISXafQvgSDJizlmsP9OqkEk5
   CRXcKG70g6eOQGbft5w7/GvJf7UavniG9/2MEmq8auPKNIpLjXcK9WA0E
   A8dUxxQ+X2lZy7/Z2pCDHIIjr3mGGjMEmkooATxPJ2+9qtTdRfNbtRFvg
   gRRROGNBR0nYAVTs3RY8TMUysjrEwsfn+mVDhzhRnN1k1MBmGi3D2Gnl2
   BBtpHEm/coi11KQzx+wCypXgcklFrEzXtWEVZoL6Ki6NkmZMYG+tZlodo
   XfNkSGPT/0bSASWcjLY2zCFJ4HH7N8f4ZP9m2pwrtaj7vi7hN2QSxvBXP
   A==;
X-CSE-ConnectionGUID: yuTTVzAxQDSCoDYASQw2+A==
X-CSE-MsgGUID: 6jocMX0SQ06WqP+aY72wZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13355932"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13355932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:13:27 -0700
X-CSE-ConnectionGUID: 18xmAMLaTPKIo+Bce4uC9g==
X-CSE-MsgGUID: 6JcBvRBUS/CZL1GteHtHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35432799"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:13:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCKzP-0000000BqDZ-1suc;
	Wed, 29 May 2024 18:13:19 +0300
Date: Wed, 29 May 2024 18:13:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: ranechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Okan Sahin <okan.sahin@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: iio: adc: add support for ad777x family
Message-ID: <ZldGD4ByS_QCEFuS@smile.fi.intel.com>
References: <20240529150322.28018-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529150322.28018-1-ramona.nechita@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 06:03:09PM +0300, ranechita wrote:
> Added support for ad7770,ad7771,ad7779 ADCs. The
> data is streamed only on the spi-mode, without
> using the data lines.

Do not send new version if we have not settled down everything in the previous
review round, hence I even won't bother to look into the code. Will wait your
replies in v1 and, when we got into agreement, v3 after that.

> Signed-off-by: ranechita <ramona.nechita@analog.com>
> ---

This misses a lot of information I asked about in the v1 round of review.

-- 
With Best Regards,
Andy Shevchenko



