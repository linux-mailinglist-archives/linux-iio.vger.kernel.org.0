Return-Path: <linux-iio+bounces-16049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EAA43C01
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66941169547
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A1266196;
	Tue, 25 Feb 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfVEQ6Qe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C9233714;
	Tue, 25 Feb 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479995; cv=none; b=gsMJNrDhKvUma6wY3JbwrMVDrSSY+jqhHE0rW2g/BGHlyb7ZmRkG5Sdji1ZSbBdQhZGge/S0vDVWBnOGsYhRZPjsNgMt7D1QY97ACBMtcMcxsefXAkqNikZiSDNi72AZ5ZqIa1B4ArrwWtL9MUFd4CtaQFnc0J0XOiEsbq+fA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479995; c=relaxed/simple;
	bh=WyqYTE7rMoOZSS+5Gkk3EOQ86ZSaUphQT2/6XSSeDUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoEnzLYAFnGpzG3nWLhun5wRqgBvI0fknaDLCQNfc9NlWUyRvwhoZxlUpHInmmpEkZSGyudUjjzDhz1ftvqkLcgpa+UilD2W2fOFYFR6vTfMpycYv8PuYYKHnSJAtOyDCe8LXPtbEdjqG2hdB4NJbvo809rS6pFkOF0I0PL2deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfVEQ6Qe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740479994; x=1772015994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WyqYTE7rMoOZSS+5Gkk3EOQ86ZSaUphQT2/6XSSeDUA=;
  b=OfVEQ6QeLGCoHd4E0w/9HaoUdZKcq8LcQJOXIOmDl00Aqk+AwFkPR/aA
   CyystChlhSQte2IXTUpqRxijqtJUzRiKYSrkj0hbsOIoElNSdFSdlsXjS
   ddTYu8VY3sMHutjfY77LS/DtgrxhwuLbHeYwk8WBPdnzK6zLXCWoUnQNU
   BkA+hdXFzzbkq4Cy2FCmbZUQWkMoiO0XIWcSCLYTNoHfDhYelw47cO6ZR
   KVtzdstdUKLDEOLqvk+XtomIj3zscVO8X+/TpQrILd+A72PfO4g3+xsab
   tU+ZqAGOXtPbT0cDKiZEqtLofkXbv3/fU5GBzmP05tnAa1KeeXRDIpbB6
   w==;
X-CSE-ConnectionGUID: BdCynxS0SWWzLYoWAncWdw==
X-CSE-MsgGUID: 333icalsRWekj5bSMO+NJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58701581"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58701581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:39:53 -0800
X-CSE-ConnectionGUID: YEFntbX8TteoUjNIRJ5PNw==
X-CSE-MsgGUID: fVi37cX7QIWfmgGUTO0geA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="139595621"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:39:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmsLl-0000000ExcQ-3fHY;
	Tue, 25 Feb 2025 12:39:41 +0200
Date: Tue, 25 Feb 2025 12:39:41 +0200
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
Message-ID: <Z72d7TzZ21WITW3f@smile.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
 <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
> On 25/02/2025 12:21, Andy Shevchenko wrote:
> > On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
> > > > +/**
> > > > + * device_get_child_node_count_named - number of child nodes with given name
> > > > + *
> > > > + * Scan device's child nodes and find all the nodes with a specific name and
> > > > + * return the number of found nodes. Potential '@number' -ending for scanned
> > > > + * names is ignored. Eg,
> > > > + * device_get_child_node_count(dev, "channel");
> > > > + * would match all the nodes:
> > > > + * channel { }, channel@0 {}, channel@0xabba {}...
> > > > + *
> > > > + * @dev: Device to count the child nodes for
> > 
> > This has an inconsistent kernel doc structure in comparison to the rest in this
> > file.
> > 
> > > > + * Return: the number of child nodes with a matching name for a given device.
> > > > + */
> > > > +unsigned int device_get_child_node_count_named(const struct device *dev,
> > > > +					       const char *name)
> > > > +{
> > > > +	struct fwnode_handle *child;
> > > > +	unsigned int count = 0;
> > > > +
> > > > +	device_for_each_child_node(dev, child)
> > > > +		if (fwnode_name_eq(child, "channel"))
> > > 
> > > s/"channel"/name/ ?
> > > 
> > > > +			count++;
> > > > +
> > > > +	return count;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
> > > 
> > > I did not check how many users are you proposing for this, but if
> > > there's only one, then IMO this should not be a global function yet.
> > > It just feels to special case to me. But let's see what the others
> > > think.
> > 
> > The problem is that if somebody hides it, we might potentially see
> > a duplication in the future. So I _slightly_ prefer to publish and
> > then drop that after a few cycles if no users appear.
> 
> After taking a very quick grep I spotted one other existing place where we
> might be able to do direct conversion to use this function.
> 
> drivers/net/ethernet/freescale/gianfar.c
> 
> That'd be 2 users.

I haven't checked myself, I believe your judgement, but can you add a (rfc?)
patch at the end of this series to show that? With the luckily event of acking
by the network people we may have it already done.

> While I looked at it, it seems that a 'device_for_each_named_child_node()'
> -construct would have a few users.

-- 
With Best Regards,
Andy Shevchenko



