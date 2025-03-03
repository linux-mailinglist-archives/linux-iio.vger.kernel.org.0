Return-Path: <linux-iio+bounces-16281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF7A4BFAA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3CE188A687
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9420E308;
	Mon,  3 Mar 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGOeW4Tm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB11CAA71;
	Mon,  3 Mar 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003233; cv=none; b=Jd8ZRE137h4mbN0sHnIaOxpHts+QwjrmuroMzxtNB+a30mDmeiFr9OThiPHL5d4E8HZmlSjdTLk1w71IsJ3M+gzuGm+9f0TpsEAzmyxV2989Nz/FLR1Ij88WQOcb4YkiInQ36XZGlYQMn3/H4Xshg6wmfgJvJBvNTpKKPPb5aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003233; c=relaxed/simple;
	bh=VFeoSGzVzp2v1XgvCh7gFDPeObOphuG8s93CmdXo9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ5sUpzcUUm7mtP9WgzV2eKRTcC+st5pjxGn+Y+bufJc7QqQn6gU6sx9KHft+Ty3FbBON8caezwLtfIR2MwmvCIGHHs1SthlBQzNCC0fisikEL/hGYtyAIA6haeGwXLOdISA9aNmYDwnPBiORhR6vbmiAIUSIc61ioZQLWZ/Exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGOeW4Tm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741003232; x=1772539232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFeoSGzVzp2v1XgvCh7gFDPeObOphuG8s93CmdXo9RY=;
  b=aGOeW4TmMjSQ7vIHU+tMK5I8R9Sv/enGvAliS/EcJqJ+bcpJfDw5IOY/
   MR4VHWMHUVNRicmaw/IbwBY6oFkPoE6xXZme1J+quTyxWchhQwPHFaTEe
   q2lYRg8gxYIrwITwZoQSH6nPpREZClGECbqzwnInAlYVjYz6SP/nNtxl/
   LJkLZKofcQLW08Xl9ftSVm40Zn9naMUGUSMDu/dpcuFwCRU9x2hbIa802
   30PJZXwmeTWEIsj+PUHhf8Dj6uEDUav/JgGCwgKTgIiFi4bmI5ZDO2aK7
   ry/I9hZMuuFxuYl4F9BpG5IOLAYD7vzBMR+1oVjT+pkziJNDdPgr0K9Uf
   A==;
X-CSE-ConnectionGUID: 7TPp13B7RGi4+4/24wUZwA==
X-CSE-MsgGUID: QU23Y/8RRmivgc9kWkx2mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="67244982"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="67244982"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:00:30 -0800
X-CSE-ConnectionGUID: wKAJU+r/To2Xz12sBSBZQA==
X-CSE-MsgGUID: iTim9FfQTmKv3dVha2I1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117841138"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:00:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4T7-0000000GnzB-2gTb;
	Mon, 03 Mar 2025 14:00:21 +0200
Date: Mon, 3 Mar 2025 14:00:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 02/10] property: Add functions to count named child
 nodes
Message-ID: <Z8WZ1dXN7GLBYKvb@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>
 <Z8WXdf8lnivYKiks@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8WXdf8lnivYKiks@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 01:50:13PM +0200, Heikki Krogerus wrote:

...

> > +unsigned int device_get_child_node_count_named(const struct device *dev,
> > +					       const char *name)
> > +{
> > +	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +
> > +	if (!fwnode)
> > +		return -EINVAL;
> > +
> > +	if (IS_ERR(fwnode))
> > +		return PTR_ERR(fwnode);
> > +
> > +	return fwnode_get_child_node_count_named(fwnode, name);
> > +}
> > +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
> 
> Sorry if I missed something in the v4 thread, but why not do all the
> checks in fwnode_get_child_node_count_named(), and make this an inline
> function?

+1, or drop the checks and make it return 0 depending on the follow up use cases.

>         static inline unsigned int
>         device_get_child_node_count_named(const struct device *dev, const char *name)
>         {
>                 return fwnode_get_child_node_count_named(dev_fwnode(fwnode), name);
>         }

-- 
With Best Regards,
Andy Shevchenko



