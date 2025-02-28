Return-Path: <linux-iio+bounces-16164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8152A4910D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 06:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAE81884893
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 05:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C61BEF63;
	Fri, 28 Feb 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdiEh/0e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFA156861
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721352; cv=none; b=M+M3Ix4BFxirHJVXnZnZNHDurtQICC0sLcFxlr+SXXb54B37bcxTy9wdsRVtVzJrXUxbZFxte7/9kQhCq/omvc6e7TiwsDjIuzsywHKknIcMNd6JkeQs0eIdZpy7MtnScF5jHy8AyP8H1l37lpsHxc/3Ow21+DpnWcY1X0pFw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721352; c=relaxed/simple;
	bh=zNx+SAVmWl6G57S0BW/rprzaLtw/CePJbtO+ocA/I10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPddEANIonvLSeHNsyHHVix01K4BJiCBAs84FJEY3kOr/EXfVoxnxZozP0BnCap+h4mV9rT/hK/hdZoY7l5Ybe7bGLbqeD3t+lWys3jnUj+JGW9em8ETwZOIqerPJxC23MAUxUz14xKYdKx2VDINUB5/xXAZLcwPB+9d6+KKWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdiEh/0e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740721350; x=1772257350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNx+SAVmWl6G57S0BW/rprzaLtw/CePJbtO+ocA/I10=;
  b=MdiEh/0eUvURpiAf2LdYl/tKObIu3Noepp7tTMBpewjhR8cUnSOCConE
   Ix3lMaEYK0XGInW6RMQ/aqmfY7zKySAMGoSuiB1JNwOU2U91jQhwGdmLH
   a4PtApUnSsYgu7MTk+t1E23ARzcpA0OhCaoGsK1Gpqvc9UY3wu+uVG+Xr
   3qcaPCnM9xj8ASKf7/DuAovievjLnB5jpQ6fkv3wP4zgrUnHhCeI7q2V3
   9olHJZ66yQKhdQm1JoI69z+xilyc/TczpXqalk+E6ffdrIVfdxD3pgR2f
   2WgjaMwGifpQrf9+Fkg4FzuX2nduk+10vQJNCNxyJGarMkrbJ9guXfHL5
   Q==;
X-CSE-ConnectionGUID: 5NQfC957SIW+j8ajHktdOQ==
X-CSE-MsgGUID: FCHqz0BaRXe9M6eCtCxohg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="53031980"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="53031980"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 21:42:29 -0800
X-CSE-ConnectionGUID: UxLnlRBsS26MDSkQZhyITg==
X-CSE-MsgGUID: UqhdZc/BTZWSOKHIKeIXlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122369778"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 21:42:20 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnt8c-000ETK-24;
	Fri, 28 Feb 2025 05:42:18 +0000
Date: Fri, 28 Feb 2025 13:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
Message-ID: <202502281336.CipGtKOJ-lkp@intel.com>
References: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0ad2507d5d93f39619fc42372c347d6006b64319]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-ROHM-BD79124-ADC-GPO/20250225-063520
base:   0ad2507d5d93f39619fc42372c347d6006b64319
patch link:    https://lore.kernel.org/r/29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount%40gmail.com
patch subject: [PATCH v4 02/10] property: Add device_get_child_node_count_named()
config: i386-buildonly-randconfig-002-20250227 (https://download.01.org/0day-ci/archive/20250228/202502281336.CipGtKOJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502281336.CipGtKOJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502281336.CipGtKOJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/property.c:964: warning: Function parameter or struct member 'name' not described in 'device_get_child_node_count_named'


vim +964 drivers/base/property.c

   947	
   948	/**
   949	 * device_get_child_node_count_named - number of child nodes with given name
   950	 *
   951	 * Scan device's child nodes and find all the nodes with a specific name and
   952	 * return the number of found nodes. Potential '@number' -ending for scanned
   953	 * names is ignored. Eg,
   954	 * device_get_child_node_count(dev, "channel");
   955	 * would match all the nodes:
   956	 * channel { }, channel@0 {}, channel@0xabba {}...
   957	 *
   958	 * @dev: Device to count the child nodes for
   959	 *
   960	 * Return: the number of child nodes with a matching name for a given device.
   961	 */
   962	unsigned int device_get_child_node_count_named(const struct device *dev,
   963						       const char *name)
 > 964	{
   965		struct fwnode_handle *child;
   966		unsigned int count = 0;
   967	
   968		device_for_each_child_node(dev, child)
   969			if (fwnode_name_eq(child, "channel"))
   970				count++;
   971	
   972		return count;
   973	}
   974	EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
   975	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

