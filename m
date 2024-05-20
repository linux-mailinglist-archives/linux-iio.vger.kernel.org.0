Return-Path: <linux-iio+bounces-5143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69668C9D36
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D7F1F2295B
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59D548F7;
	Mon, 20 May 2024 12:28:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98452F74;
	Mon, 20 May 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208111; cv=none; b=YZlis2JFumhiR28NWSaRMtpQsZl6eWt4Bbray9thxNVB2uSAOysFoYfgwHpQ7jerLbAX8PcvdJaaWiHzBsmcCcFXaAeFVUnBqytnPRzF9Im0bYZ5Phcox6aojC2ZpzQ4IZojiCip7LvL755qTSn2jfXReLnI1DA9Gjr/oiT8egQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208111; c=relaxed/simple;
	bh=DkqAL50gnzYir27kCMGH/h7sSOH1ub09LFffmBQUdO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rORy1JNXRUA89Lt6Zhv2KND3r1E4lovS8lUgPtJuDO2KVmdlyFJZnGnoXk0xkMFxTrF5q0tTgc2RZnCj62CuQK0+2UYRgu0AHbWbWAMI1Hdze4SivoXOEQN4MQKwE5vxwLfYvplo/9DCJdaFGidlAEMM3CWUNzs71LY0vFCEjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: sNVZUuZjSIGJcSWpt0rylA==
X-CSE-MsgGUID: sFHILEtmRWWc7phETtH4kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12173833"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12173833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:28:29 -0700
X-CSE-ConnectionGUID: c/c9dzA/S2uh2zFa8+jVPg==
X-CSE-MsgGUID: E72YPrkWS12Cz7fB//pIJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="63348935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:28:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s927o-00000009JGn-3cMi;
	Mon, 20 May 2024 15:28:20 +0300
Date: Mon, 20 May 2024 15:28:20 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, michael.hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
	marcelo.schmitt@analog.com, bigunclemax@gmail.com,
	dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
	alisa.roman@analog.com, marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <ZktB5Ex5oQ2E45QR@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-7-alisa.roman@analog.com>
 <ZkNijKz0N7PPvmeU@smile.fi.intel.com>
 <20240519190304.4d93530a@jic23-huawei>
 <34c21023-441f-44e4-a427-f3e2bb2f5c15@gmail.com>
 <20240520132030.00000838@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520132030.00000838@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 01:20:30PM +0100, Jonathan Cameron wrote:
> On Sun, 19 May 2024 22:37:58 +0300
> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> > On 19.05.2024 21:03, Jonathan Cameron wrote:

...

> > +static bool ad7194_validate_ain_channel(struct device *dev, u32 ain)
> > +{
> > +	return in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR);
> > +}
> > And the negation got lost here.
> 
> Ouch :( 

And negation most likely should be on the caller's side.

-- 
With Best Regards,
Andy Shevchenko



