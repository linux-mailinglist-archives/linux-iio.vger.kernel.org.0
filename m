Return-Path: <linux-iio+bounces-16280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3022A4BF9A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25542163B57
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C746C20CCFF;
	Mon,  3 Mar 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp6Gy2cF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017120CCDF;
	Mon,  3 Mar 2025 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003155; cv=none; b=BU4bdCH6015rS6bDPDuN6K7I3xOaV4pZU/w4xa/ox5WxGXoKXPafrX5yBh+9jbE9JPqz1b4eoJVYq9xMOm8Er0tVC9t2mfrZChEfmmlY4JqQuCZJcJu9nBxAIu8g0oqJ8A0uCgk0xuPcAf14QxvsJJ3ZWuuJKdhGkf0Q+JdGZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003155; c=relaxed/simple;
	bh=5p1AURD+UTpH0MuSs+nx8i5sv3QPuK1m1t4ImSSfX9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPwOECRE/dqJjgAnEaOOBJDvG2JC4fuKO4USLmJUOLmJ8fMx4OmuuAwXgCBL50MimKThvPo/ufp6YnMb79V4ZuO1qIy+6WnUX2qzrdqnmkvixVu60OeKw4mxb+6U9PZULmk3zGChFrB42UuxtqdqcSzJOeDdh1LOO/PkXo/B+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp6Gy2cF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741003154; x=1772539154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5p1AURD+UTpH0MuSs+nx8i5sv3QPuK1m1t4ImSSfX9o=;
  b=fp6Gy2cF+ftPMmUDX7SOW/Mgbf1UeLHgGdDQ1cqYfrBZUSu8dD/PRYaR
   qEATzMNcXWBoPB9jXz6A8+349jdaANpeAiKee0BLmgHycMMBbJhO47FbF
   rZokKBD9SSNw7YHlF+Za3NQICGV11I91Vm9I1vjCDrvLRqouj6IjCY01u
   CvqrvuX7/wtcYbp2T96KkYPyuxJm7D1G5pwyL5JzWi9RGpa2YuffLWlGP
   t0qGl3Mr2hDtJmc5YjKDcRNH1kWgUq3nCYSxyXIZfaNI0lq3kzWmZPHhy
   eYIgDUYPDMtc8hGen+EBduIB8HJcLvKZslwtRBzoF6q2CT2CQbBNNEWo2
   w==;
X-CSE-ConnectionGUID: gYUSQYgaRTeXtUlmMdBIQw==
X-CSE-MsgGUID: 7060SEbgQVOnzp3/4hrIJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="52517867"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52517867"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:59:13 -0800
X-CSE-ConnectionGUID: W4pEz0p8RfekLboXWPyH1g==
X-CSE-MsgGUID: WJ9zNmVDTK2jXZzOepEyhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117735957"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:59:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4Rs-0000000GnyE-0bOy;
	Mon, 03 Mar 2025 13:59:04 +0200
Date: Mon, 3 Mar 2025 13:59:03 +0200
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
Subject: Re: [PATCH v5 02/10] property: Add functions to count named child
 nodes
Message-ID: <Z8WZh5EzFqxvU5rb@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 01:31:45PM +0200, Matti Vaittinen wrote:
> There are some use-cases where child nodes with a specific name need to
> be parsed. In a few cases the data from the found nodes is added to an
> array which is allocated based on the number of found nodes. One example
> of such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
> 
> Add a helpers for counting device's sub-nodes with certain name instead
> of open-coding this in every user.

...

> +unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle *fwnode,
> +					       const char *name)
> +{
> +	struct fwnode_handle *child;
> +	unsigned int count = 0;

> +	fwnode_for_each_child_node(fwnode, child)
> +		if (fwnode_name_eq(child, name))

I would expect this to be a separate macro

	fwnode_for_each_named_child_node()

(and its device variant) that gives us more consistent approach.

> +			count++;

And the above looks like missing {}, which won't be needed with the other
suggestion in place.

> +	return count;
> +}

> +	if (!fwnode)
> +		return -EINVAL;
> +
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);

I expect that this will return 0 or number of nodes. Why do we need an error code?
If it's really required, it should be in the fwnode API above.

Also do we care about secondary fwnodes?

> +	return fwnode_get_child_node_count_named(fwnode, name);
> +}

...

> +unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle *fwnode,
> +					       const char *name);

To me the following name sounds better: fwnode_get_named_child_node_count().

> +unsigned int device_get_child_node_count_named(const struct device *dev,
> +					       const char *name);

In the similar way.

-- 
With Best Regards,
Andy Shevchenko



