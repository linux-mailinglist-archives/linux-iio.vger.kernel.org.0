Return-Path: <linux-iio+bounces-12812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1E9DE88E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17821B218CD
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A3137776;
	Fri, 29 Nov 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsJnw3O8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5528EC;
	Fri, 29 Nov 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890812; cv=none; b=fnkCJIkCtYzh1Ig2zi607rt0djSeEEsxvdCjmP02R9a7jUXMa+fLaNKQZxRfd1kq1NRrRD0hVt07OjH+W1ISU1BTUE9Rqg2QooCpW2j77H9wvafFZNGTGRLXP47HwMAZf8Mqm5GUuXujZSV/Xj14OWWNP2bVyNfbJxtzpXF3LHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890812; c=relaxed/simple;
	bh=ggcFP2TpUDuJc85F0rS6rmNVHScKViGvL5eID60yB8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6iuNTwfKuyikWmugbjDBOqb5tfwhjumVqLYMzhA0ROI8R06GDLn0FxsAJ+wgJmeh2qhqcPsXQrmw6pJf0xZQ7QLUilvbj4nmaNsxRj6kmJMkNyUDAGO2mQir/WGgRb4SOG55PUCYJTxxOC/3IZkEDVpxikqIVmh8JTMRHC4PYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsJnw3O8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732890811; x=1764426811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ggcFP2TpUDuJc85F0rS6rmNVHScKViGvL5eID60yB8U=;
  b=JsJnw3O8JGFX7gkDnIF5LdvDQSl5vMX4pyqNU+IGBfVejtlahCzkniGd
   WMdh8jsV7j90C/Ipd3q0vvPJPlD8SdhDG8dRpJPvhRZEkJDcz2rnZIoYU
   hkYm2UumbuMFL199Vy1pM2FT4W5h1S2QY2W4s+tD60GQF3g42y7R+Dosi
   DeOXYOIjk/W40aPeBIcT+Iz8iBviCxvN6uWzaAkPJByL9/iyvTJxU++2X
   4plUUImeilmxHM3kD2SzRycvXZcKZuu8xfPpfZojbsZUlKRhazqlJt1bv
   q6/g9YH3VrbYMuKxdr0ttYGYDxW51kGTB5s7UEDREaFntFXhCZkuHXu8/
   Q==;
X-CSE-ConnectionGUID: klrqiUcLStSywiqAAwHG/g==
X-CSE-MsgGUID: kOJKjDO7Q9iW7mV4z0P/QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="43798409"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="43798409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:33:30 -0800
X-CSE-ConnectionGUID: vVsuKraCRxqWXr46l3A5gQ==
X-CSE-MsgGUID: OOjSRwHmTe2M7TRTpTY39Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="92385422"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:33:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH23g-00000002GLo-44Eb;
	Fri, 29 Nov 2024 16:33:24 +0200
Date: Fri, 29 Nov 2024 16:33:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: chemical: bme680: add regulators
Message-ID: <Z0nQtMfGbEzxq8q0@smile.fi.intel.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128193246.24572-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 28, 2024 at 08:32:45PM +0100, Vasileios Amoiridis wrote:
> Add support for the regulators described in the dt-binding.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



