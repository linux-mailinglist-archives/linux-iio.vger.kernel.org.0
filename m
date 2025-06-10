Return-Path: <linux-iio+bounces-20385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECFAD449D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE84189CCF7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6928314A;
	Tue, 10 Jun 2025 21:17:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E610265CB0;
	Tue, 10 Jun 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590276; cv=none; b=kwiEaZExhNuKn6ZwNYzT1MTJLBpd5/yg9MfjaHM7g+O8kApL+fhXc5K1Hm9EBIKE5/25wDOeNHArI/vux/auZyMlEwcnevTNumjEgsuvgXu8oy9koBbPftRGNyGeCweeKhhVs+S/ELoFW5LQFQB9dPVXBdyDPiN28jJkPPWHh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590276; c=relaxed/simple;
	bh=eamKRgaYxAXQ07Oy/QgqWcISiwbzjUAkHbWUL2iYvQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL6sopVmeMwLI1H+zr36ZxgV040O4JPX3+f4a+b71aghatEEpbKLkNE3p6KIOkz6G+s0somF/u1a2joEaMAULc3Bbyv312dNuHxpOoXs2oTYQzIbMWrT3JUYY2TmF421IZWS28sxatSdgwgme5ORjygJVFE/SMHPGrKt9tVdg+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: EZ2bM47zTHqG73QoNjbdEg==
X-CSE-MsgGUID: 88GGSAUoRpm/YHbbdubbhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51428641"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="51428641"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:17:54 -0700
X-CSE-ConnectionGUID: 1y60cC8FTHuqF3DnjwJsnA==
X-CSE-MsgGUID: JFEqMThxSUuDOrHR7whurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="147898138"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:17:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uP6Lq-00000005SHX-32Ai;
	Wed, 11 Jun 2025 00:17:46 +0300
Date: Wed, 11 Jun 2025 00:17:46 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 06/11] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <aEig-gz5_fTEheiW@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <4dc5e8b4878f6442cb2ad80c1695c859daf19d47.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc5e8b4878f6442cb2ad80c1695c859daf19d47.1749582679.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 05:32:43PM -0300, Marcelo Schmitt wrote:
> Extend the AD4170 driver to allow buffered data capture in continuous read
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks if the aforementioned
> condition is met.

...

> +static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	unsigned int masklength = iio_get_masklength(indio_dev);
> +
> +	/*
> +	 * The channel sequencer cycles through the enabled channels in
> +	 * sequential order, from channel 0 to channel 15, bypassing disabled
> +	 * channels. When more than one channel is enabled, channel 0 must
> +	 * always be enabled. See datasheet channel_en register description at
> +	 * page 95.
> +	 */
> +	if (bitmap_weight(scan_mask, masklength) > 1)
> +		return test_bit(0, scan_mask);
> +
> +	return bitmap_weight(scan_mask, masklength) == 1;

Hopefully compiler is smart enough to see the two calls for the same which
can't be modified on the fly, but it definitely can't assume that the
mask is one word long, meaning the bitmap API will choose the slow path
for them. I would rather take a temporary variable approach.

It also minimizes the risk of race conditions in case something changes the
data beneath (which is quite a nasty situation to begin with).

> +}

-- 
With Best Regards,
Andy Shevchenko



