Return-Path: <linux-iio+bounces-18337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B407EA944AD
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D360416D7D3
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193301DE8AD;
	Sat, 19 Apr 2025 16:35:46 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607326AF3;
	Sat, 19 Apr 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080545; cv=none; b=EL5XCnTbU0fJNmwRwi3lxkVtcQdhf047dWE8Xcf4aJvNNLNvVoxVy+r3FTi34x1kPaF4V55NnkjZ6ueNoQLiBknE/Dx7EXYArt0As1y71/O2Bx6eFXMLpquqmz7sKLr0NcdwAyz0Z2fnvn+LoWCieHX6RkHb2yW56jzuL71PUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080545; c=relaxed/simple;
	bh=Ji9N54pQjsMdN4HZHYNj5wDSn8SF8Ls75uvLcHEA7wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FayOhJr9ZN6pvmxWcyr8aACc3IG0HOQ4LMkURSHKg7jVtBjgcFFgcx1wz6QWheQMlq37GTy50z+OVxM4Ju27txm3p5Fsa+qinek8Y7O/5MAhwKFCTex/rfrHaqP6DqwjoPxav+i/IOEpf3lgXMpw1baH0MM8UmcYv8II9NgCHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 7VFk9OR+Q72hDO8aH0Mwyg==
X-CSE-MsgGUID: k9VDNzSsSGGKKKw0/xcePg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="45914286"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="45914286"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:35:43 -0700
X-CSE-ConnectionGUID: LkCvwzblRz6uqFMUfRmyPA==
X-CSE-MsgGUID: CrGG22WKQSKZ3BohCzdlBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="136517067"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:35:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6BAH-0000000DrnG-3yTJ;
	Sat, 19 Apr 2025 19:35:37 +0300
Date: Sat, 19 Apr 2025 19:35:37 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <aAPQ2b5E9S1gMddP@smile.fi.intel.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:58:32PM -0500, David Lechner wrote:
> Add a new macro to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.

...

> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) \
> +		  + sizeof(s64)/ sizeof(type)] __aligned(sizeof(s64))

We have two alignments in a row in most of the cases, I would think that the
proper one is for DMA and this should not be used at all, it actually might be
a bug in bmp280.

-- 
With Best Regards,
Andy Shevchenko



