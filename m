Return-Path: <linux-iio+bounces-10278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CD993090
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21671F22C8F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717E1D958F;
	Mon,  7 Oct 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM8HrNUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0B1EB25;
	Mon,  7 Oct 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313518; cv=none; b=XQb15nt5R5+7xIVlnNsUWLc5m04orSxvpljW9wu7XDBKJUBys/Etv1MThDiH/tSah2LsAU+c+cNQ3d75wGNcvnsTpDvfUJqZ/VogB3SthfNvIGC6vCD8llbWTqbxiDd1O9Eicx1yCkVL6zaHrOXkX0A+SHedm3IMWvpyS/B4FmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313518; c=relaxed/simple;
	bh=JRtx5eRJkXG38uPw/npJdWEVbk79L2ljNlxvw5Jbrto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNfkd2jMq8jLxzyZTjcJGXh8WIVrURkrTOoI4N2nzFKW3Qi8R7jTARsASJZvxwIDdbqGSIErf3/srgjsDzLY3F+tF1vapSM2GlHGVE/QszAgCU33rUzDWCnJ5nB8c7SvGRqR90Ey5D/0BUj5+/vzB+usTpbS/kk3jngjGbD/mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM8HrNUf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313518; x=1759849518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRtx5eRJkXG38uPw/npJdWEVbk79L2ljNlxvw5Jbrto=;
  b=iM8HrNUfzAJTiZic/iFr5CQvhsroNwn99OLTP+w5qiWnXyTvgyvpGTwL
   NWyAwACVR5JmgLOO6h4YidCO6xxOkOhV6dfB2hfA7MOZQWOvwhEdyowrP
   +UHsLQmKVMcizl2RTFzlbUsvjL8w8hOpK7RTlEismFB2OjES6W+c/ySxv
   r8YTOZRRmO5KjKychlMBFPzQJbieUTYzethtxtt8VEZbvFCqtX9xtA1UN
   MibNOmlJ493/jr9vG/tZi3gU/ZKFYSDeoWDBvSbj41D8t0bOoflWIupb4
   xZVNuy3SL2AdClnulpJa9fVNnGWKtOX+x17sr4G6tazo5x9BNhFOgMq1K
   g==;
X-CSE-ConnectionGUID: eqUbaYReQ2mMary9kcK1fQ==
X-CSE-MsgGUID: h25eV7fGSNSwC0vrEyx4ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="50001316"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="50001316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:05:16 -0700
X-CSE-ConnectionGUID: ZAw+Mk0YRgq2jIUgeYmqbA==
X-CSE-MsgGUID: IoaAwrPFTbq17UYMK81ItQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="98822607"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2024 08:04:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxpI6-00058i-2w;
	Mon, 07 Oct 2024 15:04:54 +0000
Date: Mon, 7 Oct 2024 23:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	rickard.andersson@axis.com, kernel@axis.com,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410072240.s3wGb17S-lkp@intel.com>
References: <20241005165119.3549472-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005165119.3549472-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c559323bbaabee7346c12e74b497e283aaafef5]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241006-005244
base:   0c559323bbaabee7346c12e74b497e283aaafef5
patch link:    https://lore.kernel.org/r/20241005165119.3549472-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color sensor
config: csky-randconfig-r122-20241007 (https://download.01.org/0day-ci/archive/20241007/202410072240.s3wGb17S-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241007/202410072240.s3wGb17S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410072240.s3wGb17S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/opt4060.c:963:9: sparse: sparse: dereference of noderef expression
>> drivers/iio/light/opt4060.c:963:9: sparse: sparse: dereference of noderef expression
>> drivers/iio/light/opt4060.c:963:9: sparse: sparse: dereference of noderef expression

vim +963 drivers/iio/light/opt4060.c

   951	
   952	static irqreturn_t opt4060_trigger_handler(int irq, void *p)
   953	{
   954		struct iio_poll_func *pf = p;
   955		struct iio_dev *idev = pf->indio_dev;
   956		struct opt4060_chip *chip = iio_priv(idev);
   957		struct opt4060_buffer raw;
   958		int ret, chan;
   959		int i = 0;
   960	
   961		memset(&raw, 0, sizeof(raw));
   962	
 > 963		for_each_set_bit(chan, idev->active_scan_mask, idev->masklength) {
   964			ret = opt4060_read_raw_value(chip,
   965						     opt4060_channels[chan].address,
   966						     &raw.chan[i++]);
   967			if (ret) {
   968				dev_err(chip->dev, "Reading raw channel data failed\n");
   969				goto err_read;
   970			}
   971		}
   972	
   973		iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
   974	err_read:
   975		iio_trigger_notify_done(idev->trig);
   976		return IRQ_HANDLED;
   977	}
   978	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

