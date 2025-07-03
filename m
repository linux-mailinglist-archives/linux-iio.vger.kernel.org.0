Return-Path: <linux-iio+bounces-21308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D50AF7774
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6413542B25
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A42EAB6A;
	Thu,  3 Jul 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TomuczjE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C62EA14C;
	Thu,  3 Jul 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552910; cv=none; b=IBZo9+4xzMt//uZnv3d87IG8xOeqKTaO2/mKyBm5F6ooht39147zfEbfNx7j5fCMeuKaTq9OmGVWVwL0Y6dNdMF7mz+KT84tjmZIZq+mZgs2uXuwgBcgXXW6aiiiHtwgH0EpWerlP9JceKWl9Fs9K2NM8kHHZijQNTp3VVRwzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552910; c=relaxed/simple;
	bh=wdOiIKGzccCM8RErNFNe99zd9fwOK9DCthug8lO8Z6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYYYx8j+kb1XUz9aPHa5eI2guR9PbnbtNxJBAxC+owXzliYxbI6d6ThFeo+CtLzzmd1Zg+G4BV1WjJAZZF+B5A7lTbc3YCZHhxokfM/xwFz1GwNcvhZBfxp8FWkYU0dX2reYonc1BXu5tznvbMa9rR+PP532y0yvX+jFYgKctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TomuczjE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751552909; x=1783088909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdOiIKGzccCM8RErNFNe99zd9fwOK9DCthug8lO8Z6o=;
  b=TomuczjE6N06gzFUz1Y5q8ArK6BMvfrTcP784+m9ytevkIKyxVKTCnuK
   oI+Dav46utCdE6xBiNyc7pTRzEg8kHfY9zUBf4ozy7nQOzpHYaNBRjNlv
   SftK4RLevUOTqf9Dt8sbqSNfwxBQffvG9zPphNplJ1CZWQpPlguezsG8m
   +fywwKNYR0yGFLqsS964ybDAPnYYYsJdwVQsMJa/7IOsyyjkT0TSsLSE+
   eFaIotJB+5HGCSoGoJcKbY0ph+DDBmxjwHi6OeUMC5nD2BeY3zLy0IPjd
   M/qiC7ZN6QYu1XEzquzZ3ow//AYyo4wIDrRS0U4SsIh+YpgXDJ5Z8LZKD
   Q==;
X-CSE-ConnectionGUID: hzCs5FeJTfSWd6po6A5Q4g==
X-CSE-MsgGUID: exA6mEo1SOiLSfoLSjL78Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76428399"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="76428399"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:28:29 -0700
X-CSE-ConnectionGUID: CYkZp2T+SbuWhmncdTXPFw==
X-CSE-MsgGUID: WO/ooU8XSsS2eIyewNFEWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154750352"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:28:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKvG-0000000CE9C-0huU;
	Thu, 03 Jul 2025 17:28:22 +0300
Date: Thu, 3 Jul 2025 17:28:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 4/6] iio: adc: mt6359: Move reference voltage to
 platform data
Message-ID: <aGaThTSAriz46D7T@smile.fi.intel.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
 <20250703141146.171431-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703141146.171431-5-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 04:11:44PM +0200, AngeloGioacchino Del Regno wrote:
> In preparation to add support for new PMICs, add a `vref_mv`

I still think that the vref_mV is a better naming.

> the AUXADC_VOLT_FULL definition.
> 
> As a consequence, the definition was also removed.

-- 
With Best Regards,
Andy Shevchenko



