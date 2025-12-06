Return-Path: <linux-iio+bounces-26832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135FCAAA62
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9153035D33
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838372FC877;
	Sat,  6 Dec 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgkhFnFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471329ACDD;
	Sat,  6 Dec 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038781; cv=none; b=VTuKg7yF/Q2lx+scE4YZYTWyOSBGp8i9gFyn3f22MO3o+DXw7Pa/oHqS2umpV4NxN+8orZTPYARdbpQR8nMVqiVgzttE8KwXxEVDLb71WVxIRulXTuWxZd4uVQ0J6nMPpeLEnMJyQIUs1rvbkuUdEv/6VGIM04zYIw8/EU6ZqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038781; c=relaxed/simple;
	bh=ob25n/82zM8zU+Kp0oVp6ToXh0EkTp7b0grG87/yDM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwiQx7PwiGAxXZoPxu0+eqHuixMN4GqtLAfXvWTbCJDSnlmedz7ZnyB5SyQWY8fruL8At6Ktpx3nJkFiF10Wzu2BCFcru/TkOY4cmTqoqI9j4lLeACISJrYzFX8paI5TZbqKZ/88WkpjXMutvX97XOO2xTaqJSXigpNRcNHm0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgkhFnFS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765038780; x=1796574780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ob25n/82zM8zU+Kp0oVp6ToXh0EkTp7b0grG87/yDM0=;
  b=XgkhFnFSaVynpYDTNNlz54wiLNv3etx1wx8SJRwpplvEJ3LxQIwJCfXM
   zdpmh2m6bWV7aoClLvwPzkduYYeyWqk4ib6VPK2FqV9ZV+/EBGA3T/6kv
   aVqoO0HUYumOxzBGSXiNBlbUx1stFrWGjJloW+I/VC96xOu1QTxJLsF5k
   yMLkQhjX1fx8yqZ+UfNgIf9nyiYUE2/yRlUD2eHikpm0fXuYNrBFTjYSG
   iR6kSUOhxcJYsrAzmH9MAko0xQwDleiGWpyy4yQL2wrVN6FYJl2YLNOBn
   NIrarZpG2XpZjQZahaqoorvg29w8a76/9AeBKhJNvjtVxTFUgUgD2dcP5
   Q==;
X-CSE-ConnectionGUID: Qj2MgagsQBm9NcDL8hAXAw==
X-CSE-MsgGUID: 1MFh9gqpRrGStCuzv0OkwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="70894218"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="70894218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:32:59 -0800
X-CSE-ConnectionGUID: AJGSFgOgTBCRmSDpvi5LWQ==
X-CSE-MsgGUID: SWl0Cf1TQgKKVF9ue9eMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="195464577"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:32:57 -0800
Date: Sat, 6 Dec 2025 18:32:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: frequency: ad9832: replace long/short
 with u32/u16
Message-ID: <aTRatkxEqIxL3EEP@smile.fi.intel.com>
References: <20251206054831.26045-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251206054831.26045-1-dharanitharan725@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 06, 2025 at 05:48:31AM +0000, Dharanitharan R wrote:
> Cleanup the AD9832 header by explicitly including <linux/types.h> and
> replacing ambiguous integer types with fixed-width kernel types:
> 
> - unsigned long → u32
> - unsigned short → u16
> 
> This improves type clarity and ensures consistent behavior across
> architectures.

I have nothing to add to the Jonathan's review, just shift your focus to
another driver instead. And if see another platform data, kill it. We don't
use platform data approach in a new code.

-- 
With Best Regards,
Andy Shevchenko



