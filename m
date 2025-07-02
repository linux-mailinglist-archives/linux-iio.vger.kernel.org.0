Return-Path: <linux-iio+bounces-21223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7ADAF0CDC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4B77AC8CD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316E1DF97C;
	Wed,  2 Jul 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb8oPCif"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC034CF9;
	Wed,  2 Jul 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442367; cv=none; b=M4UzwFeSIRQWz9inWcoUA7nrwuE8y192ZtwreOG3YABCC7kxuovaPBzt1EDU2mKJ+yma83sEQtR0tf1DDW1sd9AaHaVWtSGdDL+/ey9t1llLmrMl9fnj7DWUwWBeyJsaCRZ0sHGLvClm97Vq/Ehxef/whBKh+kk6a4Y1xCtw/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442367; c=relaxed/simple;
	bh=a4vRJ7yBBMjckszCtHJaOpdrMjvLtsHTDEJwGzkriUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2wPGQ3tlGA4x6NBBA7iW90pRWN7yfkUWuaeTai/Nr+PV+2NLmlI5PWOTGIdCAreoFgxVHYxqyYArfRmquE/8Qm9zJrNjo4g254a34m7+Yk/gx1RDqhA5NLLKPrf++TKIlJzS1DKoPPpqYpQGCwFmwL9RpatO7qftlQu1CE26lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb8oPCif; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751442366; x=1782978366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4vRJ7yBBMjckszCtHJaOpdrMjvLtsHTDEJwGzkriUM=;
  b=fb8oPCifAMV2QoKZ7sEn9hpiVKjj2jBa68GS3aMYdJUs76A8x72S9jNK
   52FCWPpVBfSDHPZDyHF/yH6WgnOUmaaTD226Coh2NaB6v5lOqfkIdZUU+
   ELZufGck0bZ2Y8v320tVRn0hcnjG/L5Ju2lP198K1ZGF/ekRbJgb+dsMI
   w4n7o5PFWwb/e44V605ueVvBRhCJ0ySW6m2S8qnRmoXpclVQ428did1JN
   r7BSea0b5qtYM0JDuIB+HNtuJv7vb3GmFXFwR1SqGqg/w1vsLOidJLlNA
   lW19QO70AA5YrVjPThQtL8VNdKpeWoivRr25CduogxDyDSQjI1F7L/iXu
   Q==;
X-CSE-ConnectionGUID: N8Sz7D2fQCiCNj9jZ5NpKg==
X-CSE-MsgGUID: 5WKs+2exSKePR0TkBZ69QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64420838"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64420838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 00:46:05 -0700
X-CSE-ConnectionGUID: 7tqtdGTiTrOCENnk7LWVyg==
X-CSE-MsgGUID: JlsxvKkUSTiOEbfwwBk6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154732978"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 00:46:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWsAK-0000000Br5v-0333;
	Wed, 02 Jul 2025 10:46:00 +0300
Date: Wed, 2 Jul 2025 10:45:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, conor@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel
 and avg sample before setting register
Message-ID: <aGTjt1D2VFq1WwzA@smile.fi.intel.com>
References: <20250701213728.32064-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701213728.32064-1-rodrigo.gobbi.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 06:34:05PM -0300, Rodrigo Gobbi wrote:
> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.

...

> +#define SPEAR_ADC_STATUS_CHANNEL_NUM_MASK    GENMASK(3, 1)

You have a problem with indentation.

...

> +#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK    GENMASK(8, 5)

Ditto,

...

And I don't want to check all '+' lines in your changes, please make sure your
editor, mail user agent, other tools you are using, do not mangle the patch and
setup correctly for the indentation style used in the code.

-- 
With Best Regards,
Andy Shevchenko



