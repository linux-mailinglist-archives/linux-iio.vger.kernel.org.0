Return-Path: <linux-iio+bounces-21898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D484CB0EF31
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8953BDA78
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047328D849;
	Wed, 23 Jul 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggL6sDo+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929E272802;
	Wed, 23 Jul 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264998; cv=none; b=R42Qsbswzex/qQPJURir5bOs9sMp894k1U5DJFtyigsraewI17fipyj28+j8AmjI8rU5wqgFJcBt+XVf0Pu1mPJC8/zMTtvNBG8ZxjircWYSkbJDf59sP7tFxweo3GIf7Q1/ysjf71PRyyXYV0er7DCKxmpkU4D+HDnoZ23fvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264998; c=relaxed/simple;
	bh=IgGeQ0m8gC+koUHZIYM5w+vZO68unmZ9DltKgstIvlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAueVryBTz9trZPxe92Pv8qeD8Tf3/r6QVkKa05BBCF7HFHHi8bVDXpD/veMtIizRo8VxGuQ4ELTEKs4jzRmk1GdmV0hqWZlfiI+SCwGyUIm722U+c9oQTxP/IA9hrcIaLBIkJ+NRhG5WFANI8dps+fRKQLfJgb6z5QC+Wx7taY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggL6sDo+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753264996; x=1784800996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IgGeQ0m8gC+koUHZIYM5w+vZO68unmZ9DltKgstIvlI=;
  b=ggL6sDo+lV6fOSqhiyOoyKixyKV7ocJmt53ByZLM10/4mQmerkQb4aGg
   DP0AJ+OoOn1WLEGUKeY8vnO5ClmA5DsgymAP0/PgqmfWa+ETtSLNfD7Dk
   xJ37Vc5el+nUCpyHANxnDIDg1jvg99WCdMYdn8LA2Zap3PTkHniIsRJ8L
   J4YObyH5DPY3Ra6UrPWdcx8unYjROGVjfGWr2Xs9oPSFA0hFa9CzoHOcI
   DwHdl180pBVYKa06jGplb4xnLE4LhFsFFz36BpIKGFnmP4Zktq8oSEC9F
   4hMTqAmNhd/pzDUrnomAoUhhtCLENHAZTzZzsxTWehw5cxeR6WcCC9zme
   Q==;
X-CSE-ConnectionGUID: eqesqJ0oTqyZgNhrRObJjA==
X-CSE-MsgGUID: uboJmVUlTr+c5vT27NVVFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55246041"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55246041"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 03:03:16 -0700
X-CSE-ConnectionGUID: ft00YaJdTlqFioQ43nM3gA==
X-CSE-MsgGUID: wLiVLnrkS1mmgRzFTZqG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="160130656"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jul 2025 03:03:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueWJZ-000JDF-0O;
	Wed, 23 Jul 2025 10:03:09 +0000
Date: Wed, 23 Jul 2025 18:02:25 +0800
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
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org
Subject: Re: [PATCH v2 4/7] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <202507231743.Z1ToUg4r-lkp@intel.com>
References: <20250722101317.76729-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722101317.76729-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250722]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5 v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250722-181911
base:   next-20250722
patch link:    https://lore.kernel.org/r/20250722101317.76729-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 4/7] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
config: sparc-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231743.Z1ToUg4r-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231743.Z1ToUg4r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231743.Z1ToUg4r-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/phy/qualcomm/phy-qcom-eusb2-repeater.o: in function `eusb2_repeater_probe':
>> drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c:228: undefined reference to `devm_spmi_subdevice_alloc_and_add'
>> sparc-linux-ld: drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c:236: undefined reference to `__devm_regmap_init_spmi_ext'


vim +228 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c

   193	
   194	static int eusb2_repeater_probe(struct platform_device *pdev)
   195	{
   196		struct regmap_config eusb2_regmap_config = {
   197			.reg_bits = 16,
   198			.val_bits = 8,
   199			.max_register = 0x100,
   200			.fast_io = true,
   201		};
   202		struct spmi_device *sparent;
   203		struct eusb2_repeater *rptr;
   204		struct spmi_subdevice *sub_sdev;
   205		struct device *dev = &pdev->dev;
   206		struct phy_provider *phy_provider;
   207		struct device_node *np = dev->of_node;
   208		int ret;
   209	
   210		if (!dev->parent)
   211			return -ENODEV;
   212	
   213		rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
   214		if (!rptr)
   215			return -ENOMEM;
   216	
   217		rptr->dev = dev;
   218		dev_set_drvdata(dev, rptr);
   219	
   220		rptr->cfg = of_device_get_match_data(dev);
   221		if (!rptr->cfg)
   222			return -EINVAL;
   223	
   224		sparent = to_spmi_device(dev->parent);
   225		if (!sparent)
   226			return -ENODEV;
   227	
 > 228		sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
   229		if (IS_ERR(sub_sdev))
   230			return PTR_ERR(sub_sdev);
   231	
   232		ret = of_property_read_u32(np, "reg", &eusb2_regmap_config.reg_base);
   233		if (ret < 0)
   234			return ret;
   235	
 > 236		rptr->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &eusb2_regmap_config);
   237		if (IS_ERR(rptr->regmap))
   238			return -ENODEV;
   239	
   240		ret = eusb2_repeater_init_vregs(rptr);
   241		if (ret < 0) {
   242			dev_err(dev, "unable to get supplies\n");
   243			return ret;
   244		}
   245	
   246		rptr->phy = devm_phy_create(dev, np, &eusb2_repeater_ops);
   247		if (IS_ERR(rptr->phy)) {
   248			dev_err(dev, "failed to create PHY: %d\n", ret);
   249			return PTR_ERR(rptr->phy);
   250		}
   251	
   252		phy_set_drvdata(rptr->phy, rptr);
   253	
   254		phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
   255		if (IS_ERR(phy_provider))
   256			return PTR_ERR(phy_provider);
   257	
   258		return 0;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

