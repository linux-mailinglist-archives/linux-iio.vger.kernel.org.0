Return-Path: <linux-iio+bounces-20154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1838ACB742
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97C3A275AA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FF23A9B4;
	Mon,  2 Jun 2025 15:01:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE952233136;
	Mon,  2 Jun 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876491; cv=none; b=MmfAlj9BbUssMZEVjophdJal7EBr0zO6/jQyD0uwooQdPzOXsZek92p9F8Lc5z95ooxl+avnF7uWR/xNgYgeMhmEL08G2JMFqpnwhYq2Oa+RQ3sQJkma94WGzjTJHdU8pWtY5ijph21ozOF/0fTe0O1UzHE+mnZZzVk+1a9H8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876491; c=relaxed/simple;
	bh=tpOK624e+VTSX3n/OcsDokeXGPakaWTK0Udf8DGKI6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM/03B9lTxYdFRIOvAfswYRJw0LlG6Am0H077uF/1kxIG6YBe/a1MBCdWlLcoI+qQ1aOQaNXz+TKKy8TqdTm1Aov5Z1KNBVvl132a/+xmvxEZ20anri36hRPHhElrI66My+yVgp6OMGJTfCyJa9SM0nUjyHG3d16DiEAH4/qw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: BVT7rMQdSWSWb1BYmTzf2w==
X-CSE-MsgGUID: fLXANDqKS6q6icpe6KqhVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54688548"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="54688548"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:01:28 -0700
X-CSE-ConnectionGUID: ZcLap1ASST+LqDjBQnDOjA==
X-CSE-MsgGUID: vM00wISZTJ+FV2BHc9oH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="144518826"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:01:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uM6f8-00000002sG3-3t5Q;
	Mon, 02 Jun 2025 18:01:18 +0300
Date: Mon, 2 Jun 2025 18:01:18 +0300
From: Andy Shevchenko <andy@kernel.org>
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
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <aD28vs2_NA1jyPCE@smile.fi.intel.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
 <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 04:43:43PM +0300, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.

...

> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +#include <linux/mutex.h>

You need to follow IFYU (Include What You Use) principle, at a glance there are
a few missing. Also make them ordered. I guess I have commented on this already
and my comment was ignored for no reason.

-- 
With Best Regards,
Andy Shevchenko



