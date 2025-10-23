Return-Path: <linux-iio+bounces-25393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC0C02E6F
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55FE94ED5CA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D08277CAF;
	Thu, 23 Oct 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEtYABmL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B2270EDE;
	Thu, 23 Oct 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243785; cv=none; b=DmxH1gfOXHkOP0hwWEWPKHOLysWERc5zWuVu76UyeGycC20OnBjjosPY3uSRZZ5cKI0PKx/k6RvtwiB2FPl0bFQho8mwn2guzRdhdb0eOzaMBD/vWQbDSy0mQD800O9jejbzAgDhrDjz9TxsfwBUMgRZ+2/1BMw3pTAPCtXUxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243785; c=relaxed/simple;
	bh=itQoCTiDT763lfYHDtRGD+y331SN21ssLHWuGm9/rgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNiSKL2wdr58imnOvpgiFTn5lNM4vqfa7+Ma+e4AmJgxiww3/9gBpHDOOBaTgW0ioP70E3xoocdHYAky38XoqQid5hsbcwY+pIqgVOCwYJ3qOXy4CAUkAbBccouumn+BLY6YRaUxSuC9VEjdC4/IY6iJv3P/afkzgVSRb/9JleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEtYABmL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761243783; x=1792779783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=itQoCTiDT763lfYHDtRGD+y331SN21ssLHWuGm9/rgU=;
  b=KEtYABmLeDKuiEqI4H1BvzIZbY52TrKhf3OnBQIsZaDQnXgAR9Qfxwo5
   Aq4CW/nt0kFBK6NN0Pi6VoEPvCrlDkUUbWGzQqqYo3tvH4cVO0uS3UWsr
   hysBuVa5/LtHsJoR4FicSlek5OSs1Sc5S682yOge/mSvlUAqGiz7Fjlof
   0eO08u8z372w45++tCHzf/X3uFUcAZgghDBpY3BrlcrkCXNinhkstD2Pb
   8YHsPozbW+MGVNMFdU8uipuhLchUdLHfsG35ZECgDv8LKPFm9iFg3LoII
   pwh0lUUGd8f0PWZobMfip5SbSpok0/sTqVbI+2UkS+otsge9WoiBHR8x+
   g==;
X-CSE-ConnectionGUID: vZvrQkXGTOK0b8Q/car2vQ==
X-CSE-MsgGUID: alXQJFqyTrqH5FlDxnu8zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66039157"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="66039157"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:23:02 -0700
X-CSE-ConnectionGUID: VBJQp3rZR4+EoB5RQ/iw6g==
X-CSE-MsgGUID: QeJwaJXPR9CLCG111xrtAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="215149141"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:22:59 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBzxg-000000020pu-0Ekg;
	Thu, 23 Oct 2025 21:22:56 +0300
Date: Thu, 23 Oct 2025 21:22:55 +0300
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
Message-ID: <aPpyf1xPmU_koEXH@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
 <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 11:18:37AM -0400, Frank Li wrote:
> On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:

...

> > >  static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
> > >  {
> > > -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> > > +	if (!ops || !ops->bus_init ||
> > >  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
> > >  		return -EINVAL;
> > >
> > > +	if (!ops->priv_xfers && !ops->i3c_xfers)
> > > +		return -EINVAL;
> >
> > I would find the logically coupled proto-based xfers:
> >
> > 	if (!ops->i2c_xfers && !ops->i3c_xfers)
> > 		return -EINVAL;
> 
> Not exactly, priv_xfers is old API, which supported now. I plan remove it
> after remove all from i3c master controller driver after this patch merged.
> 
> i2c_xfers: must be no NULL
> 
> priv_xfers and i3c_xfers, one of both should be no NULL.
> 
> i2c_xfer is NULL, should be return -EINVAL, but you logic may success if
> i3c_xfers is not NULL.

You are right. I misread && as ||. Can you add a summary of the above in the
comment above the conditionals or kernel-doc of this function (if present)?

> > >  	if (ops->request_ibi &&
> > >  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
> > >  	     !ops->recycle_ibi_slot))
> >
> > >  }

...

> > > -enum i3c_hdr_mode {
> > > +enum i3c_xfer_mode {
> > > +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
> > >  	I3C_HDR_DDR,
> > >  	I3C_HDR_TSP,
> > >  	I3C_HDR_TSL,
> > > +	/* Use for default SDR transfer mode */
> > > +	I3C_SDR = 0x31,
> >
> > Why has this a specific value, while the rest have not? If it's HW mandated,
> > the all of them has to be assigned properly to avoid potential bugs.
> >
> > >  };

Are you agree on this or disagree or...?
If you agree, don't leave the unneeded context in the reply.
Otherwise, please express your objections.

...

> > >  /**
> > > - * struct i3c_priv_xfer - I3C SDR private transfer
> > > + * struct i3c_xfer - I3C data transfer
> > >   * @rnw: encodes the transfer direction. true for a read, false for a write
> > > + * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
> > >   * @len: transfer length in bytes of the transfer
> > >   * @actual_len: actual length in bytes are transferred by the controller
> > >   * @data: input/output buffer
> >
> > >   * @data.out: output buffer. Must point to a DMA-able buffer
> > >   * @err: I3C error code
> > >   */
> > > -struct i3c_priv_xfer {
> > > -	u8 rnw;
> > > +struct i3c_xfer {
> > > +	union {
> > > +		u8 rnw;
> > > +		u8 cmd;
> > > +	};
> >
> > What field is used to distinguish the union member in current use?
> > In another word, union must be accompanied with a selector.
> 
> This struct use only for i3c_device_do_xfers(), which pass i3c_xfer_mode
> informaiton. argument 'mode' will distrigiush rnw/cmd.

Then why that mode field is not present here?

> i3c_xfer[] array don't allow switch transfer mode during whole i3c
> transcation. So doesn't put mode in here.

I presume that this is the answer to my above Q? If so, I think this
dislayering is not okay, because the struct effectively lost the crucial piece
of information (for example, if you need to trace the contents of it, the mode
also needs to be provided again, and so on). I think the data type must have
this mode field as well (as long as union is in use).

> > >  	u16 len;
> > >  	u16 actual_len;
> > >  	union {
> >
> > >  	enum i3c_error_code err;
> > >  };

...

> > > +/* keep back compatible */
> > > +#define i3c_priv_xfer i3c_xfer
> >
> > How many of the current users do this? Can't we just rename treewide?
> 
> git grep -r priv_xfer drivers/

`git grep -lw ...` is a better approach :-)

> drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
> drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
> drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
> drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
> drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
> drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
> drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
> drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
> drivers/i3c/master.c:   if (!master->ops->priv_xfers)
> drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
> drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
> drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
> drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
> drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
> drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
> drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
> drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
> drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
> drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
> drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
> drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
> drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
> drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
> drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> 
> After this patch merged, I can clean up it at difference subsytem. After
> all cleanup done, we can safely remove this define.

I counted 9. I think it's not a big deal to convert all of them at once without
leaving an intermediate state. But this is a call for the I³C subsystem maintainer.

-- 
With Best Regards,
Andy Shevchenko



