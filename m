Return-Path: <linux-iio+bounces-20032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C7AC8762
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 06:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A0E9E3431
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F021E2607;
	Fri, 30 May 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAG0axz4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B619F421;
	Fri, 30 May 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580039; cv=none; b=jkIcwJvANAX7aNXODGbHhh4MiVx54qSXzN2vcNpYW6X/kgEc02NXqS5ODyzKVbevAYgRyRky8UWfT7iL4i3P38I9CL0biBLiyeA93AVHizy4hzQhq2lMDItF8b8hJDyWSAVerEK1iWfRi6N5TVeq9Lx5j3SsypaTjvyvr5KA5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580039; c=relaxed/simple;
	bh=ZnMRKAcuaAD1rxpeXbjaOqFS9Omdp1aqc5Y0HvQwzHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fijYMe8XVj8s3cnqvTibkdezUn3QTdNexRwx45ozl8dsfKWGzGys2zkkUuLOkyD4SxJ6TzzONulgBzCkJ7CjLHHlwJx5/A56QsXPxar07SRh+gDrmhlAH7FFZKuSCkpv5VkvrZopm0vNCm+COY9xIAjaDn9Efb5ixNg8lJaFPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAG0axz4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748580039; x=1780116039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZnMRKAcuaAD1rxpeXbjaOqFS9Omdp1aqc5Y0HvQwzHY=;
  b=TAG0axz46DzvNfUlJK5IbdecvsKgw0IJZL50xrvSDnAUWlOw6YeIHKvH
   wutILlm0xBJ5G7LI5DX2QP9t/1UFzMKVjYbu2odfsKL+kRi/FlEL/yu6z
   bBBuqCfSYNFkS9KiZx3jUqordGGHkEXUsj5slrqUE2hfOQSkXixzSA2Uf
   IeFsrkMb2UVDjYPWa02gZZIUHgcDc9K33w7kz03m955tOk7vmq7f92KI2
   xVfICA4R38owonYX/7+2NBhY+4Y2p6SyQNIwmgw4sDdLmKr9nggExIrcn
   dF0eNGEbYlwFvxeq9LhjDXfkLJwclpCEz89NyTu5/dwTCsaKStGhHG2or
   w==;
X-CSE-ConnectionGUID: 5bBlYA6VTDyQJPoXSYDlwQ==
X-CSE-MsgGUID: hLtRwxFvTcCbPSpLjQeAJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="49907997"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="49907997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 21:40:38 -0700
X-CSE-ConnectionGUID: g09oUuRoQEW0E6yFOep4yA==
X-CSE-MsgGUID: hRzTB1UPRx+E/ZQgolDxcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="144747777"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 May 2025 21:40:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKrXk-000XLA-0y;
	Fri, 30 May 2025 04:40:32 +0000
Date: Fri, 30 May 2025 12:39:46 +0800
From: kernel test robot <lkp@intel.com>
To: victor.duicu@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, marius.cristea@microchip.com,
	victor.duicu@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for MCP998X
Message-ID: <202505301210.l4ZriiEX-lkp@intel.com>
References: <20250529093628.15042-3-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529093628.15042-3-victor.duicu@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c86e33819785fe50616b6ee3fb35c1e4be406d5]

url:    https://github.com/intel-lab-lkp/linux/commits/victor-duicu-microchip-com/dt-bindings-iio-temperature-add-support-for-MCP998X/20250529-173844
base:   0c86e33819785fe50616b6ee3fb35c1e4be406d5
patch link:    https://lore.kernel.org/r/20250529093628.15042-3-victor.duicu%40microchip.com
patch subject: [PATCH v2 2/2] iio: temperature: add support for MCP998X
config: m68k-randconfig-r111-20250530 (https://download.01.org/0day-ci/archive/20250530/202505301210.l4ZriiEX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250530/202505301210.l4ZriiEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505301210.l4ZriiEX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/temperature/mcp9982.c:200:14: sparse: sparse: symbol 'mcp9982_3db_values_map_tbl' was not declared. Should it be static?

vim +/mcp9982_3db_values_map_tbl +200 drivers/iio/temperature/mcp9982.c

   199	
 > 200	unsigned int mcp9982_3db_values_map_tbl[11][3][2];
   201	static const int mcp9982_sampl_fr[][2] = {
   202		{ 1, 16 },
   203		{ 1, 8 },
   204		{ 1, 4 },
   205		{ 1, 2 },
   206		{ 1, 1 },
   207		{ 2, 1 },
   208		{ 4, 1 },
   209		{ 8, 1 },
   210		{ 16, 1 },
   211		{ 32, 1 },
   212		{ 64, 1 },
   213	};
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

