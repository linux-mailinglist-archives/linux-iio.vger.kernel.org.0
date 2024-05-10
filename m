Return-Path: <linux-iio+bounces-4938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA198C2C8D
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A02B1F22ED9
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 22:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662B13D252;
	Fri, 10 May 2024 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYKln0oH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4115E86;
	Fri, 10 May 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379766; cv=none; b=YGZ9vmj7VQjc67Allnw3DhFetXO+wbOvrbfawNc8ARi4wmqnGclm3sRITPltp0QTMVJEPl4r7HbzkvOcrbbkjYxvag8eYyy02U78JPnbAa5cBpOz9nDOL9KdZpj3mygBvg3//4sO1qZCmsi+tIzUMXGagSDkKgTDG5tLC5OWi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379766; c=relaxed/simple;
	bh=1eupN9In0SKeHI6aNxZYRKBeLC1ty/HA2POqcDmV410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzApeIR2ld9e1OCMM/RANPC7bgD/WIUJ5tWdWWMw7/IEEjlAsZYGJ42cvEDmAFaAhMsce3AKYX1zBSGXApD+sGJAmvUpSnhPo0K6ipVlpGLeL5QGjT6oPmC5Gim9X0Xk5BzHS4FBV3iwhN34gszTcqa6ybeTKgZ8/f03rCwZ78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYKln0oH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715379765; x=1746915765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1eupN9In0SKeHI6aNxZYRKBeLC1ty/HA2POqcDmV410=;
  b=kYKln0oHHS86QfbDEhydxEQeCC/FqOyOk7XuKpM9L5Ob1mJH3JMYu0DJ
   eGFuJ63Co/1M0OtGcE5TtzL8OY1f3h84huCaStoo1HgBec824WcDJT1hc
   6TNRqsKY0hse+l31fE7h4aASEB43m66VFdr2j6U75H8nmOjzc/PoMHdRl
   VeUCxel+FoLf+8VL8rl0EGse7fO0EEo6upv+ESd5pudxKvhCFuLmBhjj1
   eYNR8yy4E0Jk8qfw/O5nMMPv4IeA3+hOtGenMt8op4tIq2R2vns1yO0c1
   KtCmGp2faiBUB+S86Mjjpno648nNLXKJTl2B7my/GZ6bMV5axeCWsOR3o
   g==;
X-CSE-ConnectionGUID: weJCvV3aQSWIyGTs6UTOJA==
X-CSE-MsgGUID: H07Tv299QvuLmzIOiWrjGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11540583"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11540583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 15:22:37 -0700
X-CSE-ConnectionGUID: RZOv4w4eTTaxQPDK1oR0xg==
X-CSE-MsgGUID: ZJmwQYcKQ4We5Xo0hvmsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="34514195"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 May 2024 15:22:35 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5YdM-0006dn-2o;
	Fri, 10 May 2024 22:22:32 +0000
Date: Sat, 11 May 2024 06:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH v2 4/8] iio: imu: adis_buffer: Add buffer setup API with
 buffer attributes
Message-ID: <202405110642.5PmTepVs-lkp@intel.com>
References: <20240508131310.880479-5-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508131310.880479-5-ramona.bolboaca13@gmail.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240508-211559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240508131310.880479-5-ramona.bolboaca13%40gmail.com
patch subject: [PATCH v2 4/8] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240511/202405110642.5PmTepVs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110642.5PmTepVs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405110642.5PmTepVs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/imu/adis16400.c:24:
>> include/linux/iio/imu/adis.h:530:60: warning: 'struct iio_dev_attr' declared inside parameter list will not be visible outside of this definition or declaration
     530 |                                               const struct iio_dev_attr **buffer_attrs);
         |                                                            ^~~~~~~~~~~~


vim +530 include/linux/iio/imu/adis.h

   524	
   525	int
   526	devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
   527						      struct iio_dev *indio_dev,
   528						      irq_handler_t trigger_handler,
   529						      const struct iio_buffer_setup_ops *ops,
 > 530						      const struct iio_dev_attr **buffer_attrs);
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

