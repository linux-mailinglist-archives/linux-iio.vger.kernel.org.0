Return-Path: <linux-iio+bounces-16132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1AA4822F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9401899F75
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025125CC8C;
	Thu, 27 Feb 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTZ6W9Ky"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617B25C6E2;
	Thu, 27 Feb 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667798; cv=none; b=SmX+s5p7U5nB7hoI2A2VGUr4OHAiHRugUroInpUnyLl944Oibgh+DnVgp6LcdQIo1LF1XHQPaZoNwopoWKOzvDtsk0aSSF2NQ8expuqQ8flpA0/c592Gso2A7aX1X+mawLcVdlwTZu4RxA0MzHXKayJNwnMBTVBioU6oknlDOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667798; c=relaxed/simple;
	bh=/+J4TVv0pmFUhasUbdo9cIKQLHkTdGgPrNJ8G6n+C/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0ZBRo7jjCuBP2rL4tPD6C/0ALl0F16SwiCT6gyzn2W/TO/lJxG6IgS50IhvyP6DYZGabkj7QuF+SuBfiKrNp6vcIOHWM8i182+p/QuUm8AmXBUH40X1pXcSB7jDTXC2feajW2pp6eAn0oxHltwd4bhH5GnUuT/G+sBRUlCkWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTZ6W9Ky; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740667797; x=1772203797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+J4TVv0pmFUhasUbdo9cIKQLHkTdGgPrNJ8G6n+C/8=;
  b=lTZ6W9KywG0wSXdYZhOi/jxRFvoFdM4ARzxioaKlfdFhoR35Vi++DeUs
   xG5wtxALBfkJ9AjoXVijH0itE02xcwCLeq5dw1rbhvWdN70R4IpweUREZ
   pbaWt+0l0vSYMjWaRpFMX9fMcuzvbNQeZ/Y+g5ZwXUKEx5U/xgVWBNMQq
   xR9CJH6/kwZOGVtgd5r3WbszOOWS4ysfLT8NDcDT0okyNyQkEU6wNCvG3
   elxamHR9gB139wpYmfo1cHlkwNvWrotMPbAFqjbc/gCCWK+O+Aba428GS
   MZy8Wv4zksorXu9rZoDgdyvqJAGRcibcgi7U3pUCnPA6NW+vJjLhCv8mp
   A==;
X-CSE-ConnectionGUID: gw6J9OrAThCIqhqi9P6piw==
X-CSE-MsgGUID: bQP4Vv1EQQ6BBHharh//IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40735926"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40735926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:49:55 -0800
X-CSE-ConnectionGUID: QY9xDufQQdmIzsMP9JwSew==
X-CSE-MsgGUID: mjWrqQyOSxGjmaB+28Ev5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117070355"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:49:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnfCp-0000000Fcnn-1wW6;
	Thu, 27 Feb 2025 16:49:43 +0200
Date: Thu, 27 Feb 2025 16:49:43 +0200
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
Message-ID: <Z8B7h4_IWz43gFhO@smile.fi.intel.com>
References: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
 <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
 <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
 <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
 <Z78g_uiXumn4mvET@smile.fi.intel.com>
 <d7982b76-3da7-47ff-b2b2-f964610af1f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7982b76-3da7-47ff-b2b2-f964610af1f7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 10:01:49AM +0200, Matti Vaittinen wrote:
> On 26/02/2025 16:11, Andy Shevchenko wrote:
> > On Wed, Feb 26, 2025 at 04:04:02PM +0200, Matti Vaittinen wrote:
> > > On 25/02/2025 15:59, Andy Shevchenko wrote:
> > > > On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
> > > > > On 25/02/2025 12:39, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
> > > > > > > On 25/02/2025 12:21, Andy Shevchenko wrote:
> > > > > > > > On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:

...

> > > > > > > > > 
> > > > > > > > > I did not check how many users are you proposing for this, but if
> > > > > > > > > there's only one, then IMO this should not be a global function yet.
> > > > > > > > > It just feels to special case to me. But let's see what the others
> > > > > > > > > think.
> > > > > > > > 
> > > > > > > > The problem is that if somebody hides it, we might potentially see
> > > > > > > > a duplication in the future. So I _slightly_ prefer to publish and
> > > > > > > > then drop that after a few cycles if no users appear.
> > > > > > > 
> > > > > > > After taking a very quick grep I spotted one other existing place where we
> > > > > > > might be able to do direct conversion to use this function.
> > > > > > > 
> > > > > > > drivers/net/ethernet/freescale/gianfar.c
> > > > > > > 
> > > > > > > That'd be 2 users.
> > > > > > 
> > > > > > I haven't checked myself, I believe your judgement,
> > > > > 
> > > > > I took a better look and you obviously shouldn't believe :) The gianfar used
> > > > > of_node instead of the fwnode. So, it'd be a single caller at starters.
> > > > 
> > > > ...which is the same as dev_of_node(), which means that you can use your
> > > > function there.
> > > 
> > > I'm unsure what you mean. The proposed function
> > > device_get_child_node_count_named() takes device pointer. I don't see how
> > > dev_of_node() helps converting node to device?
> > 
> > dev_of_node() takes the device pointer and dev_fwnode() takes that as well,
> > it means that there is no difference which one to use OF-centric or fwnode
> 
> The proposed device_get_child_node_count_named() takes a device pointer. I
> don't see how dev_of_node() helps if there is just of_node and no device
> pointer available in the calling code.

???

The loops are working on

	struct device_node *np = pdev->dev.np;

which is the equivalent to

	struct device_node *np = dev_of_node(&pdev->dev);

which takes device pointer.

> (Well, as I wrote below, I could
> alter the gianfar code by dropping the gfar_of_group_count(), so that I have
> the device pointer in caller). Anyways, I don't see how dev_of_node() should
> help unless you're proposing I add a of_get_child_node_count_named() or
> somesuch - which I don't think makes sense.

Are you forbidding yourself to change the function prototype to take a device
pointer instead of device_node one? :-)

> > API in this particular case. Just make sure that the function (and there
> > is also a second loop AFAICS) takes struct device *dev instead of struct
> > device_node *np as a parameter.
> 
> I think I lost the track here :)

Make gfar_of_group_count() to take device pointer. As simple as that.

> > > I think I could actually kill the whole gfar_of_group_count() function and
> > > replace it with a direct call to the device_get_child_node_count_named() -
> > > but I am not at all convinced that'd be worth including the property.h to a
> > > file which is currently using only of_* -stuff. Well, I suppose it can be
> > > asked from netdev peeps but I am not convinced they see it as a great idea.
> > > 
> > > If I misunderstood your meaning - please elaborate.
> > 
> > The driver is quite old
> 
> I remember having to modify this driver somewhere around 2010 or so. :) Time
> flies.
> 
> > and has a lot of room to improve. Briefly looking it
> > may be almost fully converted to fwnode, but it's not your call (only if you
> > wish). Nevertheless, using agnostic APIs if they reduce code base is fine.
> > We have drivers that do OF and fwnode mixed approach (for various reasons,
> > one of which is the new API that is absent in OF realm.
> 
> Well, we can propose this to netdev people but I wouldn't be surprized if
> they requested full of_node => fwnode rewrite instead of removing simple
> looking loop and bringing mixture of fwnode and of_node in driver.

Without doing the proposal we will never know what they will think of all
this...

-- 
With Best Regards,
Andy Shevchenko



