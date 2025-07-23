Return-Path: <linux-iio+bounces-21915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7DB0F6D8
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E83A2223
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720E2EF660;
	Wed, 23 Jul 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6mP6wHz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12572E54C3
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283716; cv=none; b=FjluK5D7x7BI11xFlK+IMZsc4l1CJtduQZu1b/ztcfys1rrWcPexGopPY9IilGew2F71vuXlVMNv6HWdzFCJyLMXQ4k81BkbYuyYUfiJvaWh0f3DT5g/DGG1MPO/V8QOHBrxi/xr3HlUhKiXwwB5goJ+QJj+i545ZGi39fYM6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283716; c=relaxed/simple;
	bh=FLzZ5KvzABasa71LJdggysxyjPpfvLvUHQMmB093YC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdBW16nM8nXEvUIM0SN89snrr4/Rve5+WV4hpbmts3+VPpzoB/yiNzXaw14SqSj3dzu8n7RGtQ2ModMKJB+vX6BFvLSR04gHe2GFXN9B5JR/HtcCBM6dJ17R9hSzPZS6adirLf6MsoarIHQjQ0uWgPa80hYAaRGwLEe9Jlakp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6mP6wHz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283715; x=1784819715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLzZ5KvzABasa71LJdggysxyjPpfvLvUHQMmB093YC8=;
  b=X6mP6wHzXSLw5nowRecplKMQUhafX3MWjE7KaiWqmu7QHc0mwoCBdaKZ
   R2Su0hNQJXIxrHE7+EDyG9Q33+vV1P75GDpzkt351j79mQoMerwtH1gBf
   DhgGcMHU18nuQduG+yiVNAqk9l+EakA4ZFKt5oIiNqHF5G4PLuvqe5bQv
   sVyMFg0ItqV/bNOMUkatRiCC1T+E0Jw1AneR61uUpTJi5odFypAOG2IhD
   QoLkwcOpStdkfil9SSO/Q3k4BG/yyMgHrxha8sv4pgjGk84g2YCUWeZdb
   WhvuXngaCwzjoNvnMr9U2XuRSCkV2QU1TfvFSZisYmzJ984YqBW8xk1kG
   g==;
X-CSE-ConnectionGUID: 9r4JZBNDQ0Kpyx1s2cYqRg==
X-CSE-MsgGUID: ru4qb9jQRjWftxFq5kdAPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55276632"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55276632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:15:14 -0700
X-CSE-ConnectionGUID: vKfmp5b9RlWa/6CQzicN7Q==
X-CSE-MsgGUID: UQunJ7GiQAO6MGIJ/NejxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163791831"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:15:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uebBV-00000000K6O-1mvd;
	Wed, 23 Jul 2025 18:15:09 +0300
Date: Wed, 23 Jul 2025 18:15:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
Message-ID: <aID8fesLq-z0c-uq@smile.fi.intel.com>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721150614.51918-2-hansg@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 05:06:13PM +0200, Hans de Goede wrote:
> Before this change iio_read_channel_processed_scale() always assumes that
> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
> IIO_VAL_INT on success.
> 
> Ignoring any fractional values from drivers which return
> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
> might become non fractional after scaling so these should be taken into
> account.
> 
> While at it also error out for IIO_VAL_* values which
> iio_read_channel_processed_scale() does not know how to handle.

...

> +		case IIO_VAL_INT_PLUS_MICRO:
> +			*val *= scale;
> +			*val += div_u64((u64)val2 * scale, 1000000LLU);

MICRO from units.h

> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			*val *= scale;
> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);

Respectively NANO.

> +			break;

-- 
With Best Regards,
Andy Shevchenko



