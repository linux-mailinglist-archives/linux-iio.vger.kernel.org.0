Return-Path: <linux-iio+bounces-301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1677F64DB
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B60B211AF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830653FE2A;
	Thu, 23 Nov 2023 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C931BE;
	Thu, 23 Nov 2023 09:06:33 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389448692"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="389448692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 09:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796376621"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="796376621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 09:06:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1r6D9j-0000000GQ9P-1JPi;
	Thu, 23 Nov 2023 19:06:23 +0200
Date: Thu, 23 Nov 2023 19:06:23 +0200
From: Andy Shevchenko <andy@kernel.org>
To: mitrutzceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
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
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZV-Gj3boJ1LPYj5T@smile.fi.intel.com>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
 <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
 <ZV-CHima8bpXcopc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV-CHima8bpXcopc@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 23, 2023 at 06:47:26PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 23, 2023 at 05:23:22PM +0200, mitrutzceclan wrote:

...

> > +static int ad7173_free_config_slot_lru(struct ad7173_state *st)
> 
> > +static int ad7173_load_config(struct ad7173_state *st,
> > +			      struct ad7173_channel_config *cfg)
> 
> Have you checked, btw, list_lru.h? Maybe all this can be simply changed by
> using existing library?

Okay, it seems specific to MM, but maybe there something similar done which
can be split into generic LRU library? In any case it seems too much for this
nice series, so can you just add a comment on top of these functions to
mention that it may be switched to a generic LRU implementation if one exists?

-- 
With Best Regards,
Andy Shevchenko



