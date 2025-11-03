Return-Path: <linux-iio+bounces-25823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAFC2A84D
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E6A18904C8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EF02D837B;
	Mon,  3 Nov 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvbJ0XVG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E715530C;
	Mon,  3 Nov 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157726; cv=none; b=teNbtnKtFThw0aqM+ZO8rqXp/6bGI22hVHtKcy8H9XBpnNGwqNqJnAb/MSZGpf8DQ40xR5HAisCXc0QqtYcKEkGo+Yp/cAHhkv0fZc0ATCT5+9SuvwUk7cA+lRdWPvR3IQZtEJVbam2+bl2ynCdKrvLY3LQa9YpOiFGvGCpL47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157726; c=relaxed/simple;
	bh=VufkWrtuA/KSjpuq1x6sOOrO8BVr8XELL5F/FJgAris=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsDnmWzniEG7L8NYWmI+OosmtPLW0vG3SYAbdOrbGqpbZZWgQC9JssbXcfUBVSt/82TKrJWlIHrnAIh87NwmRyyu2g4vnULDlz6IcbX8pzAIwOdPNyIv+UQl3hRlaxEsW6w6IKAT+dCzdNJ/J3WXFHeocYw0+j+esJL1Iqp5yL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvbJ0XVG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762157725; x=1793693725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VufkWrtuA/KSjpuq1x6sOOrO8BVr8XELL5F/FJgAris=;
  b=FvbJ0XVGV9OnfSQKa5ZuSA7EpIJynLhwJovU8+G7nBsbe8I65lFDWNJo
   DEIsGIyxzXgdiboGxgyYPNPpSFCP3qLMDAlwzvZiru9uYpe7dRsPJJY4t
   rg8vO0VAaumtq5uhMdzEe2mL6sFXxECagL3Cjcxi5V0uf0bBr1Vn5DvKt
   OR6wbqkOHW+mm8PzCZ0MjZkMt7UDl39fq93RNnLnfrzkOLkNtLmMJML6g
   82QpViBRb0VEQM7IdM+Kcm9ADWQVW+4r1f5NMjH5kObSIr/TiBDqEzsUm
   wWsMNR/bFsD9nLNA7rPpfDs+sVXRn0NZC77w0ky7bmSmT1QDojsQLRJAp
   A==;
X-CSE-ConnectionGUID: 4fh5oSLYSAqVNJYqo2i8vg==
X-CSE-MsgGUID: afaiU5vbSY+0FZhR8MWz1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74830750"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74830750"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:15:24 -0800
X-CSE-ConnectionGUID: xxrSDRuvS4a2Km8/zCjM/A==
X-CSE-MsgGUID: jgG0tFbES6C1Q/WdN6bt/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191914908"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:15:20 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFpib-000000055PN-1HjE;
	Mon, 03 Nov 2025 10:15:13 +0200
Date: Mon, 3 Nov 2025 10:15:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v9 0/6] i3c: Add basic HDR mode support
Message-ID: <aQhkkEh5C6vl2nbT@smile.fi.intel.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
 <20251101162525.44c9862b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101162525.44c9862b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 01, 2025 at 04:25:25PM +0000, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 12:39:12 -0400
> Frank Li <Frank.Li@nxp.com> wrote:

> Assuming everyone is happy with this version,

Almost. Some nit-picks, but the main comments are:
1) arrays out of a single entry;
2) seems unneeded calls to regmap_dev_attach().

-- 
With Best Regards,
Andy Shevchenko



