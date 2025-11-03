Return-Path: <linux-iio+bounces-25822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31070C2A878
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAE33A6D73
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE432D879C;
	Mon,  3 Nov 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKdcCZ3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD623ABB0;
	Mon,  3 Nov 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157659; cv=none; b=AsfJm5TjYwCGxJHZFThCSu7M884ezbj1c3JqNw3py0fo7WS2diZxTWnjGNj3wq2SGvu1yDmUknFwG7xYBz3ZfyiPBr499alyYH/aUIt4rtuqjv5OJzHkPyCW3Vw5Iq1aUWoq8dGYbwp70R76uMT0K1Opp+SS+dwLSKybWW7coYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157659; c=relaxed/simple;
	bh=eUC7CdLY2n+Ok064KsLsxj3DXcXd7nr4SrWNiG96MhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjoDwpayvq1gBvzKYQ2mWbHJnrQRxBTcgAoBuPd07kWzFTPVL3FPn1Nm4x2B2mmmF+W8i7333tx5BKz4E0Fb8tPBQHs5GnMTpSgWhy+7U+wfLimRh5Q4G+AHQEonqRqe6/xuQTIMfLloCadfEtieYaFmZFIv0eL7nimfjtREO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKdcCZ3h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762157657; x=1793693657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUC7CdLY2n+Ok064KsLsxj3DXcXd7nr4SrWNiG96MhI=;
  b=GKdcCZ3hykFCqqjx0d5xZgRTqOvVh2YmhIJyZ77ZtG1+IG7xue1769Jv
   iVqbdaznpbH8oy+RY+36UtNZYvWCZUtIjgt8Oo+yLhobS6zNQVXxCLSA5
   q+MC7dHZp+WaVhH7hnKs9OtTU1KCK6numfhV2fNDND3M5Iy7eFeYMUf8U
   AQZOsLTqHaqHOK5CKtqh7zUrzuSJU9L8SvQ80PWiJ5APrPSENCVXHhJIV
   XYPr3bi4Ga2KewS40OQ3I/G4eqY+s0UKx0h4sbAyY3DdK/HY6jj0EQBc2
   qUSzUablhkpvtGuuJEcIU4vQqonIjcMx0c+VS7mHRLe4E6dwJtOUyT4uh
   A==;
X-CSE-ConnectionGUID: h3TKMb65TPC7s0sVTt+jHw==
X-CSE-MsgGUID: mJMnrLKTTgelXqTBjIIyHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75579235"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="75579235"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:14:09 -0800
X-CSE-ConnectionGUID: ndL/zb5NTZGkQ8kBQOxdhw==
X-CSE-MsgGUID: wc3i3tJZR1O9K3nOaBqx6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186952919"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:14:06 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFphP-000000055OO-0fwu;
	Mon, 03 Nov 2025 10:13:59 +0200
Date: Mon, 3 Nov 2025 10:13:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v9 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQhkRmtJMoB7vv8U@smile.fi.intel.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
 <20251031-i3c_ddr-v9-6-f1e523ebaf78@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-i3c_ddr-v9-6-f1e523ebaf78@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:39:18PM -0400, Frank Li wrote:
> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.

...

> - 1 -> ARRAY_SIZE()

Maybe I missed the answer, but why are the arrays to begin with?

...

> +#define MMC5633_REG_YOUT_H	0x03
> +#define MMC5633_REG_ZOUT_L	0x04
> +#define MMC5633_REG_ZOUT_H	0x05
> +#define MMC5633_REG_XOUT_2	0x06
> +#define MMC5633_REG_YOUT_2	0x07
> +#define MMC5633_REG_ZOUT_2	0x08
> +#define MMC5633_REG_TOUT	0x09

Are those _L, _H, _2 come from the datasheet?

...

> +struct mmc5633_data {
> +	struct i3c_device *i3cdev;
> +	struct mutex mutex; /* protect to finish one whole measurement */
> +	struct regmap *regmap;

Btw, have you experimented to shuffle this to put regmap to be the first
member, for example? Does it affect the binary (compiled object) size?

> +};

...

> +	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");

Missing trailing \n. Please, double check all messages for this.

...

> +	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
> +	if (ret)
> +		return ret;

Why?

...

> +	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
> +	if (ret)
> +		return ret;


Ditto.

-- 
With Best Regards,
Andy Shevchenko



