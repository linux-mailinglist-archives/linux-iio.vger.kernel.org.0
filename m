Return-Path: <linux-iio+bounces-20212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C0ACE183
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4067ACE9B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4E1A2393;
	Wed,  4 Jun 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7+i+946"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323A18B47E;
	Wed,  4 Jun 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050803; cv=none; b=mB+q9UMvOAu0y9YyFb1XHvs+vGKuEWOcfqpTewutmoqY/hku9HuCwETNpUZ7AqRepV5FCd/maz55m9lYExlsRX3QAPIUNaka+UXaA+JU/iVnb3AKnyj1gcU01jvc0SAP0YPYRAI9n5qWpoYGBzuzsU8b+EFieSWCcCJ/9tzF7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050803; c=relaxed/simple;
	bh=Oh8DXHV7AOdcNq84qhmXKNanG55G45tVRqaWXhrjhjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK9b2gRYAIFNj+pBf3u9OGsFqk68kWcv6rj3AUIPU5x+hOImeGzS8cu+IIrlxz/46DUi29voqO/fd8T5SoRBFVlNvMMKDGwEmN92r8/5GVGly8K9x/61OOVnc0Ae1WPqZaILVXv4QAezkprGTGHUYPeWiIKkAS787AkWCnkBHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7+i+946; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749050802; x=1780586802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Oh8DXHV7AOdcNq84qhmXKNanG55G45tVRqaWXhrjhjA=;
  b=k7+i+9460YyC7xnNKKOY+Vu1tVsV1uF3wQYQDWydiFAtcjM5xhb/pk93
   4FOIvk9abLbdkIn7Jb1zgF3oHE20Pndp2kByi+nndluggR7lHR+ky1czC
   Xy7jF47eNIZQM3RKC+K3vZ98KTXvYxD9TMgg3acW05bjmcJ+XYW1Xmifc
   DcpvUL15QV58OnPVt7MNrlPWZZXma/NP6Q5Mr3BhajP/5NVgXuaEzL8o9
   C63pbqSqV1IENU6rf4JE27fmgEYr5Ch5qSu1r93wKbEXUy6m6QSRzDcSD
   4mYoxSsucGcqZaj/+LguFqyA3yCdCl67DAi2xgaaGxnyI3Vl15w8CA+Wh
   g==;
X-CSE-ConnectionGUID: sMx/LoGoTEe3/CfhBphkww==
X-CSE-MsgGUID: cfmWisK7RKegq+BkUJN7KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50255997"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="50255997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:26:41 -0700
X-CSE-ConnectionGUID: m/hJNN4xS6qWugHkSbCL4A==
X-CSE-MsgGUID: nzEUE72oQYizrDPUsqdslA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145183241"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:26:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uMq0e-00000003aXx-3GkI;
	Wed, 04 Jun 2025 18:26:32 +0300
Date: Wed, 4 Jun 2025 18:26:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <aEBlqPqxd0-C7j63@smile.fi.intel.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
 <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:34:07PM +0300, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.

Hmm...
Have you seen these?

https://lore.kernel.org/linux-iio/20250602134349.1930891-1-pop.ioan-daniel@analog.com/T/#m114842887de000752231d69bc0939445b8720382

https://lore.kernel.org/linux-iio/20250602134349.1930891-1-pop.ioan-daniel@analog.com/T/#m2d90d77cd4fb1444c0c51e006b53d82ab33c27ac

-- 
With Best Regards,
Andy Shevchenko



