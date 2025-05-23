Return-Path: <linux-iio+bounces-19832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C548AC27BA
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0800D3B7222
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D60295526;
	Fri, 23 May 2025 16:37:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61354120B;
	Fri, 23 May 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018229; cv=none; b=JSDpgVIvSUGbv5Rd6QURdBx2CyKBaWyiTe43QZj7RjkRl2RpkAoP+2+RGB8j5M8nGSjYgZi2DYHtvYWO1ZOjTV5CYEsVaywaXCvasqGoA7bDXpt6ftNTCp5WoXvJpG+3uXmkxxxsCamBFonhKtOtmo7FlJ1DMADrdPQ67KeNlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018229; c=relaxed/simple;
	bh=dmHeudZ8AGy/xI/AEk31iJlaO7kmIqxc51ySVcOcXGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj+SxkF/RRsuQ7Y2ZoS+G6O7SREkshqs3Pni66w5M2+/Caddq2rbyd6OPWXbZjA+4VMaLVlfySdgqNBNsWs/fjqKgGxDiZuwyqqNHXCTj9owqlku5j4IfQ3qWOv3v07/3HclYdgZKZulAMwuOcF8W5Kk17L4VmjSElJdRxNDE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Q0Iey56jTviAJAlvRRWfcg==
X-CSE-MsgGUID: ybUalon0T72g3EM+V6jE0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67642067"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="67642067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:37:07 -0700
X-CSE-ConnectionGUID: T+r6XEMfRp2A8N5KEZbVIw==
X-CSE-MsgGUID: X8CPCvm+STu0IWSwsapyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146184994"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:37:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uIVOI-000000006VW-1Hm2;
	Fri, 23 May 2025 19:37:02 +0300
Date: Fri, 23 May 2025 19:37:02 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: fix bus free check
Message-ID: <aDCkLhsKDgN_hF2N@smile.fi.intel.com>
References: <20250522-iio-dac-adi-axi-dac-fix-bus-read-v1-1-26ec358c57bf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-iio-dac-adi-axi-dac-fix-bus-read-v1-1-26ec358c57bf@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 22, 2025 at 06:47:31PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> This patch is intended to fix [1] that looks not yet accepted in any
> upstream branch.
> 
> Poll function must check for a value equal to 0 (bus free condition).

> [1] https://lore.kernel.org/linux-iio/l6vu54ltxd7pydkzl6xbbq55gedumzbsllfxnljyngwcg4c6zd@w6qxgn2vby75/
> 

Make these two lines to be a Link tag

Link: https://... [1]

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

-- 
With Best Regards,
Andy Shevchenko



