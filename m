Return-Path: <linux-iio+bounces-13182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EC9E7A72
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF1285F5B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBC213E6F;
	Fri,  6 Dec 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+mwafAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393AA213E63;
	Fri,  6 Dec 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519606; cv=none; b=En0Fh3SJzOoPvpCAOF+Mor2q3tSdQLsTPsSiNdIFXUEbs/Engm+g5aTp+lUIitgKEYyip1kdO3rbYBu6khhJp0UJByz+0OxBRaq1hczliySxyOCG7i1qWc11j4Ap3tFdlhssnHHRzzHuMO7R8S+NQQLRqnbH+DguTWQ7CL5tCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519606; c=relaxed/simple;
	bh=RZbPzw7WbfpgyKvzGUkCTiOA90u3s1h1g6SxzMS8IbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TazOkaU+4+TuWfbNFGmo9+N4+OBN2cnQ/UqpO1dnmnYo9drgOI/ffJ6SFl1Fei26OhuuOBhDJPDY9ET/ln7WgORI6msZ23v5wjLitVBe7tDSNGpgNk2eaCAe6kTJl2RwfIwQuPiDdHERvsREPiszTwJOUm9Md62mNf4MemWxpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+mwafAM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733519605; x=1765055605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZbPzw7WbfpgyKvzGUkCTiOA90u3s1h1g6SxzMS8IbQ=;
  b=k+mwafAM98IEUskbiUeKC2S/VD4CjXzrP5QkxRtSo3Jj/8ziquJv/2U7
   LCuHsWgixbAKPXDzs58QfdYLGN0RlqeVMyClHpTOQD7mOe4lOtbGxb50F
   rhlOaI5ZYG4wGLDIUEwukiBt1MYo25OGF/PF1wGGfdgWjz0B9xzxhGOam
   G5M4Ti3wfBv7VLtZxHWiU/NY8BS43H3XsQI8pyBS/oOhnSe8qsHrmRWjO
   BGLJ4HVIhPSNOKd3Mkg+FW/PGVPMOy+8dM+a7/Pk36zFLbHlmg67DLTCt
   ssvkvgY6vfeJadyTJxK+7EmyogOtrYm0+yXFIVQB1uNdXln2oiq7ehlJy
   Q==;
X-CSE-ConnectionGUID: vrtNi2XZSraqc+H26wr/rw==
X-CSE-MsgGUID: ghPGicNqTgaWCFlG/ZlEsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34017903"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34017903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:13:24 -0800
X-CSE-ConnectionGUID: g/T+e8lQTUC77Zz/w+oudA==
X-CSE-MsgGUID: TC2avendRH2fEKIjXG26jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="99572100"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Dec 2024 13:13:21 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJfdV-0002GD-3D;
	Fri, 06 Dec 2024 21:13:17 +0000
Date: Sat, 7 Dec 2024 05:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <202412070552.HvBGzx9l-lkp@intel.com>
References: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>

Hi Mikael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5de07b8a24cf44cdb78adeab790704bf577c2c1d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikael-Gonella-Bolduc-via-B4-Relay/dt-bindings-iio-light-Add-APDS9160-binding/20241207-001144
base:   5de07b8a24cf44cdb78adeab790704bf577c2c1d
patch link:    https://lore.kernel.org/r/20241206-apds9160-driver-v2-2-be2cb72ef8f4%40dimonoff.com
patch subject: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor driver
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412070552.HvBGzx9l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070552.HvBGzx9l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/zii,rave-sp.yaml
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

