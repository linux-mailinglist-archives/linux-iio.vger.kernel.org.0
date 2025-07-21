Return-Path: <linux-iio+bounces-21816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D99B0C2FE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF01188C700
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1E29DB79;
	Mon, 21 Jul 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djgJ2LvK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6F288C0C;
	Mon, 21 Jul 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097480; cv=none; b=q7ZqPPLlMaS6bC++YTkRSSopJrAtARDdfcQb2o+TOH9OMic0qj6PUIc7nXxT3Wgc7r6h+E/SC8Qg7tgKNOFeXyDBOw6+yfyc9x/As0WWsVIyYSPLOJzQSruBexyhBrO5SDp39F02brIZIgO87dHc8qVMGZzhHOgYDWCWqfJ8JLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097480; c=relaxed/simple;
	bh=ni6NB75dBKeFo+kbnJ/UKz3oYO037eTbMmo0vF9YVBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0FIz7RRNQohPO/WjPkpfDaoYtl+A9MDSzQQWZfdvYF4U8rdFilHVV3yw0fqhcJ+gU+OCjhEXo8c1ZUQxdiZA1J8qSS7pIL7MvzY/eYeHFoqNj/XK2I0kOwp1fiJ7aFWuR6xtz4NdG6yhrzfdPZ15/0zPlCPYLc91SdcQ8YucMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djgJ2LvK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097479; x=1784633479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ni6NB75dBKeFo+kbnJ/UKz3oYO037eTbMmo0vF9YVBU=;
  b=djgJ2LvKrhEBOkBwBQifO/Q/QyUzV3BLX2WA0XiRML+AGGw6k+xeQ9hv
   02L6kQjt3FcTLMRwkB4s9EOYiwa3oZqQ2FVv/IB1dtmhDQyIV4H98V+Nx
   DGmuSARZrSLI0M/yb337DiEmaSi6kxTJZxgrQHjzCooIZuUTnMsof/aon
   i8jETXzTQZHaPZsCU3mlye1arKbc1Gy1cYz0wQI82mYDBTwaodKiN95Nw
   NNCZL8ncZw6SiU5hqyTs5dYFiVAwygqtPPswMly2+4LxHYvkQYRS7mWeT
   y4wuyE34PkLBqR32XFu9i+tA9KpOP113zOH+Gsq598lRMEkeMI00ptUP7
   Q==;
X-CSE-ConnectionGUID: Ig2pPqOpSpyWsJ6vUXsiMA==
X-CSE-MsgGUID: LUOa5WnMQi2rYhWHvUlSSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="72877893"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="72877893"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:31:18 -0700
X-CSE-ConnectionGUID: k3nqpQsRRV21/dckljTYhg==
X-CSE-MsgGUID: IuA4pZulSxy2Xw8ORfd5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="162855115"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jul 2025 04:31:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udojf-000Gkz-0h;
	Mon, 21 Jul 2025 11:31:11 +0000
Date: Mon, 21 Jul 2025 19:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 5/7] misc: qcom-coincell: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <202507211953.9ai6l420-lkp@intel.com>
References: <20250721075525.29636-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075525.29636-6-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250718]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5 v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250721-155809
base:   next-20250718
patch link:    https://lore.kernel.org/r/20250721075525.29636-6-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v1 5/7] misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
config: x86_64-buildonly-randconfig-003-20250721 (https://download.01.org/0day-ci/archive/20250721/202507211953.9ai6l420-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507211953.9ai6l420-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507211953.9ai6l420-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `qcom_coincell_probe':
>> drivers/misc/qcom-coincell.c:111: undefined reference to `devm_spmi_subdevice_alloc_and_add'
>> ld: drivers/misc/qcom-coincell.c:115: undefined reference to `__devm_regmap_init_spmi_ext'


vim +111 drivers/misc/qcom-coincell.c

    83	
    84	static int qcom_coincell_probe(struct platform_device *pdev)
    85	{
    86		struct regmap_config qcom_coincell_regmap_config = {
    87			.reg_bits = 16,
    88			.val_bits = 16,
    89			.max_register = 0x100,
    90			.fast_io = true
    91		};
    92		struct device_node *node = pdev->dev.of_node;
    93		struct spmi_subdevice *sub_sdev;
    94		struct spmi_device *sparent;
    95		struct qcom_coincell chgr;
    96		u32 rset = 0;
    97		u32 vset = 0;
    98		bool enable;
    99		int rc;
   100	
   101		chgr.dev = &pdev->dev;
   102	
   103		rc = of_property_read_u32(node, "reg", &qcom_coincell_regmap_config.reg_base);
   104		if (rc)
   105			return rc;
   106	
   107		sparent = to_spmi_device(pdev->dev.parent);
   108		if (!sparent)
   109			return -ENODEV;
   110	
 > 111		sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
   112		if (IS_ERR(sub_sdev))
   113			return PTR_ERR(sub_sdev);
   114	
 > 115		chgr.regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev,
   116							&qcom_coincell_regmap_config);
   117		if (!chgr.regmap) {
   118			dev_err(chgr.dev, "Unable to get regmap\n");
   119			return -EINVAL;
   120		}
   121	
   122		enable = !of_property_read_bool(node, "qcom,charger-disable");
   123	
   124		if (enable) {
   125			rc = of_property_read_u32(node, "qcom,rset-ohms", &rset);
   126			if (rc) {
   127				dev_err(chgr.dev,
   128					"can't find 'qcom,rset-ohms' in DT block");
   129				return rc;
   130			}
   131	
   132			rc = of_property_read_u32(node, "qcom,vset-millivolts", &vset);
   133			if (rc) {
   134				dev_err(chgr.dev,
   135				    "can't find 'qcom,vset-millivolts' in DT block");
   136				return rc;
   137			}
   138		}
   139	
   140		return qcom_coincell_chgr_config(&chgr, rset, vset, enable);
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

