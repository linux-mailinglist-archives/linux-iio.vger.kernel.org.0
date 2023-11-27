Return-Path: <linux-iio+bounces-434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000797FA5CB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE37E281629
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190D358B8;
	Mon, 27 Nov 2023 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1wVtV86"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4464BF;
	Mon, 27 Nov 2023 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701101524; x=1732637524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L5Nh0J7pr2eaq1VaPfLcwfJ9RZ8uE+ltNZ6bZoFnWM4=;
  b=n1wVtV866gKCORCBaP5DGgberFvnFRsQnUzOVJiFWYyTlEBBPPyYYBJF
   glBKHZW7Slobe3naO5VgExbK4covIkTT/ZnN8WSeT8aXW5N4SI/lKK7Wk
   eAUreY9jpTzWAMTOKgLOiRkX3f0eMexFnM4p30JgJXi6urT7TijYlGK3t
   3HmTON+eszGnl+lM+fpJUEluITPZUUEc3ngFa5oMUJC+xTfuagJsrs/Ep
   cRKQKbM9b8zTNHSX8Zqo9Bn2R2QOlZlyW9i0LPodT6K/hVZGtovEIkv9p
   ptJE7k1FkQo4Sd+5L/cxVraledRqQ8LPgdnppvJsIIx8m4xfCeSFOIVPp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383120458"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="383120458"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761634313"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="761634313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:11:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r7eDC-0000000HYGi-1uH6;
	Mon, 27 Nov 2023 18:11:54 +0200
Date: Mon, 27 Nov 2023 18:11:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Dr.-Ing. Andre Werner" <andre.werner@systec-electronic.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZWS_yjBT7XInXKA3@smile.fi.intel.com>
References: <20231125222738.97875-1-marex@denx.de>
 <20231125222738.97875-2-marex@denx.de>
 <907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 26, 2023 at 08:33:26PM +0100, Dr.-Ing. Andre Werner wrote:
> Dear Marek,
> 
> see remarks below.

Do not top-post!
Do not overquote hundreds of lines just for a single comment!

-- 
With Best Regards,
Andy Shevchenko



