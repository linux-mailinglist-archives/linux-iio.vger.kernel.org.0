Return-Path: <linux-iio+bounces-26496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 355FFC8BF8B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6F74E2006
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EC231858;
	Wed, 26 Nov 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVff0uPu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A845BE3;
	Wed, 26 Nov 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191353; cv=none; b=eisAU+Mc4iifNvvXh/iaLWBQdnfozPPYtgwaEqM053pkf0S+MUzwSorGTCPUJtnmb+YuGdGf3r2Dy+y3v7KWC3G6m9/H2NJz0YslGtkhJxrPn1fE4t1WpQwZr3TKoJR6IB52wqCk9ZIDM6yzwha1tSmIyAO3M2D9GqcTcYXXgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191353; c=relaxed/simple;
	bh=KYvjWph09n4V7peL7lFrkbgKzINx13nXluTltJFe2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnGoFoAgS8BmWTNFu2ADmoJXEkvbkEBcMBnQwXF2v5aombmnnKQMslBETe53c4wLXGZKGTBCbWIXLbUEUHNkaThJVz5oggbRr9uJRaVOb2NckTRtuar872QCUEW0eMpQcnhDA3v45l9a1CxPlJ7t8qR30lXDSp1tVcAAlosZyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVff0uPu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764191352; x=1795727352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYvjWph09n4V7peL7lFrkbgKzINx13nXluTltJFe2OI=;
  b=EVff0uPuk1OVYHbfzNIc0fbbp32aoSQFyJiRB6d3AXBn8fmgDSdUxLiq
   wX0JSOdbcanvHHEMSmiOVSOPs/atfNQHjyV0gPjC6L5b5XY80LlFw06ra
   mY7qBQSgfAAZBsCl7+CGMgfZ58MEBnue5Y+9no21kptVbSJ3WSvc99UaL
   APb3sKqImWHra0u34Qesz8DY2ae2ImmSpNQjZ/spf+T3h9mfVoByga0bs
   9HlZcvSECMoLZucmtdaT1Cv7vzsZimPa2HDiiosDtfOzGC91VuvuGEX9u
   nlkA3UxS5QFuRezJAH9VNRJoecEIUH1xdXemgN9wnEM4Xf25k3oRTRP0x
   Q==;
X-CSE-ConnectionGUID: OwGaga5pRFStyCZr9On2HA==
X-CSE-MsgGUID: 7VafkMnuTsidm2ib59rpOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77601494"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="77601494"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:09:11 -0800
X-CSE-ConnectionGUID: NSVz33FqSKm5pPK0eaW3ww==
X-CSE-MsgGUID: HUpBMYvhTe+5Rq2WWQVtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="192300645"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:09:08 -0800
Date: Wed, 26 Nov 2025 23:09:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <aSdsc6jhQLHLVfkR@smile.fi.intel.com>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
 <20251126203240.13466-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126203240.13466-1-tomasborquez13@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 05:32:40PM -0300, Tomas Borquez wrote:
> This patch replaces sprintf() with sysfs_emit() and sysfs_emit_at() safer alternative

This is a bit too long. Usually in the commit message the ~75 is a good
threshold.

> with no functional changes.

Code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

P.S. Do NOT resend if not asked so. Jonathan may amend this whilst applying.
Also note, this most likely misses the v6.19-rc1, so we have plenty of time,
no rush with it.

-- 
With Best Regards,
Andy Shevchenko



