Return-Path: <linux-iio+bounces-26798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADECA81B3
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA02230C24EB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D834DCE9;
	Fri,  5 Dec 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCXKeKmN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C131A044;
	Fri,  5 Dec 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947412; cv=none; b=t6GAjYRkwtFglHG0Rt0qD58QXtB4PWdOyD+eTTtwigrX0b4LkpmscVhCPzxadF5QRS6gKzUIBzRd3H7kKCFSnqU2u/+1JRr8cwjnstSskeBjBzYVa6vuMEEAbAvB6UDnuieg+X6Astx/T/k36WZdjRO/y6Pr5AvJY3qFGHUyIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947412; c=relaxed/simple;
	bh=yzddV00prRkaMXQlqvPLWl67v4+7ujorz4SJyywgNw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkfIKwiC33gew02HpVmqC0zx05tNFw0PgZ2stqc1h8BKDnvY4KMleTznosN7LqiwFLErSTGtd1HSI0awEFd48I58yv/Qs3yBBWm/ttAPTRRaYFO00MnAl1kgap+W+/XCkygKzbuXFt2gwS3tCf/Qb3BpfFhlQRhxXAz3KbD17Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCXKeKmN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764947409; x=1796483409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzddV00prRkaMXQlqvPLWl67v4+7ujorz4SJyywgNw4=;
  b=cCXKeKmNSvpQSi8eXvp6znU842B4Mwlcb+wu5kwA0tntXmfh0JlkqJPM
   B8AYz2b/olIPKfoWNky9kX9E9nFFm5uIiEA8uB499GfUj+GnV2qxOrgKT
   cgg2dMvywIrRQan1nXH0FIxl3WfPHwiHB1Z43K5oAUgZAREu8/DLcAxEC
   378ozXMGKyFIcPSTyx2snj5PaUB61Dg29rl7RstokNE5kX/ugbix3klOp
   4f2VLiSdQeFfiRnwAIwU4kmgDEDw030qpBa0sCOh7h4mLqFwhGNDDEy9S
   NSztZp0xYkrvKttVzL847fC1+JE/J7xgc9ar9UML0dabYVqsvJwDUgVn+
   A==;
X-CSE-ConnectionGUID: UcCjP1pfQcKk+N+uoshtOA==
X-CSE-MsgGUID: gfqKxNo3SAmgTfIj/jX2IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="78334070"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="78334070"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:10:05 -0800
X-CSE-ConnectionGUID: +OqoTXLyT+208MCAjVf+Ag==
X-CSE-MsgGUID: 9VymabUlSV6Ogtj2/3oluA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:10:02 -0800
Date: Fri, 5 Dec 2025 17:10:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <aTL1yCOgdtGH8-3x@smile.fi.intel.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
 <20251205144058.1918-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205144058.1918-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 05, 2025 at 04:40:41PM +0200, Antoniu Miclaus wrote:
> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.

...

> no changes in v6.

This is surprisingly interesting.

https://lore.kernel.org/linux-iio/CAHp75VcxYGskVpQ5HKiFUUnNSj-9qpdXeBjz9-oEHc9eumE0fg@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko



