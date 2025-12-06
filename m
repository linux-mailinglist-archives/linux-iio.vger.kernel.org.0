Return-Path: <linux-iio+bounces-26828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB8CAAA1D
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654393025F8B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF52FFF9D;
	Sat,  6 Dec 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6uupJMa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99A2FABE7;
	Sat,  6 Dec 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038266; cv=none; b=gOluEXltAUNN7TDC5/u6ReDJg+Rgy8NJj3RsLQesoF87ceKZgs7Y/gnrePaCSihrS0yHrgq861CqqbLlLwS2zLSlp36XgzKSoqz2bLMIB9oUhZPgafVngTP8tXUAKdh+NSiqnIzMKfYvi7c3Vj+QPcQTODa5RTIx8oRasgGTukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038266; c=relaxed/simple;
	bh=CVzDzQgA7F/6phatzvEyKmHq5v0ECn3LJTolVg6ewak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnnGiYV5oSWe6lbSxrPXacs+T4KyJrDrOSdcxL4KLqVjoB9+CXiZI2k89mvBTwUrUe7hOCC2pHDEQSihbbbNSjZUd8ZSqlOgym6LE0qjqmhNoNTTy5PYOYdMIdrLYMMIwrBREO/r1m6wWnv9Q3Buz9fKby4cnOgLM2B5irBiMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6uupJMa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765038265; x=1796574265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CVzDzQgA7F/6phatzvEyKmHq5v0ECn3LJTolVg6ewak=;
  b=E6uupJMakdIUCEct2xseYLRddEqUOPPR4KoqMzBcsjz/UfNJCwcQhLzc
   l38D6G4xZ78LbfhY17JRh6v3SBMHMTtVrwLkzPiU7wiXdPxrpOVRJlFIe
   XlxCkfy0ja7FC95VXb4iVdlcsS5xmC6X7KsJ9qTY8aTFQmczkAr8aoaim
   HmZvMJXhNHzwMgqAA2jlh0LhDMBu4M1fs0Dgb1swVODOsjU5Ef4xCsfyx
   4y+zNJ2JFDMQk7ihqfUW/PIVAtzUaGRPxbG74IyZG6Z2CXOg1259hqujw
   Thoe9YfDp2yTaxAbL3qrilkW8topBDn6aXAO2/JGTwwzVXQ+KzTHr56Ah
   w==;
X-CSE-ConnectionGUID: zYX1gjrGS2OK8FElWOsREw==
X-CSE-MsgGUID: 7J53K+mnQeqWxxieuU6tHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="70900822"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="70900822"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:24:25 -0800
X-CSE-ConnectionGUID: Lk7d7yE9TfCJUfwnuBUIOg==
X-CSE-MsgGUID: /mhhoiV3T7yZesO+5UdZvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="226206361"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 08:24:21 -0800
Date: Sat, 6 Dec 2025 18:24:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] staging: iio: ad9832: remove platform_data
 support
Message-ID: <aTRYsueq31e3CtYJ@smile.fi.intel.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
 <20251205202743.10530-2-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205202743.10530-2-tomasborquez13@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 05, 2025 at 05:27:41PM -0300, Tomas Borquez wrote:
> Remove legacy platform_data support as there are no in tree users and
> this approach belongs to a long gone era. The policy decision on what
> to output is a userspace problem, not something that should be provided
> from firmware.
> 
> The driver now initializes the device to a safe state (SLEEP|RESET|CLR)
> outputting nothing. Userspace can configure the desired frequencies and
> phases via the existing sysfs attributes once the device is ready to be 

Tailing space on the above line (and the only line with this issue).

> used.
> 
> Original discussion started here [1].

The change LGTM, Jonathan, can you amend the above and apply it?
(Yes, I have read the discussion about removal the driver, but meanwhile
 the change is good on itself even if we are going to remove the driver.
 It just makes an additional harmless step in my opinion.)

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



