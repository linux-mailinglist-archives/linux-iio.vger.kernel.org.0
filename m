Return-Path: <linux-iio+bounces-6652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8300911853
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147B4B21BAA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA7839F7;
	Fri, 21 Jun 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFxux7T6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100482891;
	Fri, 21 Jun 2024 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935939; cv=none; b=PRKbB0gQcM0JTW2YMz5zy3kbk/JU79PAw62zCQ7+P3xA3+WDGG5IAuyIWDIuUX1sDzdoMeRPA1dX6yC/9TXHoyE26w9u7W0/HFOY6D6OiriYu5Hg81TQ973U6Oqlsv72vwN9GJg07cv6uv5zz1WZ07uaVT2/5edceHqMs6jxUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935939; c=relaxed/simple;
	bh=VtbuAL0k2R3PK0ZQnn4MK2s9swzhNafL3alpu/2FQ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw25vUV4mYJ6V42e1uOzoft0QJgTt1gAPMX2hDkspY3OmplEPuqFQzF2+NbtbK8zP8RrJQRUrU/TyGmR6Q2E/FCBTYZlBcLMgMMLLTjuxSVcqXJGcK1CE0wppzpqDgVDKvCcv2aeWPTGscGXvQCcrcch+Ys4XPOpL4P3fzE+QRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFxux7T6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718935938; x=1750471938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VtbuAL0k2R3PK0ZQnn4MK2s9swzhNafL3alpu/2FQ6A=;
  b=oFxux7T6RNdHjzsDfJFeOksZqq7uv/H7Ho+jenkNycQ5KZCxRB6wVeDu
   tQJIuaOF8wV9spKvz1ebc/OHI+0qMkmmv9v2gWwY4pmKC6VA3GsjNy5vj
   mU5NhbSbvYwHcKm8ESlvFFyEH3+9PV4gX5yiVvX+9Z4EuahSCFO0aMcwZ
   tJ2hPtlhqC6bc2X4e3bM6iELxmP1rW60SN2ke4ksSdSq1jkUbSpQKlDr6
   3NVQfahmOBEmavcIfZAQzLMkd80tvZpzgyBYHpp0HEx8cFjLECyA3Dfpf
   A9XL7WF/R6DYzBwNQkzJZYWz/pdyzhabAzwfX4GPYTxKz6fqsRjsIBFDa
   Q==;
X-CSE-ConnectionGUID: 5yl1BUOTSOKfunqNHETiNQ==
X-CSE-MsgGUID: 8xxUHfpLS8Wz3uhLOjHdMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16096316"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16096316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:12:17 -0700
X-CSE-ConnectionGUID: FXAbsbInRCmjE3eRj6Lhvw==
X-CSE-MsgGUID: /11Rj0coTMuQ4KELGq1LKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="65690570"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jun 2024 19:12:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKTl5-00087B-0W;
	Fri, 21 Jun 2024 02:12:11 +0000
Date: Fri, 21 Jun 2024 10:11:41 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] iio: accel: add ADXL380 driver
Message-ID: <202406210959.gSwDq0Ql-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240621/202406210959.gSwDq0Ql-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210959.gSwDq0Ql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210959.gSwDq0Ql-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/iio/accel/adxl380.c: In function '_adxl380_config_irq':
>> drivers/iio/accel/adxl380.c:1764:16: error: implicit declaration of function 'irq_get_irq_data'; did you mean 'irq_set_irq_wake'? [-Werror=implicit-function-declaration]
    1764 |         desc = irq_get_irq_data(st->irq);
         |                ^~~~~~~~~~~~~~~~
         |                irq_set_irq_wake
>> drivers/iio/accel/adxl380.c:1764:14: warning: assignment to 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1764 |         desc = irq_get_irq_data(st->irq);
         |              ^
>> drivers/iio/accel/adxl380.c:1768:20: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]
    1768 |         irq_type = irqd_get_trigger_type(desc);
         |                    ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/adxl380.c:1769:25: error: 'IRQ_TYPE_LEVEL_HIGH' undeclared (first use in this function)
    1769 |         if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl380.c:1769:25: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iio/accel/adxl380.c:1772:32: error: 'IRQ_TYPE_LEVEL_LOW' undeclared (first use in this function)
    1772 |         } else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
         |                                ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1764 drivers/iio/accel/adxl380.c

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

