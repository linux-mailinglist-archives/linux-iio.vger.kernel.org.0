Return-Path: <linux-iio+bounces-9142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B202596BFFE
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5791F22075
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAF1E0B6F;
	Wed,  4 Sep 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iS5xzqXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728A1DB957;
	Wed,  4 Sep 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459459; cv=none; b=Wly2wiIYBHbMALr5A+hT1oweGRVM99iJI3mAcvT5VGfuk2RswE/g691ZJm8Vno1wUYEorovMFSiWPuPq4kt9sZ1ymOvnlJ5sWS1A1bSkfxwklldg7YbAu7VG/c4DSwlCN+EL+9hwC4kOZl7BnhO2iNwjkEO4PRu1aV6oNSaUSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459459; c=relaxed/simple;
	bh=W4le2lcpo7LUpcfmumYArYOf+r681pzkEsJct3yzx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpvE18LwCqK8CP/BZezKf2J9Ooct9SzwEi4fNK9H/l3fs35OOeqRpXiB5DVM6nr3y2qTWAFzuM4HWGiZWC8TzD/v++pQ93qOh0WB4zYaE+0BU07bfdeWnmz95XDrIfakj3gWit9Y35hekf9naJNpd2Qg2pX6MxZq0TFcmBskVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iS5xzqXq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725459458; x=1756995458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4le2lcpo7LUpcfmumYArYOf+r681pzkEsJct3yzx3c=;
  b=iS5xzqXqlNYCxwGl74Gw6yuisojKg96cNIo16zdbVIed8+5Aeldn0rQN
   yuajHZaebAVq70+26RFbom7KGr3lsHbgqcQhaXzP6fgbUIpEmfRl5O9dl
   K/RDi8hm821y69B4WkOTcmzvsJPgwYD/MVFTLvmhysFek9aeWbVil3AOZ
   GezbMKlrpuJFHAV15AtKu5uJV/oI0UlpAR7VdJdfnnW3yZui1/txS/Bb0
   u31JVtzYVBgav3Ewuqvh1MARV/9mRP0JE/6tGgNAUsF1+Lwmof7OmmxC/
   mEEBo3eg3yeNe0oJwso+sxAMlWTQYqc7ZtlrWPciZ5BlpHCcJ2zkW7/di
   g==;
X-CSE-ConnectionGUID: 0avJRG1sR3GzXmOolG2RCA==
X-CSE-MsgGUID: T9QrY7u9RtKsbcSIDg+svg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27913525"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="27913525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:17:37 -0700
X-CSE-ConnectionGUID: JwunMGIxRzezRjT3xNB7WA==
X-CSE-MsgGUID: Hens8zXCRFipGsBFQs2O+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="70077188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:17:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slqp7-000000055R2-3RXp;
	Wed, 04 Sep 2024 17:17:29 +0300
Date: Wed, 4 Sep 2024 17:17:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <Zthr-bKR-jr7B2kc@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-5-vassilisamir@gmail.com>
 <ZtccnvhmcxyRQVuf@smile.fi.intel.com>
 <20240904102427.GA44250@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102427.GA44250@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 12:24:27PM +0200, Vasileios Amoiridis wrote:
> On Tue, Sep 03, 2024 at 05:26:38PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2024 at 08:42:19PM +0200, Vasileios Amoiridis wrote:

...

> > > +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> > > +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > > +		return -EBUSY;
> > > +	}
> > 
> > Alternatively
> > 
> > 	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
> > 	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > 		return -EBUSY;
> > 	}
> 
> Why would I use && instead of || ? I just need one of the 2 to be true
> (one of the 2 measurements is not complete) and I can trigger the error
> action.

Oh, I messed up the logic inversion, but wouldn't it be simpler to read
"we return busy if neither press nor temp drdy bit set"?

	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) && (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {
		dev_err(data->dev, "Measurement cycle didn't complete.\n");
		return -EBUSY;
	}

(I left long line for the better understanding of my point, you may break it to
 two if needed)

With that, you even may have

#define BMP380_STATUS_DRDY_PRESS_AND_TEMP_MASK ...

	if (!(reg & BMP380_STATUS_DRDY_PRESS_AND_TEMP_MASK)) {
		dev_err(data->dev, "Measurement cycle didn't complete.\n");
		return -EBUSY;
	}

which makes it all obvious.

-- 
With Best Regards,
Andy Shevchenko



