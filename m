Return-Path: <linux-iio+bounces-638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A518480592D
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5336B20F29
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB268EBB;
	Tue,  5 Dec 2023 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZYJE74i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661F194;
	Tue,  5 Dec 2023 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701791692; x=1733327692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qz2x4Irj/nbMAhPFLu+qAvZ6QslY2QGofqktzf7KUEs=;
  b=LZYJE74iOzDHFcYDRS8rQmaxYF1Y0eXhnErmIHotRp0tCJDTd8qXDtcp
   Ct3RmRidklagWD7Y4LvWVPnqjxnyYpvBy3/4THmRZ363ukH1gaYnxa7X5
   I9y7FR8TYEteKDhud/x/SRYCjTTeaj1TRkBzzA1DonPPyZoqgGZ93aAoK
   yobHXTKjwBoVI8W11KlVizwWpsK0uAyCdi0A+mocLint6Vtnxz9qG3C8U
   VJLE5Chb0DwoTQNhdvdw1GuHcGFqu19xmVXbnoAoNln31gwbanXXhAyWY
   kKZcRsXwb988bDrIB3IH4alTR/9ozC10TdMDtMbQhdPEyeerdqx2u53xd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7259334"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7259334"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="861786051"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="861786051"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:54:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rAXkw-000000024qO-2eyL;
	Tue, 05 Dec 2023 17:54:42 +0200
Date: Tue, 5 Dec 2023 17:54:42 +0200
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
Message-ID: <ZW9Hwm5LnPGl4Ird@smile.fi.intel.com>
References: <20231127212726.77707-1-marex@denx.de>
 <20231127212726.77707-2-marex@denx.de>
 <20231204112941.770e22cb@jic23-huawei>
 <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 02:43:30AM +0100, Marek Vasut wrote:
> On 12/4/23 12:29, Jonathan Cameron wrote:
> > On Mon, 27 Nov 2023 22:26:53 +0100
> > Marek Vasut <marex@denx.de> wrote:

...

>                 If a discrete set of scale values is available, they
> -               are listed in this attribute.
> +               are listed in this attribute. Unlike illumination,
> +               multiplying intensity by intensity_scale does not
> +               yield value with any standardized unit .

(Do not forget to drop extra space)

-- 
With Best Regards,
Andy Shevchenko



