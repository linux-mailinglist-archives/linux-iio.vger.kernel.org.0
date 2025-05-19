Return-Path: <linux-iio+bounces-19666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E9ABBCE8
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B763E3AAB71
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408DA274FD5;
	Mon, 19 May 2025 11:48:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883501925AB;
	Mon, 19 May 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655333; cv=none; b=W6+Bz1Qq8QAbxHUs07ZxVddzqW5bZ5JDKAcPLnEykMIHqrLQOLMdy2EYSbtcyuMiR0In34divDNM+1vTYBwuGB/XN7TCVvNoeBIvLLcgP2StOv6xG4U/4H3joauBHj+p6Zol5PqAGzvZxNdNaObx8FaVQKPeBENTI8zEvkn/sF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655333; c=relaxed/simple;
	bh=259YgTAgujkk0sSgdsunp3RGNblXRO7BV0CwSa+4ccQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEuU6iWXSC13PfvTvzwlZclVaicrWGfGPRtat7dEZP/a0o9LQodkotIuZbDDagnRQtSlv+l5uiWuNBha1DhUt5hrh1rnEV9KfErTBDWIfwQJAXZzDmUd862MYAr5MZWYzzBxfxLawt1Qefpei9cZi/FxsoOa9ycszS4+qrsmgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xGpff4MFQOi8MiDByTLf9w==
X-CSE-MsgGUID: Y8rNP6H9QiqL2o/+XpTKGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="53224049"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53224049"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:48:51 -0700
X-CSE-ConnectionGUID: Q67spwoPT7atR9G09oGenQ==
X-CSE-MsgGUID: rsDLRLbpTzSjVohdTcYmLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="162636795"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:48:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGyz7-000000031S7-3YFU;
	Mon, 19 May 2025 14:48:45 +0300
Date: Mon, 19 May 2025 14:48:45 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/12] iio: accel: adxl313: prepare interrupt handling
Message-ID: <aCsanRq9xYvSIYVR@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-7-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:15AM +0000, Lothar Rubusch wrote:
> Evaluate the devicetree property for an optional interrupt line, and
> configure the interrupt mapping accordingly. When no interrupt line
> is defined in the devicetree, keep the FIFO in bypass mode as before.

...

> +#define ADXL313_INT_NONE			0

Hmm... I would rather make it U8_MAX, but it's up to you.

> +#define ADXL313_INT1				1
> +#define ADXL313_INT2				2

...

> +		/* FIFO_STREAM mode */
> +		regval = int_line == ADXL313_INT2 ?  0xff : 0;

One space too many.

> +		ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);

Don't you want to use regmap_assign_bits() or something like this to have
the above ternary be included?

> +		if (ret)
> +			return ret;

-- 
With Best Regards,
Andy Shevchenko



