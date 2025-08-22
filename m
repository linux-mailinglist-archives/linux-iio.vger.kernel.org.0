Return-Path: <linux-iio+bounces-23139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD01B3143E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C33C1D20DDE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF62EE29D;
	Fri, 22 Aug 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOt7Sl4F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD02EE286;
	Fri, 22 Aug 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855691; cv=none; b=gTbsDV+00uz5fW6UsSs040Mk+66xnuItKft/m1sKn15uRYvnsMUBhupWiaa4DHJme2FjP46OG19SHuTmfTfsDiE6jImXtuq57aDLwsETLxup4SDhdWiXeMchKM5PdIP3QOGGi4FXEQ1SnmMNFQXG8IUmdO2yPBvitAia2GAkUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855691; c=relaxed/simple;
	bh=RZKftV/2n/t5kgoSakypDVxhxqhMEzE7Gy6hWmya91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuQLzquTWRKFcefRmTSe8eplSCJlnNB0LiiLrqJgmpG9QpaV7EqvM1Yu4wda8JrZbbZFLIFsthH0vNL2PVav3S8R8BehdqamYNDGjzKF/YnpxTA0IMi929rcSliZ80uRaml7sGbMKNHE2biYE9QIDvqbvMO41mSZVp+CzXycQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOt7Sl4F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855690; x=1787391690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZKftV/2n/t5kgoSakypDVxhxqhMEzE7Gy6hWmya91U=;
  b=QOt7Sl4FI+/gwek72VSCovIXtpyoAvoI4WB4gykS6kQ4F24vtqS7Zg85
   QZpNqVLfEe8A6KvtM9d/1nZZIKDKQuvA+fNktetqtT3YfSvyvL/vKRjsP
   RYbR9NrFQKYHsy07RASi5N9SuxYh+oIIWxY52pcadXQZR5J4ufzU1YvST
   RwP4hVick6vrl9YRj/nuO2zXf/NeCNMWnOIpCQiXusFTHKuVhyjHnsBoh
   cWtp6konsYLNC17SG4qfCbMmCxTMaGOfJ8LbDfGKH4SEFoUbZKyGXXxrD
   vMREkU2r7dqCQsa/wlzaE/A79HmcTXU2dBi4/M1vs3WXK4qbsiZZdGT3J
   g==;
X-CSE-ConnectionGUID: GLEIF0/8QW6sLS9Ocwwf3w==
X-CSE-MsgGUID: T87sE9eFTj2jZk1r1+7Jzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61994838"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61994838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:41:29 -0700
X-CSE-ConnectionGUID: 7dUmcja+THqiuGqu0CivaA==
X-CSE-MsgGUID: 0REQ5MhYReu1rNaxxngBzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172857947"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:41:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1upOGs-00000007To4-2PQ4;
	Fri, 22 Aug 2025 12:41:18 +0300
Date: Fri, 22 Aug 2025 12:41:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 02/10] iio: adc: Drop unnecessary -ENOMEM messages
Message-ID: <aKg7Ptj4jy4Icvgo@smile.fi.intel.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
 <20250822-enomam_logs-v1-2-db87f2974552@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-enomam_logs-v1-2-db87f2974552@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 22, 2025 at 09:19:50AM +0530, Dixit Parmar wrote:
> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().

...

>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ddata));
> -	if (!indio_dev) {
> -		dev_err(&pdev->dev, "failed to allocate iio device\n");
> -
> +	if (!indio_dev)
>  		return -ENOMEM;
> -	}
> +
>  	ddata = iio_priv(indio_dev);
>  	ddata->ato = device_get_match_data(&pdev->dev);
>  	if (!ddata->ato)

Looking at this hunk I'm wondering if you are using --histogram diff algo when
preparing patches. If not, please do for the next version.

-- 
With Best Regards,
Andy Shevchenko



