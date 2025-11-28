Return-Path: <linux-iio+bounces-26551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D573CC92ED2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E4484E1823
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16E26E6F6;
	Fri, 28 Nov 2025 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/+RxORL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884821F7586;
	Fri, 28 Nov 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355595; cv=none; b=eBoT2YId3obDQkw3ge8iRFPgLZLXhoub0B5kltOInLkWXbaXmmFTa8X0VtrLHhd7FvEINu//Yd7jSYr+zXVfoC2K09bmNFVx9rrfe33VLxmcPR7OFKz+HfCKpMqfxiA5MpoUbltcz1AwZGDOk0350Uo8yGxMVTaKUz0kJTnFmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355595; c=relaxed/simple;
	bh=DpQafR+0vhopUwNj74SdoMaNJqnU/dy1P1aVEFArtGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onPhagOFwys7BlsPvT+oGCSJHqGhHaCrb9px4wie8v7yinuvjSDn4L25gQwr52FMtv3k7vwezu9pzh13DublezSMUdf2YOU4ELp8lerrv2n4bnCChaZLT0rTa64YCiOZ2EFTuVtEjvI3bqMPlF34fqnPugCQaK+sh0LUBj3CPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/+RxORL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764355593; x=1795891593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpQafR+0vhopUwNj74SdoMaNJqnU/dy1P1aVEFArtGw=;
  b=O/+RxORL2dapz6fIj4h1ytyyjiJYpy46WEyoo9M1+VpT6tkYgo0MxCFs
   ix1Dka+9yUsgAeHK8qOXglaAi6rM0ChYGrLM6rQV7PnpNRA8s7MoMEjKw
   lGZ4MI/ssncfsvoVstOLuLiObtev+9VE1r5cQdgrJFxCtqrMGas2L5EAQ
   sCilxk1BNY9uGE1Avr/NHLDLkpk887OQVRB8pt1c3dCxySMQmH6jeawCD
   49X0wlGxSZtd/kY3PTq7zFCddOel26G+hDQtbsrjBU6WkJPBRfoG3zKfb
   1BzEcrhLYAtPDCLTQHhifef152u1GVJ+YK4Qhs+bMffjeUNXBo4PJcmlg
   g==;
X-CSE-ConnectionGUID: FgA1dETPRj6RUaV0B/czQw==
X-CSE-MsgGUID: /tdp05vjQU2oAIBDxMO1mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66276433"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66276433"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 10:46:33 -0800
X-CSE-ConnectionGUID: 6442T8RxSkmvyKM+i3J1mQ==
X-CSE-MsgGUID: QDoamcWWQuKyuayM66dxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="198622633"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Nov 2025 10:46:31 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vP3UC-000000006en-2lI3;
	Fri, 28 Nov 2025 18:46:28 +0000
Date: Sat, 29 Nov 2025 02:46:07 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v4 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <202511290251.tcqKd4O5-lkp@intel.com>
References: <20251121095204.18574-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121095204.18574-3-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.18-rc7 next-20251128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/dt-bindings-iio-amplifiers-add-adl8113/20251121-180600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251121095204.18574-3-antoniu.miclaus%40analog.com
patch subject: [PATCH v4 2/2] iio: amplifiers: adl8113: add driver support
config: x86_64-randconfig-r071-20251128 (https://download.01.org/0day-ci/archive/20251129/202511290251.tcqKd4O5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511290251.tcqKd4O5-lkp@intel.com/

smatch warnings:
drivers/iio/amplifiers/adl8113.c:58 adl8113_set_path() warn: inconsistent indenting

vim +58 drivers/iio/amplifiers/adl8113.c

    48	
    49	static int adl8113_set_path(struct adl8113_state *st,
    50				    enum adl8113_signal_path path)
    51	{
    52		int va, vb;
    53	
    54		/* Determine GPIO values based on signal path */
    55		switch (path) {
    56		case ADL8113_INTERNAL_AMP:
    57			va = 0; vb = 0; /* Internal amplifier */
  > 58			break;
    59		case ADL8113_INTERNAL_BYPASS:
    60			va = 1; vb = 1; /* Internal bypass */
    61			break;
    62		case ADL8113_EXTERNAL_A:
    63			va = 0; vb = 1; /* External bypass A */
    64			break;
    65		case ADL8113_EXTERNAL_B:
    66			va = 1; vb = 0; /* External bypass B */
    67			break;
    68		default:
    69			return -EINVAL;
    70		}
    71	
    72		gpiod_set_value(st->gpio_va, va);
    73		gpiod_set_value(st->gpio_vb, vb);
    74		st->current_path = path;
    75		return 0;
    76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

