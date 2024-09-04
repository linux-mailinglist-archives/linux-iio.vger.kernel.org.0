Return-Path: <linux-iio+bounces-9149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74D96C55D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC4F1C251CC
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704581E1A20;
	Wed,  4 Sep 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm1uEBSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50114BF85;
	Wed,  4 Sep 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470621; cv=none; b=EypjB2jc20VNgrnu4xdEpeu+bTa0hSr0bUjQ8o/qo/X9Mj0BF7kluLq2Qkljjd0vUINDYogpaFi7IIk/fblJ1gY4L25hMYuzlh+3KpTxYNlSp9M7ko042HG450cv2LkB5BG5EJvjfPDBXF2hpnFDGVyk75zDhEEwkX/oQwB6CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470621; c=relaxed/simple;
	bh=ILuonY5731KqpUyvDIpzSQYrE7kjsGqjXWSqJ8pp3+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny6wffCHkq1r+GHQZYEHO+/1PzAtaOIV2WphGDQagc6SF33Z9awZlGZTqBar5Ib9jyPq9K/bEop7e0vOIrArDTyDIk59gWLBIQL9CRS3tCDFPa8cyc896qwnenlIwbYC8mB6evS9TMCo4G+8/drTJxmQ+eDC7ZwwYQYN8bPLGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm1uEBSn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725470619; x=1757006619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILuonY5731KqpUyvDIpzSQYrE7kjsGqjXWSqJ8pp3+g=;
  b=Qm1uEBSnDPHOWDVx7+0a+rxKFadR68t+2Phbm1MYarl57FOcSJEF8Wb2
   aZZup1tbqjaLQIhwufBRBovcNvPGgi90j3Wm/cP+Hni9fce2pRckRyaYP
   zphgDGOv4Snqect2mPlBbzBc0vNN5QD+EgcUmbZNqkUx0NI0jhkzbAUMQ
   gFZRggtbOH5eKnaMJ1uR7r4o5av9aKrDvGRTdy1aVYxjOhZrjsoaSEC8f
   WKaSs1Bd19MhhJ+sdhAX2qh42N63C1rZoFmQxxVBDw8SxB9ptLaa5FnOF
   x2Ys642sI39VbM4HNCcCpAI00OBtI1cIrLUH8OADzN5hq4Kk7zAHx5eq1
   g==;
X-CSE-ConnectionGUID: OFN2U3hHS2qJMNbxH+E/nQ==
X-CSE-MsgGUID: 0SOOPFy3RdCtwb4C4n+htA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24340538"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24340538"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 10:23:38 -0700
X-CSE-ConnectionGUID: 19/cCM0JQEuNh6FlCbvv3w==
X-CSE-MsgGUID: 7/kbMBt0T8CdPYilquRsZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65177629"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Sep 2024 10:23:34 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sltj8-0008OJ-1z;
	Wed, 04 Sep 2024 17:23:30 +0000
Date: Thu, 5 Sep 2024 01:23:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <202409050100.CGStaazP-lkp@intel.com>
References: <20240904023040.23352-3-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904023040.23352-3-Mariel.Tinaco@analog.com>

Hi Mariel,

kernel test robot noticed the following build errors:

[auto build test ERROR on c4b43d8336e52dce6d124e428aa3b71703e62647]

url:    https://github.com/intel-lab-lkp/linux/commits/Mariel-Tinaco/dt-bindings-iio-dac-add-docs-for-ad8460/20240904-103413
base:   c4b43d8336e52dce6d124e428aa3b71703e62647
patch link:    https://lore.kernel.org/r/20240904023040.23352-3-Mariel.Tinaco%40analog.com
patch subject: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240905/202409050100.CGStaazP-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409050100.CGStaazP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409050100.CGStaazP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/dac/ad8460.c:165:9: error: call to undeclared function 'get_unaligned_le16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     165 |         *val = get_unaligned_le16(state->spi_tx_buf);
         |                ^
>> drivers/iio/dac/ad8460.c:172:2: error: call to undeclared function 'put_unaligned_le16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     172 |         put_unaligned_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val),
         |         ^
   2 errors generated.


vim +/get_unaligned_le16 +165 drivers/iio/dac/ad8460.c

   155	
   156	static int ad8460_get_hvdac_word(struct ad8460_state *state, int index, int *val)
   157	{
   158		int ret;
   159	
   160		ret = regmap_bulk_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   161				       &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   162		if (ret)
   163			return ret;
   164	
 > 165		*val = get_unaligned_le16(state->spi_tx_buf);
   166	
   167		return ret;
   168	}
   169	
   170	static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
   171	{
 > 172		put_unaligned_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val),
   173					     &state->spi_tx_buf);
   174	
   175		return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
   176					 state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

