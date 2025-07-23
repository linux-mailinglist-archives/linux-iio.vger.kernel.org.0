Return-Path: <linux-iio+bounces-21903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E7B0F4E9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF547A64C2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2A29B229;
	Wed, 23 Jul 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gtmfnbug"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991C19A;
	Wed, 23 Jul 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279708; cv=none; b=h3ar+FqpGIYKjdIQ0UauVgGiGKxkL8cS4vx9kcitD76Q9Y9eqOPFo88cktYt6FStZRb3d3JEs0K1QnRi8Q6LWWz6XpPNyEGb+vxo7y76eGI5L7ACLmPRQovyy8s3kLYeswzpj7coABOUhThzQBPnF5rhTwLvMoqn6wMbyrmF0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279708; c=relaxed/simple;
	bh=92ipyn7X+SAiarW6Qmxrc7CJb/m+PUn4xpkuIA29pak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdieIegpHlx4lDNeUyl9nTnvpIwslSlOR+UZnXSZkVxMhEljQux8AaboN1ztzoIAzpVtZ8ZkKugbZboZsgk4SzAEw2yK/hr6S3oCirx73RdgcaLnwAB6lTL6nc9KP6/tdubhtlJLO5j+mq3wrV+mQpz70E5nT6Ym/XsnFCRUIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gtmfnbug; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753279707; x=1784815707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92ipyn7X+SAiarW6Qmxrc7CJb/m+PUn4xpkuIA29pak=;
  b=Gtmfnbug9zOJrquJi9YXwUu5/8NA//lT45VQrk0W64AZj+dscqFZ8ekk
   MMu9VFcm7iY/p2jYVA7PEkFFCcGbp1UqwZiU5TzBulVBXNnPAHbDW8S57
   V3gQ6iu9Bm7P8Cgm/QRZEHDUpyIgQJXnM+0787S+SSS16Z3QziO1nX5wD
   pn0WlYHptlEt5J8snTMxDVIZHZjej1YHujKatd0RyyPXh9e16fbINZ3bh
   QHahAVyN9d7mgL0MrshRhvqIUstCEDnLLV5UNnOso3BreMIV3GsebELIg
   TdmyrmcA4431xclUGxvZV5Ycywsz3FSrhgmwC6hki7qLxQTb9Q5yfMc+1
   Q==;
X-CSE-ConnectionGUID: HxP5Z8F0R0+vasjk5ZKTwA==
X-CSE-MsgGUID: ERBuY0iIR9GphK/gj8LtbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73020091"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="73020091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:08:27 -0700
X-CSE-ConnectionGUID: bINOWqH8RCKBulMfDWo3NQ==
X-CSE-MsgGUID: aNt33i6iRmWRCZVBpUlw+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="183200354"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:08:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uea8r-00000000JCf-3WGM;
	Wed, 23 Jul 2025 17:08:21 +0300
Date: Wed, 23 Jul 2025 17:08:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add debugfs register access support
Message-ID: <aIDs1bvDRyerQHAK@smile.fi.intel.com>
References: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 05:16:38PM +0530, Akshay Jindal wrote:
> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.

...

> -#define LTR390_ALS_DATA			0x0D

To avoid churn, I prefer this to stay.

> +#define LTR390_ALS_DATA_0		0x0D
> +#define LTR390_ALS_DATA_1		0x0E
> +#define LTR390_ALS_DATA_2		0x0F

Instead you can add a macro

#define LTR390_ALS_DATAx(x)		(0x0D + (x))

Same for other cases like this.

...

> +	ret = regmap_read(data->regmap, reg, readval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return regmap_read(...);

-- 
With Best Regards,
Andy Shevchenko



