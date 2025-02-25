Return-Path: <linux-iio+bounces-16047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C33A43B83
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B963BD03B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33F267B76;
	Tue, 25 Feb 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCStcfdO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A9267B6A;
	Tue, 25 Feb 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478902; cv=none; b=SUGSAQInCdmSoCfzZ4v67YnyFUY6mLcnwXH1VnHQj3GLH9R2VGOA1sZHgIEgFLfntDyGPa8qzNY6QP/2dbjG/M5RplzlcaM429Wo115VXl/DbrFs0Y3jLE5nzQuq+ANxxc178GorZCHaaOzCBZKGLsQtKZPrM5Wx2MLL0d/GzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478902; c=relaxed/simple;
	bh=O7XFosUMq18SOY1Uke3gT9fhryi5WO3Dg5KUjBJMkkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua8UxpeWNDSLfWoYymHpHiZ5f7lyniF/50EFydFqFw9mNpe/Euz9OWKod4fzPAiYk2F1YYlHmDS+9HSqxdDjgrCdQv6VnhEGPt35vSE+RcFRHMshPk/r12mmbvfvliM5kWuw4MW5j0/crChK0u4Tp/EYJJObgXLD6RAf5FZ2t/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCStcfdO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740478900; x=1772014900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7XFosUMq18SOY1Uke3gT9fhryi5WO3Dg5KUjBJMkkw=;
  b=jCStcfdOkWp+WhCFvJteOmoqVNOSVYWLvmGF7vXUrQeAOF3N4roSbdhM
   Tw6hVdCo0jY/WFwgBn5Vb0hn8JfSPKKbseeGwKXSYL3JoJpsxnmgzT8VL
   7MgKJk7K6mMcOy/YiU7BK+fw8fHll/EFVwoIrFS20Z/pmraPstP2bwftT
   HEtUXK+U584dXsEksllvGlbKc2tMAhStmKEdFtVw/RjMpAdpEwBCyEh7/
   btX45u1AQO7fDUo0iaTGfFj92X1njOvgC609xMpQbeusjFi24HrpQKQQ9
   OhKFhPLMW9ACwlimjNOJLi7hmpdxF2FLJ12RP54/VFVXJnQ4vp2MhjUmH
   Q==;
X-CSE-ConnectionGUID: omf430/sRo2FIIHyt0O0jQ==
X-CSE-MsgGUID: Qe/hd4Q+Q5C7KATZRj0gOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44101701"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44101701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:21:39 -0800
X-CSE-ConnectionGUID: scDSegHXRMquAd8KbKBguA==
X-CSE-MsgGUID: Q73F1GJkT++WQOlPBRuFvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121321448"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:21:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tms47-0000000ExN6-17ps;
	Tue, 25 Feb 2025 12:21:27 +0200
Date: Tue, 25 Feb 2025 12:21:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
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
Message-ID: <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
> > +/**
> > + * device_get_child_node_count_named - number of child nodes with given name
> > + *
> > + * Scan device's child nodes and find all the nodes with a specific name and
> > + * return the number of found nodes. Potential '@number' -ending for scanned
> > + * names is ignored. Eg,
> > + * device_get_child_node_count(dev, "channel");
> > + * would match all the nodes:
> > + * channel { }, channel@0 {}, channel@0xabba {}...
> > + *
> > + * @dev: Device to count the child nodes for

This has an inconsistent kernel doc structure in comparison to the rest in this
file.

> > + * Return: the number of child nodes with a matching name for a given device.
> > + */
> > +unsigned int device_get_child_node_count_named(const struct device *dev,
> > +					       const char *name)
> > +{
> > +	struct fwnode_handle *child;
> > +	unsigned int count = 0;
> > +
> > +	device_for_each_child_node(dev, child)
> > +		if (fwnode_name_eq(child, "channel"))
> 
> s/"channel"/name/ ?
> 
> > +			count++;
> > +
> > +	return count;
> > +}
> > +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
> 
> I did not check how many users are you proposing for this, but if
> there's only one, then IMO this should not be a global function yet.
> It just feels to special case to me. But let's see what the others
> think.

The problem is that if somebody hides it, we might potentially see
a duplication in the future. So I _slightly_ prefer to publish and
then drop that after a few cycles if no users appear.

Also this misses the test cases.

-- 
With Best Regards,
Andy Shevchenko



