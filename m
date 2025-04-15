Return-Path: <linux-iio+bounces-18126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1EA8969F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B293B95F0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320228A1F6;
	Tue, 15 Apr 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3U2rZCA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E528A1C3;
	Tue, 15 Apr 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705660; cv=none; b=uhGqyJ3gKv0OhEq+azKqovJkGD0eRKJ81pN6ilcMuOs1JbDNFthzgMJs7Y1xoF0sB5MBuubnZ+cV0DvlHwDU8YXvj61e5NBQ6/MOuX1ubal34yxA8XEKG/oJBFpKZu8JwKI6+em61AHUe1AdtXzWOWUrWJXFE2KmQ6KWe2LcfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705660; c=relaxed/simple;
	bh=/NWQer13qfQtTS0IPMGbnftEkMcL2u4+nq/Oeev8wi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2FtpTNqrf2qNe6vYD1ifY16slJv20q4VLrwZyb6zdhQ8Sf/zycqDNLv7C9iRU9uGOGAazkbP6rTR9+u+m61OrJHALdylmccFRl92o2K52FER8U9u61l4xVklDtBxjHJSKeu/gJPJlGWS268YG2hlo1rBrQXl98obLEoe+/qaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3U2rZCA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705659; x=1776241659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/NWQer13qfQtTS0IPMGbnftEkMcL2u4+nq/Oeev8wi0=;
  b=a3U2rZCARQVjrpZuRLpKnGGoK0EogJN4Rl2Bs0ifXJGJlXfGd8C+URFa
   ibRBGomjzlQelZDt4Dyg8cfvnyogzDm2/AZ74NimLWcKP4WgXlKwK0GcH
   6i3APbuWdnRJIPtP4QkJ0JwjGh33u2WAprFJ6PmwoTN8o6DX3Hcj9o7lP
   YnPZVM2qH/5QyEeVmwhQ7f0Mvbbv0kCbea8VAiLV6p+WFUGLYUPzFvV6j
   5kUq3SUMG/2qQDCFKGMdZC5FvVPLMGELYj/wYfT1RZrmwyHlWCKEzfXik
   h06Xlg8pf7FotgFCxVmmJD7YnpMwaonvwu0wDClGLK7Dy5hnw95rtaEx5
   A==;
X-CSE-ConnectionGUID: tHaVRnPaRlKIeVA+SX4+KA==
X-CSE-MsgGUID: 9RCRcqzHTL63RxL8gsfq0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45914696"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45914696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:26:32 -0700
X-CSE-ConnectionGUID: qrpIY++ySUCX/8SUuS4vUA==
X-CSE-MsgGUID: xgVmuuT2QAu6SMtEtu38Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130374897"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:26:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4bcd-0000000CUHm-0iFL;
	Tue, 15 Apr 2025 11:26:23 +0300
Date: Tue, 15 Apr 2025 11:26:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
	tgamblin@baylibre.com, alisadariana@gmail.com,
	antoniu.miclaus@analog.com, eblanc@baylibre.com,
	jstephan@baylibre.com, matteomartelli3@gmail.com,
	angelogioacchino.delregno@collabora.com, herve.codina@bootlin.com,
	marcelo.schmitt@analog.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <Z_4YLq_uR_6uroNd@smile.fi.intel.com>
References: <20250409012351.2543450-1-j2anfernee@gmail.com>
 <20250409012351.2543450-3-j2anfernee@gmail.com>
 <Z_aeEuIk9brES6dM@smile.fi.intel.com>
 <CA+4VgcKG2EEsicysds0zu7y1xDhg88m3heGUBaQZ7-MVWanCaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+4VgcKG2EEsicysds0zu7y1xDhg88m3heGUBaQZ7-MVWanCaw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 09:40:35PM +0800, Yu-Hsian Yang wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> 於 2025年4月10日 週四 上午12:19寫道：
> > On Wed, Apr 09, 2025 at 09:23:51AM +0800, Eason Yang wrote:

...

> > Here and elsewhere why ' < 0' is used? Do you expect positive return values
> > from those?
> 
> In regmap_read function, A value of zero will be returned on success,
> a negative errno will be returned in error cases.
> We don't have a positive return case.

So, can we remove ' < 0' parts where they are not required, please?

...

> > > +     chip->client = client;
> >
> > How exactly is _client_ used elsewhere? Shouldn't it be just a struct device
> > pointer?
> 
> Yes, it is just a struct device pointer.
> In nct7201_init_chip(chip), we would use the chip->client->dev as
> dev_err_probe() parameter

Just save there struct device *dev and use chip->dev instead.

-- 
With Best Regards,
Andy Shevchenko



