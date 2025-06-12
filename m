Return-Path: <linux-iio+bounces-20550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3354AD710A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0161BC646E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A3239E6B;
	Thu, 12 Jun 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drZSHf3F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0763C47B;
	Thu, 12 Jun 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733402; cv=none; b=m2Myt23S/TFjTKJJlbYKiCjekqF3KoPyBYe/+isWAQ5UgZEbkJgVRD47uy083feZPFdDBPRn2QVsSIIKTxGPaKzIbdTuR1UIVPkRKsj4pjVoEZWP5YKIBc0iWmD5Cl3y6hEvFsnJPn2vy3CI/fmiCGHYijS4qx1tVlCnbhvyKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733402; c=relaxed/simple;
	bh=smFod4njUytLjEceTyaLsqM0FApkQys84GHLHROOmnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjkmxlR1ShXcan2HzhJvQ7zxPxp9yPqx+imNeq+atL7CJJriw59r2IN4MYCx2foMvyFoCopk4vopR5umWpRXwWd8tsM+RzGJgiTbqq9cFlmF45TfCIOmmDZ41B8j4ysGijkj75LxTXhnOYcNQYO2P+Rn/01RQkeWmW9RiUI5duE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drZSHf3F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749733401; x=1781269401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smFod4njUytLjEceTyaLsqM0FApkQys84GHLHROOmnU=;
  b=drZSHf3FlumkCbb6glLa1P+eghFYqU0dYeNgR0VgwphCYhBuo9vy/Ofm
   vxPriUqhlq7x7BHY1TGcLHEqWc77sdnrAxu+q7g00ZmnLSVPFRJdQQGgK
   ix/WLfVI5bc+Rdfv3rL4+wyvibQv5+jO+E2sIRGRRtBZMWWrA07Pr1lYc
   yArLUFm7rN9Nh+2uXAo+ZUxId7GgSehG87ukZtIs6DMWu5Gq7GypLAnV3
   tGD4XFPaPXlwUNNK/Ri6BUECwDHQd8giFajgSgrGaS5UE2ha+rc4BRixV
   pTJinnkSl5CoVYFs7uekuU84Bnua9RFsEzuDqjgIYIyH80j0Z5xLxbT7A
   Q==;
X-CSE-ConnectionGUID: CFr9smqsSs+ck/T2OrbbHQ==
X-CSE-MsgGUID: 2E2CWMiHTiO6ujTDm8mlHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="39521660"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="39521660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:03:20 -0700
X-CSE-ConnectionGUID: o2H5FO0LQy2gl7sQKQtNMA==
X-CSE-MsgGUID: EEn9lOyjQpiYIK1ODSG7Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148066333"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:03:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhaM-00000005xI7-1Fw2;
	Thu, 12 Jun 2025 16:03:14 +0300
Date: Thu, 12 Jun 2025 16:03:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: amplifiers: ada4250: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aErQEn5sdf25Vlvi@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-3-bf85ddea79f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-3-bf85ddea79f2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:33:03PM -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
> 
> Replace 1000000 with MICRO while we are touching this for better
> readability.

...

> -	voltage_v = DIV_ROUND_CLOSEST(voltage_v, 1000000);
> +	voltage_v = DIV_ROUND_CLOSEST(st->avdd_uv, MICRO);

Side note. I'm always worry about CLOSEST choice when it's related to voltage
or current. Imagine the table which gives you 5, 3.3, and 1.2. If it happens to
be closest to higher value, it may damage HW forever.

-- 
With Best Regards,
Andy Shevchenko



