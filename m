Return-Path: <linux-iio+bounces-21243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E745AF5BC9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7861F7A29CE
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AAD30AAB8;
	Wed,  2 Jul 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+ReiwSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FF3093D8;
	Wed,  2 Jul 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468045; cv=none; b=knyImZBWW7nZwLvjio50pmjnW8FTsXbVNnAp2jFM8+7utrNe5fSV84wKbStbN6a8l9xhsYf5QZ1qydK2AbxGWQ20NrT9EayVyp+uCX3lucEcqBEFLjmVZK6g0Z3B4RK82tT7LcqXKwOD/i9NpiRbpJcEehlVkPwWXMW99BTUTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468045; c=relaxed/simple;
	bh=pCEg0EdOzKP+ZUExkv71c25NkuI2si5Osz6a0iRg3jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv6pBBIAZILPyjczWXxD9HXFvhp9ZMIlQ5RX1zQGyjYPzXDrMw2YdMg5k8A3Qj8P0qwsarzAT86ys0aEllYQM+HYmYuL+Yp2o7v4mPVM+EAtLmaix/nhtOUZ0pbXOyWrKD065mxWYMnBWFTpfVgkr7zz8wtPxqXKyuYx+3rt+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+ReiwSO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751468044; x=1783004044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pCEg0EdOzKP+ZUExkv71c25NkuI2si5Osz6a0iRg3jE=;
  b=D+ReiwSO0WdRpR2lhHOZQ40cxKkBxCU1gGwasfbywm0h7kA8bssItJ5o
   wjm8avOf0x15+YoqeUFWWW2IZyIWrqlzytMICWwc2OUXuNFNgkpbbONjF
   w2PsOh3+7VYBzgJ2PlG8pHzkauzjQcLqcXwK88Ziog6bU8HustZXGjqXT
   ygh0rnUjm29TFvLvE1Q8Cu8IdwKFdNEL0Gx+GGdzabBBglMCA2VXlv0Rf
   stJThK4HYpllqjVONpQWB1BtTuaHANgOmOQBD+xgQG80NX5gl10ljL0tI
   MbAlUvKZByuaVdmcMLsTVXRFKCtozlNMEL9PEdRt0qkBbmCjY8u6QRjV4
   w==;
X-CSE-ConnectionGUID: iyW8BOO0Tz2fXLdnmfa/DA==
X-CSE-MsgGUID: l1OQY7bmTYiTr28m1cs5lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65115576"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65115576"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:54:04 -0700
X-CSE-ConnectionGUID: cUXzadvVQxKM5FdeQxjB1A==
X-CSE-MsgGUID: 6gkIpMEbSmmRCp1lMg8YNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="185126577"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:54:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWyqT-0000000Bwkw-3mLM;
	Wed, 02 Jul 2025 17:53:57 +0300
Date: Wed, 2 Jul 2025 17:53:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
Message-ID: <aGVIBVsFPcVw3lN6@smile.fi.intel.com>
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:
> Rework the clock rate range test to test if sync_mode_data != NULL
> instead of testing if the for loop index variable. This makes it easier
> for static analyzers to see that we aren't using an uninitialized
> sync_mode_data [1].

But at the same time it makes it not to be the usual pattern.,,

-- 
With Best Regards,
Andy Shevchenko



