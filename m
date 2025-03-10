Return-Path: <linux-iio+bounces-16680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5AA5982D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72F916B204
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3B22C321;
	Mon, 10 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUWJnFZ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4221E0BC;
	Mon, 10 Mar 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618302; cv=none; b=sYBVd84zlhvIDhRLB5uO+zw9CrpA64BkCebsLL2g+0o0zJK+JamQ/y7NV/GJS0tc1Y5y24PB39eXOeyQvOClutrwFshQeCAaMoOaXb1jdemoch2GUFnxSbKaDcdD2LP1wDq5CDUEM/4onPKyJUXfeGk5VJVAu4ik1cQmwMckGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618302; c=relaxed/simple;
	bh=zO7kUCe8uLE5ctoZD12xa9sBOGlLFKuMkKgvnrTd5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju/Sohufs8Un8+oxtEyPJlAiCr0iLo7Etef5nJgU7FrtmdO1LqHRKIkC2s+8EC97U2KNz0mbPe4CRhSRgScv0yPsPqWRnsAtRjpQKwFt75lqRMPK71S6ZcAJF/H5pVzVeqOh0jEfGw0xeS68LS7lJcdTM5cWpIZAeV4H6eHQVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUWJnFZ7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741618301; x=1773154301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zO7kUCe8uLE5ctoZD12xa9sBOGlLFKuMkKgvnrTd5aU=;
  b=fUWJnFZ7YG0oFZogoAmkvEdJFLgN6L9w0TmKUMEBospR11rS7/8uJOkP
   ALanXBM9YiZFV9k4B+Q5JmGzbx2iCOR17s2A+r/PK5+TLcMv4dvi7DaNp
   E+uRmH46Jq/lymyijsmpJorg7m5s1JOY+GQe1299OR8imno9IhKJoMgfg
   6JU9ZpkHN9LKRbcFzP7uB1AEwVjKVu0jGkbLU3x1GNfef2UlOp9d2C+HC
   u3dGv+StD22E9AjN/y0+XxIKvF8NBAU7ha71jdZ4qe90bJtjTr9zNMJaN
   wxIfLSRaMeHYjMMnXyGzIMmzNpro2PqJkvmwITUiN8Yx/KMj3h1++aSDd
   A==;
X-CSE-ConnectionGUID: oBehZy1sSCSeL8BorUFszQ==
X-CSE-MsgGUID: 82hUhATsTFWGSZ6CdmT1BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42525843"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42525843"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:51:40 -0700
X-CSE-ConnectionGUID: kB4eIOiSTMmE6HGJMYaQSA==
X-CSE-MsgGUID: ov/+pZneR7SBXYD2R0g8zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119952590"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:51:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1treTW-00000001HaO-3Qek;
	Mon, 10 Mar 2025 16:51:26 +0200
Date: Mon, 10 Mar 2025 16:51:26 +0200
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
Message-ID: <Z878bsd7i-wAuCZ6@smile.fi.intel.com>
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

> Please note, the checkpatch.pl was not happy about the for_each...()
> macros. I tried to make them to follow the existing convention. I am
> open to suggestions how to improve.

You also may update .clang-format.

-- 
With Best Regards,
Andy Shevchenko



