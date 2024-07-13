Return-Path: <linux-iio+bounces-7577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06F930414
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 08:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC09A282F4C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCB1CD37;
	Sat, 13 Jul 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcyTqJn4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBA1B960;
	Sat, 13 Jul 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851370; cv=none; b=rUGoP5aahfdG3MmdCwOTQ0hKeFXnSTR45qm5dQWLp8sXwLspnewSabFLpwGuTbkxs1JlGbzkuPDXZb4ytsHT7gtljEgd27sxPNGNrdNLlu5BtrrEO6V3qYfqEBeEkeu4L5GX70KnUEZbPbXpLAEvdV9q6Up7aoWq00To1dvpcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851370; c=relaxed/simple;
	bh=KN85+gFWkF03HdphdQDW1hlUh8APmU7td3URDxBVy48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdqJEZCe94Qpp5pqPkFkzROokpHBgvadw4GtGo/hpd/kO8kUkFEc2yzMMDcpuTsbN4f4E+RpzUFcsUUBeImrYViNxkDRpmcgbE55OkZ0pubu5scyq27uI8IMKMaJnXyIzK63hCJmj+SsQrGr2iPo4NoHy8VQ2xTSSVRtBTdTK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcyTqJn4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720851369; x=1752387369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KN85+gFWkF03HdphdQDW1hlUh8APmU7td3URDxBVy48=;
  b=NcyTqJn4XI8d8/fAPo8cQl9CNbs0wijANkjyAHDgEfU+FABqeY6XaaJt
   XgXoOqAs+vV8QW0M9Xb+G9gEYJf+oJcQ5opWZuIksSZ9kxys2nRrq8Aly
   BG4FVt24+ZwkE2US2jne64E/b7bd6piKEiZUS/UpPBguSOiQYnky799yh
   PdVx9Q3vH8y+ct/iem/WGJN7hDknuxElGnPsMi/Djo5blBFTd+n0ZZsGL
   X3qFWaYkUP/FoXOOtr4HEkeMie2MULyfYx4h9Ch54uFXh/Mu5GDrNQ8Ik
   ab58qCr/viKvzuFSA0J7XWTaXDOuqQj327PcGymjNnIhZ9HAdgA3a7Ain
   A==;
X-CSE-ConnectionGUID: Pelzu2pBTjyBEJUjrfeEmg==
X-CSE-MsgGUID: WRJqBmpnSbeE/mkUm6zxFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12532205"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="12532205"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 23:16:08 -0700
X-CSE-ConnectionGUID: F/bBVadJQ4StEAO2fBoYOA==
X-CSE-MsgGUID: Sjafa8h+T7GCEgWKURv48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="53683508"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jul 2024 23:16:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSW39-000blC-1h;
	Sat, 13 Jul 2024 06:16:03 +0000
Date: Sat, 13 Jul 2024 14:15:19 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	waqar.hameed@axis.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wangshuaijie@awinic.com,
	liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Message-ID: <202407131316.CrET2D2p-lkp@intel.com>
References: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 43db1e03c086ed20cc75808d3f45e780ec4ca26e]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-Add-YAML-to-Awinic-proximity-sensor/20240712-194024
base:   43db1e03c086ed20cc75808d3f45e780ec4ca26e
patch link:    https://lore.kernel.org/r/20240712113200.2468249-3-wangshuaijie%40awinic.com
patch subject: [PATCH V3 2/2] Add support for Awinic proximity sensor
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240713/202407131316.CrET2D2p-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131316.CrET2D2p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131316.CrET2D2p-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/proximity/aw9610x.c: In function 'aw9610x_datablock_load':
>> drivers/iio/proximity/aw9610x.c:665:1: warning: the frame size of 1356 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     665 | }
         | ^


vim +665 drivers/iio/proximity/aw9610x.c

   634	
   635	static void aw9610x_datablock_load(struct aw_sar *p_sar, const char *buf)
   636	{
   637		struct aw9610x *aw9610x = p_sar->priv_data;
   638		unsigned char addr_bytes = aw9610x->aw_i2c_package.addr_bytes;
   639		unsigned char data_bytes = aw9610x->aw_i2c_package.data_bytes;
   640		unsigned char reg_num = aw9610x->aw_i2c_package.reg_num;
   641		unsigned char reg_data[220] = { 0 };
   642		unsigned int databuf[220] = { 0 };
   643		unsigned char temp_buf[2] = { 0 };
   644		unsigned int i;
   645	
   646		for (i = 0; i < data_bytes * reg_num; i++) {
   647			if (reg_num < attr_buf[1]) {
   648				temp_buf[0] = buf[attr_buf[0] + (addr_bytes + i) * 5];
   649				temp_buf[1] =
   650					buf[attr_buf[0] + (addr_bytes + i) * 5 + 1];
   651			} else if (reg_num >= attr_buf[1] && reg_num < attr_buf[3]) {
   652				temp_buf[0] = buf[attr_buf[2] + (addr_bytes + i) * 5];
   653				temp_buf[1] =
   654					buf[attr_buf[2] + (addr_bytes + i) * 5 + 1];
   655			} else if (reg_num >= attr_buf[3] && reg_num < attr_buf[5]) {
   656				temp_buf[0] = buf[attr_buf[4] + (addr_bytes + i) * 5];
   657				temp_buf[1] =
   658					buf[attr_buf[4] + (addr_bytes + i) * 5 + 1];
   659			}
   660			sscanf(temp_buf, "%02x", &databuf[i]);
   661			reg_data[i] = (unsigned char)databuf[i];
   662		}
   663		aw9610x->aw_i2c_package.p_reg_data = reg_data;
   664		aw9610x_awrw_write_seq(p_sar);
 > 665	}
   666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

