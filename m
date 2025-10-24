Return-Path: <linux-iio+bounces-25423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8ADC0721C
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B473BA9EB
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E33321DD;
	Fri, 24 Oct 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8LewufV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76C32A3C6;
	Fri, 24 Oct 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321831; cv=none; b=l6nInrYv9UjUH9fnMxdjV6U/XJmBFdiLj4xI3dzLOjnqwUrgAWgTC/Za1TKenKfybcrw+bgZmAPi7uT4C2/ji76KbDQru5QhnLh84k3AoDiGTlXykwTX616C2+J6wWIjUi6bApLGYbv+JLklOXmjFpUDbiLu4LOtZVMrYlQBdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321831; c=relaxed/simple;
	bh=4rQ06hcRDPh06TcIr4Hhsm2kdiwKuNYxumRXFNrUjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joe6FQClezer77/ddQFVWihMr9QQf/SK2UBSonJanoe4W7c54VzfgaZ/r+06DMFgGEjvftc9lHNukK8Oo3VKd8+Xt1ysUQQEYGWu8gltBUtF+pitsouX3Lzo+QWNSDXqSk2dIIkkwPK4LhErwYuPrNb+VCFyM1GakzJhUT59BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8LewufV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761321830; x=1792857830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4rQ06hcRDPh06TcIr4Hhsm2kdiwKuNYxumRXFNrUjJA=;
  b=E8LewufVOxQ5HbMhl4pPzsvceo8qzmYX8Zw0jI61OYSmJYCHZ/kQduSA
   SnjYLzl0Ahru1o6ZAzTWcobcGe5Qe9d7SDFRVLvmMg9uCTYw8fQK5QSCh
   nilq95pjqPgfPYHCN2Bjz7ozsi+Xt0PV7qeO/OBIIoTrfq1LT9/sFrVvb
   ENVWn244n+WWYnIhlUUKarnp8lUtzixF8fhFBhlm0VyKA5YFmDK7rpVD7
   0OMD20wEnLsF5HW3GdRRk23e8S0lJYLebnWGHc2+77+tMwQ+L80hge7EF
   RTaTeMAwsJ7xs41devNKfcmj3Dt8NgfWXVYWxpt7sHvNaiti52koYOcTW
   Q==;
X-CSE-ConnectionGUID: YJvAx88bRAmZ7ChbH30NLA==
X-CSE-MsgGUID: lyFltYAaQP2wqda7BA/o3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81132279"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="81132279"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:03:49 -0700
X-CSE-ConnectionGUID: oM1QeLgRR2izo7nsOkSYWQ==
X-CSE-MsgGUID: nRGZyRpfSYK4S0x3HQThpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="215117928"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:03:45 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCKGT-00000002Cpo-42le;
	Fri, 24 Oct 2025 19:03:41 +0300
Date: Fri, 24 Oct 2025 19:03:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@nxp.com>
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] i3c: Add HDR API support
Message-ID: <aPujXUO2h5zHy2fj@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
 <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
 <aPpyf1xPmU_koEXH@smile.fi.intel.com>
 <aPq/6/+63sHuq/qy@lizhi-Precision-Tower-5810>
 <aPsZB44qXR77jNHF@smile.fi.intel.com>
 <aPuHKs3u344zoI2+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPuHKs3u344zoI2+@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 10:03:22AM -0400, Frank Li wrote:
> On Fri, Oct 24, 2025 at 09:13:27AM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 23, 2025 at 07:53:15PM -0400, Frank Li wrote:
> > > On Thu, Oct 23, 2025 at 09:22:55PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 23, 2025 at 11:18:37AM -0400, Frank Li wrote:
> > > > > On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:

...

> > > > > > > +/* keep back compatible */
> > > > > > > +#define i3c_priv_xfer i3c_xfer
> > > > > >
> > > > > > How many of the current users do this? Can't we just rename treewide?
> > > > >
> > > > > git grep -r priv_xfer drivers/
> > > >
> > > > `git grep -lw ...` is a better approach :-)
> > > >
> > > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
> > > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
> > > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
> > > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
> > > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > > drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
> > > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > > drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
> > > > > drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
> > > > > drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
> > > > > drivers/i3c/master.c:   if (!master->ops->priv_xfers)
> > > > > drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
> > > > > drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > > drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
> > > > > drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
> > > > > drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > > drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
> > > > > drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
> > > > > drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
> > > > > drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
> > > > > drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
> > > > > drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> > > > > drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
> > > > > drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
> > > > > drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
> > > > > drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
> > > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
> > > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
> > > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > > >
> > > > > After this patch merged, I can clean up it at difference subsytem. After
> > > > > all cleanup done, we can safely remove this define.
> > > >
> > > > I counted 9. I think it's not a big deal to convert all of them at once without
> > > > leaving an intermediate state. But this is a call for the I³C subsystem maintaiiner.
> > >
> > > There also are other cleanup works. The key point is that everyone agree my
> > > HDR solution. Cleanup these is not big deal. I am not sure how to avoid
> > > build broken at difference subsystem.
> > >
> > > After this patch merge, cleanup will be easier and safer.
> >
> > Then leave that renaming to the cleanup series. No need to use a define, just
> > use the old function name.
> 
> Using old function name for HDR will be very strange and conflict with
> spec's name convention.
> 
> The term 'private' transfer in i3c spec is specific for SDR transfer. It
> is neccessary steps to complete whole naming switches.

Right, but this out of scope OR a prerequisite to this series. My point that
these two shouldn't be mixed and one left half-baked.

-- 
With Best Regards,
Andy Shevchenko



