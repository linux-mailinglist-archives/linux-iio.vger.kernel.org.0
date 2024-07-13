Return-Path: <linux-iio+bounces-7578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F333930451
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE4E2851C7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B04655D;
	Sat, 13 Jul 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTuz9cIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A145008;
	Sat, 13 Jul 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856593; cv=none; b=IY+nyr7zM69I88XZThuDlAzSOlf7oKe+bA1S7LwiAx+xGLv+cRt4Ef2//9bph7qDVr7AwYzeVFLEPKSe64RdueLchfNq/6+T0GFtxuSVboQzQumesONF0JMwzQ5IKjD1jRH68/5fbR25Pp5fau6hr+LpTimVmoZX4245D8xAkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856593; c=relaxed/simple;
	bh=8APyXt8NaBnkPT00DgequUjKNEazJwOXgsU2Ys9YZ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIGMQUzH+kPbAG/2mQw7SYzldxLbPCfeNJlvG1QtKItFOuFNJqU9vxXnEQXPqer+zri8ILmlp1J+cEwE2eXqzyEWYYWq8XuNwZV+liLq3DbZMNDQFUlT/htlOkGx23WlSNA6siCRsb4cFdSAU/lj7t0L+AGQ6okgU6QXi9r3mJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTuz9cIq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720856592; x=1752392592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8APyXt8NaBnkPT00DgequUjKNEazJwOXgsU2Ys9YZ6k=;
  b=aTuz9cIqIhlTJBQP/Zj0Sy7xAPXzBY5eVdZ/w1K+q30IsdJy92P7bCSl
   FZW7Ycj/f29v6hDoIDI91WvGsLooe6s3sfoW78mIY2fORCoG1qo6NMVOX
   o3Fig8wmkRMk1BgRf8Ru+GWoRi+swRpXCn3F61K8gClrX1iOAw3mAP6Jo
   vlVMJvL5oNQ+chomA7dtsNGTRp+C3YAPieL2jcNFT1G+GjSDbUhCnEfkT
   zTFywd8c7ZSFfY31iI1ge/rUoNuZkeW5bfu+UyRvOJ/6e3FALj9D17B9p
   DNRbdnLYRWV7/oKHXJapW8m60hYgdXhA4/GNOxdAKCSWXyZtGryCD2vPr
   w==;
X-CSE-ConnectionGUID: 8oX6MUlkQcKF/XCZfwWYAQ==
X-CSE-MsgGUID: PInH8TikTJurZjfXJ73UpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18116161"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="18116161"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 00:43:11 -0700
X-CSE-ConnectionGUID: eytwdp1fQzGrOOuZwppMTA==
X-CSE-MsgGUID: 24RR+7NNR8WSlez/+COfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="86635688"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2024 00:43:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSXPO-000bqY-14;
	Sat, 13 Jul 2024 07:43:06 +0000
Date: Sat, 13 Jul 2024 15:42:24 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
Message-ID: <202407131554.tOb1HnRA-lkp@intel.com>
References: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Felmeden/dt-bindings-iio-humidity-add-ENS21x-sensor-family/20240711-022826
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240710-ens21x-v3-2-4e3fbcf2a7fb%40thegoodpenguin.co.uk
patch subject: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
config: sparc64-randconfig-r053-20240712 (https://download.01.org/0day-ci/archive/20240713/202407131554.tOb1HnRA-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131554.tOb1HnRA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131554.tOb1HnRA-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/iio/humidity/ens21x.o: in function `ens21x_get_measurement':
>> ens21x.c:(.text+0x388): undefined reference to `crc7_be'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

