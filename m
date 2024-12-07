Return-Path: <linux-iio+bounces-13206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7985C9E819D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3074A281C3E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31315530B;
	Sat,  7 Dec 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8evFj8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3D2E822;
	Sat,  7 Dec 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596475; cv=none; b=G5hbcCYMdpwM1r3LtpfSxGtzW7UFCOMXOhWwBkiJdjaXVAOawrktrXEdjcIdglmkV8Ta68Rp1lgCaGaAXgsDIWwCB/Qfr7yNKMH154Bc52ZTPn+lUee6gmOuPC6Ev6ImSXI/QxD7tsat9gMeWh4HEWXYbzALpRMdg8l6Y8dnsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596475; c=relaxed/simple;
	bh=ofinPvirUzJea//33qM+nXzmX47xAchXXYpLv/XduA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCTWxxra/21rEiQ6jSARTMzbcg1zE+AhLdD6N54stK9J+XLZUKlhZxVwQE9QIWy4QB7nttX2O7v3HmcMnnBu7NOe+gBNJ5s1UMsRotdxk/4z6sJIqSk6ZBzSV1XigdvZZDIGDHg/g7VhVCJp7i/7KDZ9yp6RAcGSSw1gQ+RRjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8evFj8o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733596474; x=1765132474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ofinPvirUzJea//33qM+nXzmX47xAchXXYpLv/XduA4=;
  b=R8evFj8oitbcOoP1zddjvKOZHLdmGN0x0iiYyXSLS+iCQL4LtvA2bTgs
   iO+spRw/oZV7WbToenoC6RYrjE9yAadClnfqWUmSrXVJMY6xnrBvfTdxO
   q1v5u/VTVX3tCAjmKF8iliVZ+YE/AtalyyXtcOVmQCItEeQx9FtDxXfZH
   QCo0NpU2B7+Q5zWngF9wL4OxTtSNZJJPi//g+pHJeao4GS0UzSzfhnLeR
   W5sDEMAXmevEHp5yFVD5SvvrAOcouqUuuSsgN+aneRB76fG7230LRBKq7
   hgwGqjQAi4r4NS7DyN54tCy5W5vVQm/W6m//Zrdguw5iu77ESStxAwRZ8
   w==;
X-CSE-ConnectionGUID: 9eV4LdbsQvy0Li3fjppRCg==
X-CSE-MsgGUID: VOZp5EuFTWCftDfpp8PaKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="37866621"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="37866621"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 10:34:33 -0800
X-CSE-ConnectionGUID: s7Eo6KhcQlK5fN2TFDcg8w==
X-CSE-MsgGUID: 0J//wxV3TSiiZRQ6JLzIOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="95057420"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 07 Dec 2024 10:34:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AC7301FF; Sat, 07 Dec 2024 20:34:30 +0200 (EET)
Date: Sat, 7 Dec 2024 20:34:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, lars@metafoo.de, dmurphy@ti.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Message-ID: <Z1SVNlBHz12-OP7j@black.fi.intel.com>
References: <20241122164308.390340-1-festevam@gmail.com>
 <20241201130356.3bf4c693@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201130356.3bf4c693@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 01, 2024 at 01:03:56PM +0000, Jonathan Cameron wrote:
> On Fri, 22 Nov 2024 13:43:08 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> > Using gpiod_set_value() to control the reset GPIO causes some verbose
> > warnings during boot when the reset GPIO is controlled by an I2C IO
> > expander.
> > 
> > As the caller can sleep, use the gpiod_set_value_cansleep() variant to
> > fix the issue.
> > 
> > Tested on a custom i.MX93 board with a ADS124S08 ADC.

> Hmm. Could be considered a feature, but fair enough as the change is
> trivial and you are setting it on a real board.
> 
> Applied to the fixes-togreg branch of iio.git.

...

> > @@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
> >  	struct ads124s_private *priv = iio_priv(indio_dev);
> >  
> >  	if (priv->reset_gpio) {
> > -		gpiod_set_value(priv->reset_gpio, 0);
> > +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> >  		udelay(200);

Obviously if you allow that change, you should switch to fsleep() here.

> > -		gpiod_set_value(priv->reset_gpio, 1);
> > +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> >  	} else {
> >  		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
> >  	}

-- 
With Best Regards,
Andy Shevchenko



