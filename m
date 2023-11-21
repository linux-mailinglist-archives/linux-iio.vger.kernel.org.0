Return-Path: <linux-iio+bounces-236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA497F34D3
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83F6B20FE4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920965A119;
	Tue, 21 Nov 2023 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK7g3UYZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D864113;
	Tue, 21 Nov 2023 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700587214; x=1732123214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmXyXdmIpGPFkC5nxq2ckbTRsSvvh69NGe2Z/8/ScyY=;
  b=gK7g3UYZNU0oOjYczNcYNjgWR1VR/SCg7kl9Wzu3oheVLyMS/d4hGbv5
   mZITl91pKE1JvYtkunzBGq9V90P3zl9MSn5RlYt21+2VBy1I2ojnNKCX3
   vVKTFDmt2nWZe0kQqKs1c9uAY7WJxrqHGj4+t2V7lLmdZxkK2NpoBY4Im
   U4vbSzhnrw06IK8meTUq8eaLYbbpHDM7ZEZk18DF5YEKG6DBzkcZIc/Tv
   IqP4e3Tg0M4SuZb4pJC92wLmugyBnaLd6jpzZ8DsibsHJUK1L/vigJ5t2
   GuZlf4GB0xbDt5bvLWxbzNUcs+UeV5GP1+YvQPvPypLWI4VKQvryrpgA3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10554723"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10554723"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013974419"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1013974419"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:20:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r5UPs-0000000FsAr-2V7h;
	Tue, 21 Nov 2023 19:20:04 +0200
Date: Tue, 21 Nov 2023 19:20:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZVzmxP2FypnkUE4I@smile.fi.intel.com>
References: <20231119212515.54001-1-marex@denx.de>
 <20231119212515.54001-2-marex@denx.de>
 <ZVtKyPvYHgg61JFG@smile.fi.intel.com>
 <adb40cdd-c4c0-4564-99e5-aac25f5cd700@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb40cdd-c4c0-4564-99e5-aac25f5cd700@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 04:14:54AM +0100, Marek Vasut wrote:
> On 11/20/23 13:02, Andy Shevchenko wrote:

[...]

> > > +static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
> > > +{
> > > +	struct device *dev = regmap_get_device(chip->regmap);
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
> > > +	if (ret < 0)
> > > +		dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);
> > 
> > > +	chip->command = 0;
> > 
> > Even in an error case? Is it a problem?
> 
> I added a comment in V4, if the I2C communication fails, hopefully the next
> time user reads data the command register will be rewritten again and the
> communication would have succeeded by then (assuming this was some weird
> glitch on the I2C bus). So this is best effort attempt to recover from that.

OK.

...

> > > +
> > 
> > Redundant blank line.
> > 
> > > +module_i2c_driver(isl76682_driver);
> 
> That ^ newline is above the module_i2c_driver or below it ?
> 
> I removed the one below .

Hmm... Comment was clearly about above one (as you see a single + there).

-- 
With Best Regards,
Andy Shevchenko



