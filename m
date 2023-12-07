Return-Path: <linux-iio+bounces-721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A652808FEA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB801281740
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E746BA4;
	Thu,  7 Dec 2023 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="He42HI5W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6F10E7;
	Thu,  7 Dec 2023 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701973849; x=1733509849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y2t867H8uPObLoUue6uM57n3MWPsr44cSJW7VsVsF3w=;
  b=He42HI5Wb671cHw0sVhTNkCYTbgKgI2lSC0o59wHop0CjcJFaKeCunrP
   XI/iBGaifP4GwqHs3iYBkw9CP6IeYiuULawWIFe4G91TX79GuJPT8LnH2
   VItkk8u+JiDqYfFeyM24mmue06xZ240LtaN9RqV4r7u4GLvgIGV/4eTlS
   iE6LgLfIKtcPGsGoT8Tcts6PiHzEy3EhFwyWXuN5ta5bL/g8AshMUmWbp
   rrMTrJoszME3lU/SKGnKKz5zRsgrmdAon92/J1e2tTjKS0rpywfb2lOSq
   uaDYK/DnALhcFoiiQFm4sfMrRCD2aQyBtYWufBKp7+sws6NWUt53JTViB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480474543"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="480474543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="765191302"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="765191302"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:30:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rBJ91-00000003scM-0r0L;
	Thu, 07 Dec 2023 20:30:43 +0200
Date: Thu, 7 Dec 2023 20:30:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
References: <20231207164634.11998-1-petre.rodan@subdimension.ro>
 <20231207164634.11998-2-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207164634.11998-2-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 07, 2023 at 06:46:29PM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.
> code is now based on iio/togreg

There is room to improve, but I think it's good enough to be included and
amended later on if needed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



