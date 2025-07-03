Return-Path: <linux-iio+bounces-21310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B6AF77B3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4853F4A2B7B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCD2ED169;
	Thu,  3 Jul 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im062G0a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAD2ED166;
	Thu,  3 Jul 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553410; cv=none; b=pXXqAp8PnWjT1VNntfv4Baqz4ppYOmUDqderw62JxvTNpZ7f8o4/29Md5N5OC0uwu8Fs4CAcq2Zxpv9AxGahooGf1C40MKqLLA3umhsIzJHTV0lGWEJ69N3nF6koX/K4fX5sVXGyYKSFDU15tHu0JX16x8uXPNjV+xv1tWBEktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553410; c=relaxed/simple;
	bh=rTOn1AIaO8LZCWYp7rpafEsjm051YHLR63q+OfJU+5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr8x4b6/wKOaHoOjz5H7U8hcaydpZJPBEjhP2aGubyNXqWMmRP/g4zGDqDE0Pw0/HDYPNn5qZE9XV0hJM3F4HiWsxLAneFv6wHKL2LeJwfzWyuQFKUjzJXKwsearYj+el96kSXGbXH8P/lsGYW3lmAPTeLj4iU3WNWr+1wv5cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=im062G0a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751553409; x=1783089409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rTOn1AIaO8LZCWYp7rpafEsjm051YHLR63q+OfJU+5s=;
  b=im062G0avjES6byx3cjUeeiRVHr6DreNJvWo1/PolpqhxXsASm/I/lUN
   gLWYu57mOAWoB+TJ864xFeH7S/9r8Er2R1e57FVtgC3NY3Jsaez1QDeX6
   0woNNhzHTb0CCJdLPx8AAoFu6ppMp4K71Bc2doiKRRyKwBPsXfUJrrBbs
   5SsbUsX2WL5AEvfjLX2Q8/xZYsgpMnegvgNMPgKVRISSLa++4O0v3iNrp
   tQE0OKfJZezpuCvOUZE/IZOhOdy6VQy5uxX+58C4frmLyXiBtuWfOwvg8
   Dq7GluiUix9aYRckClqGbTH9MRVpjkahrRpPytj0nibwPFe0Lh1L6Ekfr
   Q==;
X-CSE-ConnectionGUID: I76hACkmRjqCgP5uj1ZX7Q==
X-CSE-MsgGUID: iasp9O/BSMWqaz4LySW6KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53977843"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53977843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:36:48 -0700
X-CSE-ConnectionGUID: OdxT0FuBQIGz2pkz5H19WA==
X-CSE-MsgGUID: 4LAmYQlyTBOI04Bzp/lYdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="185397552"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:36:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXL3J-0000000CEFa-46sF;
	Thu, 03 Jul 2025 17:36:41 +0300
Date: Thu, 3 Jul 2025 17:36:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, bagasdotme@gmail.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
Message-ID: <aGaVeW4l6HkiMtql@smile.fi.intel.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
 <20250702230819.19353-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702230819.19353-4-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 11:08:14PM +0000, Lothar Rubusch wrote:
> Cover the following tasks:
> - Add scan_mask and scan_index to the IIO channel configuration. The
> scan_index sets up buffer usage. According to the datasheet, the ADXL313
> uses a 13-bit wide data field in full-resolution mode. Set the
> signedness, number of storage bits, and endianness accordingly.
> 
> - Parse the devicetree for an optional interrupt line and configure the
> interrupt mapping based on its presence. If no interrupt line is
> specified, keep the FIFO in bypass mode as currently implemented.
> 
> - Set up the interrupt handler. Add register access to detect and
> evaluate interrupts. Implement functions to clear status registers and
> reset the FIFO.
> 
> - Implement FIFO watermark configuration and handling. Allow the
> watermark level to be set, evaluate the corresponding interrupt, read
> the FIFO contents, and push the data to the IIO channel.

...

> +err:

The rule of thumb for naming error labels is an answer to "what does code do
when I goto $LABEL?". In other words name should encode what will be done when
goto. In this case I would make it

err_fifo_reset:

The rationale is that reading the code won't require to "goto" to understand
what 'err' means.

> +	adxl313_fifo_reset(data);
> +
> +	return IRQ_HANDLED;

-- 
With Best Regards,
Andy Shevchenko



