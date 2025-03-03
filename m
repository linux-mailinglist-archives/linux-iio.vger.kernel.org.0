Return-Path: <linux-iio+bounces-16279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E610A4BF4C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5832E188CBA9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A020C014;
	Mon,  3 Mar 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiLNK/ya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0251F4297;
	Mon,  3 Mar 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002622; cv=none; b=HM6GO9yyN6fgoU2gwSzEncAEU9edKnjtBESu4JpL0sLn7mlEVYGy2GPq6/D7D5b60XJUULzn6qch157RHdtGUSWNJrSQbCNocp+VdN0FiUz1jZWL2KHWAKGpM4AKng7Df/nXUle/PIdOTDkdtuJbnTg9t0EJwBk15AR3hr3yyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002622; c=relaxed/simple;
	bh=snj0IOsRFkl6P2f5roV9E+UId9WY9PXHz7NyOEcIJm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plURwxP/JBE3MsB2hgHondCJTP8UC9T71ShNAsl9ZKqz5DdpoKhaYpSrzQhtWHNhhHoeGvcv+C+vxoxHdQdM6nYpIv9gMCRu3zAl0B0hEcSJ6KTElMKl1Cqfy3GRQvfJSPI7Lowglm09E42UzrTmIwr+YuEQodQAbzxy1gFFoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiLNK/ya; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741002621; x=1772538621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=snj0IOsRFkl6P2f5roV9E+UId9WY9PXHz7NyOEcIJm8=;
  b=GiLNK/ya25sSmGsW7RkiiFy20I0QltE88PtRaWzfNmPh5vPEZaWpO0mQ
   /Q5xqIi4tRvQlr0vz0abHoT2i2qm/sJiHh6h8t9wfqiGjwSwwDr6bMGPl
   R+oPZ/TCCJqfC5PeAq+YdgV8PWI5M0XvQOst6pXaNKr4APJ+Ba9wtoA+S
   LUgEp+ClJ15I18djtUaaqRKM9y63DCHjQjSytlKMhJXw2uyFBbiGzH9Jd
   qXstFMLqb67CwU2ZJ4YpsnXvMGzgfL6XJ9J7zp0h395INi+VnjkSAknQP
   FqmvR9aG6D0X7ZHXsjZNdx576imZCbwgaePJOXMKGltqwNh0parOHQPLp
   A==;
X-CSE-ConnectionGUID: C3QvsQ6+QsSGl6qWhaN5Jg==
X-CSE-MsgGUID: p32QVHxSRwiD/nqrppi1Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41995021"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41995021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:50:20 -0800
X-CSE-ConnectionGUID: xZT7KB1/S8CgofptislTcQ==
X-CSE-MsgGUID: TuVZKZz5SNSmQzv5bSvYOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123126795"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 03 Mar 2025 03:50:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Mar 2025 13:50:13 +0200
Date: Mon, 3 Mar 2025 13:50:13 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <Z8WXdf8lnivYKiks@kuha.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>

Hi,

> +/**
> + * fwnode_get_child_node_count_named - number of child nodes with given name
> + * @fwnode: Node which child nodes are counted.
> + * @name: String to match child node name against.
> + *
> + * Scan child nodes and count all the nodes with a specific name. Return the
> + * number of found nodes. Potential '@number' -ending for scanned names is
> + * ignored. Eg,
> + * device_get_child_node_count(dev, "channel");
> + * would match all the nodes:
> + * channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */
> +unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle *fwnode,
> +					       const char *name)
> +{
> +	struct fwnode_handle *child;
> +	unsigned int count = 0;
> +
> +	fwnode_for_each_child_node(fwnode, child)
> +		if (fwnode_name_eq(child, name))
> +			count++;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_child_node_count_named);
> +
> +/**
> + * device_get_child_node_count_named - number of child nodes with given name
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
> + */
> +unsigned int device_get_child_node_count_named(const struct device *dev,
> +					       const char *name)
> +{
> +	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> +
> +	if (!fwnode)
> +		return -EINVAL;
> +
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
> +
> +	return fwnode_get_child_node_count_named(fwnode, name);
> +}
> +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);

Sorry if I missed something in the v4 thread, but why not do all the
checks in fwnode_get_child_node_count_named(), and make this an inline
function?

        static inline unsigned int
        device_get_child_node_count_named(const struct device *dev, const char *name)
        {
                return fwnode_get_child_node_count_named(dev_fwnode(fwnode), name);
        }

thanks,

-- 
heikki

