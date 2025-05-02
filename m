Return-Path: <linux-iio+bounces-18978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F2AA6E7B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736AB9C0564
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B823184A;
	Fri,  2 May 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV/vFuwm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D823182E;
	Fri,  2 May 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179570; cv=none; b=gXL5gnd19AypM6YGmLdlgNQtBIei1hIjaOEX7jKK41Qq6Ujp58NzeXevDYFsj4RVxjF9/vzeF2bZix78L/92cTntbQ/LY7dHjYRb6aAMtRzXbP4ugFvueg+xsT/a9s7mZO7BMJaKyiGrGfPLIhgmvPm7GTaPerC4MomdU1muiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179570; c=relaxed/simple;
	bh=QHN2zaWuAM7RHV7iyUCY1FWmMmQkekv0CaUHa28bOnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7DrYEi/gJ5YfBWTakcCKJdH5M4KaF+JxuaYUT9PG95xzUcW6DspujvJdAB8rXcwZJRMt0Fkq9lUYw4xn24+Q1Fyz+Lhbv2nd7jE5zwBVXnOCvXnvdBYkpP1SVB0c4yzRCsYRihsL4UKPABupMPsCmPu0ZjURj7s3aTRS86DO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XV/vFuwm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746179569; x=1777715569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHN2zaWuAM7RHV7iyUCY1FWmMmQkekv0CaUHa28bOnA=;
  b=XV/vFuwmA+3Oyep0fPXK5tZfnJw8oQESV8qV5vCijiCkedAN88YcqBab
   eUcDUQtOOd3WN1JY1TELkZXF2n0rU1zAsGjMzMJy56aqPh4psxeYv5I96
   z22Otqe97M4kZAeL9w5ipGq57ZUyFecPLUDDBXjrzER9Uoe8xO3IaOUCe
   kxF5jA6BqrAqmvP2ZpZsU6Z0iLWjwKkCNk6bXjKuWAcD1Re0CSbIkyKPt
   C3tLwBynUoMlBFOHwkmYf1+4j851dVYZzSTdzJDfLcoV5CekFhbdNRz5D
   bMQo+yNK7beUnRM+LKzr1RtVgzaHRyXJxp29TkgZjfpCOso0POUP1KZtQ
   g==;
X-CSE-ConnectionGUID: aaYaRlGwTiK+/NZ/yCUCyw==
X-CSE-MsgGUID: Sb5RMzdcSVqhOBZ0cXmNtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58527793"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58527793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:52:48 -0700
X-CSE-ConnectionGUID: UFMmxyHVTPiblVRZZnPABQ==
X-CSE-MsgGUID: ma2+lM9ZSnicgX88wMt2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="171851347"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:52:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAn4R-000000029T6-2oV8;
	Fri, 02 May 2025 12:52:39 +0300
Date: Fri, 2 May 2025 12:52:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, olivier.moysan@foss.st.com,
	gstols@baylibre.com, tgamblin@baylibre.com, alisadariana@gmail.com,
	eblanc@baylibre.com, antoniu.miclaus@analog.com,
	stefan.popa@analog.com, ramona.gradinariu@analog.com,
	herve.codina@bootlin.com, tobias.sperling@softing.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iio: adc: Add initial support for TI ADS1262
Message-ID: <aBSV56I5pYg5kgTd@smile.fi.intel.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <46659705-0384-4497-9f5d-cae4a8290093@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46659705-0384-4497-9f5d-cae4a8290093@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 01, 2025 at 01:20:51PM -0500, David Lechner wrote:
> On 5/1/25 5:00 AM, Sayyad Abid wrote:

> It looks like you managed to CC everyone who ever touched the IIO ADC makefile.
> On v2, you don't need to include quite so many. :-) Just the people listed in
> MAINTAINERS.

FWIW, one may use my "smart" script [1] that has some heuristics which appears to
be quite robust (rarely gives false positives).

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh


-- 
With Best Regards,
Andy Shevchenko



