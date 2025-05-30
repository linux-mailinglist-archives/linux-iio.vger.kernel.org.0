Return-Path: <linux-iio+bounces-20054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8AAAC953C
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6461C081AE
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E727585E;
	Fri, 30 May 2025 17:49:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D62367CB;
	Fri, 30 May 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627366; cv=none; b=bYGUQYzI9gjOFv7Ix3Qz4A43h78Gvgpa4LwlPtP1cVrQPxYNHJc+1T0Nyb6gam7IgKwADAt76Vxbr5VnKVrANkN9ATM5KpfHfMGagUSUGpD7r9EiS/hNjBoKk05tsm9RuoPi7ZzIqThRVDcZeeBSmMaT6PEi0OvFxAppFX6EePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627366; c=relaxed/simple;
	bh=hxRWWOaBYp6tiVYo7uluS1eq98GxxBbeDU9cg7wTn6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6lVE98Mmn/f82GF+p8HEK2JFm81Gj/f9SFHrVVsIfKkqdnkbZUD1JTPlbVkmA+ZeFjiCkO36PYvkYNyfUOHpnk2p5UTyL/JxYn2bYypNG8L4ErFn7kb4dWiFRNJ1s6FytJEYgyDB3ZVE4bUkgqoA+iAiD20253k3e8r7WkU3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: x4XEobw2RTmePI/Hq56d6Q==
X-CSE-MsgGUID: C06xsM31Ta+d8MeuKRJtKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49848350"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49848350"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:49:25 -0700
X-CSE-ConnectionGUID: 2zB/LkoLQsegjlKjPUVX4Q==
X-CSE-MsgGUID: LX32MatAQjq41TRkJBXwZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144917079"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:49:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uL3r2-000000024ZU-3t10;
	Fri, 30 May 2025 20:49:16 +0300
Date: Fri, 30 May 2025 20:49:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	rafael@kernel.org, djrscally@gmail.com
Subject: Re: [PATCH v9 00/12] iio: adc: ad7768-1: Add features, improvements,
 and fixes
Message-ID: <aDnvnMqPd-Ahu5o6@smile.fi.intel.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 29, 2025 at 07:47:57PM -0300, Jonathan Santos wrote:
> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver. 
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage output
> configuration and GPIO support. Additionally, this includes fixes 
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.

If you haven't run `make W=1 ...` build against this driver, do it with
GCC and clang and fix all respective compilation warnings / errors,
if any.

-- 
With Best Regards,
Andy Shevchenko



