Return-Path: <linux-iio+bounces-6653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED09118D1
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 04:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D061C2216C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAABA85260;
	Fri, 21 Jun 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgH8WeJs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DF84A32;
	Fri, 21 Jun 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937803; cv=none; b=RVVhk3ZwnbyyxgZaYM/gr0fsQ6JFKiQzxRH0x+K+lBSuL5fH1+gJHwH4axmzWliGtJwI3BtVYD/I5nwaATOu0TSAZodQL6QaAEvgMKiNEBTWqyv5C7ctF/rsPJRvUZg3WkiITXOSCRxNHm5kS7/1lngcz2RjMsThyx/qk2x2Gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937803; c=relaxed/simple;
	bh=R89nx9GPsZw3sS3/Gf6Reyi/X9jJl5d4U1rPtlvh8yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJH3qhVH6rNP2XAiTObTMlk7eJpKeVOJ5I6VOihJ66ONrucZfyb52zpOTCbtbVYMWlFeym+hJFP2aoTyR9eSoLKvt3dqUMdF8qx+xHKjAg4sDxS+jPpw99BWcy7FJbmEqEwVnaG6QmL8aN9dxY9epdXs6FvxCN8LUkEn4Sdhe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgH8WeJs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718937801; x=1750473801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R89nx9GPsZw3sS3/Gf6Reyi/X9jJl5d4U1rPtlvh8yY=;
  b=jgH8WeJsxg/M1N8yJEZJG7cSxOH9zxFXxrVFLzhO5qsOfU+kdaTC7sUY
   vcUOVi54ZyxVJq6ZxPFajGxtcvdjrA10Nko4SFL//RzzRXXDBsyY6eLhy
   dK5XmKziegOwNHnp9hSnslzvsTAg/Vlt2VF/IhNBznDb52dmal+S6mcuI
   Ffbglj0gEWfMNPGCqozt/QGkLp8eefT4mpJXvUDJh7s5X22RQ2dKaQmkb
   Lxl0t7gDSCt4rBkGHGdcsOMrpkm5HlBZE5skPslbcDx/j95U54dMG0c4+
   G/YziZYznKaDahFKxsEi5yhIhsK3QFg7kmOk/zx93e5yBFhQLsIKf5Sp+
   Q==;
X-CSE-ConnectionGUID: TO6mZGDvTyezWMdLOavgtQ==
X-CSE-MsgGUID: KhFHBPrRSQ+ERbC/jy+Cyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33413349"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="33413349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:43:20 -0700
X-CSE-ConnectionGUID: eFhGsVG3RZOaHxSCwbdPzA==
X-CSE-MsgGUID: AWVMIsbCSqy0MWaoPHI4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42308319"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Jun 2024 19:43:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKUF7-00088I-2M;
	Fri, 21 Jun 2024 02:43:13 +0000
Date: Fri, 21 Jun 2024 10:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] iio: accel: add ADXL380 driver
Message-ID: <202406210921.VoM5ac1P-lkp@intel.com>
References: <20240618105150.38141-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618105150.38141-2-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc4 next-20240620]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-accel-add-ADXL380-driver/20240618-194141
base:   linus/master
patch link:    https://lore.kernel.org/r/20240618105150.38141-2-antoniu.miclaus%40analog.com
patch subject: [PATCH 2/3] iio: accel: add ADXL380 driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240621/202406210921.VoM5ac1P-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210921.VoM5ac1P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210921.VoM5ac1P-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/accel/adxl380.c:1764:9: error: call to undeclared function 'irq_get_irq_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1764 |         desc = irq_get_irq_data(st->irq);
         |                ^
   drivers/iio/accel/adxl380.c:1764:9: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:485:12: note: 'irq_set_irq_wake' declared here
     485 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
>> drivers/iio/accel/adxl380.c:1764:7: error: incompatible integer to pointer conversion assigning to 'struct irq_data *' from 'int' [-Wint-conversion]
    1764 |         desc = irq_get_irq_data(st->irq);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/adxl380.c:1768:13: error: call to undeclared function 'irqd_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1768 |         irq_type = irqd_get_trigger_type(desc);
         |                    ^
>> drivers/iio/accel/adxl380.c:1769:18: error: use of undeclared identifier 'IRQ_TYPE_LEVEL_HIGH'
    1769 |         if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
         |                         ^
>> drivers/iio/accel/adxl380.c:1772:25: error: use of undeclared identifier 'IRQ_TYPE_LEVEL_LOW'
    1772 |         } else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
         |                                ^
   5 errors generated.


vim +/irq_get_irq_data +1764 drivers/iio/accel/adxl380.c

  1754	
  1755	static int _adxl380_config_irq(struct iio_dev *indio_dev)
  1756	{
  1757		int ret;
  1758		struct irq_data *desc;
  1759		unsigned long irq_flag;
  1760		u32 irq_type;
  1761		u8 polarity;
  1762		struct adxl380_state *st = iio_priv(indio_dev);
  1763	
> 1764		desc = irq_get_irq_data(st->irq);
  1765		if (!desc)
  1766			return dev_err_probe(st->dev, -EINVAL, "Could not find IRQ %d\n", st->irq);
  1767	
> 1768		irq_type = irqd_get_trigger_type(desc);
> 1769		if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
  1770			polarity = 0;
  1771			irq_flag = IRQF_TRIGGER_HIGH;
> 1772		} else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
  1773			polarity = 1;
  1774			irq_flag = IRQF_TRIGGER_LOW;
  1775		} else {
  1776			return dev_err_probe(st->dev, -EINVAL, "Invalid interrupt type 0x%x specified\n",
  1777				irq_type);
  1778		}
  1779	
  1780		ret = regmap_update_bits(st->regmap, ADXL380_INT0,
  1781					 ADXL380_INT0_POL_MSK,
  1782					 FIELD_PREP(ADXL380_INT0_POL_MSK, polarity));
  1783		if (ret)
  1784			return ret;
  1785	
  1786		return devm_request_threaded_irq(st->dev, st->irq, NULL,
  1787						 adxl380_irq_handler,
  1788						 IRQF_ONESHOT | irq_flag,
  1789						 indio_dev->name, indio_dev);
  1790	}
  1791	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

