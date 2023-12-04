Return-Path: <linux-iio+bounces-573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0238033A0
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF85B280FAB
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AA249ED;
	Mon,  4 Dec 2023 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfBguMuL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAF109;
	Mon,  4 Dec 2023 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701694660; x=1733230660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Cj0FSe2KITpAAhEvGgLmANZmxOhurePzJN16LUJB2M=;
  b=RfBguMuLdBuuo3xYIkGcpAEVeGD+FAuIuKfU2OaErgIQiCmh1bIWuift
   kjBiGs2EXMV2T6gV+02C/eKKSUZ+CRS0oP7Cpd3GdQU+XzGGujaCXe7vd
   CJFNK1Aw8vYRjusvm6gNmuNezP38EhowWfOam1AmVkw4V6lsuXE600Qh6
   SmQrOwgH1geSKhMxeUcVzRCNWx3rClINSGZUfNDY6DDdVz0G3xKQvjfyS
   GDv9BzbzBcsfwTGmgpXrQcUuUDFKkHfURulrz0tVULARU4gxKkIxAbNRQ
   zbUlnM9vdF1Sa0RnljcJWbk7xyflKjLOYXCZtNdu7HkP48v+LHYpY88uf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="384130171"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="384130171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017839179"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1017839179"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:57:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rA8Vx-00000001kkV-3MSm;
	Mon, 04 Dec 2023 14:57:33 +0200
Date: Mon, 4 Dec 2023 14:57:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
 <ZWtWAPcJTNrD9wgv@sunspire>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWtWAPcJTNrD9wgv@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 02, 2023 at 06:06:24PM +0200, Petre Rodan wrote:
> On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > > 
> > > 437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> > > 					&triplet);
> > > [..]
> > > 455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > > 						triplet);
> > > 		if (ret < 0)
> > > 			return dev_err_probe(dev, -EINVAL,
> > > 				"honeywell,pressure-triplet is invalid\n");
> > > 
> > > 		hsc->pmin = hsc_range_config[ret].pmin;
> > > 		hsc->pmax = hsc_range_config[ret].pmax;
> > > 
> > > triplet is got via device_property_read_string(), is there some other property
> > > function I should be using?
> > 
> > I think I mentioned that API, but for your convenience
> > device_property_match_property_string().
> 
> one of us is not sync-ed with 6.7.0-rc3 :)

No, one of us is not synced with subsystem "for-next", which in this case
is IIO "togreg" (IIRC) and it definitely has the above mentioned API.

-- 
With Best Regards,
Andy Shevchenko



