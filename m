Return-Path: <linux-iio+bounces-655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20180611F
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 22:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05AE1F211F7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D556FCE8;
	Tue,  5 Dec 2023 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABBWAVA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCDBD3;
	Tue,  5 Dec 2023 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701813486; x=1733349486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmgNkHBF0/cbJizp8pAUjxzxghNb6XzJWYSo4FRAuCg=;
  b=ABBWAVA2a54Jm7QJ8ELIG3pgnuMyNAPqmVM0mPSAljyYW6Zh5n4VFkMq
   92a02z7zRQJ8IqF+gkcQ4hL9rPD2F+HHX1n9L9xebz4+WLB2Cm5ic0oMD
   I9ElY6rzqQSY9WZ3+r8ha0LAtcq/ePZHIcx9lVa4805JmWebyUny2cSIm
   qNaqmAuMq7OadT7wdBY1Xb567YmtRvyHMQlrQb3cQPN2+0/ilBh3sqgZ+
   m+KDWLCsCy9A1p0fWSmMiMu1QrQiK+r/7ZrbfM0OMOT+liznAYpsg4P81
   d1Er79xI4kRaEUznyUr7XO49CL+WuBh6f626sle3keGzrcT9Ye85OzQmj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="458283461"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="458283461"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800115628"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800115628"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:58:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rAdQS-00000002Bzt-0K94;
	Tue, 05 Dec 2023 23:57:56 +0200
Date: Tue, 5 Dec 2023 23:57:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZW-c44H84hZPNWl-@smile.fi.intel.com>
References: <20231127212726.77707-1-marex@denx.de>
 <20231127212726.77707-2-marex@denx.de>
 <20231204112941.770e22cb@jic23-huawei>
 <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
 <ZW9Hwm5LnPGl4Ird@smile.fi.intel.com>
 <62015c87-cc24-4ab6-9c91-605926f1c572@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62015c87-cc24-4ab6-9c91-605926f1c572@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 10:02:32PM +0100, Marek Vasut wrote:
> On 12/5/23 16:54, Andy Shevchenko wrote:
> > On Tue, Dec 05, 2023 at 02:43:30AM +0100, Marek Vasut wrote:

...

> > ...unit .
> >
> > (Do not forget to drop extra space)
> 
> Which extra space ?

Like in your question :-)
(I left the only relevant context, easy to notice.)

-- 
With Best Regards,
Andy Shevchenko



