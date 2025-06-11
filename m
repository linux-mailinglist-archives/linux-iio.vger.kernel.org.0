Return-Path: <linux-iio+bounces-20445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CFAD5A47
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008E23A8393
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471851A8419;
	Wed, 11 Jun 2025 15:21:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB2170A37;
	Wed, 11 Jun 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655262; cv=none; b=XxuZsH92J2DOx7uzcfSmtvOEkcDDGXTb9ZzF7pqcYkTsm4EfzTjIz9rN675+BbFfaCFm+6cF913TdUVdek2niKvPjgkcpl2KpnrdPkCRas6CNI2fHxKeesdX59E15+2DidAjDFpM6ZYZbGKLHRD4zzp8iHNebrkSUxJW+v+Ht2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655262; c=relaxed/simple;
	bh=xaTNTPbxZsvpbqHtFS8+iQeMzvrXx92QdtUJnrQK0yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGWgEXLGYRTYfj0e5tHUFZPT0h7gChIcr9YvIn933x61LgrARxSLUaeVzFHHtgGYqV+M8Ij35UIvP+gWvawG5n7HRB1u4qI5WrqEmRCXVaeXOpETSUxiaynufBU3hgenXTyKtdO9wUsU8Vx2C1tjHPLntKwEoH5yERVKHQz4xY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: HgWc72P3S2a0aoZjpjRrPg==
X-CSE-MsgGUID: g4Tmpv+ERemjI0e/53zgmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="50910859"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="50910859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:21:00 -0700
X-CSE-ConnectionGUID: +0f4dEKlSdWXFUfamii2PQ==
X-CSE-MsgGUID: kw5hmdTHROqrJFc2sVzi3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="178134571"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:20:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uPNG1-00000005gNl-3Llj;
	Wed, 11 Jun 2025 18:20:53 +0300
Date: Wed, 11 Jun 2025 18:20:53 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 04/11] iio: accel: adxl345: simplify interrupt mapping
Message-ID: <aEme1ZmmEHmNr0Pa@smile.fi.intel.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
 <20250610215933.84795-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610215933.84795-5-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 09:59:26PM +0000, Lothar Rubusch wrote:
> Replace mapping all sensor interrupts to the corresponding interrupt
> line using regmap_assign_bits() since it takes a boolean directly.
> Further prefer the units.h identifier to cover the full register when bits
> are set.

...

> -		regval = intio ? 0xff : 0;
> -
> -		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
> +		ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_MAP,
> +					 U8_MAX, intio);

I'm wondering if GENMASK() is actually better to point out to the amount and
exact bits in the bitfield? After all this is HW register we program, right?

>  		if (ret)
>  			return ret;

-- 
With Best Regards,
Andy Shevchenko



