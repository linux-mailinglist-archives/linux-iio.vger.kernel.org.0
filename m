Return-Path: <linux-iio+bounces-26504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA96C8C239
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 23:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6035652C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B622DCBE3;
	Wed, 26 Nov 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYoWZwft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CDCA4E;
	Wed, 26 Nov 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194494; cv=none; b=sxJ8DrrMULmGJb0vf6515o/Smn1TU2S95ORkH7HWH2IKck7fRxfQLjP9PT1Sgklc6GmfCVNqyTERdTCM5hE93f+mGO3/bHlqQ/t+7irfFZmXo6X6V4UT6JgP3qIXu8jf2E747UMG3s91meNM5uI9t+7Qg7fpAUrGCeZBTNbu188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194494; c=relaxed/simple;
	bh=FYy7F66tsFMoZ7D/ON+5BKuOhS62vELGJDmu3EwKYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Veu3+GLA7pTu4wVIGmkP4aJMuoKygZkExay2R5m5XejCodto6ufs6eYDSXgSrA2iuGODGW6P/V7BIpnkfXnUSG001dmYvalmntImkaVzotSL9ml4YlPV0be7Sl76pDhQla1bySFsqEWdotyHN7a1UGfjh0hHdr0oKSXNzjgm/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYoWZwft; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764194493; x=1795730493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FYy7F66tsFMoZ7D/ON+5BKuOhS62vELGJDmu3EwKYM0=;
  b=NYoWZwftxk5bP4C4V1X8U3LkpMqdifFNtY1vwniJRZb1gmyK16UYExV+
   mtGiL8gke6kRkpr1b4LLGkot52ddAJ8X8WmofkC8Q18G7y8CASuW/MgRs
   Lnhl03SRJVHrXNk0mY1hJzBP2mNF84TC2LD1fI9VdSFZkFewGLWjrDYbh
   /D63I5HCU2bHBPjs5ELXfGfBJejz7mqDUVASPpOkYqW2VQMuI0Ujq1dyL
   2m2aJ/3nWteNB6U7H2eyuLHSygk0I8HEBERdycWLf7hUxS5aBNVDywgP4
   vrlxXuWAXvpLwqFCp4q5indN1yxDRNKtPG1HyAsToa9NZCXbsLCyEUia4
   g==;
X-CSE-ConnectionGUID: eGvfFNlbSOeTZ7x5zmCnlA==
X-CSE-MsgGUID: 2PaBnNHFQBi0avAIDTm0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="83631618"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="83631618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:01:33 -0800
X-CSE-ConnectionGUID: nUklIH9PRfar7kg0jXe1KA==
X-CSE-MsgGUID: CN3g3udYQwWAmXe6rhRlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="223767123"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:01:29 -0800
Date: Thu, 27 Nov 2025 00:01:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt@analog.com,
	jonath4nns@gmail.com
Subject: Re: [PATCH v4 3/4] units: add BASIS_POINTS macro
Message-ID: <aSd4t0kln98ptofg@smile.fi.intel.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
 <6dafbe2577ba5fab28a84daf55111d9ede4a1938.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dafbe2577ba5fab28a84daf55111d9ede4a1938.1764101647.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 06:56:26PM -0300, Jonathan Santos wrote:
> Add macro for basis points unit, defined as a 1/100th of a percent.

Fine, but why? Can you elaborate more on use cases?

...


Perhaps you also want to add a PERCENT to understand the relationship
between two?

> +#define BASIS_POINTS 10000UL

And this needs a comment with an example (something like I asked above
for the commit message).


-- 
With Best Regards,
Andy Shevchenko



