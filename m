Return-Path: <linux-iio+bounces-25429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E9C08290
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F161501928
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173832FF665;
	Fri, 24 Oct 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OZVY0rw1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49B2FE56F;
	Fri, 24 Oct 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340347; cv=none; b=XL3cXWVteQ/cBU1os0+jjLZQn+7IteZEajvn0UtjF4lbJSMyaEbVXWjSD5+qvOHzsJANJD8EPBGqS8Jd6II4Kp1KcirtSYRxwn4ZQIN5dajlA1a238/rrhQiSrjU4CmgtxAWVZ6uWd3SV6oHn5a8GUVUY+jRtqFi7xRBeObtQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340347; c=relaxed/simple;
	bh=XapeQpNiVnOZWKHzPMxALSxZqbbB82+/0jrRk+Be5o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3QVULbg8Uu4NmVKIAeFyk93kzCHBYsqgh/wbBGaEpyp1SDnieAMpFpRcajnVBDn7lXIguuigp6RhklV5Eoo4HOO7vZxaoKYuXy+92TMNSCDoY7CQ1rGvG6F2nBAyZJ1SeDIEsi/J5aZ+88rlMI8344jh3BF02uDTTgheAW5ICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OZVY0rw1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CD5DEC0C43F;
	Fri, 24 Oct 2025 21:11:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A4CD60703;
	Fri, 24 Oct 2025 21:12:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D37E7102F22B5;
	Fri, 24 Oct 2025 23:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761340335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f1MDeUalmO2MBuHBwgqnu8xSGd9CwkEHdnrfQWRAgQ8=;
	b=OZVY0rw1nmczW237v6np6WNDFGQ6eR2zd3znpqkEWDafR9sNuuOUqwUVUhzR+5csGyUMqu
	ij3T6l9saudJiYUTmnsvl2Xi5nlZq3J0kyPd8Tql/Ns82Z9NGh90a4Lm+MlCnCxLryVh8S
	KBrrsGTu+0hpPp8k7pi1WG/zaRKG0oV5q3tjdi8KXdZ2QnaTa26nokWcHF+Ue5dLwX5yMF
	kIiunQ8OqPITEpQBqZaocyh3urX8kuNaPawctzTyBc18pfcZsr0EFHb1YzbfrQU9d6ZM1L
	cPBxprhTwc75j+aoy6sLKLnLsQZpfGsGAAh9hj0K8ziOSun3hTEywQcPLKJ2PQ==
Date: Fri, 24 Oct 2025 23:12:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Message-ID: <20251024211205055af5b3@mail.local>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
 <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
 <aPpyf1xPmU_koEXH@smile.fi.intel.com>
 <aPq/6/+63sHuq/qy@lizhi-Precision-Tower-5810>
 <aPsZB44qXR77jNHF@smile.fi.intel.com>
 <aPuHKs3u344zoI2+@lizhi-Precision-Tower-5810>
 <aPujXUO2h5zHy2fj@smile.fi.intel.com>
 <aPupaHEZM20Q8aJu@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPupaHEZM20Q8aJu@lizhi-Precision-Tower-5810>
X-Last-TLS-Session-Version: TLSv1.3

On 24/10/2025 12:29:28-0400, Frank Li wrote:
> On Fri, Oct 24, 2025 at 07:03:41PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 24, 2025 at 10:03:22AM -0400, Frank Li wrote:
> > > On Fri, Oct 24, 2025 at 09:13:27AM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 23, 2025 at 07:53:15PM -0400, Frank Li wrote:
> > > > > On Thu, Oct 23, 2025 at 09:22:55PM +0300, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 23, 2025 at 11:18:37AM -0400, Frank Li wrote:
> > > > > > > On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:
> >
> > ...
> >
> > > > > > > > > +/* keep back compatible */
> > > > > > > > > +#define i3c_priv_xfer i3c_xfer
> > > > > > > >
> > > > > > > > How many of the current users do this? Can't we just rename treewide?
> > > > > > >
> > > > > > > git grep -r priv_xfer drivers/
> > > > > >
> > > > > > `git grep -lw ...` is a better approach :-)
> > > > > >
> > > > > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
> > > > > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
> > > > > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
> > > > > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
> > > > > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > > > > drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
> > > > > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > > > > drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
> > > > > > > drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
> > > > > > > drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
> > > > > > > drivers/i3c/master.c:   if (!master->ops->priv_xfers)
> > > > > > > drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
> > > > > > > drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > > > > drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
> > > > > > > drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
> > > > > > > drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > > > > drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
> > > > > > > drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
> > > > > > > drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
> > > > > > > drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
> > > > > > > drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
> > > > > > > drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> > > > > > > drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
> > > > > > > drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
> > > > > > > drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
> > > > > > > drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
> > > > > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
> > > > > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > > > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
> > > > > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > > > > >
> > > > > > > After this patch merged, I can clean up it at difference subsytem. After
> > > > > > > all cleanup done, we can safely remove this define.
> > > > > >
> > > > > > I counted 9. I think it's not a big deal to convert all of them at once without
> > > > > > leaving an intermediate state. But this is a call for the I³C subsystem maintaiiner.
> > > > >
> > > > > There also are other cleanup works. The key point is that everyone agree my
> > > > > HDR solution. Cleanup these is not big deal. I am not sure how to avoid
> > > > > build broken at difference subsystem.
> > > > >
> > > > > After this patch merge, cleanup will be easier and safer.
> > > >
> > > > Then leave that renaming to the cleanup series. No need to use a define, just
> > > > use the old function name.
> > >
> > > Using old function name for HDR will be very strange and conflict with
> > > spec's name convention.
> > >
> > > The term 'private' transfer in i3c spec is specific for SDR transfer. It
> > > is neccessary steps to complete whole naming switches.
> >
> > Right, but this out of scope OR a prerequisite to this series. My point that
> > these two shouldn't be mixed and one left half-baked.
> 
> It doesn't make sense that the new iio driver still use old interface, then
> replace new one later.
> 
> Is it okay I create new patch serial, which switch to new interface, but
> it's depend on this one. Let each maintainers decide how/when merge it?
> 

I'm fine with the define as I believe you are going to send the series
switching to the new name quickly enough.
I'll provide an immutable branch so the various subsystem maintainers
can apply that on their own.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

