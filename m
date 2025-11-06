Return-Path: <linux-iio+bounces-25982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDBC3C49C
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFFD188FCE9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7D34AAE4;
	Thu,  6 Nov 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAPB+iyQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530934A3CD;
	Thu,  6 Nov 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445427; cv=none; b=lioUJy9uz3u+hBfCAr+ECrNwF4+uzBIgJglEu3Mz93qI7u22S8ERjXqj4IaSOxmSmHKJ5hkxhM7tKprUWE/8xcWMs/PILlD61HwgdmJVR43OAltm4IDAqJcKYu6BjajZ2hZXo2i/O/pJYs+NkF/ZYu+SR8IQnGgxpjTwHFm/ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445427; c=relaxed/simple;
	bh=Llc47k9a9TnaZH+5o6GJeioVsarqczKfv1LsFk7gtBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2J2rg8AvWRp4RAd1EofZwqbvYLCcnypwmBHzTLozanUsiyaqosc5n0DDe8ErT6gxjLxVBwh8XNQLQeakFg6+oMsaN3lv/p4f6eHOAwMDMQV1mD55yZSEolTNoWb6lPZf+j78zWe8Qwe68X0RHbhlPFLcZbQ31OjKGT+25zshAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAPB+iyQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445425; x=1793981425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Llc47k9a9TnaZH+5o6GJeioVsarqczKfv1LsFk7gtBQ=;
  b=gAPB+iyQEtwqd044pOKIT+QJ8OVW7ob4GWX9B9fN7hEwc0hcfmBIXgNN
   VYnjJrH+uN9l4y5GhpVeUO1k+9es6gfyUoajmXfadKsO0lnrSfQUNij4R
   wBIgcmY7BkCtMINuUm3zelm04gO6bv9ji0+TQeLTpCfdbshYP3SD+V9Y7
   DVSFGOstPfv1DqIFvg4Au8k2FTDQeAzIwU96SucUfpEA2vy5eQa9berMt
   MUb4H5QTsxXwGP0+QwYVvGLEkjMux/I9+8rDkfhelUJrnsZcSUhdXf2O7
   52w/GaW8JBFnMaaX50dJaCYdcrI3drtCFJyGIl/IdO6WmMP4PmXURbx3t
   w==;
X-CSE-ConnectionGUID: XjAcL7QJR7+3K7vO1qC4Rw==
X-CSE-MsgGUID: AyPaW+eBT3qQsEfaEW23jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68446874"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="68446874"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:10:25 -0800
X-CSE-ConnectionGUID: 18epo9g/S/+XH0+8iF5hZg==
X-CSE-MsgGUID: Yw6PxLOjQLqAALwiKX9jYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187637058"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:10:22 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2Z1-00000006Brb-0xHC;
	Thu, 06 Nov 2025 18:10:19 +0200
Date: Thu, 6 Nov 2025 18:10:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: test: Add kunit tests for
 iio_divide_by_value()
Message-ID: <aQzIavXYD7fUbrqc@smile.fi.intel.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-3-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-ltm8054-driver-v3-3-fd1feae0f65a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:11:48PM +0100, Romain Gantois wrote:
> Add kunit tests for iio_divide_by_value(), these are similar to the
> existing tests for iio_multiply_value(), but the operand values used differ
> slightly.

When use abs() in the code, always add a check for the *_MIN.
This will give you a few surprises.

-- 
With Best Regards,
Andy Shevchenko



