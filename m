Return-Path: <linux-iio+bounces-17103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E48A69332
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5097ABD2C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E941CAA70;
	Wed, 19 Mar 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAsOR6BA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D711AF0BC;
	Wed, 19 Mar 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397833; cv=none; b=iVtcfBR/h3vOG5ZhpfE4PG7G8AdxXIcZd6XgADzZv8btEy/wJEcqIYgRHeFiQOpEiL5F+QWprVrPAePLbe+tlSpS5Zvf3tYHHVDZBXZMOm3QS04u9HcRM42mhmzDWXc2I2SnGDdLPIt2wkJvUmFxOi2JSAXCm6zjmyq0H/JXrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397833; c=relaxed/simple;
	bh=+ND2GQ1ucjL2Fbj/gHU8rnxTiLp8tL39vHpjDRl8G5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLyj+tpYoWp+pv/JeVzRtKcA1HPWa3NgTm8b4+TjaSsfhO3YW+pIxMALKVlfzcocOg8PpFeIhvmHI1D7ToPV6hae6RCDxRmJI7J/k7wflT+6FJyUM38tRW1KoCnyx7ACaiET83PY8S66iAzPRbTCD1vkAx+Wv+zGY9pWcVesnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAsOR6BA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742397832; x=1773933832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ND2GQ1ucjL2Fbj/gHU8rnxTiLp8tL39vHpjDRl8G5A=;
  b=eAsOR6BAWppqkOMXNXLsbA4C/Jn/nP33uZFU67qC0+VZtmufHdiaNXBc
   /4ImQGuriHjwy/AAz0az7uk6VUO1wCIHyYmVPrCWpHx528T9aCyyRzBu0
   lYoiKEx1N4KixKyNjH1aQ7ZF0p+I3wK8S6GhI/zHwNVv1nblmoxX6d49h
   s2M65DAlv46bWHosW4DZ8kU/d5kt6c18ie2MDiCbrJZVfl1CuZVzZD4wX
   8dpc0KqI1DrjLchMTKkYg7/3lWEKGqsgv2sI+AgXiOsYjTdNpY1f8x8TQ
   OZTjCQRqaBrJIAXxW8YETgf5cH5XZRfgl+t4O7uoeQ3mqn5LvbI7H9bGh
   A==;
X-CSE-ConnectionGUID: KBFwm3yhRfK8Lt0TtqUqFQ==
X-CSE-MsgGUID: F8LdNn8fS66zhmF+LDD3tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31174872"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31174872"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:23:51 -0700
X-CSE-ConnectionGUID: 1KhLNtoLQ4eE7Zyd8ixR4w==
X-CSE-MsgGUID: 6RmOKgCuQwGgjoIUotAsvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153527828"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:23:45 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5A9F811F998;
	Wed, 19 Mar 2025 17:23:40 +0200 (EET)
Date: Wed, 19 Mar 2025 15:23:40 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
	netdev@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 02/10] property: Add functions to iterate named child
Message-ID: <Z9rhfJUlCbi7kA2m@kekkonen.localdomain>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>
 <Z9mQPJwnKAkPHriT@kekkonen.localdomain>
 <b6b62ddd-ab59-4112-8f6e-c72618c45910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b62ddd-ab59-4112-8f6e-c72618c45910@gmail.com>

Hei Matti,

On Wed, Mar 19, 2025 at 08:02:24AM +0200, Matti Vaittinen wrote:
> Moro Sakari,
> 
> Thanks for the review.
> 
> On 18/03/2025 17:24, Sakari Ailus wrote:
> > Moi,
> > 
> > On Mon, Mar 17, 2025 at 05:50:38PM +0200, Matti Vaittinen wrote:
> > > There are a few use-cases where child nodes with a specific name need to
> > > be parsed. Code like:
> > > 
> > > fwnode_for_each_child_node()
> > > 	if (fwnode_name_eq())
> > > 		...
> > > 
> > > can be found from a various drivers/subsystems. Adding a macro for this
> > > can simplify things a bit.
> > > 
> > > In a few cases the data from the found nodes is later added to an array,
> > > which is allocated based on the number of found nodes. One example of
> > > such use is the IIO subsystem's ADC channel nodes, where the relevant
> > > nodes are named as channel[@N].
> > > 
> > > Add helpers for iterating and counting device's sub-nodes with certain
> > > name instead of open-coding this in every user.
> > > 
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > > Revision history:
> > > v7 => v8:
> > >   - Fix the example in fwnode_get_named_child_node_count() documentation
> > >     to use the fwnode_get_named_child_node_count() and not the
> > >     device_get_named_child_node_count()
> > >   - Fix the rest of the new macro's indentiations
> > > v6 => v7:
> > >   - Improve kerneldoc
> > >   - Inline device_get_named_child_node_count() and change it to call
> > >     fwnode_get_named_child_node_count() inside
> > >   - Fix indentiation of the new macros
> > > v5 => v6:
> > >   - Add helpers to also iterate through the nodes.
> > > v4 => v5:
> > >   - Use given name instead of string 'channel' when counting the nodes
> > >   - Add also fwnode_get_child_node_count_named() as suggested by Rob.
> > > v3 => v4:
> > >   - New patch as suggested by Jonathan, see discussion in:
> > > https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
> > > ---
> > >   drivers/base/property.c  | 27 +++++++++++++++++++++++++++
> > >   include/linux/property.h | 24 ++++++++++++++++++++++++
> > >   2 files changed, 51 insertions(+)
> > > 
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index c1392743df9c..f42f32ff45fc 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -945,6 +945,33 @@ unsigned int device_get_child_node_count(const struct device *dev)
> > >   }
> > >   EXPORT_SYMBOL_GPL(device_get_child_node_count);
> > > +/**
> > > + * fwnode_get_named_child_node_count - number of child nodes with given name
> > > + * @fwnode: Node which child nodes are counted.
> > > + * @name: String to match child node name against.
> > > + *
> > > + * Scan child nodes and count all the nodes with a specific name. Potential
> > > + * 'number' -ending after the 'at sign' for scanned names is ignored.
> > > + * E.g.::
> > > + *   fwnode_get_named_child_node_count(fwnode, "channel");
> > > + * would match all the nodes::
> > > + *   channel { }, channel@0 {}, channel@0xabba {}...
> > > + *
> > > + * Return: the number of child nodes with a matching name for a given device.
> > > + */
> > > +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> > > +					       const char *name)
> > > +{
> > > +	struct fwnode_handle *child;
> > > +	unsigned int count = 0;
> > > +
> > > +	fwnode_for_each_named_child_node(fwnode, child, name)
> > > +		count++;
> > > +
> > > +	return count;
> > > +}
> > > +EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
> > > +
> > >   bool device_dma_supported(const struct device *dev)
> > >   {
> > >   	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
> > > diff --git a/include/linux/property.h b/include/linux/property.h
> > > index e214ecd241eb..a1856e6b714c 100644
> > > --- a/include/linux/property.h
> > > +++ b/include/linux/property.h
> > > @@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
> > >   	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
> > >   	     child = fwnode_get_next_child_node(fwnode, child))
> > > +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
> > > +	fwnode_for_each_child_node(fwnode, child)			\
> > > +		if (!fwnode_name_eq(child, name)) { } else
> > > +
> > >   #define fwnode_for_each_available_child_node(fwnode, child)		       \
> > >   	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> > >   	     child = fwnode_get_next_available_child_node(fwnode, child))
> > > +#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
> > > +	fwnode_for_each_available_child_node(fwnode, child)		\
> > > +		if (!fwnode_name_eq(child, name)) { } else
> > > +
> > 
> > OF only enumerates available nodes via the fwnode API, software nodes don't
> > have the concept but on ACPI I guess you could have a difference in nodes
> > where you have device sub-nodes that aren't available. Still, these ACPI
> > device nodes don't have meaningful names in this context (they're
> > 4-character object names) so you wouldn't use them like this anyway.
> 
> I believe you have far better understanding on these concepts than I do. The
> reason behind adding fwnode_for_each_available_child_node() was the patch
> 10/10:
> 
> -	fwnode_for_each_available_child_node(sensors, node) {
> -		if (fwnode_name_eq(node, "sensor")) {
> -			if (!thp7312_sensor_parse_dt(thp7312, node))
> -				num_sensors++;
> -		}
> +	fwnode_for_each_available_named_child_node(sensors, node, "sensor") {
> +		if (!thp7312_sensor_parse_dt(thp7312, node))
> +			num_sensors++;
>  	}
> 
> 
> > So my question is: is it useful to provide this besides
> > fwnode_for_each_named_child_node(), given that both are effectively the
> > same?
> 
> So, I suppose you're saying the existing thp7312 -driver has no real reason
> to use the 'fwnode_for_each_available_child_node()', but it could be using
> fwnode_for_each_child_node() instead?
> 
> If so, I am Ok with dropping the
> 'fwnode_for_each_available_named_child_node()' and changing the 10/10 to:
> 
> -	fwnode_for_each_available_child_node(sensors, node) {
> -		if (fwnode_name_eq(node, "sensor")) {
> -			if (!thp7312_sensor_parse_dt(thp7312, node))
> -				num_sensors++;
> -		}
> +	fwnode_for_each_named_child_node(sensors, node, "sensor") {
> +		if (!thp7312_sensor_parse_dt(thp7312, node))
> +			num_sensors++;
>  	}
> 
> Do you think that'd be correct?

I'd say so. Feel free to cc me to the last patch as well.

I guess one way to make this clearer is to switch to
fwnode_for_each_child_node() in a separate patch before
fwnode_for_each_named_child_node() conversion.

There are also just a handful of users of
fwnode_for_each_available_child_node() and I guess these could be
converted, too, but I think it's outside the scope of the set.

-- 
Terveisin,

Sakari Ailus

