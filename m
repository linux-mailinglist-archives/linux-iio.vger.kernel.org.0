Return-Path: <linux-iio+bounces-20444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3884AD5A28
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA411E4BC8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86011B0421;
	Wed, 11 Jun 2025 15:15:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E310A3E;
	Wed, 11 Jun 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654926; cv=none; b=aG0WkVrc4bhToah/IRMegBjE4Ir9xPEHS4OeBPpwmvj0OtLP/TLtXvnruYU+jVGCJE0P6f1qo3xHETVQ2nfX2eEtjk2xm8cHRE3KrBL5eaY330na7KTzQUdFZuGWFpbZWjx+66wyncYeybDPiF3An5QyN33j0JADvuweZ4De2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654926; c=relaxed/simple;
	bh=Xra69tmZS3fpjJeBgHc+1iBGy9hoV7GWfvRxN9zoVv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImXv1IUVRbo4VElkRTKu32g4Ph1MaqPfw0qYiu9SI3DQ4W9k5apFlNicwtsM1D5WHtdEOVIwN3kF0GHx76yZBph32dXKs+t9A2Z7raalINqzE2pFTzU7JTZkV00aV3JNhpr710P24pwm8sSEHTeYtDTqVLHiSu1P0Pyq+NOnP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: G542xsPTTw2gO9RUH7Pr9w==
X-CSE-MsgGUID: CfArInyYQo6B/diLnnB29Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62083977"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="62083977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:15:25 -0700
X-CSE-ConnectionGUID: RqDJS5oZTUGG50MctG74ug==
X-CSE-MsgGUID: aX1+3EfSR7K7nKqxctsySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="184428915"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:15:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uPNAb-00000005gIz-18f5;
	Wed, 11 Jun 2025 18:15:17 +0300
Date: Wed, 11 Jun 2025 18:15:17 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Da Xue <da@libre.computer>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
Message-ID: <aEmdhV0ATRuUeGaL@smile.fi.intel.com>
References: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 10:04:58AM -0500, David Lechner wrote:
> Use spi_is_bpw_supported() instead of directly accessing spi->controller
> ->bits_per_word_mask. bits_per_word_mask may be 0, which implies that
> 8-bits-per-word is supported. spi_is_bpw_supported() takes this into
> account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.

> Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/

Reported-by yourself. I'm wondering if the Closes adds a value in this case.
Otherwise I can do the same to maybe 10% of my patches, for instance. But
I don't think I put Closes tag on whatever improvement potential bug fix
I do report (read: notice) myself.

> Signed-off-by: David Lechner <dlechner@baylibre.com>

Code wise LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



