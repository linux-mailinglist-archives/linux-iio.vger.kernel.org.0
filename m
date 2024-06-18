Return-Path: <linux-iio+bounces-6500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14390D53A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416BE1F22507
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FC13DDDA;
	Tue, 18 Jun 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1uJ0Y6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691618040;
	Tue, 18 Jun 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719982; cv=none; b=fbrrY/SaX7c9pJ7a4DtN40BD5vmd6GRwoK9xOliNYw1AqCg3a1yYYR1kn6Fcu9SzR4aY8YbyvmiRN1iKXvF1CPAzwKeT7XKCBlpHNpl+JkWyy86qD33IVbYA4cl2ZOcnDWqIitNFUCD72HsqeWTjDBuDvnfH5ROCJ6T2VzzmxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719982; c=relaxed/simple;
	bh=lLz9t87GAV8WZCzP6X8aC19L9aHIUDZG7fDqmJ8BeO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMD7W7cG9KCap8NT+WLca5GISSpI+DwvH/1+vd8Y2b+PqVztu77m04kBajEpd38k3soswpMSZ7UbSx0Xhu1pqO0sOxroxfXFhDeEOVsFT3nRz2w+ewRVavDycE0MYs0KEljRlbh0NEs8bfgpm69iGF+66T9jn7XpVBiCgRcFe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1uJ0Y6Y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719981; x=1750255981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLz9t87GAV8WZCzP6X8aC19L9aHIUDZG7fDqmJ8BeO4=;
  b=S1uJ0Y6YE3ks8OiR4xVbiY8YjmUYA9Z5AKNTA3vmggXofOrUo9IlwH7r
   vpcPGL12grb63hjIBZrxnBO7mhT4CD5+mfvRwGYAIIPfeRq8JBKVB0NUB
   CdOarSucRwBlTlqr41dXj+WWTxXLfa16OuRIQ579S4kEh1BeC1Mp0ujtQ
   0yrDTqHPNQkeurbP0NKQc+1KoX/9pmfuUY/A0b+IzYmKKxfSThhBWLDhf
   dVjwSZ4lrylF5WZFHRJtrLeVcEEgr+zkjoe+92RD6djkoe/z/nmjbuYv5
   vKstgroFVaHpbiWnt6qUAshwh8Vq0BOOn024xcR28h8lWQZD1mh1k972u
   A==;
X-CSE-ConnectionGUID: yveDJFJKSD2ZnjbDgHVKtw==
X-CSE-MsgGUID: hwf9/lIdTiqv88Rv37MByQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15439259"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15439259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:13:01 -0700
X-CSE-ConnectionGUID: L/KDT+eqS0C7agofXOHiUg==
X-CSE-MsgGUID: +V223NW8S3C6Fq4nSjr71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="45928171"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jun 2024 07:12:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJZZt-0005aN-36;
	Tue, 18 Jun 2024 14:12:53 +0000
Date: Tue, 18 Jun 2024 22:12:08 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] docs: iio: add documentation for adxl380 driver
Message-ID: <202406182244.fOy7IrR8-lkp@intel.com>
References: <20240618105150.38141-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618105150.38141-3-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc4]
[cannot apply to jic23-iio/togreg next-20240617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-accel-add-ADXL380-driver/20240618-194141
base:   linus/master
patch link:    https://lore.kernel.org/r/20240618105150.38141-3-antoniu.miclaus%40analog.com
patch subject: [PATCH 3/3] docs: iio: add documentation for adxl380 driver
reproduce: (https://download.01.org/0day-ci/archive/20240618/202406182244.fOy7IrR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406182244.fOy7IrR8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/iio/adxl380.rst references a file that doesn't exist: Documentation/iio/iio_tools.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

