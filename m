Return-Path: <linux-iio+bounces-26340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76600C73076
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 10:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 21DFF2A2D7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A430FC3A;
	Thu, 20 Nov 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIRU5AYy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDB308F23;
	Thu, 20 Nov 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629783; cv=none; b=Q+4B+WA16zh7Nzdc+Sa0c4CHpitnN8wLymihtkdLnefkXpa1K3RoorUGfuUimB6f4GQPSR+yH0EZu8AIUXTHGiYuCcol+aY+47oz99LJ6qMWE/8jF8MukaSc5Rr7cXXCJNNkdnHJu6ID5kNUrdhJeGFDW9IakWkIH/eTPzUSyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629783; c=relaxed/simple;
	bh=jhpOSf9tg/knjPkQ2TEUOAOiovrt4oNBJGUqRCHfAuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/dnsMYCFVsmw+aBHAB6SLO6njf1VZKfWK2ZfYI3I5sY5I6o0g08aaLYbqqym9dslOHVju7YDthMK5XW6KURtdIG1AUwIvEtRA2VdxxtuXeWE8ruvU/Gb78hJt8zHyt5IGWUoD9v0DpIGazAhI1LmUH7+H8HhuptezZFCl6KPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIRU5AYy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763629781; x=1795165781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhpOSf9tg/knjPkQ2TEUOAOiovrt4oNBJGUqRCHfAuI=;
  b=JIRU5AYym4wxxYHi/Q1SZv9o1PCf7swQzWjgaz8oxrVQW/eEt0Q9S5Tx
   n6NR1nAku1YJsGPcA+zhWxZ4XmN8oZYEnLK9WBI8Xbomu8HOuCtIFoWqo
   MhB+hT0hZT3o6vcBOoofMRvlMVgtuMZ+vr0qCREYRV4IS64RAWQtEu5Gb
   NO4Bon+QqHwpmHnqJnJ9Vqzw0WBePGBzvkI+7TWC9HfrgoyYaxyBuIR4q
   q9Akl0T5V+NqE3/7tZEL3wwlUcCvO7KOx+PpAh0Y7EnA1YoYlL1cqW/rZ
   UfYMlvmaMWKrgGKHz6Wm3PeaHs+KwF97XQ338v1uZrYsee3PVwMYvI0HO
   g==;
X-CSE-ConnectionGUID: Zdjaci4xSLi3e5sIEMZMdA==
X-CSE-MsgGUID: VUcPBrBrR3WjFaB3TG6X2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69309390"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69309390"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:09:40 -0800
X-CSE-ConnectionGUID: 6i/j7LxmTumInCAFxz/tYg==
X-CSE-MsgGUID: 2+epo3/QTViAtPjtlsR9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191335867"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:09:38 -0800
Date: Thu, 20 Nov 2025 11:09:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] st_lsm6dsx: add tap event detection
Message-ID: <aR7az3s1lqdtFX6a@smile.fi.intel.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 09:26:06AM +0100, Francesco Lavra wrote:
> The bulk of this patch set consists of reworking the existing code for
> event detection (which supports IIO_EV_TYPE_THRESH events only) in order to
> make it generic to accommodate different event types. Actual support for
> tap events is implemented in the last patch.
> Tested on LSMDSV16X.

Still one piece to get better, but overall looks good to me now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(at least for the patches with no comments from me, and for the one more
 after addressing the comment)

-- 
With Best Regards,
Andy Shevchenko



