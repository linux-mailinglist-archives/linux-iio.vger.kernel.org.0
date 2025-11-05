Return-Path: <linux-iio+bounces-25920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4093C36619
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD1501B3E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE433344E;
	Wed,  5 Nov 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIKnVS9e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9332ED43;
	Wed,  5 Nov 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356063; cv=none; b=U8eD1l7nLdRWJILoSzaB8MBzfSVSBa1FEAI4Nn8KR+hvEVi4DIXPOOSEtIkj173P9IurtVR94ZQqKSqOsPj/Isw3BX5At6yVbvjfXRaoRDD0+YC/2e75Pclx4ztCXP3R+2aQpU+5ZsiOLVgPXHyOIV/mgy7gVr7ZVymMEWfaQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356063; c=relaxed/simple;
	bh=s9x9qnNTXmFHL0/OJXGem8OC5QAEeRr8cOIRJg2Ibbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivzHWsE4FFIEQUYLkN/1ewfnvtp9/tshz0uoG3BI4MTPCMCvbJZy72kIKujU9VQmCl+Dr0YFE4kYwdbDKxLgsJzI2TTX4iOgiqQdwuFcnGh44KbjVSZ/LX3sG9bPNWXUzTGjUkQ1m2thX9H0s5No4133dKvtkIyqW3oOkbINx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIKnVS9e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762356062; x=1793892062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9x9qnNTXmFHL0/OJXGem8OC5QAEeRr8cOIRJg2Ibbg=;
  b=jIKnVS9eMzmbv0ozAB3P5bW1tBRzDZt3JlZaeM33pMeKjPTb+If3Mn4B
   5jeP0AlH6CjIJGEsHCMApP3x1Gdv1ICUmwOBHaFoGIFWtQwzBRdcYuiPR
   lW5njYWHJ50QAaoXMjCi3KL04WXMiKSp1SbtRhCOzvMXLrsmyi2OqZsrQ
   W+BhqFcsTb3fJOjE60V5KPJ4HaWik7xDro+5OjDaAcAgaQFvIYwJqf7L2
   AXRPOTAlgPV8d+stdk45fv32bdCa36VaAVTehFWpkv0ABMGXBgSsqsVfa
   jz3+MWhoVZq0MLAq9G8Jntt3TmsGacieKJWfnY7HA/Hp+qpmsOvB7K+g4
   w==;
X-CSE-ConnectionGUID: UnzS3xdKSTmdfFq/V5xMLg==
X-CSE-MsgGUID: hXRHs9dfRPic2oe8fMI6sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68311400"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68311400"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:21:00 -0800
X-CSE-ConnectionGUID: xH8ZQIgwQfOcO8WI3NBpxw==
X-CSE-MsgGUID: joWrVgYySOGNIN+j6koxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="192550628"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:20:57 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGfJd-00000005p7L-1IMG;
	Wed, 05 Nov 2025 17:20:53 +0200
Date: Wed, 5 Nov 2025 17:20:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <aQtrVNktJcNrFOdx@smile.fi.intel.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-2-apokusinski01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 10:56:13AM +0100, Antoni Pokusinski wrote:
> The pressure measurement result is arranged as 20-bit unsigned value
> residing in three 8-bit registers. Hence, it can be retrieved using
> get_unaligned_be24 and by applying 4-bit shift.

get_unaligned_be24()

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
independently on the below.

...

> +		u8 tmp[3];

While at it, you also may rename it to something better

${foo}_be24;

where ${foo} should be replaced to the meaningful name.

-- 
With Best Regards,
Andy Shevchenko



