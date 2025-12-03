Return-Path: <linux-iio+bounces-26703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB6CA0051
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367D93009418
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4253AA1A2;
	Wed,  3 Dec 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGi1p8nD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8735F8AF
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779606; cv=none; b=q3jZy7iqarFxngmPhDGyZK77z+J9DY9mo/jdGR+WX4LjFzsG40dPJK3jBLwLu/C3jL2RZvsQupROfJcnDN8XkbS2yxfbjF2WygvycUi4hriJhDLm7u3lq0wsOPr8s5BhF+lkhDFw5xiZz2ToY7FNCrUsQnORdoZ5TLuDBfWNFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779606; c=relaxed/simple;
	bh=JiTK9ToulJV884NCnvrpngbHjUUn0mZiutsYuTJ0Nt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1zRQDXoAQeCrfKnfUCOSnrTHW+Ki79UuQfJv8xY6fJW4EIMFtov1uP91onEZHnoTFqBeYc7OYWZOi4M9NJIAFH4TmxLJJi/bfkheoCYFNZ1Fh4Mx6u6R7PaBOCgPSj8KOlSbjIr4HcXOxmVneb0d+4n1fHz+9vZMVeXNT0EsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGi1p8nD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764779604; x=1796315604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JiTK9ToulJV884NCnvrpngbHjUUn0mZiutsYuTJ0Nt4=;
  b=IGi1p8nDQ8oVaEfGdOKXE33IQZHZrUQWrxy4OcYyQnfNar0MYIhFjYN+
   q7FiloPenRCd3nflqnFKoNZoP4c0GOSFp+L57FcUmXsT/GApQt4mlwdDe
   ca7fCX4CQmX33gW5CUaj65PdUeAoAgVOkOfVv3kjk5jHMJey5w2UyHE3f
   fKpD7bswHMoRSQdHy5E7ctMN8/hajNk5B9DqWmTlV5BhDe7gyyX+bEkDJ
   YHyxmw5PtNoO9B3n/oFMheVh8kwJSJwDFVDBAahDnomg2bGNzUtyJaO0l
   XmisJJPk3rYRebdVhcMPf/rtbXwA6CEJyL78xzzex7qBJv8D6Vz52BEJ9
   A==;
X-CSE-ConnectionGUID: 7ILuBuqjSmWeHA3hw95Adw==
X-CSE-MsgGUID: ivqi+SYURDCpNKmapMUM9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89431310"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="89431310"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:33:23 -0800
X-CSE-ConnectionGUID: O7uWtZqlSq64EKOp9ZmV1Q==
X-CSE-MsgGUID: sZxDUeCKRrekgumctJ2Vjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="225407886"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:33:23 -0800
Date: Wed, 3 Dec 2025 18:33:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 6/6] iio: buffer-dmaengine: Fix coding style complains
Message-ID: <aTBmT605yRjGtTR1@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
 <aTBl9U1KS__Lkfbt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTBl9U1KS__Lkfbt@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 06:31:53PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 03:11:41PM +0000, Nuno Sá via B4 Relay wrote:
> 
> > Just making sure checkpatch is happy. No functional change intended.
> 
> ...but trigger the fighters for 80 rule!

I believe

	scripts/checkpatch.pl --strict ...

should catch this up.

-- 
With Best Regards,
Andy Shevchenko



