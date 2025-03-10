Return-Path: <linux-iio+bounces-16678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20161A59786
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DDA16B8AB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEC22B8D1;
	Mon, 10 Mar 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD1wPxDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AE229B1F;
	Mon, 10 Mar 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616760; cv=none; b=FEXvJe2zL1VjqvdG3qKvhvBUJmI6re8wLcY2y1VomAaDnlIA1+4EI6Tm5sdJR5Dct0ZoeP6BwNE4rgrBBcMf0ADnp5cJFaI5s58AbgKWx0Xk6jZlHGsJXCdDEelWnbX+v1z288tJQORrdvtkq+9sNNOPyVvD9xKIe9kaCB936ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616760; c=relaxed/simple;
	bh=KTv7qk5oFKTYLjgfXPm/6oQ2B3je70yz0idFkos48O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN6z+a/UYVDxMSvTYxPwH8DOT4c9vDtBnEMbPiXYE1i7OsjLsJvZbL1fqLaWtLuvy9wWXTCFRz5Tq9qdGqttSTDoSv43JOmkKD1iDz9SdwhkxHgBY/RpvCzZjFavKmqWoCE7tNUQEgiTxZ5pT8ywewv/whf5RHAhYWVPp+omoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD1wPxDG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741616758; x=1773152758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTv7qk5oFKTYLjgfXPm/6oQ2B3je70yz0idFkos48O0=;
  b=oD1wPxDGFB8Ple/HMz5XT3EFrAShSiVNsVflzgoF5BnsoRNZ1Pp+8o16
   NFN8uBDuSRy2TpPh8c79iuD2h+NSR9BvUPS1vZMKqDWMiiYp3Q72Cyhoq
   4WisPtN6bSHxgMo13tU86c6z2RhpQyf3PEqRZQGkyxlmG2hI+FvSE5m4M
   3dpwiqkb3ubkQSUuySLg2ukpzvkcTfhDTcNLAWhLbI2H3DydiOMeZur7f
   POUsygWmXNDkLJo/lsc7GDml6GTOvTrR2QxvFk+vrYudASjgd7NiHZgaE
   Z1fYiYDVLgFeYZAMyp1EuhOY864UF9/6hreggvJ7TVkuh4s7b9+92+5iy
   A==;
X-CSE-ConnectionGUID: am71XqZWSkCUM4sTDE5jpA==
X-CSE-MsgGUID: x/2sxWncQyaUcUmiYHnBLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41783035"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41783035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:25:57 -0700
X-CSE-ConnectionGUID: jDa+VHRMR/+nIR3ONdo6JQ==
X-CSE-MsgGUID: iGz3W6rdQtqyLnR9sIXeUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124609108"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:25:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tre4i-00000001HFA-3w1b;
	Mon, 10 Mar 2025 16:25:48 +0200
Date: Mon, 10 Mar 2025 16:25:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH v6 02/10] property: Add functions to iterate named child
Message-ID: <Z872bHMRtSglB8pf@smile.fi.intel.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
 <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 10, 2025 at 02:55:53PM +0200, Matti Vaittinen wrote:
> There are a few use-cases where child nodes with a specific name need to
> be parsed. Code like:
> 
> fwnode_for_each_child_node()
> 	if (fwnode_name_eq())
> 		...
> 
> can be found from a various drivers/subsystems. Adding a macro for this
> can simplify things a bit.
> 
> In a few cases the data from the found nodes is later added to an array,
> which is allocated based on the number of found nodes. One example of
> such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
> 
> Add a helpers for iterating and counting device's sub-nodes with certain
> name instead, of open-coding this in every user.

Almost good, I doubt we need the exported function for the device as it can be
derived from the fwnode_*() API by supplying dev_fwnode(dev).

Perhaps we want also this for the completeness (other comments are below):

 From f52dbbe97ff0cdf835eef29506e482433f0a50a9 Mon Sep 17 00:00:00 2001
 From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Date: Mon, 10 Mar 2025 16:20:35 +0200
 Subject: [PATCH 1/1] device property: Split fwnode_get_child_node_count()

The new helper is introduced to allow counting the child firmware nodes
of their parent without requiring a device to be passed. This also makes
the fwnode and device property API more symmetrical with the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 12 ++++++------
 include/linux/property.h |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..805f75b35115 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -928,22 +928,22 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
 /**
- * device_get_child_node_count - return the number of child nodes for device
- * @dev: Device to count the child nodes for
+ * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
+ * @fwnode: Pointer to the parent firmware node
  *
- * Return: the number of child nodes for a given device.
+ * Return: the number of child nodes for a given firmware node.
  */
-unsigned int device_get_child_node_count(const struct device *dev)
+unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *child;
 	unsigned int count = 0;
 
-	device_for_each_child_node(dev, child)
+	fwnode_for_each_child_node(fwnode, child)
 		count++;
 
 	return count;
 }
-EXPORT_SYMBOL_GPL(device_get_child_node_count);
+EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
 
 bool device_dma_supported(const struct device *dev)
 {
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..bc5bfc98176b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -208,7 +208,12 @@ DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-unsigned int device_get_child_node_count(const struct device *dev);
+unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode);
+
+static inline unsigned int device_get_child_node_count(const struct device *dev)
+{
+	return fwnode_get_child_node_count(dev_fwnode(dev));
+}
 
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)

...

> Please note, the checkpatch.pl was not happy about the for_each...()
> macros. I tried to make them to follow the existing convention. I am
> open to suggestions how to improve.

checkpatch is known for false-positives and/or false-negatives.

...

> +/**
> + * fwnode_get_named_child_node_count - number of child nodes with given name
> + * @fwnode: Node which child nodes are counted.
> + * @name: String to match child node name against.
> + *
> + * Scan child nodes and count all the nodes with a specific name. Return the

You already have a return section below. Perhaps rephrase somehow?

> + * number of found nodes. Potential '@number' -ending for scanned names is

Not sure how this "'@foo' -ending" part is being rendered in HTML/PDF...
Also kernel-doc might be not happy with the @ character followed by an
immediate text as it might be misinterpreted as a reference to a parameter.

> + * ignored. Eg,

E.g.,

(because it's the phrase in Latin: exempli gratia)

> + * device_get_child_node_count(dev, "channel");

Shift right to make sure it's not a text, but a code, better even to use reST
approach, i.e. (note additional leading space(s) and double colon):

 * ignored. E.g.::
 *
 *   fwnode_get_child_node_count(dev, "channel"); // you have a copy'n'paste typo
 *
 * would match all the nodes::
 *
 *   ...
 *

> + * would match all the nodes:
> + * channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */

...

> +/**
> + * device_get_named_child_node_count - number of child nodes with given name
> + * @dev: Device to count the child nodes for.
> + * @name: String to match child node name against.
> + *
> + * Scan device's child nodes and find all the nodes with a specific name and
> + * return the number of found nodes. Potential '@number' -ending for scanned
> + * names is ignored. Eg,
> + * device_get_child_node_count(dev, "channel");
> + * would match all the nodes:
> + * channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.

Similar comments as per above.

> + */

...

> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
> +		fwnode_for_each_child_node(fwnode, child)		\

One TAB too much.

> +			if (!fwnode_name_eq(child, name)) { } else

Ditto.

Note, I believe this won't get v6.15-rc1, so there will be for_each_if()
available and these will become

#define fwnode_for_each_named_child_node(fwnode, child, name)	\
	fwnode_for_each_child_node(fwnode, child)		\
		for_each_if(fwnode_name_eq(child, name))

and so on...

...

>  unsigned int device_get_child_node_count(const struct device *dev);
> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> +					       const char *name);
> +unsigned int device_get_named_child_node_count(const struct device *dev,
> +					       const char *name);

I would add a blank line.

unsigned int device_get_child_node_count(const struct device *dev);
// here is a blank line
unsigned int device_get_named_child_node_count(const struct device *dev,
					       const char *name);
unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
					       const char *name);

But see above the proposed additional patch that you may include in your next
version.

>  static inline int device_property_read_u8(const struct device *dev,
>  					  const char *propname, u8 *val)

-- 
With Best Regards,
Andy Shevchenko



