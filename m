Return-Path: <linux-iio+bounces-471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C87FC9EF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6906C1C20FE5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFCF495C5;
	Tue, 28 Nov 2023 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2pl/21G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9619B0;
	Tue, 28 Nov 2023 14:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701211869; x=1732747869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ztBJ4WMhhTqyzABcnjcpzEitF6N0C+6gJOSX759StWI=;
  b=V2pl/21GqrQiB6Qb3P+vUbIj8qqsbPp9gZEYxiCFY+Dg3da/YRKilaQ/
   XjCc/yMrfwyiNPPWSphqrzllYgSkc77zK9vrymSswP+6PPHaAUdQ2SY3D
   k9ku4fyv/TZxSB75tqOy+ogejXx42fodysi3F5yV/69K3AK4z5mNg6U+x
   vQy2+XwH1CIXN3vaRSszlcSA4RMSl1DaGLnCH261X+iBr/rHePDlrZtWO
   oAJkGZXudTPmBAzY6pUIqPJzfA+AiuEePF5/3De4YJUIFkeqxv1MGr8kS
   ifRE82TLlY8Pd1CLWDXGYrifMBZ/s6hS/CNSO9xdgwt1ga3i6FfWBbr7F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6304146"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6304146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839215213"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839215213"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2023 14:51:05 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r86v1-0008Dw-0R;
	Tue, 28 Nov 2023 22:51:03 +0000
Date: Wed, 29 Nov 2023 06:50:53 +0800
From: kernel test robot <lkp@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <202311290346.3SedpbhM-lkp@intel.com>
References: <20231128124042.22744-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128124042.22744-1-petre.rodan@subdimension.ro>

Hi Petre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petre-Rodan/iio-pressure-driver-for-Honeywell-HSC-SSC-series-pressure-sensors/20231128-204804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231128124042.22744-1-petre.rodan%40subdimension.ro
patch subject: [PATCH v4 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311290346.3SedpbhM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290346.3SedpbhM-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml: properties:honeywell,pmin-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>> Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml: properties:honeywell,pmax-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmin-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmax-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

