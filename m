Return-Path: <linux-iio+bounces-23053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65298B2DEE8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AAD168649
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD626B742;
	Wed, 20 Aug 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhSQxCBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0827255E53;
	Wed, 20 Aug 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699195; cv=none; b=IgHwBdS4KnGT8mpLn/k1aR/ikod6Ol0saVX/HkEOOb9dl/IFNhotEmcMi4HdFv78HA4RfGbjVUdeUoFFodkBJa2sLtaLHRb3WYYdtoKLFBokrQpKHDUQj2UG67uUmu6XsdFOUnzkpD44bSkbcNc3VDX2aT208zXf+psel6K49Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699195; c=relaxed/simple;
	bh=VfORanwWK0N2IhGqM8/NSiG1djWcKbLvF+xLsE3bUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GalfCSn0oGQcxkqZ6s3eGq0iV/MoYgiGwxIhAuDwG4emGCJ7RDYjMGx5X1NB7lbQq1vdF0DtJ9bxtMc4WNzbBbyksUb6wkm5PGYxNVT0MaYTf4+TbONams0eruFPOJ9CUo51wSCiKT6e50b4ra7ck+U0JDTImm/v2vkGkzf0NlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhSQxCBd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755699194; x=1787235194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfORanwWK0N2IhGqM8/NSiG1djWcKbLvF+xLsE3bUv0=;
  b=lhSQxCBdJ3COdJ/bYPnndOtQeI7PMnea21xkKLz44eMnNhXMO97KzCxZ
   MDgZtS5UtvTJrvk9LlMxcNS587eNNie0YwYJbdcPKp20A3KhS7Dgjjxkf
   NoUiPIdoxL8Vx/z0Qg0ddbX2+or9EEI6HJLH229qhmre6tZpmLT4i2Y6a
   sfJlJeOU8JEk1nQEM3cJ1Yrf5I3gQVqnF8ZofmcRXowLVCvwTe7jRDTdA
   do0YiJyhqorEsiITavYSlF1Jf9aHRGmjq4LZU7hA8zhA5TqUMRtk2S4z5
   wjJP9BQwVXZmRFZPmo9CVMrMQHxr7cbQ7Hi9PdeZFPuQVllxUKufLIvmR
   Q==;
X-CSE-ConnectionGUID: QibCzH58QB2Mfc4f7niEIQ==
X-CSE-MsgGUID: 1K+00CdPRNOe54wSaVqUtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61781622"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61781622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:13:13 -0700
X-CSE-ConnectionGUID: TSwpvnkqSheNUQkwfrIe3Q==
X-CSE-MsgGUID: 6XH5irdqTRyaRUjP2zyWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="199006074"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:13:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojYp-00000006xCa-26br;
	Wed, 20 Aug 2025 17:13:07 +0300
Date: Wed, 20 Aug 2025 17:13:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: adc: extract setup function without backend
Message-ID: <aKXX8-ZrIgl9DeSs@smile.fi.intel.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
 <20250820120247.3012-4-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820120247.3012-4-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 03:02:44PM +0300, Ioana Risteiu wrote:
> Refactor probe function by moving the initialization specific to
> communication without iio-backend into a separate setup function.
> 
> The purpose of this modification is better code organization. No
> functional changes intended.

...

> +	if (ret)
> +		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> +					st->spi->irq);

Something went wrong with the indentation.

...

> +	ret = ad7779_setup_without_backend(st, indio_dev);

>  

Now we have redundant blank line here, please remove it.

>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko



