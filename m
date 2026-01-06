Return-Path: <linux-iio+bounces-27508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A24CFB084
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 22:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F45302D538
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266E29B79B;
	Tue,  6 Jan 2026 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cd1Sq3Hz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805E27BF6C;
	Tue,  6 Jan 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767733447; cv=none; b=rBhNqlebzVSL4BoNMeeKLYPV/416OfMFulOZ9la2g2T8XkmjPPCc4uFXBj6c9C8WaV10So0liE1s2EnLzqDjFCM0DtD7K2ZvS/5VWKXp7LAzoKmMX7WaRTtLsAFpdEKxOtcRcGgVn6wbjnggvVc5bPZwPBdEuTATlGQSogfd3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767733447; c=relaxed/simple;
	bh=8RvXhQ8PiUoYei/2WW7O3rDrD/DdPrZKB0hyfXPx6H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1W8gq/e+OfcDnLfdmzAszHAce8WPWPEeJRSEwJOwXiC7G4rzP4DSPv1BFokQMJ1p18FaeQXVYFF/tsa4+IoWVy3pP+o4lLt20xZh3slH+On/Xuw9UASsWMnGeC/Z449B7vRFdtevTpvxyJyJ9CcthaqGmVpDLw+W+xf2/eNww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cd1Sq3Hz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767733446; x=1799269446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8RvXhQ8PiUoYei/2WW7O3rDrD/DdPrZKB0hyfXPx6H8=;
  b=cd1Sq3HzErgT3yKIHC4KmREVbFNF+2kpTzIxh3rncvYNl43Eolput61e
   dvNTHLG0ZwN+3L0jOe/uO/WU2BtQePsCj0bwhooaNuioJ8zeHa5NKus2F
   I13e6GAuLLDbhyeW/TPLXykLBybO7jDlpncsQipOLVRXt2GN+wdHeTsUO
   oFFUloNsCcvVs2Fu+Py/zHMNMK9VBCTRK3PHajY2gs3s0KMoCe9Zgn46v
   rQkWuXK6mMK5bwkHM9U+LU+Nt4R1WMUvM3Dxp2xelWZxUSwj+Sjuvp34C
   2/j/QTwRxg8+ov+h/9zbl8z5IApQb0IPNjmMvvjfJXobzhLujIn4qTe45
   A==;
X-CSE-ConnectionGUID: XcYBNfTrSr+7QGh55yQqQA==
X-CSE-MsgGUID: YZhdquebQ2O+qgXlbuQo4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79407449"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79407449"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:04:05 -0800
X-CSE-ConnectionGUID: N9K6vD9cT0CO7JUDOmWSFA==
X-CSE-MsgGUID: 4KWTPl0gQSqYlqkbA59/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="233450103"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:04:03 -0800
Date: Tue, 6 Jan 2026 23:04:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: adt7316: modernize power management
Message-ID: <aV14wL35muj55kMF@smile.fi.intel.com>
References: <20260106145055.2557551-1-michaelharriscode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106145055.2557551-1-michaelharriscode@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 06, 2026 at 06:50:55AM -0800, Michael Harris wrote:
> Replaced use of deprecated function SIMPLE_DEV_PM_OPS() with
> EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> 
> Removed PM preprocessor conditions with usage of pm_sleep_ptr().

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



