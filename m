Return-Path: <linux-iio+bounces-321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B046C7F8979
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 10:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20BF1C20BE7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115699470;
	Sat, 25 Nov 2023 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHeFdIJ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E310C1;
	Sat, 25 Nov 2023 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700903421; x=1732439421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QdzRfqqMDGrm6F4e1ZpjewvxXCLTWBlTVCn5Wi8ZJlM=;
  b=WHeFdIJ5Ox1Ts8/OeglmIumtCX9s28W1fX/YRXQykOd1gSrM81nPj3bM
   do1ryxCXrKjwn9CvDU7GI14imuqkasMeF+6GWMZcK/Ix/vI9+J0WQwUXu
   NfgD5niI4nPCYFxWFdL9/Ysn8ctpBJOauWLoV/Iw6KnjqbjJ0R4OIZ6kA
   dEj8WGHe4S/LDgOc8w0Qv+ey/hic31HS4pdLGW3RiE+4vW6y0RQHcHJJZ
   TSchJnzQTUD2AOe6hEVJsYDKL7qjVxuj93Pa4py1QaK5TBUCmr/sU/vzt
   MYO3gvr/jX+ZjRgEAZil4FOBHct/6BDYsQ1I1fPfovKMarttso669KOgg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="392268731"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="392268731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1099303470"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="1099303470"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2023 01:10:18 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6og4-0003p9-1e;
	Sat, 25 Nov 2023 09:10:16 +0000
Date: Sat, 25 Nov 2023 17:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: Anshul Dalal <anshulusr@gmail.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: chemical: add support for Aosong AGS02MA
Message-ID: <202311251636.m0yt3fIb-lkp@intel.com>
References: <20231121095800.2180870-3-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095800.2180870-3-anshulusr@gmail.com>

Hi Anshul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshul-Dalal/dt-bindings-iio-chemical-add-aosong-ags02ma/20231121-180435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231121095800.2180870-3-anshulusr%40gmail.com
patch subject: [PATCH v3 3/3] iio: chemical: add support for Aosong AGS02MA
config: arm-randconfig-r081-20231123 (https://download.01.org/0day-ci/archive/20231125/202311251636.m0yt3fIb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231125/202311251636.m0yt3fIb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251636.m0yt3fIb-lkp@intel.com/

New smatch warnings:
drivers/iio/chemical/ags02ma.c:53 ags02ma_register_read() warn: unsigned 'ret' is never less than zero.

Old smatch warnings:
drivers/iio/chemical/ags02ma.c:63 ags02ma_register_read() warn: unsigned 'ret' is never less than zero.

vim +/ret +53 drivers/iio/chemical/ags02ma.c

    45	
    46	static u32 ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay)
    47	{
    48		u32 ret;
    49		u8 crc;
    50		struct ags02ma_reading read_buffer;
    51	
    52		ret = i2c_master_send(client, &reg, sizeof(reg));
  > 53		if (ret < 0) {
    54			dev_err(&client->dev,
    55				"Failed to send data to register 0x%x: %d", reg, ret);
    56			return ret;
    57		}
    58	
    59		/* Processing Delay, Check Table 7.7 in the datasheet */
    60		msleep_interruptible(delay);
    61	
    62		ret = i2c_master_recv(client, (u8 *)&read_buffer, sizeof(read_buffer));
    63		if (ret < 0) {
    64			dev_err(&client->dev,
    65				"Failed to receive from register 0x%x: %d", reg, ret);
    66			return ret;
    67		}
    68		ret = be32_to_cpu(read_buffer.data);
    69	
    70		crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
    71			   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
    72		if (crc != read_buffer.crc) {
    73			dev_err(&client->dev, "CRC error\n");
    74			return -EIO;
    75		}
    76	
    77		return ret;
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

