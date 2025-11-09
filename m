Return-Path: <linux-iio+bounces-26103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E2C4432B
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1315188B5F2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A2303A27;
	Sun,  9 Nov 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvZrOFX1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE02FFF8F;
	Sun,  9 Nov 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707951; cv=none; b=G4ehd3dxLNj30zeiZyLzkgQy3xDHP7fn+hl6dcxi4lxy0hFC0MQx6GFA8wrFjdb7ECJm2PHIihLxeLyw2/XktAX6ONqkX3Z4d+VGBA+WAE1M0uRN9uoLjxXyHPh0YAHwnQ5L5QQ2j/eyRsDpRwsIlqb0SFt5TKydiw+AZ4lj95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707951; c=relaxed/simple;
	bh=ZalydpZC9sowtVEzmQ+/6gdzAoR4PY0F4g1l2JMGZ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCVKXDiIBobzJ83ZmUJpyj+U83aVaZXptVNTgvwjGf6JjoEo+Zrnra1s+7jbCNI1/GjqmuE1aDGCAoK84WQ9jhQK97Ik4AQbZU5jJvu0Jr3nQ1UdSad10dpqHWI+xk6TIsxqc01o6YxEIVZ+W2zldIOd+MbIwtULDeSddrEDEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvZrOFX1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762707950; x=1794243950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZalydpZC9sowtVEzmQ+/6gdzAoR4PY0F4g1l2JMGZ3E=;
  b=MvZrOFX17/8+uEFcl/loTVMCkYNHh1HF9NNxSYBgCZTTmhom3C3w/8Wp
   RvPx72vi9tTrjOUPeUBmGG/D1mYjBK0EeMmP9GCtCYeE1ZT6Q8RkWJ4uY
   X3s6wB+jobVO//NQlixcbgoR75/H8FHfl+ruiEP4H11W0Gwo9zVW1MwHr
   GuP4ZF1DLWxYdZE2gSpUQXiGl97YsHf941d6AW5LxnFaZ62dlSnlLVolc
   SjC1lGXld4rOkJQayz3iUYwlct/vlXRevbLfradmfkD9FZMGkidneGV9W
   JOE8O2przOcIyV2pgNk8sH7L8noupB9vNaSMDdYJIi/73lfVV8dRug6TN
   w==;
X-CSE-ConnectionGUID: HIAxMCAgSSqi0/TpU1QJ+A==
X-CSE-MsgGUID: B5U1LnRfSp+yCdCHtl+6rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75070859"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75070859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:05:48 -0800
X-CSE-ConnectionGUID: huSmQp89Tea5RmNNM7cgMw==
X-CSE-MsgGUID: lo93QnP1T+KjCwloY495FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192875107"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:05:45 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vI8rH-000000074j2-0yag;
	Sun, 09 Nov 2025 19:05:43 +0200
Date: Sun, 9 Nov 2025 19:05:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Message-ID: <aRDJ5ugv8xJzbxTW@smile.fi.intel.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
 <aRDJexPYkIDoE9nc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDJexPYkIDoE9nc@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 07:03:56PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 09, 2025 at 07:41:19PM +0530, Ajith Anandhan wrote:

...

> Many are still missing... Please, follow IWYU principle.
> 
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> 
> > +#include <linux/device.h>
> 
> Not see why you need this and not
> 
> dev_printk.h
> device/devres.h

Actually even devres.h is not needed if I did not miss anything.

> instead.
> 
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/unaligned.h>

...

Overall looks much better than previous version.

-- 
With Best Regards,
Andy Shevchenko



