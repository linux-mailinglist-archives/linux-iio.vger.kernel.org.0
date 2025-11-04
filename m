Return-Path: <linux-iio+bounces-25899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF8C32AA9
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CE1465623
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A22E33E37D;
	Tue,  4 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iex8m4DW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA72D595D;
	Tue,  4 Nov 2025 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280783; cv=none; b=mioZ0oOiBQ5NsEBH3xrmtZnUi8ZoBaRgRoaMdEQSp8wNsnhdQsAfUoTmLexIRqjgO5i40DyvId/MCk4ELeVuGX9tVqTP2ZvR6M/Mnp2mC10k3SxrZh+nMZTAl9aqCgjXGIcsRBh7K4vZyfaTFNFB0Cla+7ZavM7X5oXAS1RZIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280783; c=relaxed/simple;
	bh=9denLrXT8/5h67X72p3softZN54f7BUN5VRh7wSpwx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgZDnvEQ/JXkgeUVbnUmn7HD06yLYDH+2AmIHJrqxcc6c4D7zuGA53UviM8F3bNJtVFKtyQ4s3eLGyNk5KTm6IWVp5cTrRjQIM+o8NOOsmfl93fKwRtc3vBfzNDPzGOOkVaueprRVOuVueHgID2iL59d10u6JzprsZlGGg6naCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iex8m4DW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280782; x=1793816782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9denLrXT8/5h67X72p3softZN54f7BUN5VRh7wSpwx4=;
  b=Iex8m4DWY4we9ozBpnRECBWgAxR7oSwxvo1S9JPHS9TGTk9Qg52WI+8N
   DZGnCSeE9QUxC6l10sgGxAUaNh4NJHlExVHlRvmSuL4pLazyTwSBrSTYV
   SZ+mOPndXTiOTZ5KHgnzZwYUSAFPNK+RmaN4sCD3x1+YBCoh9hm3NhijQ
   71N6K/435Jz1Bhm8Khoel6tjmdQj2AZ9w8QQXgCN23pWkqaQZnLAbpU66
   Scr2PYEDhHwLocAwn5TcSPMcVD6AQK8AowmKe4wJi2VpqCdGprE518Ydp
   0gSKGkoMg+oNHsgjNIgTPkZMfKmvW7efm7gnxboBxDFPXAuaDfUc4i37d
   A==;
X-CSE-ConnectionGUID: 580xVNxZTeG9XEdC7kULCA==
X-CSE-MsgGUID: lOET9pabQ0m7WTDccMOHzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68223095"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68223095"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:26:22 -0800
X-CSE-ConnectionGUID: HDGHFYDvQoWE0yhAO4HP3Q==
X-CSE-MsgGUID: 2e54oaCZSqq4iYpwc2UGJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186472327"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:26:20 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGLjV-00000005XeD-07n4;
	Tue, 04 Nov 2025 20:26:17 +0200
Date: Tue, 4 Nov 2025 20:26:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 11/12] iio: dac: ad5446: Fix coding style issues
Message-ID: <aQpFSNGqf7wrUmYX@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-11-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-11-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:16PM +0000, Nuno Sá via B4 Relay wrote:

> Fix style issues as reported by checkpatch.

Can we do this before splitting the driver?
This sounds to me like a change towards the fix, however quite minor, but still
better to move it closer to the beginning of the series.

-- 
With Best Regards,
Andy Shevchenko



