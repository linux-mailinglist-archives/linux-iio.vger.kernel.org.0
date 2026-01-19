Return-Path: <linux-iio+bounces-27938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48005D3A0CC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBD523003191
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3B3396F0;
	Mon, 19 Jan 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVjHYboM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84FD3375D5;
	Mon, 19 Jan 2026 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809455; cv=none; b=gs4DWat+R9jhRFhIOUz7nNTe2dqNTdbNhUQ++5bGktcYwXIooUbiVbDvaRnp2RrqpiOgxBlYuRJ8cJPJHH22VnqBTDOoGYh+lKY/o2rhPJYtuoSBOO7oT+pu2gvF6wx5UQQONOWHyZkdOy38HTJg9Kw2UX4YIHAqG8QoJmHcXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809455; c=relaxed/simple;
	bh=pDFpHPyb4pokxTQABJ2iBXlXKbi+LWtXvvlGnH2UsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsndsiXR8F5FFzsCnud6FwdryCRkLXaVOrdYsRSW6DzZV/kOIMMhUIMf1UYJpMpDhIEa/SuUmhf/HJmU4U+zxnVxE+m1hVxft8PGNGro9BTlXkUNdle631GMFkom+IRv9BWIjHhGY4l10fslMQdT6cu1P4MzG4G/5/B/u9aIRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVjHYboM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809454; x=1800345454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDFpHPyb4pokxTQABJ2iBXlXKbi+LWtXvvlGnH2UsCY=;
  b=FVjHYboMOmlEpZcXKDykOkvwXPEKyqhP3K74i828fKtZX11/FZQCYUXm
   rO/c/sFmtYkbs2JLRUMROfqV1f+hQNNw28lytX7k3H8EsLF+kb6KFY1KI
   Z+u1rCcIxpeu/X3E2h0rVChy0spPf9v7fjuROsPhb+D8ZElFhs1Vi0h+B
   vmaHTj2uoPMzePl1Lj9C+yKtCNrXJEhynsoHfX+I6LC217pqJOoF1l638
   vcOg9z36kfthp8gZs8HPWsdLgG6LRZ1M/RYTVBkblmITZX5VFnRUAgYkh
   cy8PGR4iskmL4PPHpbb/mggbXkjb/QHEZoaAb6/0vZuAzzTi7eUtnTgl/
   g==;
X-CSE-ConnectionGUID: v8BxqS0STXeLQTWX9o+XQg==
X-CSE-MsgGUID: 8uSt3gYATDK5KYINl0qfjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69927086"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69927086"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:57:33 -0800
X-CSE-ConnectionGUID: Eyc2C0Z9S26iSViHMw0gKQ==
X-CSE-MsgGUID: 4gvhf4sKQ3OMebMmUWoiiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205052405"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:57:30 -0800
Date: Mon, 19 Jan 2026 09:57:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonath4nns@gmail.com
Subject: Re: [PATCH v6 3/5] units: add conversion macros for percentage
 related units
Message-ID: <aW3j5-oXvbC6sBRZ@smile.fi.intel.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
 <dde9b98e2ab2bfdb5806ee413732cdfeb6c1c90b.1768350772.git.Jonathan.Santos@analog.com>
 <aW3jQtiBcgcXLgsR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW3jQtiBcgcXLgsR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:54:42AM +0200, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 06:27:03AM -0300, Jonathan Santos wrote:
> > Add macros to convert between ratio and percentage related units,
> > including percent (1/100), permille (1/1,000), permyriad (1/10,000,
> > also equivalent to one Basis point) and per cent mille (1/100,000).
> > Those are  Used for precise fractional calculations in engineering,
> > finance, and measurement applications.
> 
> This version LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

FWIW, we have one dup
drivers/net/wireless/realtek/rtw89/phy.h:93:#define PERCENT 100

But since the type and value is the same it can be addressed later on.

-- 
With Best Regards,
Andy Shevchenko



