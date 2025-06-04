Return-Path: <linux-iio+bounces-20213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1226ACE17A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C35917918E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC61A23A9;
	Wed,  4 Jun 2025 15:30:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69D13A3ED;
	Wed,  4 Jun 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051032; cv=none; b=rS1Ldh33QfzUHrIyTP4kpdiXXk53TvCbz53H3rxjouYZBkXC+f/ZL2zLSNd13bieumGu0ao1BEWinla0L861K7YnX3pw9Dr88x6Ze5cJynEbD3X/qFpXBXmVjYwTUmlaGn/PF+YR8uLm0O9ZtlqV4lu/Fl7LAZdv5lrlYfJCwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051032; c=relaxed/simple;
	bh=Vi54+MTJC05Rofk/bnZBllkeyCAg+RDLF5sCSBzbJX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhZ/4An49FnljHR7w+O2evvCJ3oL9sGPeX0wBMCuguWUq63MmaDN/YzhwbWYC6RWckJbXY58LL7xBlQpZ5IWzwzEZ5f1AYDqmcROLnYUMWmXMd6Qx7leW13QOTPt4hYzZYufcA5cDlnnN9w/FxCkyQKltkaySIl3AXKiMuhQV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: XAn1vIKZSOugyxDDoxv91A==
X-CSE-MsgGUID: 9WauvoQcTZWIxlFkCMrSUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61405822"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="61405822"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:30:30 -0700
X-CSE-ConnectionGUID: TCxxyYDtQAC0rXI23RcsiA==
X-CSE-MsgGUID: 6aKuB2ElR7OU4wLhtq26/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="176180957"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:30:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uMq4D-00000003abB-1jJd;
	Wed, 04 Jun 2025 18:30:13 +0300
Date: Wed, 4 Jun 2025 18:30:13 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: ti-ads131e08: Fix spelling mistake
 "tweek" -> "tweak"
Message-ID: <aEBmhUv-xpNgmv6v@smile.fi.intel.com>
References: <20250603165706.126031-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603165706.126031-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 03, 2025 at 05:57:06PM +0100, Colin Ian King wrote:
> There is a spelling mistake in variable tweek_offset and in comment
> blocks. Fix these.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

Datasheet doesn't give any special term for this, so I think the patch
is correct. OTOH, the dictionary defines tweek as "A form of atmospherics
(radio interference) produced when the high-frequency components reach
the receiver before the low-frequency components." which is somehow might be
related (like high byte goes before low or vise versa).

-- 
With Best Regards,
Andy Shevchenko



