Return-Path: <linux-iio+bounces-11131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F49AE8D9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA792292AE5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F181F76BE;
	Thu, 24 Oct 2024 14:28:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B351F669F;
	Thu, 24 Oct 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780102; cv=none; b=sBayP/2KkMjL1Z6Fz4U3VmBrtfhTo3/DTFZt3MOB3ZPglhTBmRTb3Vowo0UWG9yEGeHDF0ZjjEGvT3LS1EPeensUstqJghFvmIIY27EIdZK01zfqSwop+6zDlkvYH9RIjTbLOvlK899GMlA++oZAllh/bbFBDUSvHNo4NLS4kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780102; c=relaxed/simple;
	bh=9KmBYw1eiZZ45NfTasyieiF5LdLBmbJ72ug2/gAsLL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eepb3oj2sOgPU1bMVfknhzV9wAih8uCZbJRGu865gLd/VRgijLgwO3mf3/1HrTsT/b8Rzfl7njwuARUswFD/OWieq1U1d2Bm5Hy1/JCrZXaQsRR4vZteXHEOF81zS1ZRkC3ukR9kBd4btp9jA7YPxpeY/qGq4zaCFmnDVXKd21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: dcA/yEC9RTOptQYJQJFs5Q==
X-CSE-MsgGUID: q+V8CnhlQyKW+z9MOo4oLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33209024"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33209024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:28:19 -0700
X-CSE-ConnectionGUID: kAxyAEgGRsqzP2CbF2dKlA==
X-CSE-MsgGUID: ROTIQ0wXTPGJYZDISuk74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80776831"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 07:28:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 30C1B252; Thu, 24 Oct 2024 17:28:14 +0300 (EEST)
Date: Thu, 24 Oct 2024 17:28:14 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Yang <decatf@gmail.com>, Rob Herring <robh@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: Add support for KX022-1020
Message-ID: <ZxpZfgsf-KldiX4w@black.fi.intel.com>
References: <20240714173431.54332-1-rayyan@ansari.sh>
 <20240714173431.54332-3-rayyan@ansari.sh>
 <823ce598-dffd-4983-bffa-32559558235d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823ce598-dffd-4983-bffa-32559558235d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jul 15, 2024 at 10:30:46AM +0200, Hans de Goede wrote:
> On 7/14/24 7:33 PM, Rayyan Ansari wrote:
> > Add compatible for the KX022-1020 accelerometer [1] using the
> > KX022-1023 [2] register map as both have an identical i2c interface.
> > 
> > [1]: https://kionixfs.azureedge.net/en/datasheet/KX022-1020%20Specifications%20Rev%2012.0.pdf
> > [2]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
> > 
> > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note, this patch broke kx231025 case...

> >  	KXCJ91008,
> >  	KXTJ21009,
> >  	KXTF9,
> > +	KX0221020,
> >  	KX0231025,
> >  	KX_MAX_CHIPS /* this must be last */
> >  };

...because this enum is used of ODR startup timeout settings which
are all moved now to be 0 and new ID inherited the timeouts from
the KX0231025 case.

Since I have been looking into the driver, and I have a few patches
coming, I propose to do the following (as it's still ODR data being
missed) to:
1) revert this one;
2) apply my set;
3) re-apply this with the fixed data.

Another approach can be done (but probably not by me) is to move the ID
to the proper location, add ODR startup timeouts or explain why it's not
needed and then apply my patch.

But, taking into account that we are almost at -rc5 and I want my stuff
not to be postponed, I tend to follow the first approach.

Opinions, comments?

P.S. FWIW, my set will include switching this driver to use chip_info
structure so the similar mistakes won't happen again, that's also why
I prefer the first approach I listed above.

-- 
With Best Regards,
Andy Shevchenko



