Return-Path: <linux-iio+bounces-26627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E776EC9BBAC
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3588F3A757C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01565322551;
	Tue,  2 Dec 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HC1WjKnl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59732143C;
	Tue,  2 Dec 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684711; cv=none; b=Z8MveZmXsEpJyNBjBIeLRcZqtbQ3Jhoq3nuJN738b884vpXdvZVH8u3ZNxkfZoJwlXo8mK33FIqyeI87B9YFcabTdFcG55GSE1/W9wNmKkL9wEjvF7w1lZPbSGFlh4kfey+i/KcEcGjT9k6ppJ+CaIfPDAoX5AKAABlFi5ZdfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684711; c=relaxed/simple;
	bh=tz1SHOL624D6b6vg8OnKl0dvhb3N0P9qUHC9Cvtbql0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9ldw6wn6cxOvbmj5PyNnzqh/1f6SGZ/8eUdz1ibH0r55zzO47KSA6pvbm/1tE/ULb3cBSrm6xRwp5IcH8EzBXY33dX85oJy8lEPmru01qfPjYctA4AAE9KaxARjH0bs2qkHTNAD7uJttoNTHx6G+cZuAhCsSuMyRjzJRBj1K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HC1WjKnl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764684710; x=1796220710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tz1SHOL624D6b6vg8OnKl0dvhb3N0P9qUHC9Cvtbql0=;
  b=HC1WjKnl147HxHBhlbmi25YP5m5ipry8MVXwITaww8EG0QkrK+UCKYio
   usioMnS6rvHCuzsHUsFLra5KEQBY2xDNDd7QtfggE7uNcSyzd5Fh/rTHN
   fkXFIBgceXueeS9i3+ZrdRWCMWMYfB8EMrT5KdAMZEp6RfCEOBcxNHLj0
   IrecSqo0Zv29WThRSzxqXXAUWCHqbWJyBbms1gA9rfbPec/XaK2PTGg4O
   6+sM4UlpjrBFRe97iTUQLHaSKmT9kwFG1yhmjRkyYZRfubeeVn5xhYdoC
   ypYS+mELNZirdWyDMzdDEtX47azimbg49Eab5kGONwlHjXbZUDH5Fudwq
   Q==;
X-CSE-ConnectionGUID: R+ORU46HSZalDWyh0WNxMQ==
X-CSE-MsgGUID: Br2xV+DSRO6CDP7kWb+kbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66538728"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66538728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:11:48 -0800
X-CSE-ConnectionGUID: V0+5JZcRRxKVa2KEGX6JNA==
X-CSE-MsgGUID: 3xV3cQS7QKecEBXRUJ5qOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194218333"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:11:46 -0800
Date: Tue, 2 Dec 2025 16:11:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ad9467: fix ad9434 vref mask
Message-ID: <aS7zn779gAyfFyHi@smile.fi.intel.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-1-fa73d4eabbea@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-ad9434-fixes-v2-1-fa73d4eabbea@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 12:53:08PM +0000, Tomas Melin wrote:
> The mask setting is 5 bits wide for the ad9434
> (ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
> from ad9265 were copied by mistake when support for the device was added
> to the driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



