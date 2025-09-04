Return-Path: <linux-iio+bounces-23715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3DFB43DAC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437367C6B3D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D82D8771;
	Thu,  4 Sep 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6DjApMN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4223B616;
	Thu,  4 Sep 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993762; cv=none; b=guc8kvdYMrqFfz2NKhiRaC4CL5bsT3p1ATS9OjFLh8MkM+ll9HCzaW5sSxFmDoG1b3l9p+x8rPZQBwJ15GC8SJ07bYVs38CluQzp09WfdSOR5EzA9AAUZIvFBoR5La1JcOfN08TYINNO7jQ//fp2S4vCJNVo5ARodGpTkFHfKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993762; c=relaxed/simple;
	bh=AkLMZM2IWuZTM3/2Jc4sRylXbsnaUGbk4biSzT3SKRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh5drxCVF3hHoSdxMkXYZ8TC03l/sYmbuV7OctEAI+8RjqBn4nHDJRbQME2cXp3sVOTrAjdZg+SHQCjV5E4InDdu50e1D1AfSqMncy+3qCcNYKZD0xQu1H/pJMNAuIRpHPMUFEFS3ORIW6eGiJh3gSKZZA+gdNeiJQU9k57DaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6DjApMN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756993761; x=1788529761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AkLMZM2IWuZTM3/2Jc4sRylXbsnaUGbk4biSzT3SKRY=;
  b=a6DjApMNScDsM5T1tiqiPuxTfniOnorUhfnlD8nHvESLAa3W55lNvNXs
   hS1kFOhJz3mBVb1lCrfhqIlhkIqZbbvJH0E/Z9cqPC9JWA6G7OXR/3TfD
   DL4UZ5uVOWx0H6vFxTMKJPc/aRsRrmZPDktkE139Jdz1eml/RYNal9/Kz
   t92O+cjEWPElMHDNT2Dx3w69SAZ5VuIC5pVeoAXB1rMf1u1EydAYpTdvp
   LoNuKfdDynMDt5xPQnh89BLTDZ1bj+ooXYDXTJVIjzklbTNm/raVDisdy
   p0f+/6ysAfUljZc+8vBdBurXjTvM/sCHZJKmWApWDNJ3K252tTPDeUGX9
   A==;
X-CSE-ConnectionGUID: SAPTXMoHT+eEH3l3vII1VA==
X-CSE-MsgGUID: 901zvDddTjeoG9P6iJiNfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="69595854"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="69595854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:49:20 -0700
X-CSE-ConnectionGUID: mAtn5fxNRc2bybinVojzcg==
X-CSE-MsgGUID: zJgKwK+8QS2lsmlHSg5pnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="177113763"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:49:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuAKw-0000000BHbp-2mBK;
	Thu, 04 Sep 2025 16:49:14 +0300
Date: Thu, 4 Sep 2025 16:49:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Remi Buisson <Remi.Buisson@tdk.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Message-ID: <aLmY2mKg_FsPOpsq@smile.fi.intel.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
 <aKbk9WYtfb5L5la4@smile.fi.intel.com>
 <FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc I³C people to comment on the returned values on the regmap. See below.

On Thu, Sep 04, 2025 at 01:01:32PM +0000, Remi Buisson wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> >Sent: Thursday, August 21, 2025 11:21 AM
> >On Wed, Aug 20, 2025 at 02:24:21PM +0000, Remi Buisson via B4 Relay wrote:

...

> >> +#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES {U8_MAX, U8_MAX, U8_MAX, U8_MAX, }
> >
> >When one line, no need to have inner trailing comma, besides that missed
> >space.
> The trailing comma was a request from Jonathan Cameron on the v2 of patchset.
> Let me know, if you disagree with him and I'll fix.

I see, then let's ask him, because it's a usual pattern for
the one-line arrays like this to have no inner trailing commas.

> And I'll add a space before first element.

...

> >> +	/* Try to read all FIFO data in internal buffer. */
> >> +	st->fifo.count = fifo_nb * packet_size;
> >> +	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> >> +				st->fifo.data, st->fifo.count);
> >> +	if (ret == -ENOTSUPP || ret == -EFBIG) {
> >
> >Strictly speaking this is a bit of layering issue, do we have other means to
> >check the support before even trying?
> 
> No unfortunately, we can't with current I3C regmap implementation.
> I2C and SPI regmaps are able to split transfers according to max_read_len.
> But for I3C, it is left to the controller driver, which usually only returns an error.

Have it been discussed with I³C maintainers / stakeholders? Because this kind of APIs
will be hard to follow and even change for both sides caller and callee.

> >> +		/* Read full fifo is not supported, read samples one by one. */
> >> +		ret = 0;
> >> +		for (i = 0; i < st->fifo.count && ret == 0; i += packet_size)
> >> +			ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> >> +						&st->fifo.data[i], packet_size);
> >> +	}
> >> +	if (ret)
> >> +		return ret;

...

> >> +	/* Disable FIFO and set depth. */
> >> +	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> >> +			 INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
> >> +	val |= INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX;
> >
> >FIELD_MODIFY()
> Ok, great.

Actually this is not a modification per se, it's just an assignment (PREP)
split to two lines, can you just make it a single expression (wrapped on a few
lines, though)?

...

> >asm/byteorder.h ?
> Yes.
> Is linux/byteorder/generic.h OK?

No, as I put it.

linux/*
...blank line...
asm/*
...blank line...
linux/iio/*
...blank line...

...

> >> -	scoped_guard(mutex, &st->lock)
> >> +	scoped_guard(mutex, &st->lock) {
> >
> >Ah, nice. It should have been done in the first place and put a comment to that
> >patch that scoped_guard() {} used specifically for limiting churn in the next
> >changes.
> If ok for you, I'll keep that as it is.
> If I add a comment in previous patch, I'll anyway have to delete it this patch.

"Comment" is to be added to the email and not the code. It's a free words to
the cover letter and/or to this email after '---' line but before the actual
diff.

But {} should be added as even in the first patch this is multi-line body.

> >> +	}

-- 
With Best Regards,
Andy Shevchenko



