Return-Path: <linux-iio+bounces-21721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED645B07274
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3D67ACDFD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282F2F2C57;
	Wed, 16 Jul 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkudpMto"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440D2F2C49;
	Wed, 16 Jul 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660101; cv=none; b=ZzcFT8jF6bpt9owDaSotyU/qPHHvmniFCCNdLq14hLpUa3xGwR6efIOYwNis6e84UAOkt+QIau6EBbT+B8kFi80wwFDHln9konJsjoJ1xVsrA5N+LiEeyjP5xsjuTbZoOO6iV+iUmwibzDFpoKZloN4GawTJ6jILngjlYBLchew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660101; c=relaxed/simple;
	bh=bNB67Ct8l9GTm/Wm6EXqO7hY0gIbyhcFELP7xTzfj3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq2gpCme3UTdXrooJf0kHdL95T+UBe8TWLd3o5EieUwFmB0dAX6YSCtEN4koFeiPvXfHpXb/CbzCE2im66nhJkvFgkMIC02xkgyyJgE0gHfVgVWHopChACwsofNvy7I6hFqbZc+l9jIIdhT2bafJtY+6142FCGZztdeolUTblQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkudpMto; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752660100; x=1784196100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNB67Ct8l9GTm/Wm6EXqO7hY0gIbyhcFELP7xTzfj3Y=;
  b=fkudpMtoGjgTCF57SLtzpOVHQnSzIQlBUAwgo+DgfttWb0WLB64BIgND
   EkGtLnyX/k6TL60/ZbMBDXgAkWXOnpiu//3KcrvnQ+Lk3YsS2bRHu5ml2
   dDrsjM+HHxvXV7wFDLU5oK6ze85+jLBYg59ccAf3NKLbnU2n3RRuH9NdR
   wn/M15wTGXkO0CkD/p566JpYJcVck3S3Pg6AhXSnXUP1xTGgApzr5Tg6X
   UVHzt2C+LKHvLyUjHJ/uQKnoWoTfrA/PLFKqtg3QL6uMqtgIZLHOMpJ61
   fCU+SyI0VesRJrnF9UQ9yrdILxG6pgMoxB50TJrQrR4g3RErC7bSpjaBQ
   w==;
X-CSE-ConnectionGUID: dsWOMa3vTuW1LZFZ+NWpZw==
X-CSE-MsgGUID: mYSUCPR0SDy4H0r1+UZD0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80349884"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="80349884"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:01:39 -0700
X-CSE-ConnectionGUID: G18xTV40S6O4LtkL1hf+ZA==
X-CSE-MsgGUID: KBunt/LSS7aO7VwHCXs9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="156858495"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:01:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubyxA-0000000FuGo-3b6b;
	Wed, 16 Jul 2025 13:01:32 +0300
Date: Wed, 16 Jul 2025 13:01:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
Message-ID: <aHd4fOCoaAYdqbMy@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-7-sean.anderson@linux.dev>
 <aHYUOs25SrUb4BtD@smile.fi.intel.com>
 <05fbc6c9-0b6a-42bd-8940-242c80a79b7f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fbc6c9-0b6a-42bd-8940-242c80a79b7f@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 12:05:15PM -0400, Sean Anderson wrote:
> On 7/15/25 04:41, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:22PM -0400, Sean Anderson wrote:

...

> >> +	return sprintf(buf, "%d\n", result);
> > 
> > Mustn't be sysfs_emit() ?
> 
> It doesn't matter in this case (as %d can never emit more
> than 20ish characters), but that works too.

Have you read the documentation? It uses word 'must'...

-- 
With Best Regards,
Andy Shevchenko



