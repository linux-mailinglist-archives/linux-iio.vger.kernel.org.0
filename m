Return-Path: <linux-iio+bounces-8373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C5F94D378
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B8284A92
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F0198856;
	Fri,  9 Aug 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jO535wSV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF215B992;
	Fri,  9 Aug 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217339; cv=none; b=T/Hh2fSUqD3aQV+2a+f006XMHB+iCDIPT/7QpypFNFjjxr/ABQWc2CEmkG3CJzEweFaNe425ztV8FpzQJ+JU0WWNd4tDp582ukUszWuHNCa8TItsD4PRKSDWNtZ2E9/1EcFRMhJ+YIKSneEEub4u/exCWWIJe7e56X9YtPOs6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217339; c=relaxed/simple;
	bh=KsX+Kf82qQK+XJnO+x6d8UQK9IGdMWChaFfgA5l5EsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToTMgWAeaDBYLx4knJcDpRnngYKTlwtrBHc1kPB8MsTwlY4JSMY94xIhXOT3+NH65u+l24CgvQJmWH0zW0vVUk9fxzfxQPcuJhVK+8CfKOBBmJ4iSFa0BYIdRQRs2Fow6Hc4sr4yqXnETLMCoeYnwZiusbN1kSxPzb4Qpc60+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jO535wSV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723217338; x=1754753338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KsX+Kf82qQK+XJnO+x6d8UQK9IGdMWChaFfgA5l5EsU=;
  b=jO535wSVJd9gnFSs3IMeL2Ce1dvcO4XguZ0QlqXsc40Su68XlllaMpk1
   4UESAEuJS8wOxpNs4oq4XKXqDC3VATTDNnTnj7XTCH442aj1kqfYwH209
   atLE0459D5dhPI27F812y6K4ro/k59csTIOZChK8GtfU4HpGKsGP0d82j
   sYGpWz9Wz6moyWD4YPjki6gej0MykLKil6WOlF2Rr/ToY/h4ujgH8eYHE
   MLNs4IaZ9dgcn880Q6aHjZ3Wd7ohntz+YvAlJtuy60rhxbuBQppvL6GmC
   +ew1t8QrXuGJ1mvbfKO+jE48UfPTkQ4V6vgqbDdgtCuCy8wfwF6LJ0efp
   Q==;
X-CSE-ConnectionGUID: IynqNRkgQRO/djfO7gyBtA==
X-CSE-MsgGUID: ZfBTFZ/OTECdnUlE0yiVPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25163216"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25163216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:28:56 -0700
X-CSE-ConnectionGUID: 2e0XJ5hSQPWNM0euqwq0yg==
X-CSE-MsgGUID: ClDyMm98RXSdFm/l2U6R+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58313165"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:28:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRXv-0000000DSL9-2SUd;
	Fri, 09 Aug 2024 18:28:51 +0300
Date: Fri, 9 Aug 2024 18:28:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: pd.pstoykov@gmail.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <ZrY1s5fYdC3hMxjj@smile.fi.intel.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jul 02, 2024 at 04:59:09PM +0200, Petar Stoykov via B4 Relay wrote:
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.

...

+ array_size.h
+ bits.h
+ dev_printk.h
+ errno.h

> +#include <linux/i2c.h>
> +#include <linux/crc8.h>
> +#include <linux/iio/iio.h>

+ mod_devicetable.h
+ module.h

> +#include <linux/regulator/consumer.h>

+ types.h

Keep them ordered, also you may split iio/ group out

> +#include <asm/unaligned.h>

linux/*
...blank line...
asm/*
...blank line...
iio/*

...

> +struct sdp500_data {
> +	struct device *dev;
> +};

Why is this structure needed at all? You may put dev pointer directly, no?

-- 
With Best Regards,
Andy Shevchenko



