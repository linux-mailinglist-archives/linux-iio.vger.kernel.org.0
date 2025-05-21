Return-Path: <linux-iio+bounces-19765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F3ABEF85
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7987A3528
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278923C513;
	Wed, 21 May 2025 09:21:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49380221549;
	Wed, 21 May 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819318; cv=none; b=FvPnwsnvWkfMLrdIaLp9TKXNNRYxCBWpHZC/xOQsB+vRkQrEj8kYoxf5uXkDRF4hJSU0K7XGCBRasRr7/Pg2KBoo78ZjlZ7rMG1Fhoz2e98kuvnwhCQcDu5QKQENWtI+i9uflcZ997SBFhfMKByVANzBhtHiUGSlbbC2dmC6Qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819318; c=relaxed/simple;
	bh=cG2It/o5K1guofgcqdeku8OVjfaZZB5/SW3spEARnt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgissw5NMNJANzNfxAt4ioCP4Xae6jMgkqb0RVgquALQ/bZgJb5LeMHO6K4TBhNjpzDjz+X6P0GcpTMtcdtQElwM/yAxlv32Cr1qf3do05NG0p1wnlMCc4hO43UyGIhVCzOCJj9pKnAkrqsl9QVtx2DRuA7s9Mjg820FwtnSA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: rBwTygqwQna1pwGSd1QVuQ==
X-CSE-MsgGUID: ZCyaXk9rSEep0CHEKfv9aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49047727"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49047727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:21:55 -0700
X-CSE-ConnectionGUID: efxh/olVQzaksKAyqTKUQw==
X-CSE-MsgGUID: YnYAIHTIRpyaZWzogC1ncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="143977678"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:21:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uHfe2-00000003ZRl-1SSp;
	Wed, 21 May 2025 12:21:50 +0300
Date: Wed, 21 May 2025 12:21:50 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <aC2bLrxMP2DhY4go@smile.fi.intel.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
 <20250520225007.10990-10-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520225007.10990-10-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 20, 2025 at 10:50:04PM +0000, Lothar Rubusch wrote:
> Add possibilities to set a threshold for activity sensing. Extend the
> interrupt handler to process activity interrupts. Provide functions to set
> the activity threshold and to enable/disable activity sensing. Further add
> a fake channel for having x, y and z axis anded on the iio channel.
> 
> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.

...

> +	int axis_en, int_en, ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
> +	if (ret)
> +		return ret;

> +	/* Check if axis for activity are enabled */
> +	if (type == ADXL313_ACTIVITY)
> +		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +	else

Probably redundant 'else'. Wouldn't

	if (!=)
		return 0;

work?

> +		return 0;

> +	/* The axis are enabled, now check if specific interrupt is enabled */
> +	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;

> +	int_en = adxl313_act_int_reg[type] & regval;
> +
> +	return axis_en && int_en;

With the above these lines become:

	if (FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl) == 0)
		return 0;

	return !!(adxl313_act_int_reg[type] & regval);

...

> +	ret = regmap_update_bits(data->regmap,
> +				 ADXL313_REG_ACT_INACT_CTL,
> +				 axis_ctrl,
> +				 cmd_en ? 0xff : 0x00);

Please, utilize given space. You have a lot of it in each line above.

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko



