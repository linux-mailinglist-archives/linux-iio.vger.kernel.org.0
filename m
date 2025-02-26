Return-Path: <linux-iio+bounces-16093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01342A46210
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7242177EE8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2816221F2C;
	Wed, 26 Feb 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8BUmLbT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF0221DBA;
	Wed, 26 Feb 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579307; cv=none; b=jodeuf1MarLweVjAfYUjR+zrnA+unE6M8G+A/C4cVqBchiZYqB1BNP9g8NLBsIxz9YHG4DJ3l7jWkRBmp4dIregC33tW4+V4Vaz/0Z+P+MLY/d7n+EGHuG/5oew0JvL15nWEyT4unZ/5wgyS0BsY9p55xkADWQ7C2reLUO1/OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579307; c=relaxed/simple;
	bh=DQfqoYcLRD2Zeo+43lklnMk6+hDgT7YZ/1xvKUYxQ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z93+Nf3Vr4QkJmOaQ5n+CETovQBuox+Y2Cah2BJPF/VkjnpX+pfANWYfVXO1PlpFrvU5257xVqOSnJWeCcjEbkrQVkPx7NB8zENBCwl1ps1Rug2h7YasoKYfkHFqtLbWEk4e2Z/DZL4Ea7Bqt/Og+n5flpUdNxm6ml7L+MGa21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8BUmLbT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740579306; x=1772115306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQfqoYcLRD2Zeo+43lklnMk6+hDgT7YZ/1xvKUYxQ1o=;
  b=W8BUmLbTeydN+RUrOssfhUFEMxZ7Wmi62FDwyk0sCPtgZhQOONTFJrX4
   lRwnAx+vTuPdax/XkUXrXVGmFcXI09HbF3DbNm+CJD5Zp5bLyvnojHL4P
   5UeFkGUBTyFcahCdU44+oCDvZxyrPf/dts3+s5FO+gZjUZICmmp+DrZuE
   8vs/otl/xS6dwY5ykjCQ0F8/zLH0IKzY7IZM/bLZlfgpA9myZChsxNiZa
   yfe6+G18xYeujHdNTtQABuqTXBcBurfuoXnXnWqr+suH3dIcEEWK3R3X5
   XB8qQlP3PQGaD4HQpmMuZ1o7BeV3uvVt/oxpxgffZy3+24sAsnpFHSVLn
   A==;
X-CSE-ConnectionGUID: B2KRgDT1QnaEH5Xi7eqCJQ==
X-CSE-MsgGUID: mxZi/vjDRYmAfMkKd49sOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52817162"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52817162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 06:11:23 -0800
X-CSE-ConnectionGUID: SfzjqrcRQU6U9pWwkoyKjw==
X-CSE-MsgGUID: DAtu5ZbIRzCICP2T7HfhTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121960718"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 06:11:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnI7y-0000000FLJp-1jew;
	Wed, 26 Feb 2025 16:11:10 +0200
Date: Wed, 26 Feb 2025 16:11:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
Message-ID: <Z78g_uiXumn4mvET@smile.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
 <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
 <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
 <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 04:04:02PM +0200, Matti Vaittinen wrote:
> On 25/02/2025 15:59, Andy Shevchenko wrote:
> > On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
> > > On 25/02/2025 12:39, Andy Shevchenko wrote:
> > > > On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
> > > > > On 25/02/2025 12:21, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:

...

> > > > > > > 
> > > > > > > I did not check how many users are you proposing for this, but if
> > > > > > > there's only one, then IMO this should not be a global function yet.
> > > > > > > It just feels to special case to me. But let's see what the others
> > > > > > > think.
> > > > > > 
> > > > > > The problem is that if somebody hides it, we might potentially see
> > > > > > a duplication in the future. So I _slightly_ prefer to publish and
> > > > > > then drop that after a few cycles if no users appear.
> > > > > 
> > > > > After taking a very quick grep I spotted one other existing place where we
> > > > > might be able to do direct conversion to use this function.
> > > > > 
> > > > > drivers/net/ethernet/freescale/gianfar.c
> > > > > 
> > > > > That'd be 2 users.
> > > > 
> > > > I haven't checked myself, I believe your judgement,
> > > 
> > > I took a better look and you obviously shouldn't believe :) The gianfar used
> > > of_node instead of the fwnode. So, it'd be a single caller at starters.
> > 
> > ...which is the same as dev_of_node(), which means that you can use your
> > function there.
> 
> I'm unsure what you mean. The proposed function
> device_get_child_node_count_named() takes device pointer. I don't see how
> dev_of_node() helps converting node to device?

dev_of_node() takes the device pointer and dev_fwnode() takes that as well,
it means that there is no difference which one to use OF-centric or fwnode
API in this particular case. Just make sure that the function (and there
is also a second loop AFAICS) takes struct device *dev instead of struct
device_node *np as a parameter.

> I think I could actually kill the whole gfar_of_group_count() function and
> replace it with a direct call to the device_get_child_node_count_named() -
> but I am not at all convinced that'd be worth including the property.h to a
> file which is currently using only of_* -stuff. Well, I suppose it can be
> asked from netdev peeps but I am not convinced they see it as a great idea.
> 
> If I misunderstood your meaning - please elaborate.

The driver is quite old and has a lot of room to improve. Briefly looking it
may be almost fully converted to fwnode, but it's not your call (only if you
wish). Nevertheless, using agnostic APIs if they reduce code base is fine.
We have drivers that do OF and fwnode mixed approach (for various reasons,
one of which is the new API that is absent in OF realm.

-- 
With Best Regards,
Andy Shevchenko



