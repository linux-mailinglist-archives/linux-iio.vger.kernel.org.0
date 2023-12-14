Return-Path: <linux-iio+bounces-925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B1813381
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B62F1F220B9
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9085B204;
	Thu, 14 Dec 2023 14:47:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3094116;
	Thu, 14 Dec 2023 06:47:39 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="13822066"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="13822066"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021526074"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021526074"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:47:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rDmzp-00000005s1e-3AHo;
	Thu, 14 Dec 2023 16:47:29 +0200
Date: Thu, 14 Dec 2023 16:47:29 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZXsVgVzcK6Om4td_@smile.fi.intel.com>
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <20231212104451.22522-2-mitrutzceclan@gmail.com>
 <20231214123029.000002f1@Huawei.com>
 <375bf803-a5d5-4778-938a-b8218b116375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375bf803-a5d5-4778-938a-b8218b116375@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 02:57:35PM +0200, Ceclan Dumitru wrote:
> On 12/14/23 14:30, Jonathan Cameron wrote:
> > On Tue, 12 Dec 2023 12:44:36 +0200
> > Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

...

> >> +		ret = fwnode_property_match_property_string(child,
> >> +							    "adi,reference-select",
> >> +							    ad7173_ref_sel_str,
> >> +							    ARRAY_SIZE(ad7173_ref_sel_str));

> >> +

Redundant blank line.

> >> +		if (ret < 0)
> >> +			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> >> +		else
> >> +			ref_sel = ret;
> > Simpler pattern for properties with a default is not to check the error code.
> > 
> > 		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> > 
> > 		fwnode_property_match_property_String(child, ...
> > 
> > so only if it succeeds is the value overridden.
> 
> Where exactly would the value be overridden, the function does not have an
> argument passed for the found index. The function is written to return either
> the found index or a negative error.
> 
> The proposed pattern would just ignore the returned index and would always
> leave ref_sel to default. Am I missing something?
> 
> I can see in the thread where it was introduced that you proposed:
> "Looking at the usecases I wonder if it would be better to pass in
> an unsigned int *ret which is only updated on a match?"
> 
> But on the iio togreg branch that was suggested I could the function on, it
> does not have that parameter.

Yeah, with the current API we can have one check (no 'else' branch):

		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
		ret = ...
		if (ret >= 0)
			ref_sel = ret;

But your approach is good to me.

...

It's always possible to change prototype, and now of course is the best time
as all the users are provided in the single tree. That said, patches are
welcome if this is what we want. (My proposal was to return index in case of
no error, but at the same time leave it in the returned code, so it will be
aligned with other match functions of fwnode.

But this in either way will complicate the implementation. And I don't find
critical to have if-else in each caller as some of them may do something
different on the error case, when option is mandatory. In such cases we
usually don't provide output if we know that an error condition occurs.

-- 
With Best Regards,
Andy Shevchenko



