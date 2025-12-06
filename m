Return-Path: <linux-iio+bounces-26864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03245CAAE6C
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 22:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0847300CBB6
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F3202F70;
	Sat,  6 Dec 2025 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed8swZyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D21F17E8;
	Sat,  6 Dec 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057814; cv=none; b=ROH2vv7gzzs89COR5LlILkj4AIU3pZmB2zB2Pwn5KKlI808XzF5lTnVj1v9u3ZxUc9KcTmfwx4prbgcsDNn1K3uq4Zl4PcCxhb5dwUlMqbYex0IV8mxKyejPJHYPNL8ImUMw5tgAB6dZe8iIPvyN+38czLkFaL1GCx07YsmO4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057814; c=relaxed/simple;
	bh=gNgPcVTa0ckHFERCqjtzt9Jz7wwU/BsZLDqoKp8khkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVOEZ0CZQ7m68T9boHvQO9Pa9fay4zGGb20SHz14McWHxc2vD5g56qFW+YVAZ5VgNpNpJGyeD4S1jhECuHanC14pM8vB1HK/ZJvZO7vpxvfSUMvGaIU0+DS3oWtOsxfgqEGqAHeChxIwrrr3Is6FIVjHgja6/rpbzrkxmdoddZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed8swZyx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765057813; x=1796593813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNgPcVTa0ckHFERCqjtzt9Jz7wwU/BsZLDqoKp8khkY=;
  b=Ed8swZyxW9+//guMTrsqUxKyqEdFrUV0YiNzV0AhWCXOQLQJ1BMb79dM
   RhCxH9AC++3J2Sl5I4NpyeQ/vtPeMTwDHjNfKKt0Y3CmcXLJ2ZdPuL3Xi
   P7vFmCCyyWVVOkSp4UV5f4t5c7qyxylpJ9FKV0dQiYJEuzKy4md0GqRdm
   2ILT/hChD+ao9uiVhzdYFT6K25CxG6WQAOuJ+8FxZb224CQU+vGe5Nw1s
   PrJyB3ru38q6MNypLxUoPxn8zJx6AtCD4r7xV7L8nqXYrMhtypAgqzYvL
   4ASwjKbWiUIA9aunbja24uXAq+E1DaFtUxqC2touzpsdWMud8NjmbZXLj
   Q==;
X-CSE-ConnectionGUID: yG9r1EKZTd2tWDZnv20E/Q==
X-CSE-MsgGUID: MJuwc4hETKyJdfQawc5U7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="67092496"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="67092496"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 13:50:12 -0800
X-CSE-ConnectionGUID: 36vIdHZTRjqYskuaoE+I5w==
X-CSE-MsgGUID: RovfcrTBQXajCqiTyTT5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="218942530"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 13:50:09 -0800
Date: Sat, 6 Dec 2025 23:50:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aTSlDoXYarcrhEbE@smile.fi.intel.com>
References: <20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro>
 <20251204-honeywell_abp2_driver-v3-2-ad3275bad35e@subdimension.ro>
 <20251206205407.6ba41d76@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206205407.6ba41d76@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 06, 2025 at 08:54:07PM +0000, Jonathan Cameron wrote:
> On Thu, 04 Dec 2025 17:12:56 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:

...

> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/jiffies.h>
> 
> I'm not immediately spotting use of this but I might well be missing it!

HZ ?

> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/units.h>

-- 
With Best Regards,
Andy Shevchenko



