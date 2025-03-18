Return-Path: <linux-iio+bounces-17027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90244A677CC
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D019A79F2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D320FABC;
	Tue, 18 Mar 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHmBZ1RF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2042AA1;
	Tue, 18 Mar 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311499; cv=none; b=mWCXR/TcZsu8dOB6xLUENmYitvspsR0ZJ2vZFWgVQ92WvPV8RqJ/7PJvdxSINvBoThZIoe4IKfzWdQaCH3GDdH5E3aHSitG4ifotfb9cnYFOoV8eIXnWtzlCg3d2W1zz5TDTb7IGjBOXjrtYAOKzs4mJwYGo8WQl6x9Ukl/IOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311499; c=relaxed/simple;
	bh=/Vxtk/M/zsYmwadz5SgxJ5mP+fz1qKWq85EWjMZiyDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/U8Cak+/BKD0HvHAyeouGd4MJt3LlLRjx6f+PaBLom5Bj5paXyoLge7Uph/36woz+eziAcVPRO7s12ZIMoQ97XsHqG4+IdKCk/21HUgK7Sqs1u4az8dEDkD6/BkdR+nfkJVrs1SrI88Bne1aaHGa4CI0dS3ScgCU95V9Q7Engs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHmBZ1RF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742311493; x=1773847493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Vxtk/M/zsYmwadz5SgxJ5mP+fz1qKWq85EWjMZiyDo=;
  b=cHmBZ1RFSRqe4FUE5X+nAlMFWrBarJHKUUCo1ZnXcv5rKPZwXYxFcIDc
   OyeMFEMjPOQNtt5gXueGH47KywBKLYIHn/VcsyghrNCdJWp/ZLhIJ7X6j
   9SA6GAcSQVCnK7hssZZqzAq4aTt8FBEuJ5Zs2fMPJdQbNi/w20Ule638h
   WUG6LkBphcdeHv7myEgcUehy0Wi1B9Bi4RpwJcMhdXywfZE5593xeYhc1
   wPH1fEjnBFzRXANhMsGuOfQu2Z3pQyWiZWZ72JDEXF7mdZ65fpsfKeCD/
   QXnJwQcTWTUQ2cWb4KoSyleC49n0kF7KiAOGCwCGECbv1HqJqGGzBjHhO
   A==;
X-CSE-ConnectionGUID: 9w61opJDRF+XTadj9AwZGQ==
X-CSE-MsgGUID: +64MRf30QU6k6pS7L84zkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54135685"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54135685"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:24:52 -0700
X-CSE-ConnectionGUID: kMdL4c7YRZKiJ3gE8xKbMw==
X-CSE-MsgGUID: fO2F/3zYQOS+T4NonmXKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122233599"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:24:48 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 95F1711F9BD;
	Tue, 18 Mar 2025 17:24:44 +0200 (EET)
Date: Tue, 18 Mar 2025 15:24:44 +0000
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
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 02/10] property: Add functions to iterate named child
Message-ID: <Z9mQPJwnKAkPHriT@kekkonen.localdomain>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>

Moi,

On Mon, Mar 17, 2025 at 05:50:38PM +0200, Matti Vaittinen wrote:
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
> Add helpers for iterating and counting device's sub-nodes with certain
> name instead of open-coding this in every user.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Revision history:
> v7 => v8:
>  - Fix the example in fwnode_get_named_child_node_count() documentation
>    to use the fwnode_get_named_child_node_count() and not the
>    device_get_named_child_node_count()
>  - Fix the rest of the new macro's indentiations
> v6 => v7:
>  - Improve kerneldoc
>  - Inline device_get_named_child_node_count() and change it to call
>    fwnode_get_named_child_node_count() inside
>  - Fix indentiation of the new macros
> v5 => v6:
>  - Add helpers to also iterate through the nodes.
> v4 => v5:
>  - Use given name instead of string 'channel' when counting the nodes
>  - Add also fwnode_get_child_node_count_named() as suggested by Rob.
> v3 => v4:
>  - New patch as suggested by Jonathan, see discussion in:
> https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
> ---
>  drivers/base/property.c  | 27 +++++++++++++++++++++++++++
>  include/linux/property.h | 24 ++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..f42f32ff45fc 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -945,6 +945,33 @@ unsigned int device_get_child_node_count(const struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_get_child_node_count);
>  
> +/**
> + * fwnode_get_named_child_node_count - number of child nodes with given name
> + * @fwnode: Node which child nodes are counted.
> + * @name: String to match child node name against.
> + *
> + * Scan child nodes and count all the nodes with a specific name. Potential
> + * 'number' -ending after the 'at sign' for scanned names is ignored.
> + * E.g.::
> + *   fwnode_get_named_child_node_count(fwnode, "channel");
> + * would match all the nodes::
> + *   channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */
> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> +					       const char *name)
> +{
> +	struct fwnode_handle *child;
> +	unsigned int count = 0;
> +
> +	fwnode_for_each_named_child_node(fwnode, child, name)
> +		count++;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
> +
>  bool device_dma_supported(const struct device *dev)
>  {
>  	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e214ecd241eb..a1856e6b714c 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
>  	     child = fwnode_get_next_child_node(fwnode, child))
>  
> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
> +	fwnode_for_each_child_node(fwnode, child)			\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  #define fwnode_for_each_available_child_node(fwnode, child)		       \
>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>  
> +#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
> +	fwnode_for_each_available_child_node(fwnode, child)		\
> +		if (!fwnode_name_eq(child, name)) { } else
> +

OF only enumerates available nodes via the fwnode API, software nodes don't
have the concept but on ACPI I guess you could have a difference in nodes
where you have device sub-nodes that aren't available. Still, these ACPI
device nodes don't have meaningful names in this context (they're
4-character object names) so you wouldn't use them like this anyway.

So my question is: is it useful to provide this besides
fwnode_for_each_named_child_node(), given that both are effectively the
same?

>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  
> @@ -178,11 +186,19 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  	for (child = device_get_next_child_node(dev, NULL); child;	\
>  	     child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_named_child_node(dev, child, name)		\
> +	device_for_each_child_node(dev, child)				\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  #define device_for_each_child_node_scoped(dev, child)			\
>  	for (struct fwnode_handle *child __free(fwnode_handle) =	\
>  		device_get_next_child_node(dev, NULL);			\
>  	     child; child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_named_child_node_scoped(dev, child, name)	\
> +	device_for_each_child_node_scoped(dev, child)			\
> +		if (!fwnode_name_eq(child, name)) { } else
> +
>  struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  						  const char *childname);
>  struct fwnode_handle *device_get_named_child_node(const struct device *dev,
> @@ -210,6 +226,14 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
>  
>  unsigned int device_get_child_node_count(const struct device *dev);
>  
> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
> +					       const char *name);
> +static inline unsigned int device_get_named_child_node_count(const struct device *dev,
> +							     const char *name)
> +{
> +	return fwnode_get_named_child_node_count(dev_fwnode(dev), name);
> +}
> +
>  static inline int device_property_read_u8(const struct device *dev,
>  					  const char *propname, u8 *val)
>  {

-- 
Terveisin,

Sakari Ailus

