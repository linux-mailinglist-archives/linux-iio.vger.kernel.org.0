Return-Path: <linux-iio+bounces-14422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B6A150D6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB6B3A888F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687011FDE31;
	Fri, 17 Jan 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3/VOJfw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099A1F957;
	Fri, 17 Jan 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121599; cv=none; b=b7+FNCoA2CHe/sDCiqusWPApGK3AoU3qn3d6OALIwS5wCWG60T2VuO/BZA4w16MWVcS6FH75aNez28GySNhLDz80FGo/HGtF/vbEwmWaoJWlSxrF+SgOEM+NGKUP7mBnB21DgfmLfFhR3DiOkdeScimFO5gYtHTllRwfq4XY7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121599; c=relaxed/simple;
	bh=+l69ay6YBI/s8vF12UyAf4InZRENzuWKw38D/MFG2Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhkf+Ikm5yFI517XSjKPtdDRlNJkTYNRylhLtpKcZz8KRwA8u9J600TbzUvd0Q7yT5JsY3FxyEiehPTwtXE2PBhiZPrL13iaJUTn+KQn8t8bncrBRxfZr6UtHpKnupF3nFRyJeKHzcu2havk+gK2/UOd9sXspp6GAwOV0gJ5QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3/VOJfw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737121598; x=1768657598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+l69ay6YBI/s8vF12UyAf4InZRENzuWKw38D/MFG2Oc=;
  b=G3/VOJfwzk++A4+0c9zMB99V+2k0jL9k1c9hD30qV0QyeHOyKBE5vEgl
   1UsP0jY1I0TlbJ/TkOEyU6+x/h6o1NmoDhwyhbrQ0j2urPZK3Pyzd6N2f
   ab/hSKdWfRjw/bgdHujWPiqoRMWR7qRkFZBUSvlpCcLVnizAS/iRWkn/W
   cVZyTd3Tgxi4kUfxf4pmmXsKEARx8B9uW0+OsSfTbKdv7EGDwP3uGdMER
   p+7+xGHVZa2JnArQl4wclwsfzvsecr9cqlKdCqiBU+X7UJsmKQj0NFAKB
   B11YHT/eutmoOSvFRCLnKqGMKz3LTrtI25Okz33hBeK6FOKIlrGtQ0J9U
   A==;
X-CSE-ConnectionGUID: 5mMnIdYsTiax1ciuhz8Bnw==
X-CSE-MsgGUID: MTvg59s9RDSbFBIcikQ9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="60026064"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="60026064"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:46:37 -0800
X-CSE-ConnectionGUID: 1U1mkzUdRJ+uHpbir2Ek1w==
X-CSE-MsgGUID: sec1iNPRRhaA89YyFtti0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="110797984"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:46:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYmgB-000000024s4-1GWD;
	Fri, 17 Jan 2025 15:46:31 +0200
Date: Fri, 17 Jan 2025 15:46:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <Z4pfN6lDKysMxTWR@smile.fi.intel.com>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
 <20250115201622.270130-3-apokusinski01@gmail.com>
 <Z4jCz1VXVPtEDNqB@smile.fi.intel.com>
 <20250116200558.mr23jxpdpwyu62md@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116200558.mr23jxpdpwyu62md@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 09:05:58PM +0100, Antoni Pokusinski wrote:
> On Thu, Jan 16, 2025 at 10:26:55AM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 15, 2025 at 09:16:22PM +0100, Antoni Pokusinski wrote:

...

> > > +	/* Write the registers 0xCE - 0xD0 */
> > > +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Just to be sure I understand the above. There are two of 24-bit values or there are
> > two sets of 3 byte arrays? How does datasheet refers to them? What does common sense
> > tell us here?
> 
> It's the second option: we have 2 arrays of 3 elements each (a0, a1, a2
> and a3, a4, a5). In the datasheet the names of the values correspond
> to the names I used in the driver, that is there are 6 values a0, ..., a5.
> 
> The point is that the their registers are separated by the 0xCD register.
> Therefore I had to call `regmap_bulk_write()` twice in order to
> write values a0 - a2 to the registers 0xCA - 0xCC and similarly the
> values a3 - a5 to the regs 0xCE - 0xD0.

Thanks for the explanation! Looks reasonable to me.

...

> > Overall LGTM, there is no need for resend as I believe the three things above
> > may be tweaked by Jonathan. The last one can go even if there are 2 24-bit
> > values, but ideally in that case we should use those as a such and apply
> > put_unaligned_be24/le24() whichever suits better.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



