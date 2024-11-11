Return-Path: <linux-iio+bounces-12114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECF9C3B02
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 10:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0512282F8A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB031531C5;
	Mon, 11 Nov 2024 09:38:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C9143C72;
	Mon, 11 Nov 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317905; cv=none; b=iuJQdDSZeHlhOMGON38xDnj+kve2ZSIjVNt7QLp0d4IDHaeqA8xezmjq65tSZDdO5OlWKrSRRd1v2ok7ZdEdS0yVZh5jTqshFuRwl0IgaBPoffRPc7eSs+L5u193ZbDtlhF+3ntNnU0mn7hudelVYCnLDctjsUUDjxwBcd5VmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317905; c=relaxed/simple;
	bh=xeAyYEonYfltQhc7TK13Y/TErfyKMLlkw7rNEBEmLZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMUoR/BOcz9HkmXezVcfh/XEMNPsy54Q6giEjP749Fqy4/wrAWUYqNjrhqvTY62jhhSQUcNQhlBF3b1CmDyb+1oKan/LFJ36W1x6MpZr8+BkIMDYvFE/8doX3JvO8eVHyARWT1Pa+X2kXWlnRkElExCwn8jYYAnjUdgsTQx01ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: SHRe0o4mSM2Dbi0HHIojsA==
X-CSE-MsgGUID: 7TM6ngcORletU/gd1KwUIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31283510"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31283510"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:38:23 -0800
X-CSE-ConnectionGUID: vKgxvLnxSW2eLqkX5QZQww==
X-CSE-MsgGUID: e+5VjbTJS5GlYdx0irgteA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="87640065"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:38:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tAQsB-0000000DXr3-2uiO;
	Mon, 11 Nov 2024 11:38:15 +0200
Date: Mon, 11 Nov 2024 11:38:15 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Aren <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <ZzHQh8CV4c2HC4NY@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
 <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
 <mlvzaskgxqjfu6yiib2u7m3pczsifsluc4mqnzy6w3xzxblvm6@xrxvvruzftn2>
 <ZzEOqC9dAHCRX5a9@surfacebook.localdomain>
 <qqk4rbx6wxr7vofepk63yvuimavafbiy2srkqx2zvl2kxttlrk@axpphmdxffis>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qqk4rbx6wxr7vofepk63yvuimavafbiy2srkqx2zvl2kxttlrk@axpphmdxffis>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 10, 2024 at 05:37:56PM -0500, Aren wrote:
> On Sun, Nov 10, 2024 at 09:51:04PM +0200, Andy Shevchenko wrote:
> > Sun, Nov 10, 2024 at 01:38:39PM -0500, Aren kirjoitti:
> > > On Mon, Nov 04, 2024 at 10:32:08AM +0200, Andy Shevchenko wrote:
> > > > On Sat, Nov 02, 2024 at 03:50:37PM -0400, Aren Moynihan wrote:

...

> > > > > +	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
> > > > 
> > > > Why not simply 'dev' as in below call?
> > > 
> > > I was trying to avoid refactoring the entire function to replace
> > > &client->dev with dev, I'll add a patch for that to the next revision.
> > 
> > I'm not talking about refactoring, I'm talking only about the lines that you
> > have touched / added.
> 
> Ah right, this one makes sense, my comment should have been on the next
> patch in this series which is a little more complex. For that patch it
> seemed inconsistent to use dev only in new code and mix it with calls
> using &client->dev.

It's fine, you can add a new cleanup patch later on.

-- 
With Best Regards,
Andy Shevchenko



