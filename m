Return-Path: <linux-iio+bounces-20901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612BAE3D35
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858E31781DB
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914423C516;
	Mon, 23 Jun 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvLkYCvl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C118A6A7
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675513; cv=none; b=m4e2u4zaTzBXI1G5zkQJu29X4BUYVX62watja/Ob+MAiNCYsnioRHGlAjxNvOyQ9u4+7xhBwPFUAiTzk71Sgy5I4pcbha/fFBAZIieMm4QYnUCoivSs3fxNecSLTvRtVy5ftqb/0mPNEFKTW97RkadBelezwFp2jC///KgR3bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675513; c=relaxed/simple;
	bh=L06ElXWy8V969egiTxFaIcfw/vBAMHlrYHgw+dk8MhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TgZs4adYEQ51b8cK+vQI83Vrr5U+9fU8RPn6mrj2alP/XduDFw1fWrCgdbYrlN0Wr8XndYR5+R5dYCTd5nMZGwmY0NjO1Upp7Modj8+Qj0NP3pfntrG1ffNTFBlXIV/eARfMfMKNxAGQ4uu5v2+4ue1gNWSSHaBz3iOQmOOcVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvLkYCvl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750675512; x=1782211512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L06ElXWy8V969egiTxFaIcfw/vBAMHlrYHgw+dk8MhU=;
  b=gvLkYCvlbEqlsCYN2yI7Ffur5Spd4EuxKf8IHYvFDRoeyKC5Iye2VK+7
   DuDttsSJzkBy4CgIBktn55jL2cw/+B5lhhCrAeYJ37Mf+H1EL8XstN7j3
   cpxHJKRoLODD0noVAGvy5SecwCPHPosE2EQ4OmsljZgE5SPoVKA7JH8Nw
   Xmyhb0LLuRN6QKXLGHne7cPweRyGsfQ/CLAkt5wg018KOXoWQOuycZxGe
   B1lQSeMsaTE9f6WdG321cJBLl6JtZ19i9quXjPcSw49FRB9asWSKJyLuA
   QCjHJNllm318lcOrGdUAQbW8HG9oqkmyKOB38rkaonMOO2CE6PvSjrdKw
   A==;
X-CSE-ConnectionGUID: pS3X+TXmQq6LgW5ornGjow==
X-CSE-MsgGUID: cYb0wa8iSrGFtED7V2/hmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56656359"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="56656359"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:45:11 -0700
X-CSE-ConnectionGUID: D9ErFu8VSP2hlOm376NByw==
X-CSE-MsgGUID: nYYidfzvQO+bLM2YQ6V/Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151336349"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:45:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uTefj-000000098vz-27gH;
	Mon, 23 Jun 2025 13:45:07 +0300
Date: Mon, 23 Jun 2025 13:45:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: EXPORT_SYMBOL_GPL_FOR_MODULES() heads up
Message-ID: <aFkwMyQ4v6i4JBG_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

Pay attention to a new commit 707f853d7fa3 ("module: Provide
EXPORT_SYMBOL_GPL_FOR_MODULES() helper"). This one is what we
mostly need in IIO.

-- 
With Best Regards,
Andy Shevchenko



