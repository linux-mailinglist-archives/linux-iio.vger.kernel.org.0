Return-Path: <linux-iio+bounces-19988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7DDAC6700
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B1C9E8402
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F6278145;
	Wed, 28 May 2025 10:33:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B035979;
	Wed, 28 May 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428388; cv=none; b=XPn0kgInO+YF1gE6uQ/zx9qj4a7RuWapNxtjeEZBF4AU84fz9SpW6QcIwDlRumTaITijxOuO7kfuu+axBF3DtwvRniow61oK7VbVYnHt1fpakrSot1xTbQUKSfxBwm6judzzUHOr9QsavekEaWX2BI06Vu3nnePJI/9RhHMumR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428388; c=relaxed/simple;
	bh=y0zEsHlsG2aRl5gev3bnEDneC5AhDmONPTNqoGbrqQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlWEoDzWHPuRkW0XpRS64zHvDO6wWAjKAdocbPqlFeVsFn4xKjAFX4kbNvcn4gKh8YH0H1xDMnVfDpCubAXlhb5cWnVr+KN8NlQo8v/Bb+4kOoxv/P9+VjNdh05DJeoXdKbw0cAQqUf6DeyonwVH0XQaaQPkjE56DxmhcXuVC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: SUrw+wohSDC6MylUdIfmdA==
X-CSE-MsgGUID: 6/3NdaRFSpOqRK87DUvDuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61106994"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61106994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:32:52 -0700
X-CSE-ConnectionGUID: RLj7Q9ijRpC+4K9vkmSrAg==
X-CSE-MsgGUID: iz4umwZ/SJOgIc72Sseqdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143181651"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:32:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uKE5W-00000001Pwl-0GHg;
	Wed, 28 May 2025 13:32:46 +0300
Date: Wed, 28 May 2025 13:32:45 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <aDbmTaX1d0HCx8V2@smile.fi.intel.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
 <20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 26, 2025 at 12:03:16PM +0200, Angelo Dureghello wrote:
> 
> Add new IIO "convdelay" documentation.
> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the convdelay suffix.

...

> +KernelVersion:	6.16

You need to bump to 6.17 if it's not a fix.

...

> +KernelVersion:	6.16

Ditto.


-- 
With Best Regards,
Andy Shevchenko



