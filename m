Return-Path: <linux-iio+bounces-25648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C2C1EDA8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE65404DEC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BEA337BA4;
	Thu, 30 Oct 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL9dvFU+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37C337B90;
	Thu, 30 Oct 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810679; cv=none; b=qMDvEGrhLay2tVvIkrF6YqLlSL6rVkra/jncXpLn5r8Fi/N6cAnMqK2G1esdvpDzAmxt8Xx+Xf7Qek+VP0osIzTqGPtrMovoaz8hIsdy+0OcY3sp/HHdqxHIq6mII+cv2gIScjjZyusAOcDsXlReKto0FwPklitvvsuUb/Bisbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810679; c=relaxed/simple;
	bh=i2o3lPX24fKmxQVeAxzXXKnFXNnmPunVGpcSChGJjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g75H7vRuQlp4OEuAkwuvNJA0Vylcp0NSuOtjBtxyYjL0NvmKnVQeSQKIB1Ie2yTWT3MCEXWYtYzk1W1tZD2ETrSjOjSTfnpqUbk7AO/31CqkMSiX0Z54MInD6jW0MOUHgHROYNvZPlgSjwULgJxyD1Gl2MIlFRVF0dyVjA0kPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL9dvFU+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761810678; x=1793346678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i2o3lPX24fKmxQVeAxzXXKnFXNnmPunVGpcSChGJjZ4=;
  b=mL9dvFU+jaetvl8FAHDrEWglI5oR8HnMBV0DSQ++s9RE4HIi+Y5Uqw52
   L+N+4wGEDARihYZjczJboiI1QDCbr0zfP6GxyhFMfJidkglUQLPxC3uCr
   jhWjs091eHpSRtLnogpvcUZEy85Wfvs5fOyEbVgDu+rZ1dh/JQjlb5OJG
   6j0pVQZYQ+Lt5iJZDJLg3Gu6rd8L4GJGB9f0V/1MEhCrszQU8ZAKHtYpv
   /zv5w0i/hrO8j+Z8dCovGq3GgQdHCrMvZA1vWOzxWbU+WIMBWuRRfVEPz
   aQNefj1K6kQiAPCj6m6FjmLBVbytNRMV4a9ZYoY+iBkyz+5bYvOtgn7TX
   Q==;
X-CSE-ConnectionGUID: qm+8gNG3TuCt2273XoyEqA==
X-CSE-MsgGUID: 9HVKlFp2TY+sHbQ8WVhi1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75393483"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75393483"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:51:16 -0700
X-CSE-ConnectionGUID: I2DDdL9vQWaAvAcwSGvghg==
X-CSE-MsgGUID: MHQTsx82RMa03zag5bzJtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186231747"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:51:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENR7-00000003ps3-2Wqs;
	Thu, 30 Oct 2025 09:51:09 +0200
Date: Thu, 30 Oct 2025 09:51:09 +0200
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
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v7 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQMY7WaDixv9C2QE@smile.fi.intel.com>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
 <20251027-i3c_ddr-v7-5-866a0ff7fc46@nxp.com>
 <aQCgD3iVOXoNr7uY@smile.fi.intel.com>
 <aQI4v1lVcagBWY3i@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQI4v1lVcagBWY3i@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 11:54:39AM -0400, Frank Li wrote:
> On Tue, Oct 28, 2025 at 12:50:55PM +0200, Andy Shevchenko wrote:
> > On Mon, Oct 27, 2025 at 04:08:33PM -0400, Frank Li wrote:

...

> > > +static const struct {
> > > +   int val;
> > > +   int val2;
> >
> > No need. Just
> >
> > > +} mmc5633_samp_freq[] = {
> 
> There are some place will like
> 
>         if (mmc5633_samp_freq[i][0] == val &&
>                 mmc5633_samp_freq[i][1] == val2)
> 
> previous
>         if (mmc5633_samp_freq[i].val == val &&
>                 mmc5633_samp_freq[i].val2 == val2)
> 
> Previous version seem have better readablity. But it is not big deal, if
> you like, I change to [0][1].

It's not my preference, it's how all but this driver do in IIO, it's about
consistency of the style / patterns.

...

> > struct i3c_device doesn't have a name, does it?
> 
> It has name, but it is hexnumber (VID+PID), like 0-4a20000f000.
> So use friend/readable name here.

I think it's better to use the name provided by the subsystem. This way we may
guarantee the unique one. The hard coded values potentially might collide
(imagine some I³C driver for the very similar chip, let's say, in hwmon).

-- 
With Best Regards,
Andy Shevchenko



