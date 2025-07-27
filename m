Return-Path: <linux-iio+bounces-22033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C9B12D69
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68821897039
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211C145FE0;
	Sun, 27 Jul 2025 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dM/E5u+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78A7DA66;
	Sun, 27 Jul 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753582253; cv=none; b=kNWM3ad7hyWPiLNZ2fbvwBu2o8R6i3XAfy4/+PoNeOgjjI4VkMuYcH9MYUV+QfueOWOOtGazQBo3PdOqRHRpRUvk1qNky4P8r4ABfatmVvHYrYFwIRWMpd2PkTR6AlJ+JSbJ1YuAWw62Vr1yo92qOjaf+g0Hf8FQv5Q8+MpbIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753582253; c=relaxed/simple;
	bh=UhoE20TaiamGl1zWAnlhaizRkE8396wfghIqT0wavoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezVIPqusxFwPMOrWhzdOKVsFzX+hL4q9SLbDrXeHbZvvE9N2Er6HPdOxJZAf7PlpSRNL8EUf/WlWINmgbHHCpRtQNoxRj1XHk6wEnyY3q1vcVb8vLx7ynkQHgUcUXu+zkElUchxepBjd6TuLDsr4Yu0plkLabTmr72HO4jFNV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dM/E5u+B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753582251; x=1785118251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhoE20TaiamGl1zWAnlhaizRkE8396wfghIqT0wavoU=;
  b=dM/E5u+BztqK7LLrK4AgGeSEjIbFGXLHilSTIc4N735tJ0XArLQdIdJo
   mJ7L/bLWuc44nm+16x5CGlj9HXIGDIY0ZvH5XmJHzn20305DkCwt/QOMx
   KFndebLzS48tingBMWLwF4y4OmNgQs2CTQlNhZbMa6aE480MFdtAbyYVu
   82iTagAeyEACOngniPDmJBoAZ8U93VvwyS//q0wOaK2vzMR1D3eFZhNO4
   SuaWALjtkDZ2tF8jVRgmrrBgBo6w0vr2X6aDxLklEmwMw6qOzDUatpgQO
   C0sb6opFrCYrE3uwK0sNuTIJEy+I0ZM04orM5w/WNWU7p4Nq1bT2xqTrt
   w==;
X-CSE-ConnectionGUID: w3kNKfcoTFycjtXRrjEW7w==
X-CSE-MsgGUID: CEoeE+AFQQCTKkKM+uZwyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55808241"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55808241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 19:10:50 -0700
X-CSE-ConnectionGUID: /bk1uIjaRNWmRuoR0j7zbg==
X-CSE-MsgGUID: 7SsLfpVnQxyuHlfITFtA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161801477"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2025 19:10:47 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufqqb-000MOt-2K;
	Sun, 27 Jul 2025 02:10:45 +0000
Date: Sun, 27 Jul 2025 10:09:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Dixit Parmar <dixitparmar19@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <202507270929.aFInjuAM-lkp@intel.com>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>

Hi Dixit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d7b8f8e20813f0179d8ef519541a3527e7661d3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dixit-Parmar/iio-magnetometer-add-support-for-Infineon-TLV493D-3D-Magentic-sensor/20250726-173919
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32%40gmail.com
patch subject: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon TLV493D 3D Magnetic sensor
config: csky-randconfig-051-20250727 (https://download.01.org/0day-ci/archive/20250727/202507270929.aFInjuAM-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.5.0
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270929.aFInjuAM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270929.aFInjuAM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Duplicate compatible "infineon,tlv493d-a1b6" found in schemas matching "$id":
   	http://devicetree.org/schemas/trivial-devices.yaml#
   	http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

