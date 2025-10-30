Return-Path: <linux-iio+bounces-25650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19007C1EE40
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E745118995CC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D83385A3;
	Thu, 30 Oct 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxVfkB/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A71338584;
	Thu, 30 Oct 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811172; cv=none; b=pN+ZdDKe3L2rirtxZE5tsCOKOG9EyZucRX7fCoGv3zOS3wYnND+eLlCEoXrl0vPInsJMLo3Ju0ich8ZPtFAaTbaJjXDlAUdwdXqueRxKZ3INMFZfyA/QV2Y1xAJCuUscrokJhYPjawSyYkf+Wpzpt58wzttyQskkbxms4ww+SXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811172; c=relaxed/simple;
	bh=VFIMq42hgnA3UBCToJHx/z7x/0ECwRTKZSe78uPjBfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRS1uxBalxWP0cc7KMaR1mh1xP9AcdmOQYWOb2wijXO3y8PxR/+THitqe9MLSpehN4rAxKvxTdj4VC2qqcZR5f1w8avmhqNDXb+8ZyozB2KMxuMb7e0pVad70cSYlUFmH2/asplCzG6G+WZTq/Ans4Rr5hOZt8EgOvSZxtTtFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxVfkB/v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761811171; x=1793347171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFIMq42hgnA3UBCToJHx/z7x/0ECwRTKZSe78uPjBfQ=;
  b=mxVfkB/vE5gygiNmVUv9dHCoXAmTSbet0PhvJBc3d4wYp+zBysYD3epq
   6Mn2ClCNgciOASxI3jIRQVQZ6PeT2YtK9lGa9rDy554Y8On0zDGLnd6ou
   3Q6nop9NgUP33+B7r13DooWeGQ6r/VzKmV0CAUPCgvzsPuiy0aJrqvnuV
   fBxPX1BZCgRaZQ3kleRowXBNiCdRTLEC0AFu2xbfITcJ2cOPO5vR9Ezku
   3aBYvf5fC85IB3B9M9qFjfZHqlV45wEk2KJlbPyOs/y60COyc08SCe4Xh
   u/BOZd1Xxk0eOXqfx0fLvXbP37gTJKktdGSKfWFAH/Ci4y2i/+Nqkymd/
   Q==;
X-CSE-ConnectionGUID: BvsXFAycTOiug8DPBy5GbA==
X-CSE-MsgGUID: vjPjvKVGReOGMFnbVAv8gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63830216"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63830216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:59:30 -0700
X-CSE-ConnectionGUID: TXRNuK61Sh+DUshxd3zBSQ==
X-CSE-MsgGUID: vsDc7rypSkC9lb4kIiu1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="223107607"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:59:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENZ7-00000003pxz-48al;
	Thu, 30 Oct 2025 09:59:25 +0200
Date: Thu, 30 Oct 2025 09:59:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: imu: st_lsm6dsx: move wakeup event enable mask
 to event_src
Message-ID: <aQMa3cwHfMt-NC13@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-4-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:27:46AM +0100, Francesco Lavra wrote:
> The mask value being assigned to the irq1_func and irq2_func fields
> of the irq_config struct is specific to a single event source (i.e.
> the wakeup event), and as such it should be separate from the
> definition of the interrupt function registers, which cover
> multiple event sources.
> In preparation for adding support for more event types, change the
> irq1_func and irq2_func type from an {address, mask} pair to an
> address, and move the mask value to a new field of struct
> st_lsm6dsx_event_src. No functional changes.

...

>  	/* Enable wakeup interrupt */
> -	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
> -	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
> -					     hw->irq_routing->mask, data);
> +	enable_mask = hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].enable_mask;
> +	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
> +	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
> +					     enable_mask, data);

I would go with one line here (despite on having it 85 characters long).

-- 
With Best Regards,
Andy Shevchenko



