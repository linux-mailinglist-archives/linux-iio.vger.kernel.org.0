Return-Path: <linux-iio+bounces-25570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF327C1405F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A01744E5B84
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A520302143;
	Tue, 28 Oct 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNJ4L9Ul"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1F23507B;
	Tue, 28 Oct 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646499; cv=none; b=IrPesmVbjOli/DaeEx9sTa+1WoQm2zuzbqdQYureQxxftFGGs2jAbL39k0fPhkYLybGXeSXDJTUkq5VbvoVV0glZRxH6vqWAHeqIT/3+5uI16Oey+THBAUF3Sq33gRc9r8vGdKo3ErP3C/nZDuT6yzC2Fe10jpshP1UjiUkgFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646499; c=relaxed/simple;
	bh=4xas4y94vi3/3tBwp2J+Ktp/jrZPl//0sQ0Xoe5S36I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COwahyOlbizxFS79DxQMFia0FHJ+7TB/L4iITwKQpkWA4QJNML2190OB0HR0ZuaonkUb8cI50shF10FFPAyDf2P+YFYc0M/wiSGuT9ae+NoJq2CwwpxnP17VAxlLrMDsPKsbGhU7VyQd1BxaBxqpIAM7QtFSq5On636XWieVHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNJ4L9Ul; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761646498; x=1793182498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4xas4y94vi3/3tBwp2J+Ktp/jrZPl//0sQ0Xoe5S36I=;
  b=UNJ4L9UlT5T2EsQF4T+SDfV+GoZE3lWl0GXyb/7rtV1Hi4EMT0L/iQtC
   5Q5BEblpwkQjmYR6KZLDPjK1KELmvL7ufZ1vLNoYv9eUln31RIVBhj7cG
   jyaA3I7sFJlXyXOHq0KvjdSXU+J7Yp9ZcdGUc7bksjzTmr8g3kC+iQkfw
   2KDik9+B0PLtPGXI+QwV7HxQgkdoJ/fPUm+5o5O38hD8xHl5yLYbDDL8y
   uaU1GNu9XB0QNwQE0Y627633mq5ihDWPl4SJqx+98xM2xtzXnNAGLThMr
   OHyhDca4yiBj7CIunJPVVnW1vebnnh6y3ioWJ8KkBZj5DOqLmFv5M0Xaf
   Q==;
X-CSE-ConnectionGUID: iC3VGzNfSkOevWOn6dKqWQ==
X-CSE-MsgGUID: HlhxQ3ICSQ+E7ZL3KPXZSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63444473"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63444473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:14:57 -0700
X-CSE-ConnectionGUID: iFQ8YCGpRB2ERMJDAZdzpg==
X-CSE-MsgGUID: 721JDO40R1+Z9Qpg7Dkeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="215964946"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:14:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDgj5-00000003HMI-2Wgx;
	Tue, 28 Oct 2025 12:14:51 +0200
Date: Tue, 28 Oct 2025 12:14:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
Message-ID: <aQCXm_rvwpB6-UUq@smile.fi.intel.com>
References: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 01:41:02PM +0800, Billy Tsai wrote:
> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---

It's a v2 and here a changelog is missing.
No need to resend, just reply with a missing piece.

-- 
With Best Regards,
Andy Shevchenko



